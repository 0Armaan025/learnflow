import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  // Dummy data for announcements
  final List<Map<String, String>> announcements = [
    {'school': 'Sacred Heart Convent School', 'announcement': 'Important notice for upcoming event.', 'timestamp': '5'},
    {'school': 'Sacred Heart Convent School', 'announcement': 'School will be closed on Monday.', 'timestamp': '15'},
    {'school': 'Sacred Heart Convent School', 'announcement': 'Parent-Teacher meeting scheduled for next week.', 'timestamp': '30'},
    // Add more announcements as needed
  ];

  TextEditingController _announcementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('https://lh3.googleusercontent.com/proxy/M203TuwuLhvA579cDT4QCt1vgGbR9qX8XlVOTQDrKmeMvGfd4_0t2La0sMhXBqxiAytFKn17F9A5xyP9LgdEy-xRFMO4i6hWjaPQ'),
                      ),
                      title: Text(
                        announcements[index]['school'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(announcements[index]['announcement'] ?? ''),
                          SizedBox(height: 5),
                          Text(_calculateTimeAgo(int.parse(announcements[index]['timestamp'] ?? '0'))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _announcementController,
                      decoration: InputDecoration(
                        hintText: 'Type your announcement...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Add a new announcement
                    setState(() {
                      String newAnnouncement = _announcementController.text.trim();
                      if (newAnnouncement.isNotEmpty) {
                        announcements.insert(
                          0,
                          {'school': 'Sacred Heart Convent School', 'announcement': newAnnouncement, 'timestamp': '0'},
                        );
                        _announcementController.clear();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _calculateTimeAgo(int minutesAgo) {
    String timeAgo = 'just now';
    if (minutesAgo > 0) {
      timeAgo = '$minutesAgo ${minutesAgo == 1 ? 'minute' : 'minutes'} ago';
    }
    return timeAgo;
  }
}
