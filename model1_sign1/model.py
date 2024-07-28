import time
import pickle
import cv2
import mediapipe as mp
import numpy as np


def SignModel(cap, model, hands, labels_dict):
    last_detected_time = time.time()  # Initialize last detected time
    detected_character = None

    while True:
        current_time = time.time()  # Get current time
        elapsed_time = current_time - last_detected_time  # Calculate elapsed time since last detection

        ret, frame = cap.read()
        H, W, _ = frame.shape

        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = hands.process(frame_rgb)

        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                mp_drawing.draw_landmarks(
                    frame,
                    hand_landmarks,
                    mp_hands.HAND_CONNECTIONS,
                    mp_drawing_styles.get_default_hand_landmarks_style(),
                    mp_drawing_styles.get_default_hand_connections_style()
                )

                data_aux = []
                x_ = []
                y_ = []

                for i in range(len(hand_landmarks.landmark)):
                    x = hand_landmarks.landmark[i].x
                    y = hand_landmarks.landmark[i].y

                    x_.append(x)
                    y_.append(y)

                for i in range(len(hand_landmarks.landmark)):
                    x = hand_landmarks.landmark[i].x
                    y = hand_landmarks.landmark[i].y
                    data_aux.append(x - min(x_))
                    data_aux.append(y - min(y_))

                x1 = int(min(x_) * W) - 10
                y1 = int(min(y_) * H) - 10

                x2 = int(max(x_) * W) - 10
                y2 = int(max(y_) * H) - 10

                if elapsed_time > 2.0:  # Check if more than 2 seconds have passed since last detection
                    prediction = model.predict([np.asarray(data_aux)])
                    predicted_character = labels_dict[int(prediction[0])]

                    if detected_character != predicted_character:
                        detected_character = predicted_character
                        last_detected_time = current_time

                    cv2.rectangle(frame, (x1, y1), (x2, y2), (128, 0, 128), 4)
                    cv2.putText(frame, detected_character, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.3, (128, 0, 128), 6,
                                cv2.LINE_AA)
                    # Send a signal to Arduino based on the predicted sign
                    # ...

        cv2.imshow('frame', frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break


model_dict = pickle.load(open('./model.p', 'rb'))
model = model_dict['model']

cap = cv2.VideoCapture(0)
cap.set(3, 640)  # Width
cap.set(4, 480)  # Height

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles

hands = mp_hands.Hands(static_image_mode=True, min_detection_confidence=0.8, max_num_hands=1)

labels_dict = {0: 'A', 1: 'B', 2: 'C', 3:'D',4:'E',5:'F',6:'G',7:'H',8:'I',9:'K',10:'L',11:'O',12:'R',13:'V',14:'W',15:'Y'}

while True:
    if mp.solutions.hands:
        SignModel(cap, model, hands, labels_dict)

cap.release()
cv2.destroyAllWindows()
