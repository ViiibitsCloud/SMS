import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_poc/widgets/Responsive_Wrapper.dart';

class TeacherGradesScreen extends StatefulWidget {
  const TeacherGradesScreen({super.key});

  @override
  State<TeacherGradesScreen> createState() => _TeacherGradesScreenState();
}

class _TeacherGradesScreenState extends State<TeacherGradesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final List<String> classes = ["6", "7", "8"];
  final List<String> students = ["Aarav", "Ananya", "Rohan"];
  final List<String> subjects = ["Math", "Science", "English"];
  final List<String> exams = ["Unit Test", "Midterm", "Final"];

  String? selectedClass;
  String? selectedStudent;
  String? selectedSubject;
  String? selectedExam;

  final marksController = TextEditingController();
  final totalController = TextEditingController(text: "100");

  String? editingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Manage Grades"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => _showAddEditSheet(),
        child: const Icon(Icons.add),
      ),
      body: ResponsiveWrapper(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection("grades")
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;

            if (docs.isEmpty) {
              return const Center(child: Text("No Grades Added"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final id = docs[index].id;

                return _buildGradeCard(data, id);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildGradeCard(Map<String, dynamic> g, String id) {
    double percentage = (g['marks'] / g['total']) * 100;

    Color color;
    String performance;

    if (percentage >= 80) {
      color = Colors.green;
      performance = "Excellent";
    } else if (percentage >= 60) {
      color = Colors.orange;
      performance = "Good";
    } else {
      color = Colors.red;
      performance = "Needs Improvement";
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${g['student']} • Class ${g['class']}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("${g['subject']} - ${g['examType']}"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Marks: ${g['marks']} / ${g['total']}"),
              Text("${percentage.toStringAsFixed(1)}%"),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              performance,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  editingId = id;
                  selectedClass = g['class'];
                  selectedStudent = g['student'];
                  selectedSubject = g['subject'];
                  selectedExam = g['examType'];
                  marksController.text = g['marks'].toString();
                  totalController.text = g['total'].toString();

                  _showAddEditSheet();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _firestore.collection("grades").doc(id).delete();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showAddEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(editingId == null ? "Add Grade" : "Edit Grade",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: selectedClass,
                hint: const Text("Class"),
                items: classes
                    .map((c) =>
                        DropdownMenuItem(value: c, child: Text("Class $c")))
                    .toList(),
                onChanged: (val) => selectedClass = val.toString(),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                value: selectedStudent,
                hint: const Text("Student"),
                items: students
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => selectedStudent = val.toString(),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                value: selectedSubject,
                hint: const Text("Subject"),
                items: subjects
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => selectedSubject = val.toString(),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                value: selectedExam,
                hint: const Text("Exam"),
                items: exams
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => selectedExam = val.toString(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: marksController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Marks"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: totalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Total Marks"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveGrade,
                child: const Text("Save"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveGrade() async {
    final marks = int.tryParse(marksController.text) ?? 0;
    final total = int.tryParse(totalController.text) ?? 100;

    final existing = await _firestore
        .collection("grades")
        .where("class", isEqualTo: selectedClass)
        .where("student", isEqualTo: selectedStudent)
        .where("subject", isEqualTo: selectedSubject)
        .where("examType", isEqualTo: selectedExam)
        .get();

    if (editingId == null && existing.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: const Text("Grade already exists"),
          backgroundColor: Colors.red,
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child:
                  const Text("DISMISS", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );

      return;
    }

    if (editingId == null) {
      await _firestore.collection("grades").add({
        "class": selectedClass,
        "student": selectedStudent,
        "subject": selectedSubject,
        "examType": selectedExam,
        "marks": marks,
        "total": total,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } else {
      await _firestore.collection("grades").doc(editingId).update({
        "class": selectedClass,
        "student": selectedStudent,
        "subject": selectedSubject,
        "examType": selectedExam,
        "marks": marks,
        "total": total,
      });

      editingId = null;
    }

    marksController.clear();
    totalController.text = "100";
    selectedClass = null;
    selectedStudent = null;
    selectedSubject = null;
    selectedExam = null;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Grade Saved Successfully"),
        backgroundColor: Colors.green,
      ),
    );
  }
}


