# Face Recognition and Anti-Spoofing System

This project combines face recognition with anti-spoofing detection using YOLO. It processes each frame from the webcam, detects faces, checks if they are real or fake, and updates the attendance records. The integration with Arduino and sound alerts enhances the system's interactivity and security.

## Libraries and Initial Setup

### 1. Importing Libraries:
```python
from ultralytics import YOLO   # Used for object detection.
import cv2   # OpenCV library for image and video processing.
import cvzone    # Additional functionalities for OpenCV.
import math      # Helper libraries for mathematical operations
import time      # Helper libraries for time management
import numpy as np      # Helper libraries for array processing.
import face_recognition      # Library for face recognition.
import os      # Library to interact with the operating system.
from datetime import datetime       # For handling date and time.
import pygame      # For playing sounds.
import serial      # For serial communication with Arduino.
 ```````
    
### 2- Initializing Hardware and Software Components:
```python
    arduino = serial.Serial('COM3', 9600)    #Establish a serial connection with Arduino.
    pygame.mixer.init()      #Initialize Pygame for sound playback and load an alarm sound.
    alarm_sound = pygame.mixer.Sound('1.wav')
    confidance = 0.9
    cap = cv2.VideoCapture(0)    #Set up the webcam with specific resolution settings.
    cap.set(3, 900)
    cap.set(4, 780)
    model = YOLO('D:/project/anti spoofing/Dataset/models/n_version_1_5.pt')    #Load the YOLO model for anti-spoofing detection.
    className = ["fake", "real"]     #Define class names for fake and real faces.
 ```````

3- Loading and Processing Attendance Images

    1- Loading Attendance Images
    
    2- Encoding Faces


4- Marking Attendance

    1- Function to Mark Attendance:
    
          Open the Attendance.csv file and read the existing attendance records.
          
          If the given name is not already in the list, append it with the current timestamp.

5- Encoding Known Faces

    1- Encode the Loaded Images:
    
        Call findEncodings to encode all loaded images and print a message upon completion.


6- Main Loop for Face Recognition and Anti-Spoofing

    1- Main Loop:
    
        Capture frames from the webcam, resize, and convert them to RGB.
        
        Detect face locations and encode faces in the current frame.
        
        Use YOLO to get anti-spoofing results.
        
    2-  Processing YOLO Results:
    
        Extract bounding boxes, confidence scores, and class labels from YOLO results.
        
    3- Face Matching:
        Compare detected face encodings with known encodings.
        Find the best match for each detected face.
    4- Draw Bounding Boxes and Labels:
        If a match is found, retrieve the name and classification (real or fake).
        Scale up the face location coordinates and draw bounding boxes.
        If the face is fake, play the alarm sound and send a signal to Arduino.
        Mark attendance for recognized faces.
    5- Displaying the Results:
        Display the processed frame with bounding boxes and labels.
        Break the loop and release the camera if 'x' is pressed.
