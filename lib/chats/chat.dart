import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_app/constant/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String userClass = Get.parameters['userClass'] ?? '';
    final String role = Get.parameters['role'] ?? '';
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        title: Text(
          '$role Conversation',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: role == 'Teacher'
          ? TeacherView(userClass: userClass)
          : StudentView(userClass: userClass),
    );
  }
}

class TeacherView extends StatelessWidget {
  final String userClass;

  const TeacherView({super.key, required this.userClass});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('students')
          .where('class', isEqualTo: userClass)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Students Found'));
        }

        var students = snapshot.data!.docs;

        return ListView(
          children: students.map((student) {
            String studentId = student.id;
            String studentName = student['name'];

            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.freepik.com/512/14365/14365803.png'), // Replace with your image URL
              ),
              subtitle: const Text(
                "SM School System",
                style: TextStyle(color: Colors.black),
              ),
              contentPadding: const EdgeInsets.all(10),
              trailing: Icon(Icons.message_sharp, color: Colors.indigo[800]),
              title: Text(
                studentName,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Get.to(() => ChatWithUser(
                      recipientId: studentId,
                      recipientName: studentName,
                      userClass: userClass,
                      role: 'Teacher',
                    ));
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class StudentView extends StatelessWidget {
  final String userClass;

  const StudentView({super.key, required this.userClass});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot?>(
      future: FirebaseFirestore.instance
          .collection('teachers')
          .where('class', isEqualTo: userClass)
          .limit(1) // Limit the query to fetch at most one document
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.first; // Return the first document if available
        } else {
          return null; // Return null if no documents are found
        }
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No Teacher Found'));
        }

        var teacherData = snapshot.data!;
        String teacherName = teacherData['name'];
        String teacherEmail = teacherData['email'];
        String teacherId = teacherData.id;

        return Column(
          children: [
            ListTile(
              title: Center(child: Text(teacherName)),
              subtitle: Center(child: Text(teacherEmail)),
            ),
            Expanded(
              child: ChatConversation(
                recipientId: teacherId, // Pass teacherId to ChatConversation
                userClass: userClass,
                role: 'Student',
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChatWithUser extends StatelessWidget {
  final String recipientId;
  final String recipientName;
  final String userClass;
  final String role;

  const ChatWithUser({
    super.key,
    required this.recipientId,
    required this.recipientName,
    required this.userClass,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        title: Text(
          'Chat with $recipientName',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ChatConversation(
        recipientId: recipientId,
        userClass: userClass,
        role: role,
      ),
    );
  }
}

class ChatConversation extends StatelessWidget {
  final String recipientId;
  final String userClass;
  final String role;

  const ChatConversation({
    super.key,
    required this.recipientId,
    required this.userClass,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    String chatRoomId = role == 'Student'
        ? 'chat${FirebaseAuth.instance.currentUser!.uid}$recipientId'
        : 'chat$recipientId${FirebaseAuth.instance.currentUser!.uid}';

    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .doc(chatRoomId)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No Messages Available'));
              }

              var messages = snapshot.data!.docs;
              List<MessageWidget> messageWidgets = [];
              for (var message in messages) {
                var messageText = message['message'];
                var messageSender = message['sender'];
                var currentUser = FirebaseAuth.instance.currentUser!.email;

                final messageWidget = MessageWidget(
                  sender: messageSender,
                  text: messageText,
                  isMe: currentUser == messageSender,
                );
                messageWidgets.add(messageWidget);
              }
              return ListView(
                reverse: true,
                children: messageWidgets,
              );
            },
          ),
        ),
        const Divider(height: 1.0),
        MessageInput(
          recipientId: recipientId,
          chatRoomId: chatRoomId, // Pass chatRoomId
        ),
      ],
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageWidget({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(
              height: 5.0), // Add spacing between sender name and message
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 0.0 : 15.0),
              topRight: Radius.circular(isMe ? 15.0 : 0.0),
              bottomLeft: const Radius.circular(15.0),
              bottomRight: const Radius.circular(15.0),
            ),
            elevation: 5.0,
            color: isMe ? Colors.deepOrange : Colors.indigo[800],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final String recipientId;
  final String chatRoomId;

  const MessageInput({
    super.key,
    required this.recipientId,
    required this.chatRoomId,
  });

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final messageText = _messageController.text.trim();

    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatRoomId)
          .collection('messages')
          .add({
        'message': messageText,
        'sender': FirebaseAuth.instance.currentUser!.email,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Enter Your message....',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 2, color: Colors.indigo),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 2, color: Colors.indigo),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 2, color: Colors.indigo),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 33,
              color: Colors.indigo[800],
            ),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
