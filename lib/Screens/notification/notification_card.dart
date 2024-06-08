import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String profileImage;
  final String message;
  final String timeAgo;

  const NotificationCard({
    Key? key,
    required this.profileImage,
    required this.message,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              // backgroundImage: NetworkImage(profileImage),
              // foregroundColor: Colors.amber,
              backgroundColor: Colors.black.withOpacity(0.12),
              radius: 25,
              // backgroundImage: NetworkImage(profileImage),
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
