import cv2
import numpy as np
import tensorflow as tf
import pygame


def predictImage(frame):
    img1 = cv2.resize(frame, (150, 150))
    y = np.expand_dims(img1, axis = 0)
    val = model.predict(y)
    print(val)
    if val == 0:
        cv2.putText(frame, "NO Fire", (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
    else:
        cv2.putText(frame, "Fire", (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)
        pygame.mixer.music.play()
        
        pygame.mixer.music.stop()
    cv2.imshow('frame', frame)

model = tf.keras.saving.load_model('forest_fire_detection_model.h5')
pygame.mixer.init()
pygame.mixer.music.load("Malarm.mp3")

cap = cv2.VideoCapture(0)

while(True):
    
    ret, frame = cap.read()

    
    predictImage(frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break


cap.release()
cv2.destroyAllWindows()
