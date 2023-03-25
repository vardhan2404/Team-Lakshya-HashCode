import cv2
import numpy as np
import tensorflow as tf

def predictImage(frame):
    img1 = cv2.resize(frame, (150, 150))
    y = np.expand_dims(img1, axis = 0)
    val = model.predict(y)
    print(val)
    if val == 0:
        cv2.putText(frame, "NO Fire", (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
    else:
        cv2.putText(frame, "Fire", (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)
    cv2.imshow('frame', frame)

model = tf.keras.saving.load_model('forest_fire_detection_model.h5')

cap = cv2.VideoCapture(0)

while(True):
    # Capture frame-by-frame
    ret, frame = cap.read()

    # Display the resulting frame
    predictImage(frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()