import 'package:flutter/material.dart';
import '../main.dart';
import 'uploading_screen.dart';

class SubmitAssignmentScreen extends StatefulWidget {
  final AssignmentSubmission submission;
  const SubmitAssignmentScreen({super.key, required this.submission});

  @override
  State<SubmitAssignmentScreen> createState() =>
      _SubmitAssignmentScreenState();
}

class _SubmitAssignmentScreenState extends State<SubmitAssignmentScreen> {
  late AssignmentSubmission _submission;

  @override
  void initState() {
    super.initState();
    _submission = widget.submission;
    // Sensible defaults so the form isn't empty, matching the mockup.
    _submission.submissionDate ??= DateTime(2026, 7, 28);
    _submission.submissionTime ??= const TimeOfDay(hour: 15, minute: 30);
    _submission.fileName ??= 'assignment_flutter.pdf';
    _submission.fileSizeMb ??= 2.3;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _submission.submissionDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(primary: kPrimaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _submission.submissionDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _submission.submissionTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(primary: kPrimaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _submission.submissionTime = picked);
    }
  }

  void _removeFile() {
    setState(() {
      _submission.fileName = null;
      _submission.fileSizeMb = null;
    });
  }

  void _submit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UploadingScreen(submission: _submission),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Assignment')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _FieldLabel(
                icon: Icons.event_outlined, text: 'Select Submission Date'),
            const SizedBox(height: 6),
            _PickerField(
              value: _submission.formattedDate,
              icon: Icons.calendar_today_outlined,
              onTap: _pickDate,
            ),
            const SizedBox(height: 18),
            const _FieldLabel(
                icon: Icons.schedule_outlined, text: 'Select Submission Time'),
            const SizedBox(height: 6),
            _PickerField(
              value: _submission.formattedTime,
              icon: Icons.access_time,
              onTap: _pickTime,
            ),
            const SizedBox(height: 18),
            const _FieldLabel(
                icon: Icons.attach_file, text: 'Upload Assignment File'),
            const SizedBox(height: 6),
            if (_submission.fileName != null)
              _FileChip(
                fileName: _submission.fileName!,
                sizeMb: _submission.fileSizeMb!,
                onRemove: _removeFile,
              )
            else
              OutlinedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Choose File'),
                onPressed: () {
                  setState(() {
                    _submission.fileName = 'assignment_flutter.pdf';
                    _submission.fileSizeMb = 2.3;
                  });
                },
              ),
            const SizedBox(height: 6),
            Text(
              '(PDF, DOCX, ZIP files only)',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _submission.fileName != null ? _submit : null,
              child: const Text('Submit Assignment'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FieldLabel({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      ],
    );
  }
}

class _PickerField extends StatelessWidget {
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  const _PickerField(
      {required this.value, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(value, style: const TextStyle(fontSize: 15)),
            ),
            Icon(icon, size: 20, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

class _FileChip extends StatelessWidget {
  final String fileName;
  final double sizeMb;
  final VoidCallback onRemove;
  const _FileChip(
      {required this.fileName, required this.sizeMb, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('PDF',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 11)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fileName,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${sizeMb.toStringAsFixed(1)} MB',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
