import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp(functions.config().firebase);

const db = admin.firestore();
export const createUserProfile = functions.auth.user().onCreate(user => {
  const { uid, email } = user;
  const profile = {
    uid: uid,
    email: email,
  };

   return db
     .collection('users')
     .doc(uid)
     .set(profile);
});
