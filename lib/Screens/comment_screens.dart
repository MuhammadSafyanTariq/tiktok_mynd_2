import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/user.dart';
import 'package:insta_clone/Provider/user_provider.dart';
import 'package:insta_clone/Resource/FireStore_methods.dart';
import 'package:provider/provider.dart';

import '../Widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Comments (100)",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black26,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => CommentCard(
                    snap: (snapshot.data! as dynamic).docs[index],
                  ),
                ),
              ),
              const Spacer(),
              const Divider(
                color: Colors.black26,
              ),
              Container(
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 8,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl!),
                      radius: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Comment as ${user.username}',
                          hintStyle: const TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        firestoreMethods().postComment(
                          widget.snap['postId'],
                          _commentController.text,
                          user.uid!,
                          user.username!,
                          user.photoUrl!,
                        );
                        _commentController.text = "";
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: const Text(
                          'Post',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
