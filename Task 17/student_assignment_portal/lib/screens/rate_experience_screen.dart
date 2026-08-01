import 'package:flutter/material.dart';
import '../main.dart';
import 'assignment_details_screen.dart';

class RateExperienceScreen extends StatefulWidget {
  final AssignmentSubmission submission;
  const RateExperienceScreen({super.key, required this.submission});

  @override
  State<RateExperienceScreen> createState() => _RateExperienceScreenState();
}

class _RateExperienceScreenState extends State<RateExperienceScreen> {
  double _rating = 4.5;

  void _setRatingFromTap(int starIndex, bool halfTap) {
    setState(() {
      _rating = halfTap ? starIndex + 0.5 : starIndex + 1.0;
    });
  }

  void _submitRating() {
    widget.submission.rating = _rating;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thank you for your feedback!')),
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AssignmentDetailsScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Your Experience')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'How was your assignment\nsubmission experience?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  IconData icon;
                  if (_rating >= index + 1) {
                    icon = Icons.star;
                  } else if (_rating >= index + 0.5) {
                    icon = Icons.star_half;
                  } else {
                    icon = Icons.star_border;
                  }
                  return IconButton(
                    iconSize: 40,
                    icon: Icon(icon, color: Colors.amber),
                    onPressed: () => _setRatingFromTap(index, false),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Text(
                '${_rating.toStringAsFixed(1)} / 5',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Thank you for your feedback!',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitRating,
                  child: const Text('Submit Rating'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
