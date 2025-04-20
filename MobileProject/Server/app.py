import firebase_admin
from firebase_admin import credentials, messaging, firestore, db
from datetime import datetime, timezone
import time

cred = credentials.Certificate('mobileproject-8bdc5-firebase-adminsdk-fbsvc-6af586b5a5.json')
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://mobileproject-8bdc5-default-rtdb.asia-southeast1.firebasedatabase.app/' 
})

# Firestore client
db_firestore = firestore.client()

# Realtime Database reference for temperature
ref_realtime_db = db.reference('ESP/Temperature')
def send_alert(fcm_token, temp):
    if fcm_token and temp < 20:
        message = messaging.Message(
            notification=messaging.Notification(
                title="Low Temperature Alert",
                body=f"Temperature has dropped below 20°C: {temp} °C Please make it warm. . . Or maybe your device is disconnected?"
            ),
            token=fcm_token,  
        )

        # Send the message via FCM
        response = messaging.send(message)
        print(f"Low temperature notification sent: {response}")

def check_and_send_alert():
    users_ref = db_firestore.collection('fcmToken')
    docs = users_ref.stream()
    for doc in docs:
        user_id = doc.id
        user_data = doc.to_dict()
        fcm_token = user_data.get('fcmToken')  
        
        temp = ref_realtime_db.get()
        if fcm_token and temp is not None :
            notificationstatus = user_data.get('notificationsEnabled')
            if notificationstatus:
                current_time = datetime.now(timezone.utc)
                if temp < 20:
                    alerts_ref = db_firestore.collection('alerts').document(user_id)
                    last_alert_doc = alerts_ref.get()

                    if last_alert_doc.exists:
                        last_alert_time = last_alert_doc.to_dict().get('timestamp')
                        if last_alert_time:
                            last_alert_time = last_alert_time.replace(tzinfo=timezone.utc)
                            time_diff = current_time - last_alert_time

                            if time_diff.total_seconds() > 3600:
                                send_alert(fcm_token, temp)

                                alerts_ref.set({'timestamp': firestore.SERVER_TIMESTAMP}, merge=True)
                            else:
                                print("Less than 1 hour since the last alert.")
                        else:
                            print("No timestamp found in last alert.")
                    else:
                        send_alert(fcm_token, temp)
                        alerts_ref.set({'timestamp': firestore.SERVER_TIMESTAMP})
                else:
                    print("Temperature is above 20°C, no alert sent.")
            else:
                print(f"Notifications are disabled for this user {user_id}.")


if __name__ == "__main__":
    while True:
        check_and_send_alert()
        time.sleep(10)  
