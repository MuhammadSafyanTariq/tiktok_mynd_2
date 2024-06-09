import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Widgets/Post_card.dart';
import 'package:insta_clone/Widgets/app_bar.dart';
import 'package:insta_clone/utils/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('assets/logo.png'),
                    height: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Mynd',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            }),
      ),
    );
  }
}
