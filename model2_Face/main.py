from ultralytics import YOLO
import cv2
import cvzone
import math
import time
confidance = 0.8
cap = cv2.VideoCapture(0)
cap.set(3, 1200)
cap.set(4, 780)
model = YOLO('D:/project/anti spoofing/Dataset/models/n_version_1_5.pt')
classNames = ["fake", "real"]
prev_frame_time = 0
new_frame_time = 0
while True:
    new_frame_time = time.time()
    success, img = cap.read()
    results = model(img, stream=True)
    #results = model(img, stream=True, verbose=False)
    for r in results:
        boxes = r.boxes
        for box in boxes:
            # bounding box
            x1, y1, x2, y2 = box.xyxy[0]
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            w, h = x2-x1, y2-y1

            # confidence
            conf = math.ceil((box.conf[0]*100))/100
            # class name
            cls = int(box.cls[0])
            if conf > confidance:
                if classNames[cls] == 'real':
                    color = (0, 255, 0)
                else:
                    color = (0, 0, 255)
                cvzone.cornerRect(img, (x1, y1, w, h), colorC=color, colorR=color)
                cvzone.putTextRect(img, f'{classNames[cls].upper()} {int(conf * 100)}%',
                               (max(0, x1), max(35, y1)), scale=2, thickness=4, colorR=color,
                                   colorB= color)

    fps = 1 / (new_frame_time - prev_frame_time)
    prev_frame_time = new_frame_time
    # print(fps)
    if cv2.waitKey(10) & 0xff == ord("x"):
        break
    cv2.imshow("Image", img)
    cv2.waitKey(1)
