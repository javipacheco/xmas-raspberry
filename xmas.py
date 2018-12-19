import smtplib
import time
import imaplib
import email
import email.header
import json
import os.path
import sys  
from lcd import lcd

reload(sys)  
sys.setdefaultencoding('utf8')

JSON_FILE   = "data.json"
ORG_EMAIL   = "@gmail.com"
FROM_EMAIL  = "email" + ORG_EMAIL
FROM_PWD    = "password"
SMTP_SERVER = "imap.gmail.com"
SMTP_PORT   = 993

display = lcd()

def existSubject(subject, emails):
    for email in emails:
        if email['subject'] == subject:
            return True
    return False

def readMessagesFromJson():
    if os.path.exists(JSON_FILE):
        with open(JSON_FILE) as json_data:
            try: 
                e = json.load(json_data)
            except Exception, e:
                e = []
            json_data.close()
    else:
        e = []
    return e

def writeMessagesToJson(messages):
    with open(JSON_FILE, 'w') as json_data:
        json.dump(messages, json_data)
        json_data.close()

def readEmailFromGmail(emails):
    try:
        mail = imaplib.IMAP4_SSL(SMTP_SERVER)
        mail.login(FROM_EMAIL,FROM_PWD)
        mail.select('inbox')

        type, data = mail.search('utf-8', 'ALL')
        mail_ids = data[0]

        id_list = mail_ids.split()   
        first_email_id = int(id_list[0])
        latest_email_id = int(id_list[-1])

        for i in range(latest_email_id,first_email_id, -1):
            typ, data = mail.fetch(i, '(RFC822)' )

            for response_part in data:
                if isinstance(response_part, tuple):
                    msg = email.message_from_string(response_part[1])

                    decode = email.header.decode_header(msg['Subject'])[0]
                    email_subject = unicode(decode[0])
                    email_from = msg['from']

                    if not existSubject(email_subject, emails):
                        #print 'Adding new subject : ' + email_subject + '\n'
                        new_messages = True
                        with open(JSON_FILE, 'w') as json_data:
                            emails.append({'subject': email_subject, 'from': email_from})
                            json.dump(emails, json_data)
                            json_data.close()
        return emails

    except Exception, e:
        print str(e)

while True:
    print "Reading messages..."   
    emails = readMessagesFromJson()
    writeMessagesToJson(emails)
    emailsAndNewMessages = readEmailFromGmail(emails)
    display.lcd_display_messages(emailsAndNewMessages[-3:])
