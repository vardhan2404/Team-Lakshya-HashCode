import requests
import cv2
import smtplib
import os
from email.mime.multipart import MIMEMultipart
from email.mime.image import MIMEImage
from mediapipe.framework.formats import landmark_pb2
import mediapipe as mp

cap = cv2.VideoCapture(0)

mpDraw = mp.solutions.drawing_utils
mpPose = mp.solutions.pose
pose = mpPose.Pose()

server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login("vardhan242004@gmail.com", "bkbezjqyumxitjjj")

def get_location():
    r = requests.get('https://ipinfo.io/')
    data = r.json()
    location = data['loc'].split(',')
    latitude = float(location[0])
    longitude = float(location[1])
    print(f"Latitude: {float(latitude):.10f}")
    print(f"Longitude: {float(longitude):.10f}")
    return [f"{latitude:.10f}", f"{longitude:.10f}"]

while True:
    success, img = cap.read()
    imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    results = pose.process(imgRGB)

    if results.pose_landmarks:
        loc = get_location()
        latitude = loc[0]
        longitude = loc[1]
        print("human detected!")
        img_path = 'screenshot.jpg'
        cv2.imwrite(img_path, img)
        msg = MIMEMultipart()
        with open(img_path, 'rb') as fp:
            img_data = fp.read()
        img_part = MIMEImage(img_data)
        msg.attach(img_part)
        msg['Subject'] = "Human detected @ " + str(latitude) + ", " + str(longitude)
        msg['From'] = "vardhan242004@gmail.com"
        msg['To'] = "kvardhu04@gmail.com"
        server.send_message(msg)
        print("Email sent")
        mpDraw.draw_landmarks(img, results.pose_landmarks, mpPose.POSE_CONNECTIONS)
        os.remove(img_path)
    else:
        print("human not detected")
    cv2.imshow("Image", img)
    cv2.waitKey(1)

server.quit()
