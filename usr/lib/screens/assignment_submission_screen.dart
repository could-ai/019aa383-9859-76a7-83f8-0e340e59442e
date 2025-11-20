import 'package:flutter/material.dart';

class AssignmentSubmissionScreen extends StatefulWidget {
  const AssignmentSubmissionScreen({super.key});

  @override
  State<AssignmentSubmissionScreen> createState() => _AssignmentSubmissionScreenState();
}

class _AssignmentSubmissionScreenState extends State<AssignmentSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _assignmentTitleController = TextEditingController();
  String? _selectedFileName;

  void _pickFile() {
    // In a real app, use file_picker package.
    // Here we simulate picking a file.
    setState(() {
      _selectedFileName = "homework_assignment_v1.pdf";
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFileName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload a file'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show success message
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Submission Successful'),
            ],
          ),
          content: Text(
              'Thank you, ${_nameController.text}! Your assignment has been successfully submitted.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to dashboard
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _assignmentTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment Submission')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Submit Your Work',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fill in the details below and upload your assignment file.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _classController,
                decoration: const InputDecoration(
                  labelText: 'Class / Section',
                  prefixIcon: Icon(Icons.class_),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your class' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _assignmentTitleController,
                decoration: const InputDecoration(
                  labelText: 'Assignment Number / Title',
                  prefixIcon: Icon(Icons.assignment),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter assignment title' : null,
              ),
              const SizedBox(height: 24),
              
              // File Upload Area
              InkWell(
                onTap: _pickFile,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _selectedFileName != null ? Colors.green.shade50 : Colors.blue.shade50,
                    border: Border.all(
                      color: _selectedFileName != null ? Colors.green : Colors.blue,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _selectedFileName != null ? Icons.check_circle : Icons.cloud_upload_outlined,
                        size: 48,
                        color: _selectedFileName != null ? Colors.green : Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _selectedFileName ?? 'Tap to Upload File',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedFileName != null ? Colors.green.shade700 : Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedFileName != null 
                          ? 'File ready for submission'
                          : 'Supported formats: PDF, DOCX, JPG, PNG',
                        style: TextStyle(
                          fontSize: 12,
                          color: _selectedFileName != null ? Colors.green.shade600 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 8),
                    Text('Submit Assignment', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
