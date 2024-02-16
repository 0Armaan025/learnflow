import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({Key? key}) : super(key: key);

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  // Dummy data for homework
  final List<Map<String, dynamic>> homeworkList = [
    {'teacher': 'rohan sir', 'subject': 'Math', 'description': 'Complete exercises 1-5', 'timestamp': '5', 'attachments': []},
    {'teacher': 'ritik sir', 'subject': 'Science', 'description': 'Read chapter 3 and answer questions', 'timestamp': '15', 'attachments': ['https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf']},
    {'teacher': 'Roshan sir', 'subject': 'English', 'description': 'Write a short essay on your favorite book', 'timestamp': '30', 'attachments': ['https://images.examples.com/wp-content/uploads/2017/06/Photo-Essay-Examples.png', 'https://images.examples.com/wp-content/uploads/2017/06/Photo-Essay-Examples.png']},
    // Add more homework as needed
  ];

  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homework'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: homeworkList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        homeworkList[index]['teacher'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(homeworkList[index]['subject'] ?? ''),
                          Text(homeworkList[index]['description'] ?? ''),
                          if (homeworkList[index]['attachments'] != null)
                            ..._buildAttachmentWidgets(homeworkList[index]['attachments']),
                          SizedBox(height: 5),
                          Text(_calculateTimeAgo(int.parse(homeworkList[index]['timestamp'] ?? '0'))),
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
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Type your homework...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Add a new homework
                    setState(() {
                      String newDescription = _descriptionController.text.trim();
                      if (newDescription.isNotEmpty) {
                        homeworkList.insert(
                          0,
                          {
                            'teacher': 'SHCS',
                            'subject': 'English',
                            'description': newDescription,
                            'timestamp': '0',
                            'attachments': ['https://example.com/pdf3.pdf'],
                          },
                        );
                        _descriptionController.clear();
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

  List<Widget> _buildAttachmentWidgets(List<dynamic> attachments) {
    return attachments.map((attachment) {
      if (attachment is String) {
        if (attachment.endsWith('.pdf')) {
          return ElevatedButton(
            onPressed: () {
              _openPDF(attachment);
            },
            child: Text('View PDF'),
          );
        } else if (attachment.endsWith('.jpg') || attachment.endsWith('.jpeg') || attachment.endsWith('.png')) {
          return Image.network(attachment, width: 100, height: 100, fit: BoxFit.cover);
        }
      }
      return Container();
    }).toList();
  }

  Future<void> _openPDF(String pdfUrl) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFView(
          filePath: pdfUrl,
          // You can pass additional options here
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
