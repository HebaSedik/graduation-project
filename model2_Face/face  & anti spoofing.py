from ultralytics import YOLO
import cv2
import cvzone
import math
import time
import numpy as np
import face_recognition
import os
from datetime import datetime
import pygame
import serial

arduino = serial.Serial('COM3', 9600)
pygame.mixer.init()
alarm_sound = pygame.mixer.Sound('1.wav')
confidance = 0.9
cap = cv2.VideoCapture(0)
cap.set(3, 900)
cap.set(4, 780)
model = YOLO('D:/project/anti spoofing/Dataset/models/n_version_1_5.pt')
className = ["fake", "real"]

path = 'AttendanceImages'
images = []
classNames = []
myList = os.listdir(path)

frame_resizing = 0.25
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
    ret, img = cap.read()
    imgS = cv2.resize(img, (0, 0), None, 0.25, 0.25)
    imgS = cv2.cvtColor(imgS, cv2.COLOR_BGR2RGB)
    faceCurentFrame = face_recognition.face_locations(imgS)
    encodeCurentFrame = face_recognition.face_encodings(imgS, faceCurentFrame)
    results = model(img, stream=True)

    for r in results:
        boxes = r.boxes
        for box in boxes:
            # bounding box
            x1, y1, x2, y2 = box.xyxy[0]
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            w, h = x2 - x1, y2 - y1
            # confidence
            conf = math.ceil((box.conf[0] * 100)) / 100
            # class name
            cls = int(box.cls[0])

    for encodeface, faceLoc in zip(encodeCurentFrame, faceCurentFrame):
        matches = face_recognition.compare_faces(encodeListKnown, encodeface, tolerance=0.5)
        faceDis = face_recognition.face_distance(encodeListKnown, encodeface)
        matchIndex = np.argmin(faceDis)

        if matches[matchIndex]:
            name = classNames[matchIndex].upper()
            class_name = className[cls]

            y1, x2, y2, x1 = faceLoc
            y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4

            if class_name == 'real':
                color = (0, 255, 0)  # Green color for known and real faces
            else:
                color = (0, 0, 255)  # Red color for fake or unknown faces

            cv2.rectangle(img, (x1, y1), (x2, y2), color, 2)
            cv2.rectangle(img, (x1, y2 - 35), (x2, y2), color, cv2.FILLED)
            cv2.putText(img, f'{name} ({class_name})', (x1 + 6, y2 - 6), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255),
                        2)

            if className[cls] == 'fake':
                alarm_sound.play()
                arduino.write(b'0')
                markAttendance(name)

            elif className[cls] == 'real':
                arduino.write(b'Y')
                time.sleep(1)
                markAttendance(name)
        else:
            name = "Unknown"
            arduino.write(b'0')
            class_name = className[cls]
            y1, x2, y2, x1 = faceLoc
            y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4
            markAttendance(name)

            cv2.rectangle(img, (x1, y1), (x2, y2), (0, 0, 255), 2)  # Red color for fake or unknown faces
            cv2.rectangle(img, (x1, y2 - 35), (x2, y2), (0, 0, 255), cv2.FILLED)
            cv2.putText(img, f'{name} ({class_name})', (x1 + 6, y2 - 6), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255),
                        2)

    cv2.imshow('Face Recognition', img)
    if cv2.waitKey(1) & 0xFF == ord('x'):
        break

cap.release()
cv2.destroyAllWindows()
