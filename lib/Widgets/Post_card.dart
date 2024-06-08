// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:insta_clone/Models/user.dart';
// import 'package:insta_clone/Provider/user_provider.dart';
// import 'package:insta_clone/Resource/FireStore_methods.dart';
// import 'package:insta_clone/Screens/comment_screens.dart';
// import 'package:insta_clone/Widgets/like_animation.dart';
// import 'package:insta_clone/utils/colors.dart';
// import 'package:insta_clone/utils/utils.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class PostCard extends StatefulWidget {
//   final snap;
//   const PostCard({
//     super.key,
//     required this.snap,
//   });

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   bool isLikeAnimating = false;
//   int commentLen = 0;
//   @override
//   void initState() {
//     super.initState();
//     getComment();
//   }

//   void getComment() async {
//     try {
//       QuerySnapshot snap = await FirebaseFirestore.instance
//           .collection("posts")
//           .doc(widget.snap['postId'])
//           .collection('comments')
//           .get();
//       commentLen = snap.docs.length;
//     } catch (e) {
//       showSnackBar(e.toString(), context);
//     }
//     //setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final UserModel user = Provider.of<UserProvider>(context).getUser;
//     return Container(
//       color: mobileBackgroundColor,
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 4,
//               horizontal: 16,
//             ).copyWith(right: 0),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                     radius: 16,
//                     backgroundImage: NetworkImage(
//                       widget.snap['profImage'],
//                     )),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       left: 8,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.snap['username'],
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onDoubleTap: () async {
//               setState(() {
//                 isLikeAnimating = true;
//               });
//               await firestoreMethods().likePost(
//                 widget.snap['postId'],
//                 user.uid!,
//                 widget.snap['likes'],
//               );
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.35,
//                   width: double.infinity,
//                   child: Image.network(
//                     widget.snap['postUrl'],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 AnimatedOpacity(
//                   duration: const Duration(milliseconds: 200),
//                   opacity: isLikeAnimating ? 1 : 0,
//                   child: LikeAnimation(
//                     isAnimating: isLikeAnimating,
//                     duration: const Duration(milliseconds: 400),
//                     onEnd: () {
//                       setState(
//                         () {
//                           isLikeAnimating = false;
//                         },
//                       );
//                     },
//                     child: const Icon(
//                       Icons.favorite,
//                       color: Colors.white,
//                       size: 100,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               LikeAnimation(
//                 isAnimating: widget.snap['likes'].contains(user.uid),
//                 smallLike: true,
//                 child: IconButton(
//                     onPressed: () async {
//                       await firestoreMethods().likePost(
//                         widget.snap['postId'],
//                         user.uid!,
//                         widget.snap['likes'],
//                       );
//                     },
//                     icon: widget.snap['likes'].contains(user.uid)
//                         ? const Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                           )
//                         : const Icon(Icons.favorite_border_outlined)),
//               ),
//               IconButton(
//                 onPressed: () => Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => CommentScreen(
//                     snap: widget.snap,
//                   ),
//                 )),
//                 icon: const Icon(
//                   Icons.comment_outlined,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content:
//                         Text('Sorry this feature will be supported in future'),
//                   ),
//                 ),
//                 icon: const Icon(
//                   Icons.send,
//                 ),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: IconButton(
//                     icon: const Icon(Icons.bookmark_border),
//                     onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                             'Sorry this feature will be supported in future'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DefaultTextStyle(
//                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                         fontWeight: FontWeight.w800,
//                       ),
//                   child: Text(
//                     '${widget.snap["likes"].length} likes',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.only(
//                     top: 8,
//                   ),
//                   child: RichText(
//                     text: TextSpan(
//                       style: const TextStyle(color: primaryColor),
//                       children: [
//                         TextSpan(
//                           text: widget.snap['username'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(
//                           text: "   " + widget.snap['description'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 4,
//                     ),
//                     child: Text(
//                       "view all $commentLen comments",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: secondaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 4,
//                   ),
//                   child: Text(
//                     DateFormat.yMMMd().format(
//                       widget.snap['datePublished'].toDate(),
//                     ),
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: secondaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:insta_clone/Models/user.dart';
import 'package:insta_clone/Provider/user_provider.dart';
import 'package:insta_clone/Resource/FireStore_methods.dart';
import 'package:insta_clone/Screens/comment_screens.dart';
import 'package:insta_clone/Widgets/like_animation.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;
  late VideoPlayerController _controller;
  bool isVideo = true;

  @override
  void initState() {
    super.initState();
    getComment();
    // isVideo = widget.snap['postUrl'].endsWith('.mp4');
    if (isVideo) {
      _controller = VideoPlayerController.network(widget.snap['postUrl'])
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    }
  }

  void getComment() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      setState(() {
        commentLen = snap.docs.length;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    if (isVideo) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Stack(
      children: [
        isVideo
            ? _controller.value.isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator())
            : SizedBox.expand(
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.cover,
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.snap['username'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.snap['description'],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        Positioned(
          right: 12,
          bottom: 30,
          child: Column(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await firestoreMethods().likePost(
                      widget.snap['postId'],
                      user.uid!,
                      widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 30,
                        ),
                ),
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () => showBottomSheet(
                    builder: ((context) => CommentScreen(snap: widget.snap)),
                    context: context),

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => CommentScreen(
                //       snap: widget.snap,
                //     ),
                //   ),
                // ),
                icon: const Icon(
                  Icons.comment_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Sorry, this feature will be supported in the future'),
                  ),
                ),
                icon: const Icon(
                  Icons.bookmark,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Sorry, this feature will be supported in the future'),
                  ),
                ),
                icon: const Icon(
                  FontAwesomeIcons.share,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "For You",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 20,
                  width: 2,
                  color: Colors.white,
                ),
                Text(
                  "Following",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 20,
                  width: 2,
                  color: Colors.white,
                ),
                Text(
                  "Shop",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Icon(
                  Icons.search,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          top: 15,
          // right: 10,
          // right: 10,
        )
      ],
    );
  }
}
