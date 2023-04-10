import smtplib

server = smtplib.SMTP('smtp.gmail.com', 587)

server.starttls()

server.login("vardhan242004@gmail.com", "bkbezjqyumxitjjj")

server.sendmail("vardhan242004@gmail.com", "varun80042@gmail.com", "Mail sent from python code")
print("mail sent")