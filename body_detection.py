import requests

import smtplib

# server = smtplib.SMTP('smtp.gmail.com', 587)
#
# server.starttls()
#
# server.login("mail@gmail.com", "password")

def get_location():
    r = requests.get('https://ipinfo.io/')
    data = r.json()
    location = data['loc'].split(',')
    latitude = float(location[0])
    longitude = float(location[1])
    print(f"Latitude: {float(latitude):.10f}")
    print(f"Longitude: {float(longitude):.10f}")
    return [f"{latitude:.10f}", f"{longitude:.10f}"]


import cv2
import mediapipe as mp

cap = cv2.VideoCapture(0)

mpDraw = mp.solutions.drawing_utils
mpPose = mp.solutions.pose
pose = mpPose.Pose()


while True:
    success, img = cap.read()
    imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    results = pose.process(imgRGB)

    if results.pose_landmarks:

        loc = get_location()
        latitude = loc[0]
        longitude = loc[1]
        print("human detected!")
        # server.sendmail("mail@gmail.com", "kganeshv12@gmail.com", "human detected @ "+ str(loc[0])+ ", "+ str(loc[1]))
        # print("mail sent")
        mpDraw.draw_landmarks(img, results.pose_landmarks, mpPose.POSE_CONNECTIONS)
    else:
        print("human not detected")
    cv2.imshow("Image", img)

    cv2.waitKey(1)
