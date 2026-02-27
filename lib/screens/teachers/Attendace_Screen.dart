import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_poc/widgets/Responsive_Wrapper.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? selectedClass;
  String? selectedSubject;
  List<String> assignedClasses = [];
  List<String> assignedSubjects = [];
  List<Map<String, dynamic>> students = [];
  Map<String, int> report = {};

  bool loadingStudents = false;

  @override
  void initState() {
    super.initState();
    _loadTeacherData();
  }

  Future<void> _loadTeacherData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final data = doc.data();

    if (data != null) {
      setState(() {
        assignedClasses = List<String>.from(data['assignedClasses'] ?? []);
        assignedSubjects = List<String>.from(data['assignedSubjects'] ?? []);
      });
    }
  }

  Future<void> _loadStudents(String className) async {
    setState(() {
      loadingStudents = true;
      students = [];
    });
    final snapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('class', isEqualTo: className)
        .get();

    if (snapshot.docs.isEmpty) {
      setState(() {
        students = [];
        loadingStudents = false;
      });
      return;
    }

    setState(() {
      students = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'roll': data['roll'] ?? 0,
          'name': data['name'] ?? '',
          'gender': data['gender'] ?? '',
          'present': true,
        };
      }).toList();

      loadingStudents = false;
    });
  }

  Future<void> _generateReport() async {
    int present = students.where((s) => s['present']).length;
    int absent = students.length - present;
    int boysPresent =
        students.where((s) => s['gender'] == 'Boy' && s['present']).length;
    int boysAbsent =
        students.where((s) => s['gender'] == 'Boy' && !s['present']).length;
    int girlsPresent =
        students.where((s) => s['gender'] == 'Girl' && s['present']).length;
    int girlsAbsent =
        students.where((s) => s['gender'] == 'Girl' && !s['present']).length;

    setState(() {
      report = {
        'present': present,
        'absent': absent,
        'boysPresent': boysPresent,
        'boysAbsent': boysAbsent,
        'girlsPresent': girlsPresent,
        'girlsAbsent': girlsAbsent,
      };
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Attendance Report',
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Class: $selectedClass  •  Subject: $selectedSubject'),
              const SizedBox(height: 16),
              Text(
                  'Total: ${students.length}   Present: ${report['present']}   Absent: ${report['absent']}'),
              Text(
                  'Boys: ${report['boysPresent']} present • ${report['boysAbsent']} absent'),
              Text(
                  'Girls: ${report['girlsPresent']} present • ${report['girlsAbsent']} absent'),
              const SizedBox(height: 24),
              SizedBox(
                height: 220,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: report['present']!.toDouble(),
                        color: Colors.green,
                        title: 'Present\n${report['present']}',
                        radius: 80,
                        titleStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      PieChartSectionData(
                        value: report['absent']!.toDouble(),
                        color: Colors.red,
                        title: 'Absent\n${report['absent']}',
                        radius: 80,
                        titleStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'))
        ],
      ),
    );
    try {
      await FirebaseFirestore.instance.collection('attendance_reports').add({
        'class': selectedClass,
        'subject': selectedSubject,
        'date': DateTime.now().toString().substring(0, 10),
        'timestamp': FieldValue.serverTimestamp(),
        'total': students.length,
        'present': report['present'],
        'absent': report['absent'],
        'boysPresent': report['boysPresent'],
        'boysAbsent': report['boysAbsent'],
        'girlsPresent': report['girlsPresent'],
        'girlsAbsent': report['girlsAbsent'],
        // optional: 'teacher': current teacher name
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Report saved to admin panel")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save report: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: ResponsiveWrapper(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Class',
                  prefixIcon: Icon(Icons.class_),
                  border: OutlineInputBorder(),
                ),
                value: selectedClass,
                items: assignedClasses
                    .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(c),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedClass = val;
                  });
                  if (val != null) {
                    _loadStudents(val);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Subject',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
                value: selectedSubject,
                items: assignedSubjects
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => selectedSubject = val),
              ),
              const SizedBox(height: 20),
              Text("Student List",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              if (loadingStudents) const CircularProgressIndicator(),
              if (!loadingStudents && selectedClass != null && students.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No students found for this class.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              if (students.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (context, i) {
                      final s = students[i];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(s['name'][0]),
                            backgroundColor: s['gender'] == 'Boy'
                                ? Colors.blue[200]
                                : Colors.pink[200],
                          ),
                          title: Text('${s['roll']}. ${s['name']} '),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    s['present'] = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: s['present']
                                        ? Colors.green
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "P",
                                    style: TextStyle(
                                      color: s['present']
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    s['present'] = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: !s['present']
                                        ? Colors.red
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "A",
                                    style: TextStyle(
                                      color: !s['present']
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (selectedClass != null &&
                  selectedSubject != null &&
                  students.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Submit Attendance'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _generateReport,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
