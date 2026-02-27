import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:school_poc/widgets/Responsive_Wrapper.dart';

class FeesRemainingScreen extends StatefulWidget {
  const FeesRemainingScreen({super.key});

  @override
  State<FeesRemainingScreen> createState() => _FeesRemainingScreenState();
}

class _FeesRemainingScreenState extends State<FeesRemainingScreen> {
  String? selectedClass;
  String? selectedDivision;
  String searchQuery = "";

  static final List<Map<String, dynamic>> allStudents = [
    {'class': '10', 'division': 'A', 'roll': '01', 'name': 'Aarav Sharma', 'total': 48000, 'paid': 32000, 'pending': 16000},
    {'class': '10', 'division': 'A', 'roll': '02', 'name': 'Ananya Patil', 'total': 48000, 'paid': 48000, 'pending': 0},
    {'class': '10', 'division': 'B', 'roll': '01', 'name': 'Rohan Gupta', 'total': 48000, 'paid': 20000, 'pending': 28000},
    {'class': '9', 'division': 'A', 'roll': '01', 'name': 'Sneha Deshmukh', 'total': 45000, 'paid': 45000, 'pending': 0},
    {'class': '8', 'division': 'A', 'roll': '01', 'name': 'Vihaan Rao', 'total': 42000, 'paid': 10000, 'pending': 32000},
  ];

 
  int get totalPaid =>
      allStudents.fold(0, (sum, s) => sum + (s['paid'] as int));

  int get totalPending =>
      allStudents.fold(0, (sum, s) => sum + (s['pending'] as int));

  List<String> get availableClasses {
    final set = <String>{};
    for (var s in allStudents) {
      set.add(s['class']);
    }
    return set.toList()..sort();
  }

  List<String> get availableDivisions {
    if (selectedClass == null) return [];
    final set = <String>{};
    for (var s in allStudents) {
      if (s['class'] == selectedClass) {
        set.add(s['division']);
      }
    }
    return set.toList()..sort();
  }

  List<Map<String, dynamic>> get filteredStudents {
    return allStudents.where((s) {
      bool match = true;
      if (selectedClass != null) {
        match = match && s['class'] == selectedClass;
      }
      if (selectedDivision != null) {
        match = match && s['division'] == selectedDivision;
      }
      if (searchQuery.isNotEmpty) {
        match = match &&
            s['name']
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
      }
      return match;
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Fees Details"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: ResponsiveWrapper(
       child:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

           
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search Student Name",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_alt_outlined),
                    onPressed: _showFilterBottomSheet,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

         
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Paid",
                    totalPaid,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    "Total Pending",
                    totalPending,
                    Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (filteredStudents.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  "No Students Found",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];
                  return _buildStudentCard(student);
                },
              ),
          ],
        ),
      ),
      ),
    );
  }

 

  Widget _buildSummaryCard(String title, int amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color)),
          const SizedBox(height: 8),
          Text(
            "₹$amount",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    final pending = student['pending'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Name: ${student['name']}",
              style: const TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 6),

          Text(
              "Class: ${student['class']} - ${student['division']}    Roll: ${student['roll']}"),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _feeColumn("Total Fees", student['total'], Colors.black),
              _feeColumn("Pending Fees", student['pending'],
                  pending == 0 ? Colors.green : Colors.red),
              _feeColumn("Paid Fees", student['paid'], Colors.green),
            ],
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => _shareFeesReport(student),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Share in Whats App",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 6),
                  Icon(Icons.share, size: 18, color: Colors.blue),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _feeColumn(String title, int amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text("₹$amount",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }


  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text("Filter",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedClass,
                hint: const Text("Select Class"),
                items: availableClasses
                    .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text("Class $c"),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedClass = value;
                    selectedDivision = null;
                  });
                },
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: selectedDivision,
                hint: const Text("Select Division"),
                items: availableDivisions
                    .map((d) => DropdownMenuItem(
                          value: d,
                          child: Text("Div $d"),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDivision = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedClass = null;
                        selectedDivision = null;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Clear all"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Show Results"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

 

  void _shareFeesReport(Map<String, dynamic> student) {
    Share.share("""
Dear Parent,

Fees Status Update:

Student: ${student['name']}
Class: ${student['class']} - ${student['division']}
Roll No: ${student['roll']}

Total Fees: ₹${student['total']}
Paid: ₹${student['paid']}
Pending: ₹${student['pending']}

Please clear the pending fees at the earliest to avoid any inconvenience.
Contact the school office for payment options or queries.

Thank you,
MG Public School Administration
""");
  }
}
