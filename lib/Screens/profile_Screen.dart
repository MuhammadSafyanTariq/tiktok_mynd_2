import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';
import 'package:insta_clone/Resource/FireStore_methods.dart';
import 'package:insta_clone/Screens/login_Screen.dart';
import 'package:insta_clone/Widgets/custom_button.dart';
import 'package:insta_clone/Widgets/follow_button.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void deletePost(DocumentSnapshot snap) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shrinkWrap: true,
          children: ["Delete"]
              .map(
                (e) => InkWell(
                  onTap: () {
                    firestoreMethods()
                        .deletePost((snap.data()! as dynamic)['postId']);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Text(e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
    setState(() {});
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where(
            'uid',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();
      postLen = postSnap.docs.length;

      followers = userSnap.data()!['followers'].length;
      followers = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: AppBar(
                backgroundColor: Colors.white,
                // elevation: 10,

                title: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('assets/mynd.png'),
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
            body: Stack(
              children: [
                Positioned(
                    right: 10,
                    top: 10,
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: Colors.black.withOpacity(0.8),
                      size: 35,
                    )),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Divider(
                            color: Colors.black54,
                          ),
                          Text(
                            // userData['username'],
                            "Username",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            // userData['username'],
                            "Pronouns",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              userData['photoUrl'],
                            ),
                            radius: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              SizedBox(
                                width: 150,
                                child: FollowButton(
                                    backgroundColor: Colors.lightGreen,
                                    borderColor: Colors.white,
                                    text: "Follow",
                                    textColor: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.share,
                                color: Colors.black,
                              ),
                              Spacer(),
                            ],
                          )
                          // Row(
                          //   children: [
                          //     CircleAvatar(
                          //       backgroundColor: Colors.grey,
                          //       backgroundImage: NetworkImage(
                          //         userData['photoUrl'],
                          //       ),
                          //       radius: 35,
                          //     ),
                          //     Expanded(
                          //       flex: 1,
                          //       child: Column(
                          //         children: [
                          //           Row(
                          //             mainAxisSize: MainAxisSize.max,
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceEvenly,
                          //             children: [
                          //               buildStatColumn(postLen, 'post'),
                          //               buildStatColumn(followers, 'followers'),
                          //               buildStatColumn(following, 'followings'),
                          //             ],
                          //           ),
                          //           Row(
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               FirebaseAuth.instance.currentUser!.uid ==
                          //                       widget.uid
                          //                   ? FollowButton(
                          //                       backgroundColor:
                          //                           mobileBackgroundColor,
                          //                       borderColor:
                          //                           Colors.red.withOpacity(0.5),
                          //                       text: 'Sign Out',
                          //                       textColor: Colors.red,
                          //                       function: () async {
                          //                         await AuthMethods().signOut();
                          //                         Navigator.of(context)
                          //                             .pushReplacement(
                          //                           MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 const LoginScreen(),
                          //                           ),
                          //                         );
                          //                       },
                          //                     )
                          //                   : isFollowing
                          //                       ? FollowButton(
                          //                           backgroundColor:
                          //                               mobileBackgroundColor,
                          //                           borderColor: Colors.black,
                          //                           text: 'Unfollow',
                          //                           textColor: Colors.white,
                          //                           function: () async {
                          //                             firestoreMethods().followUser(
                          //                                 FirebaseAuth.instance
                          //                                     .currentUser!.uid,
                          //                                 userData['uid']);
                          //                             setState(() {
                          //                               isFollowing = false;
                          //                               followers--;
                          //                             });
                          //                           },
                          //                         )
                          //                       : FollowButton(
                          //                           backgroundColor: Colors.blue,
                          //                           borderColor: Colors.blue,
                          //                           text: 'Follow',
                          //                           textColor: Colors.white,
                          //                           function: () async {
                          //                             firestoreMethods().followUser(
                          //                                 FirebaseAuth.instance
                          //                                     .currentUser!.uid,
                          //                                 userData['uid']);
                          //                             setState(() {
                          //                               isFollowing = true;
                          //                               followers++;
                          //                             });
                          //                           },
                          //                         )
                          //             ],
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   padding: const EdgeInsets.only(
                          //     top: 15,
                          //   ),
                          //   child: Text(
                          //     userData['username'],
                          //     style: const TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black87,
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   padding: const EdgeInsets.only(
                          //     top: 1,
                          //   ),
                          //   child: Text(
                          //     userData['bio'],
                          //     style: TextStyle(
                          //       color: Colors.black.withOpacity(0.70),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black54,
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where('uid', isEqualTo: widget.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 1.5,
                            childAspectRatio: 1,
                          ),
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data! as dynamic).docs[index];
                            return InkWell(
                              onTap: () => deletePost(snap),
                              child: Container(
                                child: Image(
                                  image: NetworkImage(
                                      (snap.data()! as dynamic)['postUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    MainAxisSize.min;
    MainAxisAlignment.center;
    return Column(
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Container(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
