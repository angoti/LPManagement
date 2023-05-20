import { initializeApp } from "firebase/app"
import { getFirestore } from "firebase/firestore"

const firebaseConfig = {
    apiKey: "AIzaSyBWS89QNiH2ja85PIQeKlr1Rw90REThb6M",
    authDomain: "luzapp-858b0.firebaseapp.com",
    projectId: "luzapp-858b0",
    storageBucket: "luzapp-858b0.appspot.com",
    messagingSenderId: "286860749647",
    appId: "1:286860749647:web:2e2c68102427c6e212f33a",
    measurementId: "G-QM1JZSSYYQ"
};

// Initialize Firebase and Firestore
const app = initializeApp(firebaseConfig)
const db = getFirestore(app)
export { db }
