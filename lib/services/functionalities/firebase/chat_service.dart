// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:school_app/model/message.dart';

// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<String?> getUserClass(String userId) async {
//     final doc = await _firestore.collection('users').doc(userId).get();
//     return doc.data()?['class'];
//   }

//   Future<void> sendMessage(String receiverId, String message) async {
//     final String currentUserId = _auth.currentUser!.uid;
//     final String currentUserEmail = _auth.currentUser!.email!;
//     final Timestamp timestamp = Timestamp.now();

//     String? currentUserClass = await getUserClass(currentUserId);
//     String? receiverClass = await getUserClass(receiverId);

//     if (currentUserClass != null &&
//         receiverClass != null &&
//         currentUserClass == receiverClass) {
//       Message newMessage = Message(
//         senderId: currentUserId,
//         senderEmail: currentUserEmail,
//         receiverId: receiverId,
//         message: message,
//         timestamp: timestamp,
//       );
//       List<String> ids = [currentUserId, receiverId];
//       ids.sort();
//       String chatRoomId = ids.join('_');
//       await _firestore
//           .collection('chatrooms')
//           .doc(chatRoomId)
//           .collection('messages')
//           .add(newMessage.toMap());
//     } else {
//       throw Exception('You can only message users in your own class.');
//     }
//   }

//   Stream<QuerySnapshot> getMessages(String userId, String otherUserID) {
//     List<String> ids = [userId, otherUserID];
//     ids.sort();
//     String chatRoomId = ids.join('_');
//     return _firestore
//         .collection('chatrooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//   }
// }
