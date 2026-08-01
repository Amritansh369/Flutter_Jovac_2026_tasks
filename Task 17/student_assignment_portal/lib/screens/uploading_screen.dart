import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';
import 'submission_successful_screen.dart';

class UploadingScreen extends StatefulWidget {
  final AssignmentSubmission submission;
  const UploadingScreen({super.key, required this.submission});

  @override
  State<UploadingScreen> createState() => _UploadingScreenState();
}

class _UploadingScreenState extends State<UploadingScreen> {
  double _progress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startUpload();
  }

  void _startUpload() {
    _timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      setState(() {
        _progress += 0.04;
        if (_progress >= 1) {
          _progress = 1;
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SubmissionSuccessfulScreen(submission: widget.submission),
                ),
              );
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percent = (_progress * 100).round();
    return Scaffold(
      appBar: AppBar(title: const Text('Uploading Assignment')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_upload_outlined,
                size: 90, color: kPrimaryColor.withOpacity(0.6)),
            const SizedBox(height: 16),
            const Text(
              'Uploading Assignment...',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 110,
              height: 110,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 7,
                      backgroundColor: Colors.grey.shade200,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
