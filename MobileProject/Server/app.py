import firebase_admin
from firebase_admin import credentials, messaging, firestore, db
from datetime import datetime, timezone
import time

cred = credentials.Certificate('mobileproject-8bdc5-firebase-adminsdk-fbsvc-6af586b5a5.json')
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://mobileproject-8bdc5-default-rtdb.asia-southeast1.firebasedatabase.app/'  # Realtime Database URL
})

# Firestore client
db_firestore = firestore.client()

# Realtime Database reference for temperature
ref_realtime_db = db.reference('ESP/Temperature')
def send_low_temp_alert(fcm_token, temp):
    """Send push notification to the user"""
    if fcm_token and temp < 20:
        message = messaging.Message(
            notification=messaging.Notification(
                title="Low Temperature Alert",
                body=f"Temperature has dropped below 20°C: {temp}°C"
            ),
            token=fcm_token,  # Send the FCM token to the target device
        )

        # Send the message via FCM
        response = messaging.send(message)
        print(f"Low temperature notification sent: {response}")

def check_and_send_alert():
    """Check temperature and send alerts"""
    # Fetch all FCM tokens from Firestore
    users_ref = db_firestore.collection('fcmToken')
    docs = users_ref.stream()
    for doc in docs:
        user_id = doc.id
        user_data = doc.to_dict()
        fcm_token = user_data.get('fcmToken')  

        temp = ref_realtime_db.get()
        if fcm_token and temp is not None :
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
                            send_low_temp_alert(fcm_token, temp)

                            # Update the last alert timestamp in Firestore
                            alerts_ref.set({'timestamp': firestore.SERVER_TIMESTAMP}, merge=True)
                        else:
                            print("Less than 1 hour since the last alert.")
                    else:
                        print("No timestamp found in last alert.")
                else:
                    # If there's no previous alert, send a notification and create an alert
                    send_low_temp_alert(fcm_token, temp)
                    alerts_ref.set({'timestamp': firestore.SERVER_TIMESTAMP})


if __name__ == "__main__":
    # Run every minute (for example)
    while True:
        check_and_send_alert()
        time.sleep(2)  # Check every 60 seconds
