import 'package:flutter/material.dart';
import 'package:insta_clone/Widgets/app_bar.dart';
import 'notification_card.dart'; // Make sure to import the NotificationCard widget

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Alera',
      'timeAgo': 'Liked Your video',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'FineAntics',
      'timeAgo': 'Requested your video',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Lucy',
      'timeAgo': 'Added your video to a playlist',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Alera',
      'timeAgo': 'Reacted to your video',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'FineAntics',
      'timeAgo': 'Love your video',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Lucy',
      'timeAgo': 'Added your video to a playlist',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Plenty Money followed you back',
      'timeAgo': '10 mins ago',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Sukura Gafari invited you to join...',
      'timeAgo': '1 day ago',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Tolulope Adisa liked your photo',
      'timeAgo': '1 day ago',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Patrick Vinc shared a new post',
      'timeAgo': '1 day ago',
    },
    {
      'profileImage': 'https://via.placeholder.com/50',
      'message': 'Blessed Sweet invited you to ...',
      'timeAgo': '1 day ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(
            title: 'Notifications',
            backButton: false,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: height * 31,
                child: ListView.builder(
                  itemCount: notifications.length,
                  padding: EdgeInsets.only(top: 5),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationCard(
                      profileImage: notification['profileImage']!,
                      message: notification['message']!,
                      timeAgo: notification['timeAgo']!,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Messages",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: height * 31,
                child: ListView.builder(
                  itemCount: notifications.length - 3,
                  padding: EdgeInsets.only(top: 5),
                  itemBuilder: (context, index) {
                    final notification = notifications[index + 3];
                    return NotificationCard(
                      profileImage: notification['profileImage']!,
                      message: notification['message']!,
                      timeAgo: notification['timeAgo']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
