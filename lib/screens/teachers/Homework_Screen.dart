import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_poc/widgets/Responsive_Wrapper.dart';

class TeacherHomeworkScreen extends StatefulWidget {
  const TeacherHomeworkScreen({super.key});

  @override
  State<TeacherHomeworkScreen> createState() => _TeacherHomeworkScreenState();
}

class _TeacherHomeworkScreenState extends State<TeacherHomeworkScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> classes = ["8", "9", "10"];
  final List<String> subjects = ["Math", "Science", "English"];

  String? selectedClass;
  String? selectedSubject;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? editingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Homework"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditSheet(),
        child: const Icon(Icons.add),
      ),
      body: ResponsiveWrapper(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection("homework")
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;

            if (docs.isEmpty) {
              return const Center(child: Text("No Homework Added"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final id = docs[index].id;

                return _buildHomeworkCard(data, id);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHomeworkCard(Map<String, dynamic> hw, String id) {
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
          Text("${hw['subject']} • Class ${hw['class']}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(hw['title'],
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(hw['description']),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  editingId = id;
                  selectedClass = hw['class'];
                  selectedSubject = hw['subject'];
                  titleController.text = hw['title'];
                  descriptionController.text = hw['description'];

                  _showAddEditSheet();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _firestore.collection("homework").doc(id).delete();
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
              Text(editingId == null ? "Add Homework" : "Edit Homework",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: selectedClass,
                hint: const Text("Select Class"),
                items: classes
                    .map((c) =>
                        DropdownMenuItem(value: c, child: Text("Class $c")))
                    .toList(),
                onChanged: (val) => selectedClass = val.toString(),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                value: selectedSubject,
                hint: const Text("Select Subject"),
                items: subjects
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => selectedSubject = val.toString(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveHomework,
                child: const Text("Save"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveHomework() async {
    if (editingId == null) {
      await _firestore.collection("homework").add({
        "class": selectedClass,
        "subject": selectedSubject,
        "title": titleController.text,
        "description": descriptionController.text,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } else {
      await _firestore.collection("homework").doc(editingId).update({
        "class": selectedClass,
        "subject": selectedSubject,
        "title": titleController.text,
        "description": descriptionController.text,
      });

      editingId = null;
    }

    titleController.clear();
    descriptionController.clear();
    selectedClass = null;
    selectedSubject = null;

    Navigator.pop(context);
  }
}
