
// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

/**
 * Triggered by a change to a Firestore document.
 *
 * @param {!Object} event Event payload.
 * @param {!Object} context Metadata for the event.
 */
exports.messageNotificationTrigger = (change, context) => {
  db.collection("users").get().then((snapshot) => {
    snapshot.docs.forEach((doc) => {
      const userData = doc.data();

      if (userData.id == "<YOUR_USER_ID>") {
        admin.messaging().sendToDevice(userData.deviceToken, {
          notification: {
            title: "Notification title", body: "Notification Body"},
        });
      }
    });
  });
};
