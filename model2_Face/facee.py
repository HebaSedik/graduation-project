import cv2
import numpy as np
import face_recognition
import os
from datetime import datetime
path = 'AttendanceImages'
images = []
classNames = []
myList = os.listdir(path)
# print(myList)

cap = cv2.VideoCapture(0)
frame_resizing = 0.25
cap.set(3, 1280)
cap.set(4, 720)
for cl in myList:
    curImg = cv2.imread(f'{path}/{cl}')
    images.append(curImg)
    classNames.append(os.path.splitext(cl)[0])
# print(classNames)
def findEncodings(images):
    encodeList = []
    for img in images:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        encode = face_recognition.face_encodings(img)[0]
        encodeList.append(encode)
    return encodeList


def markAttendance(name):
    with open('Attendance.csv', 'r+') as f:
        myDataList = f.readlines()
        nameList = []
        for line in myDataList:
            entry = line.split(',')
            nameList.append(entry[0])
        if name not in nameList:
            now = datetime.now()
            dtString = now.strftime('%H:%M:%S')
            f.writelines(f'\n{name},{dtString}')


encodeListKnown = findEncodings(images)
print('Encoding Complete')
while True:
    success, img = cap.read()
    imgS = cv2.resize(img, (0, 0), fx=frame_resizing, fy=frame_resizing)
    imgS = cv2.cvtColor(imgS, cv2.COLOR_BGR2RGB)
    facesCurFrame = face_recognition.face_locations(imgS)
    encodesCurFrame = face_recognition.face_encodings(imgS, facesCurFrame)

    for encodeFace, faceLoc in zip(encodesCurFrame, facesCurFrame):
        matches = face_recognition.compare_faces(encodeListKnown, encodeFace)
        #         print('matches',matches)
        faceDis = face_recognition.face_distance(encodeListKnown, encodeFace)
        #         print(faceDis)
        matchIndex = np.argmin(faceDis)
        if matches[matchIndex]:
            name = classNames[matchIndex].upper()
            print(name)

            faceLoc = np.array(faceLoc)
            faceLoc = faceLoc / 0.25
            faceLoc = faceLoc.astype(int)
            # y1,x2,y2,x1 = faceLoc # in the other code we risize the face
            # y1, x2, y2, x1 = y1*4,x2*4,y2*4,x1*4
            y1, x2, y2, x1 = faceLoc[0], faceLoc[1], faceLoc[2], faceLoc[3]

            cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.rectangle(img, (x1, y2 - 35), (x2, y2), (0, 255, 0), cv2.FILLED)
            cv2.putText(img, name, (x1 + 6, y2 - 6), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)
    #             markAttendance(name)

    cv2.imshow('Webcam', img)
    key = cv2.waitKey(1)
    if key == 27:
        break
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
# ser.close()
cap.release()
cv2.destroyAllWindows()