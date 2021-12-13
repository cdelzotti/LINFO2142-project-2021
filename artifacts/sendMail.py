import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from datetime import date
import sys


def sendReport(filename,filepath):
    # You must use an email address for your script to work
    fromaddr = "emitter_address@gmail.com"
    email_password = "emitter_password"
    # Where you want to send the email
    toaddr = "some.address@student.uclouvain.be"
    subject = "Monitoring daily report"
    body = f"This is monitoring daily report for {date.today()}"
    filename = filename
    filepath = filepath

    # instance of MIMEMultipart
    msg = MIMEMultipart()
    msg['From'] = fromaddr
    msg['To'] = toaddr
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))
    # Get attachment
    attachment = open(filepath, "rb")
    p = MIMEBase('application', 'octet-stream')
    p.set_payload((attachment).read())
    encoders.encode_base64(p)
    p.add_header('Content-Disposition', "attachment; filename= %s" % filename)
    msg.attach(p)
    # Send mail
    try:
        s = smtplib.SMTP('smtp.gmail.com', 587)
        s.starttls()
        s.login(fromaddr, email_password)
        text = msg.as_string()
        s.sendmail(fromaddr, toaddr, text)
        s.close()
    except Exception as e:
        print(f"Exception found : {e}")

sendReport(sys.argv[1], f"archives/{sys.argv[1]}")