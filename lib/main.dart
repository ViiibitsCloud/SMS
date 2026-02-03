// // import 'dart:io';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:share_plus/share_plus.dart'; // Add via: flutter pub add fl_chart
// // import 'package:audioplayers/audioplayers.dart';
// // import 'package:firebase_core/firebase_core.dart';


// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();

// //   await Supabase.initialize(
// //     url: 'YOUR_SUPABASE_URL',
// //     anonKey: 'YOUR_SUPABASE_ANON_KEY',
// //   );
// //   runApp(SchoolApp());
// // }

// // class SchoolApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'School POC App',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primaryColor: Colors.blue[800],
        
// //         // accentColor: Colors.teal,
// //         scaffoldBackgroundColor: Colors.grey[100],
// //         cardTheme: CardThemeData(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
// //         buttonTheme: ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
// //         textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.blueGrey[800])),
// //       ),
// //       home: LoginScreen(),
// //     );
// //   }
// // }

// // /* ===================== LOGIN ===================== */

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final TextEditingController _usernameController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   bool _isLoading = false;

// //   final Map<String, Map<String, String>> dummyTeachers = {
// //     'teacher1': {'password': 'pass1', 'fullName': 'Mr. Smith'},
// //     'teacher2': {'password': 'pass2', 'fullName': 'Ms. Johnson'},
// //   };

// //   void _login() async {
// //     setState(() => _isLoading = true);
// //     await Future.delayed(Duration(seconds: 1)); // Simulate load
// //     final username = _usernameController.text.trim();
// //     final password = _passwordController.text.trim();

// //     if (dummyTeachers.containsKey(username) && dummyTeachers[username]!['password'] == password) {
// //       final teacherName = dummyTeachers[username]!['fullName']!;
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => HomeScreen(teacherName: teacherName)),
// //       );
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
// //     }
// //     setState(() => _isLoading = false);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //          resizeToAvoidBottomInset: true,
// //       body: SingleChildScrollView(
// //         child: Container(
// //           decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.blue[300]!], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
// //           child: Column(
// //             children: [
// //               SizedBox(height: 80),
// //               CircleAvatar(
// //                 radius: 70,
// //                 backgroundColor: Colors.white,
// //                 child: Image.asset('assets/logo.png', width: 100, height: 100),
// //               ),
// //               Center(
// //                 child: SingleChildScrollView(
// //                   child: Padding(
// //                     padding: EdgeInsets.all(24),
// //                     child: Card(
// //                       elevation: 8,
// //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //                       child: Padding(
// //                         padding: EdgeInsets.all(24),
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           children: [
// //                             Icon(Icons.school, size: 64, color: Theme.of(context).primaryColor),
// //                             SizedBox(height: 16),
// //                             Text('Teacher Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
// //                             SizedBox(height: 24),
// //                             TextField(
                              
// //                               controller: _usernameController,
// //                               decoration: InputDecoration(labelText: 'Username', icon: Icon(Icons.person)),
// //                             ),
// //                             SizedBox(height: 16),
// //                             TextField(
// //                               controller: _passwordController,
// //                               decoration: InputDecoration(labelText: 'Password', icon: Icon(Icons.lock)),
// //                               obscureText: true,
// //                             ),
// //                             SizedBox(height: 32),
// //                             AnimatedOpacity(
// //                               opacity: _isLoading ? 0.5 : 1.0,
// //                               duration: Duration(milliseconds: 300),
// //                               child: ElevatedButton(
// //                                 onPressed: _isLoading ? null : _login,
// //                                 child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Login'),
// //                                 style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /* ===================== HOME ===================== */

// // class HomeScreen extends StatelessWidget {
// //   final String teacherName;
// //   const HomeScreen({Key? key, required this.teacherName}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               DashboardHeader(teacherName: teacherName),
// //               const SizedBox(height: 16),
// //               const TodaySchedule(),
// //               const SizedBox(height: 20),
// //               QuickActions(teacherName: teacherName),
// //               const SizedBox(height: 20),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /* ===================== HEADER ===================== */

// // class DashboardHeader extends StatelessWidget {
// //   final String teacherName;
// //   const DashboardHeader({Key? key, required this.teacherName}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(20),
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [Color(0xFF6A5AE0), Color(0xFF8E7BFF)],
// //         ),
// //         borderRadius: BorderRadius.only(
// //           bottomLeft: Radius.circular(28),
// //           bottomRight: Radius.circular(28),
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             children: [
// //               const CircleAvatar(
// //                 radius: 26,
// //                 backgroundColor: Colors.white,
// //                 child: Icon(Icons.person, size: 30),
// //               ),
// //               const SizedBox(width: 12),
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     teacherName,
// //                     style: const TextStyle(color: Colors.white, fontSize: 18),
// //                   ),
// //                   const Text(
// //                     'Mathematics Teacher',
// //                     style: TextStyle(color: Colors.white70),
// //                   ),
// //                 ],
// //               ),
// //               const Spacer(),
// //               const Icon(Icons.notifications, color: Colors.white),
// //             ],
// //           ),
// //           const SizedBox(height: 20),
// //           const Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               InfoTile(title: 'Today', value: 'Monday'),
// //               InfoTile(title: 'Classes', value: '5'),
// //               InfoTile(title: 'Periods', value: '6'),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class InfoTile extends StatelessWidget {
// //   final String title;
// //   final String value;

// //   const InfoTile({super.key, required this.title, required this.value});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Text(title, style: const TextStyle(color: Colors.white70)),
// //         const SizedBox(height: 4),
// //         Text(
// //           value,
// //           style: const TextStyle(
// //             color: Colors.white,
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // /* ===================== SCHEDULE ===================== */

// // class TodaySchedule extends StatelessWidget {
// //   const TodaySchedule({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: const [
// //               Text(
// //                 "Today's Schedule",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               Spacer(),
// //               Text('View All', style: TextStyle(color: Colors.blue)),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           scheduleCard(Colors.blue, 'Mathematics', '08:00 - 09:00', '10-A'),
// //           scheduleCard(Colors.green, 'Algebra', '09:15 - 10:15', '9-B'),
// //           scheduleCard(Colors.purple, 'Statistics', '11:00 - 12:00', '11-C'),
// //           scheduleCard(Colors.orange, 'Lunch Break', '12:00 - 01:00', ''),
// //           scheduleCard(Colors.pink, 'Calculus', '01:00 - 02:00', '12-A'),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // Widget scheduleCard(Color color, String subject, String time, String cls) {
// //   return Container(
// //     margin: const EdgeInsets.symmetric(vertical: 8),
// //     padding: const EdgeInsets.all(16),
// //     decoration: BoxDecoration(
// //       color: Colors.white,
// //       borderRadius: BorderRadius.circular(16),
// //       boxShadow: [
// //         BoxShadow(
// //           blurRadius: 10,
// //           color: color.withOpacity(0.15),
// //         )
// //       ],
// //     ),
// //     child: Row(
// //       children: [
// //         Container(
// //           width: 44,
// //           height: 44,
// //           decoration: BoxDecoration(
// //             color: color,
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //           child: const Icon(Icons.book, color: Colors.white),
// //         ),
// //         const SizedBox(width: 12),
// //         Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
// //             Text(
// //               cls.isEmpty ? time : 'Class $cls • $time',
// //               style: const TextStyle(color: Colors.grey),
// //             ),
// //           ],
// //         ),
// //       ],
// //     ),
// //   );
// // }

// // /* ===================== QUICK ACTIONS ===================== */

// // class QuickActions extends StatelessWidget {
// //   final String teacherName;
// //   const QuickActions({Key? key, required this.teacherName}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             'Quick Actions',
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 12),
// //           GridView.count(
// //             crossAxisCount: 2,
// //             shrinkWrap: true,
// //             physics: const NeverScrollableScrollPhysics(),
// //             childAspectRatio: 1.1,
// //             children: [
// //               actionTile(context, 'Attendance', Icons.check_circle, Colors.indigo, teacherName),
// //               actionTile(context, 'Announcements', Icons.announcement, Colors.orange, teacherName),
// //               actionTile(context, 'Homework', Icons.assignment, Colors.purple, teacherName),
// //               actionTile(context, 'Grades', Icons.grade, Colors.green, teacherName),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // Widget actionTile(
// //     BuildContext context, String title, IconData icon, Color color, String teacherName) {
// //   return GestureDetector(
// //     onTap: () {
// //       if (title == 'Attendance') {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (_) => AttendanceScreen(teacherName: teacherName)),
// //         );
// //         } else if (title == 'Announcements') {
// //           // Navigate to Announcements Screen
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (_) => AdminAnnouncementScreen()),
// //           );
// //         } else if (title == 'Homework') {
// //           // Navigate to Homework Screen
// //         } else if (title == 'Grades') {
// //           // Navigate to Grades Screen
// //         }

      
// //     },
// //     child: Container(
// //       margin: const EdgeInsets.all(10),
// //       decoration: BoxDecoration(
// //         color: color,
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(icon, size: 36, color: Colors.white),
// //           const SizedBox(height: 10),
// //           Text(title, style: const TextStyle(color: Colors.white)),
// //         ],
// //       ),
// //     ),
// //   );
// // }

// // /* ===================== ATTENDANCE ===================== */

// // class AttendanceScreen extends StatefulWidget {
// //   final String teacherName;

// //   AttendanceScreen({required this.teacherName});

// //   @override
// //   _AttendanceScreenState createState() => _AttendanceScreenState();
// // }

// // class _AttendanceScreenState extends State<AttendanceScreen> {
// //   String? selectedClass;
// //   String? selectedSubject;
// //   List<Map<String, dynamic>> students = [];
// //   Map<String, int> report = {};

// //   final Map<String, List<Map<String, dynamic>>> classStudents = {
// //     '3A': [
// //       {'roll': 1, 'name': 'Alice', 'gender': 'Girl', 'present': true},
// //       {'roll': 2, 'name': 'Bob', 'gender': 'Boy', 'present': true},
// //       {'roll': 3, 'name': 'Charlie', 'gender': 'Boy', 'present': true},
// //       {'roll': 4, 'name': 'Dana', 'gender': 'Girl', 'present': true},
// //       {'roll': 5, 'name': 'Evan', 'gender': 'Boy', 'present': true},
// //       {'roll': 6, 'name': 'Fiona', 'gender': 'Girl', 'present': true},
// //       {'roll': 7, 'name': 'George', 'gender': 'Boy', 'present': true},
// //       {'roll': 8, 'name': 'Hannah', 'gender': 'Girl', 'present': true},
// //       {'roll': 9, 'name': 'Ian', 'gender': 'Boy', 'present': true},
// //       {'roll': 10, 'name': 'Jasmine', 'gender': 'Girl', 'present': true},
// //     ],
// //     '4B': [
// //       {'roll': 1, 'name': 'Kevin', 'gender': 'Boy', 'present': true},
// //       {'roll': 2, 'name': 'Laura', 'gender': 'Girl', 'present': true},
// //       {'roll': 3, 'name': 'Mike', 'gender': 'Boy', 'present': true},
// //     ],
// //   };

// //   final List<String> subjects = ['Math', 'Science', 'English', 'History'];

// //   void _generateReport() {
// //     int present = students.where((s) => s['present']).length;
// //     int absent = students.length - present;
// //     int boysPresent = students.where((s) => s['gender'] == 'Boy' && s['present']).length;
// //     int boysAbsent = students.where((s) => s['gender'] == 'Boy' && !s['present']).length;
// //     int girlsPresent = students.where((s) => s['gender'] == 'Girl' && s['present']).length;
// //     int girlsAbsent = students.where((s) => s['gender'] == 'Girl' && !s['present']).length;

// //     setState(() {
// //       report = {
// //         'present': present,
// //         'absent': absent,
// //         'boysPresent': boysPresent,
// //         'boysAbsent': boysAbsent,
// //         'girlsPresent': girlsPresent,
// //         'girlsAbsent': girlsAbsent,
// //       };
// //     });

// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         title: Text('Attendance Report', style: TextStyle(color: Theme.of(context).primaryColor)),
// //         content: SingleChildScrollView(
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text('Class: $selectedClass'),
// //               Text('Subject: $selectedSubject'),
// //               Text('Teacher: ${widget.teacherName}'),
// //               SizedBox(height: 16),
// //               Text('Total: ${students.length} | Present: ${report['present']} | Absent: ${report['absent']}'),
// //               Text('Boys: Present ${report['boysPresent']} | Absent ${report['boysAbsent']}'),
// //               Text('Girls: Present ${report['girlsPresent']} | Absent ${report['girlsAbsent']}'),
// //               SizedBox(height: 16),
// //               SizedBox(
// //                 height: 200,
// //                 child: PieChart(
// //                   PieChartData(
// //                     sections: [
// //                       PieChartSectionData(value: report['present']!.toDouble(), color: Colors.green, title: 'Present'),
// //                       PieChartSectionData(value: report['absent']!.toDouble(), color: Colors.red, title: 'Absent'),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(title: Text('Mark Attendance', style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).primaryColor),
// //       body: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             DropdownButtonFormField<String>(
// //               decoration: InputDecoration(labelText: 'Select Class', icon: Icon(Icons.class_)),
// //               value: selectedClass,
// //               items: classStudents.keys.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
// //               onChanged: (val) {
// //                 setState(() {
// //                   selectedClass = val;
// //                   students = List.from(classStudents[val] ?? []);
// //                 });
// //               },
// //             ),
// //             SizedBox(height: 16),
// //             DropdownButtonFormField<String>(
// //               decoration: InputDecoration(labelText: 'Select Subject', icon: Icon(Icons.book)),
// //               value: selectedSubject,
// //               items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
// //               onChanged: (val) => setState(() => selectedSubject = val),
// //             ),
// //             SizedBox(height: 16),
// //             if (students.isNotEmpty)
// //               Expanded(
// //                 child: ListView.builder(
// //                   itemCount: students.length,
// //                   itemBuilder: (context, index) {
// //                     final student = students[index];
// //                     return Card(
// //                       color: Colors.white,
// //                       child: ListTile(
// //                         leading: CircleAvatar(child: Text(student['name'][0]), backgroundColor: student['gender'] == 'Boy' ? Colors.blue[200] : Colors.pink[200]),
// //                         title: Text('${student['roll']}. ${student['name']} (${student['gender']})'),
// //                         trailing: Switch(
// //                           value: student['present'],
// //                           onChanged: (val) => setState(() => student['present'] = val),
// //                           activeColor: Colors.green,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             if (selectedClass != null && selectedSubject != null && students.isNotEmpty)
// //               ElevatedButton.icon(
// //                 icon: Icon(Icons.send,color: Colors.white,),
// //                 label: Text('Submit',style: TextStyle(color: Colors.white),),
// //                 onPressed: _generateReport,
// //                 style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }









// // /* ===================== NOTIFICATIONS ===================== */

// // class NotificationService {
// //   static final FlutterLocalNotificationsPlugin _plugin =
// //       FlutterLocalNotificationsPlugin();

// //   static Future<void> init() async {
// //     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
// //     const settings = InitializationSettings(android: android);
// //     await _plugin.initialize(settings:settings);
// //   }

// //   static Future<void> show(String title, String body) async {
// //     const androidDetails = AndroidNotificationDetails(
// //       'announcement_channel',
// //       'Announcements',
// //       importance: Importance.max,
// //       priority: Priority.high,
// //     );

// //     const details = NotificationDetails(android: androidDetails);

// //     await _plugin.show(
// //       id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
// //       title: title,
// //       body: body,
// //       notificationDetails: details,
// //     );
// //   }
// // }

// // // /* ===================== ANNOUNCEMENTS ===================== */

// // // class AdminAnnouncementScreen extends StatefulWidget {
// // //   const AdminAnnouncementScreen({super.key});

// // //   @override
// // //   State<AdminAnnouncementScreen> createState() =>
// // //       _AdminAnnouncementScreenState();
// // // }

// // // class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
// // //   final textCtrl = TextEditingController();
// // //   final FlutterTts tts = FlutterTts();
// // //   String? audioPath;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     tts.setLanguage("en-IN");
// // //     tts.setSpeechRate(0.45);
// // //   }

// // //   Future<void> generateAudio() async {
// // //     if (textCtrl.text.trim().isEmpty) return;

// // //     final dir = await getApplicationDocumentsDirectory();
// // //     audioPath =
// // //         "${dir.path}/announcement_${DateTime.now().millisecondsSinceEpoch}.m4a";

// // //     await tts.synthesizeToFile(textCtrl.text, audioPath!);

// // //     await NotificationService.show(
// // //       "📢 School Announcement",
// // //       textCtrl.text,
// // //     );

// // //     setState(() {});
// // //   }

// // //   Future<void> shareToWhatsApp() async {
// // //     if (audioPath == null) return;

// // //     await Share.shareXFiles(
// // //       [XFile(audioPath!, mimeType: "audio/mp4")],
// // //       text: "📢 School Announcement",
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Announcements")),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             TextField(
// // //               controller: textCtrl,
// // //               maxLines: 4,
// // //               decoration: const InputDecoration(
// // //                 border: OutlineInputBorder(),
// // //                 labelText: "Enter announcement text",
// // //               ),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             ElevatedButton(
// // //               onPressed: generateAudio,
// // //               child: const Text("Generate Audio"),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: shareToWhatsApp,
// // //               child: const Text("Share to WhatsApp"),
// // //             ),
// // //             if (audioPath != null)
// // //               ListTile(
// // //                 leading: const Icon(Icons.play_arrow),
// // //                 title: const Text("Play Audio"),
// // //                 onTap: () => tts.speak(textCtrl.text),
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // /* ===================== ANNOUNCEMENTS ===================== */


// // // class AdminAnnouncementScreen extends StatefulWidget {
// // //   const AdminAnnouncementScreen({super.key});

// // //   @override
// // //   State<AdminAnnouncementScreen> createState() =>
// // //       _AdminAnnouncementScreenState();
// // // }

// // // class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
// // //   final TextEditingController textCtrl = TextEditingController();
// // //   final FlutterTts tts = FlutterTts();
// // //   final AudioPlayer audioPlayer = AudioPlayer();

// // //   String? audioPath;
// // //   bool isSelected = false;
// // //   bool _isGenerating = false;

// // //   @override
// // //   @override
// // // void initState() {
// // //   super.initState();
// // //   audioPlayer.setReleaseMode(ReleaseMode.stop);

// // //   _initTts();
// // // }

// // // Future<void> _initTts() async {
// // //   try {
// // //     await tts.setLanguage("en-IN");
// // //     await tts.setSpeechRate(0.45);
// // //     await tts.setVolume(1.0);
// // //     await tts.setPitch(1.0);

// // //     // Try to use Google TTS engine explicitly (very helpful on Samsung & many devices)
// // //     String? defaultEngine = await tts.getDefaultEngine;
// // //     await tts.setEngine(defaultEngine ?? "com.google.android.tts");

// // //     print("TTS engine set to: ${await tts.getDefaultEngine}");
// // //   } catch (e) {
// // //     print("TTS init error: $e");
// // //   }
// // // }
// // // //   void initState() {
// // // //     super.initState();
// // // //     tts.setLanguage("en-IN");
// // // //     tts.setSpeechRate(0.45);
// // // //     // In initState()
// // // // await tts.setEngine(await tts.getDefaultEngine ?? "com.google.android.tts");
// // // // await tts.setVolume(1.0);
// // // // await tts.setPitch(1.0);
// // // //   }
// // // //   Future<void> generateAudio() async {
// // // //   if (textCtrl.text.trim().isEmpty) return;

// // // //   // final dir = await getApplicationDocumentsDirectory();
// // // //   // final timestamp = DateTime.now().millisecondsSinceEpoch;
// // // //   // audioPath = "${dir.path}/$timestamp.m4a";   // ← .wav
// // // //   final dir = await getExternalStorageDirectory();
// // // // audioPath =
// // // //   "${dir!.path}/announcement_${DateTime.now().millisecondsSinceEpoch}.mp3";

// // // //   // Ensure directory exists
// // // //   await Directory(dir.path).create(recursive: true);
// // // //   setState(() {
// // // //     _isGenerating = true;
// // // //   });
// // // //   try {
// // // //     await tts.awaitSpeakCompletion(true);
// // // //     await tts.synthesizeToFile(textCtrl.text, audioPath!);

// // // //     final file = File(audioPath!);
// // // //     if (await file.exists()) {
// // // //       print("✅ Audio saved successfully: ${audioPath} (${await file.length()} bytes)");
// // // //       setState(() {
// // // //         isSelected = false;
      
// // // //       });
// // // //     } else {
// // // //       print("❌ File not found after synthesizeToFile");
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         const SnackBar(content: Text("Failed to generate audio file")),
// // // //       );
// // // //     }
// // // //   } catch (e) {

// // // //     print("TTS Error: $e");
// // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // //       SnackBar(content: Text("TTS Error: $e")),

// // // //     );
// // // //   }finally {
// // // //     setState(() {
// // // //       _isGenerating = false;
// // // //     });
// // // //   }
// // // // }
// // // Future<void> generateAudio() async {
// // //   if (textCtrl.text.trim().isEmpty) return;

// // //   final dir = await getApplicationDocumentsDirectory();
// // //   final timestamp = DateTime.now().millisecondsSinceEpoch;
// // //   audioPath = "${dir.path}/$timestamp.m4a";

// // //   setState(() => _isGenerating = true);

// // //   try {
// // //     await tts.awaitSpeakCompletion(true);
// // //     await tts.synthesizeToFile(textCtrl.text, audioPath!);

// // //     // EXTRA WAIT – VERY IMPORTANT
// // //     await Future.delayed(const Duration(milliseconds: 700));

// // //     final file = File(audioPath!);

// // //     if (await file.exists() && await file.length() > 1000) {
// // //       print("Audio ready ✔");
// // //       setState(() {
// // //         isSelected = false;
// // //       });
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("Audio generation failed")),
// // //       );
// // //     }
// // //   } catch (e) {
// // //     print("TTS ERROR: $e");
// // //   } finally {
// // //     setState(() => _isGenerating = false);
// // //   }
// // // }
// // //   Future<void> playAudio() async {
// // //   if (audioPath == null) return;

// // //   final file = File(audioPath!);

// // //   if (!await file.exists() || await file.length() == 0) {
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       const SnackBar(content: Text("Audio not ready")),
// // //     );
// // //     return;
// // //   }

// // //   await audioPlayer.stop();
// // //   await audioPlayer.play(DeviceFileSource(file.path));
// // // }

// // // //   Future<void> playAudio() async {
// // // //   if (audioPath == null) return;
// // // //   final file = File(audioPath!);
// // // //   if (!await file.exists()) {
// // // //     print("File does not exist: $audioPath");
// // // //     return;
// // // //   }
// // // //   await audioPlayer.stop();
// // // //   await audioPlayer.play(DeviceFileSource(audioPath!));
// // // // }

// // // Future<void> shareSelectedAudio() async {
// // //   if (!isSelected || audioPath == null) return;
// // //   final file = File(audioPath!);
// // //   if (!await file.exists()) return;

// // // //   await Share.shareXFiles(
// // // //     [XFile(audioPath!, mimeType: "audio/m4a")],   // ← changed
// // // //     text: "📢 School Announcement",
// // // //   );
// // // await Share.shareXFiles(
// // //   [XFile(audioPath!, mimeType: "audio/mpeg")],
// // //   text: "School Announcement",
// // // );

// // // }
// // //   // Future<void> generateAudio() async {
// // //   //   if (textCtrl.text.trim().isEmpty) return;

// // //   //   final dir = await getApplicationDocumentsDirectory();
// // //   //   audioPath =
// // //   //       "${dir.path}/announcement_${DateTime.now().millisecondsSinceEpoch}.m4a";

// // //   //   await tts.awaitSpeakCompletion(true);
// // //   //   await tts.synthesizeToFile(textCtrl.text, audioPath!);

// // //   //   setState(() {
// // //   //     isSelected = false;
// // //   //   });
// // //   // }

// // //   // Future<void> playAudio() async {
// // //   //   if (audioPath == null) return;
// // //   //   await audioPlayer.stop();
// // //   //   await audioPlayer.play(DeviceFileSource(audioPath!));
// // //   // }

// // //   // Future<void> shareSelectedAudio() async {
// // //   //   if (!isSelected || audioPath == null) return;

// // //   //   await Share.shareXFiles(
// // //   //     [
// // //   //       XFile(
// // //   //         audioPath!,
// // //   //         mimeType: "audio/mp4",
// // //   //       ),
// // //   //     ],
// // //   //     text: "📢 School Announcement",
// // //   //   );
// // //   // }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Announcements")),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             TextField(
// // //               controller: textCtrl,
// // //               maxLines: 4,
// // //               decoration: const InputDecoration(
// // //                 border: OutlineInputBorder(),
// // //                 labelText: "Enter announcement text",
// // //               ),
// // //             ),
// // //             const SizedBox(height: 16),

// // //             ElevatedButton(
// // //               onPressed: _isGenerating ? null : generateAudio,
// // //               child: _isGenerating ? const CircularProgressIndicator() : const Text("Generate Audio"),
// // //             ),

// // //             if (audioPath != null) ...[
// // //               const SizedBox(height: 20),

// // //               Card(
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(16),
// // //                 ),
// // //                 child: ListTile(
// // //                   leading: Checkbox(
// // //                     value: isSelected,
// // //                     onChanged: (val) {
// // //                       setState(() => isSelected = val ?? false);
// // //                     },
// // //                   ),
// // //                   title: const Text("Announcement Audio"),
// // //                  // subtitle: Text(audioPath!.split('/').last),
// // //                  subtitle: Text(audioPath!.split('/').last),
// // //                   trailing: IconButton(
// // //                     icon: const Icon(Icons.play_arrow),
// // //                     onPressed: playAudio,
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 12),

// // //               ElevatedButton.icon(
// // //                 icon: const Icon(Icons.share),
// // //                 label: const Text("Share (WhatsApp / Email)"),
// // //                 onPressed: shareSelectedAudio,
// // //               ),
// // //             ],
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // class AdminAnnouncementScreen extends StatefulWidget {
// //   const AdminAnnouncementScreen({super.key});

// //   @override
// //   State<AdminAnnouncementScreen> createState() =>
// //       _AdminAnnouncementScreenState();
// // }

// // Future<void> uploadToSupabase() async {
// //   if (audioPath == null) return;

// //   final file = File(audioPath!);
// //   if (!await file.exists()) return;

// //   final fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".wav";

// //   await supabase.storage
// //       .from('announcements')
// //       .upload(fileName, file);

// //   publicUrl = supabase.storage
// //       .from('announcements')
// //       .getPublicUrl(fileName);

// //   print("Uploaded URL: $publicUrl");
// // }
// // Future<void> shareLink() async {
// //   if (publicUrl == null) return;

// //   await Share.share(
// //     "School Announcement Audio:\n$publicUrl",
// //   );
// // }

// // class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
// //   final TextEditingController textCtrl = TextEditingController();
// //   final FlutterTts tts = FlutterTts();
// //   final AudioPlayer audioPlayer = AudioPlayer();
// // final supabase = Supabase.instance.client;
// // String? publicUrl;

// //   String? audioPath;
// //   String? downloadUrl;
// //   bool _isGenerating = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initTts();
// //   }

// //   Future<void> _initTts() async {
// //     await tts.setLanguage("en-IN");
// //     await tts.setSpeechRate(0.45);
// //     await tts.setVolume(1.0);
// //   }

// //   // ================= GENERATE + UPLOAD =================
// //   Future<void> generateAudio() async {
// //   final dir = await getApplicationDocumentsDirectory();
// //   audioPath = "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.wav";

// //   await tts.synthesizeToFile(textCtrl.text, audioPath!);

// //   await uploadToSupabase(); // upload after creation
// //   setState(() {});
// // }

// //   // Future<void> generateAudio() async {
// //   //   if (textCtrl.text.trim().isEmpty) return;

// //   //   final dir = await getApplicationDocumentsDirectory();
// //   //   final fileName = "${DateTime.now().millisecondsSinceEpoch}.mp3";
// //   //   audioPath = "${dir.path}/$fileName";

// //   //   setState(() => _isGenerating = true);

// //   //   try {
// //   //     await tts.awaitSpeakCompletion(true);
// //   //     await tts.synthesizeToFile(textCtrl.text, audioPath!);

// //   //     await Future.delayed(const Duration(milliseconds: 600));

// //   //     final file = File(audioPath!);
// //   //     if (!await file.exists()) throw "Audio file missing";

// //   //     // ===== UPLOAD TO FIREBASE =====
// //   //     final ref = FirebaseStorage.instance
// //   //         .ref()
// //   //         .child("announcements/$fileName");

// //   //     await ref.putFile(file);
// //   //     downloadUrl = await ref.getDownloadURL();

// //   //     print("Uploaded URL: $downloadUrl");
// //   //   } catch (e) {
// //   //     print("ERROR: $e");
// //   //     ScaffoldMessenger.of(context).showSnackBar(
// //   //       SnackBar(content: Text("Audio generation failed")),
// //   //     );
// //   //   } finally {
// //   //     setState(() => _isGenerating = false);
// //   //   }
// //   // }

// //   // ================= PLAY LOCAL =================
// //   Future<void> playAudio() async {
// //     if (audioPath == null) return;
// //     await audioPlayer.stop();
// //     await audioPlayer.play(DeviceFileSource(audioPath!));
// //   }

// //   // ================= SHARE URL =================
// //   Future<void> shareAudio() async {
// //     if (downloadUrl == null) return;

// //     await Share.share(
// //       "📢 School Announcement\n$downloadUrl",
// //     );
// //   }

// //   // ================= UI =================
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Announcements")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: textCtrl,
// //               maxLines: 4,
// //               decoration: const InputDecoration(
// //                 border: OutlineInputBorder(),
// //                 labelText: "Enter announcement text",
// //               ),
// //             ),
// //             const SizedBox(height: 16),

// //             ElevatedButton(
// //               onPressed: _isGenerating ? null : generateAudio,
// //               child: _isGenerating
// //                   ? const CircularProgressIndicator()
// //                   : const Text("Generate & Upload Audio"),
// //             ),

// //             if (audioPath != null) ...[
// //               const SizedBox(height: 20),

// //               ListTile(
// //                 leading: const Icon(Icons.play_arrow),
// //                 title: const Text("Play Audio"),
// //                 onTap: playAudio,
// //               ),

// //               ElevatedButton.icon(
// //                 icon: const Icon(Icons.share),
// //                 label: const Text("Share via WhatsApp / Email"),
// //                 onPressed: shareAudio,
// //               ),
// //               ElevatedButton(
// //   onPressed: generateAudio,
// //   child: Text("Generate & Upload"),
// // ),

// // ElevatedButton(
// //   onPressed: shareLink,
// //   child: Text("Share Link"),
// // ),

// //             ],
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';
// // import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart'; // Add via: flutter pub add fl_chart
// import 'package:audioplayers/audioplayers.dart';

// void main() {
//   runApp(SchoolApp());
// }

// class SchoolApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'School POC App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.blue[800],
        
//         // accentColor: Colors.teal,
//         scaffoldBackgroundColor: Colors.grey[100],
//         cardTheme: CardThemeData(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
//         buttonTheme: ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
//         textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.blueGrey[800])),
//       ),
//       home: LoginScreen(),
//     );
//   }
// }

// /* ===================== LOGIN ===================== */

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;

//   final Map<String, Map<String, String>> dummyTeachers = {
//     'teacher1': {'password': 'pass1', 'fullName': 'Mr. Smith'},
//     'teacher2': {'password': 'pass2', 'fullName': 'Ms. Johnson'},
//   };

//   void _login() async {
//     setState(() => _isLoading = true);
//     await Future.delayed(Duration(seconds: 1)); // Simulate load
//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     if (dummyTeachers.containsKey(username) && dummyTeachers[username]!['password'] == password) {
//       final teacherName = dummyTeachers[username]!['fullName']!;
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => HomeScreen(teacherName: teacherName)),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
//     }
//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[300],
//          resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.blue[300]!], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//           child: Column(
//             children: [
//               SizedBox(height: 80),
//               CircleAvatar(
//                 radius: 70,
//                 backgroundColor: Colors.white,
//                 child: Image.asset('assets/logo.png', width: 100, height: 100),
                
//               ),
//               SizedBox(height: 20),
              
//                     Text('MG Public School', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[500])),
//               Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(24),
//                     child: Card(
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                       child: Padding(
//                         padding: EdgeInsets.all(24),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Icons.school, size: 64, color: Theme.of(context).primaryColor),
//                             SizedBox(height: 16),
//                             Text('Teacher Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                             SizedBox(height: 24),
//                             TextField(
                              
//                               controller: _usernameController,
//                               decoration: InputDecoration(labelText: 'Username', icon: Icon(Icons.person)),
//                             ),
//                             SizedBox(height: 16),
//                             TextField(
//                               controller: _passwordController,
//                               decoration: InputDecoration(labelText: 'Password', icon: Icon(Icons.lock)),
//                               obscureText: true,
//                             ),
//                             SizedBox(height: 32),
//                             AnimatedOpacity(
//                               opacity: _isLoading ? 0.5 : 1.0,
//                               duration: Duration(milliseconds: 300),
//                               child: ElevatedButton(
//                                 onPressed: _isLoading ? null : _login,
//                                 child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Login'),
//                                 style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /* ===================== HOME ===================== */

// class HomeScreen extends StatelessWidget {
//   final String teacherName;
//   const HomeScreen({Key? key, required this.teacherName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               DashboardHeader(teacherName: teacherName),
//               const SizedBox(height: 16),
//               const TodaySchedule(),
//               const SizedBox(height: 20),
//               QuickActions(teacherName: teacherName),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /* ===================== HEADER ===================== */

// class DashboardHeader extends StatelessWidget {
//   final String teacherName;
//   const DashboardHeader({Key? key, required this.teacherName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF6A5AE0), Color(0xFF8E7BFF)],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(28),
//           bottomRight: Radius.circular(28),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 26,
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.person, size: 30),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     teacherName,
//                     style: const TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   const Text(
//                     'Mathematics Teacher',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               const Icon(Icons.notifications, color: Colors.white),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InfoTile(title: 'Today', value: 'Monday'),
//               InfoTile(title: 'Classes', value: '5'),
//               InfoTile(title: 'Periods', value: '6'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InfoTile extends StatelessWidget {
//   final String title;
//   final String value;

//   const InfoTile({super.key, required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(title, style: const TextStyle(color: Colors.white70)),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }

// /* ===================== SCHEDULE ===================== */

// class TodaySchedule extends StatelessWidget {
//   const TodaySchedule({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Text(
//                 "Today's Schedule",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Spacer(),
//               Text('View All', style: TextStyle(color: Colors.blue)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           scheduleCard(Colors.blue, 'Mathematics', '08:00 - 09:00', '10-A'),
//           scheduleCard(Colors.green, 'Algebra', '09:15 - 10:15', '9-B'),
//           scheduleCard(Colors.purple, 'Statistics', '11:00 - 12:00', '11-C'),
//           scheduleCard(Colors.orange, 'Lunch Break', '12:00 - 01:00', ''),
//           scheduleCard(Colors.pink, 'Calculus', '01:00 - 02:00', '12-A'),
//         ],
//       ),
//     );
//   }
// }

// Widget scheduleCard(Color color, String subject, String time, String cls) {
//   return Container(
//     margin: const EdgeInsets.symmetric(vertical: 8),
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           blurRadius: 10,
//           color: color.withOpacity(0.15),
//         )
//       ],
//     ),
//     child: Row(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Icon(Icons.book, color: Colors.white),
//         ),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
//             Text(
//               cls.isEmpty ? time : 'Class $cls • $time',
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// /* ===================== QUICK ACTIONS ===================== */

// class QuickActions extends StatelessWidget {
//   final String teacherName;
//   const QuickActions({Key? key, required this.teacherName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Quick Actions',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           GridView.count(
//             crossAxisCount: 2,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             childAspectRatio: 1.1,
//             children: [
//               actionTile(context, 'Attendance', Icons.check_circle, Colors.indigo, teacherName),
//               actionTile(context, 'Announcements', Icons.announcement, Colors.orange, teacherName),
//               actionTile(context, 'Homework', Icons.assignment, Colors.purple, teacherName),
//               actionTile(context, 'Grades', Icons.grade, Colors.green, teacherName),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget actionTile(
//     BuildContext context, String title, IconData icon, Color color, String teacherName) {
//   return GestureDetector(
//     onTap: () {
//       if (title == 'Attendance') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => AttendanceScreen(teacherName: teacherName)),
//         );
//         } else if (title == 'Announcements') {
//           // Navigate to Announcements Screen
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => AdminAnnouncementScreen()),
//           );
//         } else if (title == 'Homework') {
//           // Navigate to Homework Screen
//         } else if (title == 'Grades') {
//           // Navigate to Grades Screen
//         }

      
//     },
//     child: Container(
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 36, color: Colors.white),
//           const SizedBox(height: 10),
//           Text(title, style: const TextStyle(color: Colors.white)),
//         ],
//       ),
//     ),
//   );
// }

// /* ===================== ATTENDANCE ===================== */

// class AttendanceScreen extends StatefulWidget {
//   final String teacherName;

//   AttendanceScreen({required this.teacherName});

//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   String? selectedClass;
//   String? selectedSubject;
//   List<Map<String, dynamic>> students = [];
//   Map<String, int> report = {};

//   final Map<String, List<Map<String, dynamic>>> classStudents = {
//     '3A': [
//       {'roll': 1, 'name': 'Alice', 'gender': 'Girl', 'present': true},
//       {'roll': 2, 'name': 'Bob', 'gender': 'Boy', 'present': true},
//       {'roll': 3, 'name': 'Charlie', 'gender': 'Boy', 'present': true},
//       {'roll': 4, 'name': 'Dana', 'gender': 'Girl', 'present': true},
//       {'roll': 5, 'name': 'Evan', 'gender': 'Boy', 'present': true},
//       {'roll': 6, 'name': 'Fiona', 'gender': 'Girl', 'present': true},
//       {'roll': 7, 'name': 'George', 'gender': 'Boy', 'present': true},
//       {'roll': 8, 'name': 'Hannah', 'gender': 'Girl', 'present': true},
//       {'roll': 9, 'name': 'Ian', 'gender': 'Boy', 'present': true},
//       {'roll': 10, 'name': 'Jasmine', 'gender': 'Girl', 'present': true},
//     ],
//     '4B': [
//       {'roll': 1, 'name': 'Kevin', 'gender': 'Boy', 'present': true},
//       {'roll': 2, 'name': 'Laura', 'gender': 'Girl', 'present': true},
//       {'roll': 3, 'name': 'Mike', 'gender': 'Boy', 'present': true},
//     ],
//   };

//   final List<String> subjects = ['Math', 'Science', 'English', 'History'];

//   void _generateReport() {
//     int present = students.where((s) => s['present']).length;
//     int absent = students.length - present;
//     int boysPresent = students.where((s) => s['gender'] == 'Boy' && s['present']).length;
//     int boysAbsent = students.where((s) => s['gender'] == 'Boy' && !s['present']).length;
//     int girlsPresent = students.where((s) => s['gender'] == 'Girl' && s['present']).length;
//     int girlsAbsent = students.where((s) => s['gender'] == 'Girl' && !s['present']).length;

//     setState(() {
//       report = {
//         'present': present,
//         'absent': absent,
//         'boysPresent': boysPresent,
//         'boysAbsent': boysAbsent,
//         'girlsPresent': girlsPresent,
//         'girlsAbsent': girlsAbsent,
//       };
//     });

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text('Attendance Report', style: TextStyle(color: Theme.of(context).primaryColor)),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Class: $selectedClass'),
//               Text('Subject: $selectedSubject'),
//               Text('Teacher: ${widget.teacherName}'),
//               SizedBox(height: 16),
//               Text('Total: ${students.length} | Present: ${report['present']} | Absent: ${report['absent']}'),
//               Text('Boys: Present ${report['boysPresent']} | Absent ${report['boysAbsent']}'),
//               Text('Girls: Present ${report['girlsPresent']} | Absent ${report['girlsAbsent']}'),
//               SizedBox(height: 16),
//               SizedBox(
//                 height: 200,
//                 child: PieChart(
//                   PieChartData(
//                     sections: [
//                       PieChartSectionData(value: report['present']!.toDouble(), color: Colors.green, title: 'Present'),
//                       PieChartSectionData(value: report['absent']!.toDouble(), color: Colors.red, title: 'Absent'),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text('Mark Attendance', style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).primaryColor),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(labelText: 'Select Class', icon: Icon(Icons.class_)),
//               value: selectedClass,
//               items: classStudents.keys.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedClass = val;
//                   students = List.from(classStudents[val] ?? []);
//                 });
//               },
//             ),
//             SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(labelText: 'Select Subject', icon: Icon(Icons.book)),
//               value: selectedSubject,
//               items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
//               onChanged: (val) => setState(() => selectedSubject = val),
//             ),
//             SizedBox(height: 16),
//             if (students.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: students.length,
//                   itemBuilder: (context, index) {
//                     final student = students[index];
//                     return Card(
//                       color: Colors.white,
//                       child: ListTile(
//                         leading: CircleAvatar(child: Text(student['name'][0]), backgroundColor: student['gender'] == 'Boy' ? Colors.blue[200] : Colors.pink[200]),
//                         title: Text('${student['roll']}. ${student['name']} (${student['gender']})'),
//                         trailing: Switch(
//                           value: student['present'],
//                           onChanged: (val) => setState(() => student['present'] = val),
//                           activeColor: Colors.green,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             if (selectedClass != null && selectedSubject != null && students.isNotEmpty)
//               ElevatedButton.icon(
//                 icon: Icon(Icons.send,color: Colors.white,),
//                 label: Text('Submit',style: TextStyle(color: Colors.white),),
//                 onPressed: _generateReport,
//                 style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }









// /* ===================== NOTIFICATIONS ===================== */

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);
//     await _plugin.initialize(settings:settings);
//   }

//   static Future<void> show(String title, String body) async {
//     const androidDetails = AndroidNotificationDetails(
//       'announcement_channel',
//       'Announcements',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const details = NotificationDetails(android: androidDetails);

//     await _plugin.show(
//       id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title: title,
//       body: body,
//       notificationDetails: details,
//     );
//   }
// }

// // /* ===================== ANNOUNCEMENTS ===================== */

// // class AdminAnnouncementScreen extends StatefulWidget {
// //   const AdminAnnouncementScreen({super.key});

// //   @override
// //   State<AdminAnnouncementScreen> createState() =>
// //       _AdminAnnouncementScreenState();
// // }

// // class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
// //   final textCtrl = TextEditingController();
// //   final FlutterTts tts = FlutterTts();
// //   String? audioPath;

// //   @override
// //   void initState() {
// //     super.initState();
// //     tts.setLanguage("en-IN");
// //     tts.setSpeechRate(0.45);
// //   }

// //   Future<void> generateAudio() async {
// //     if (textCtrl.text.trim().isEmpty) return;

// //     final dir = await getApplicationDocumentsDirectory();
// //     audioPath =
// //         "${dir.path}/announcement_${DateTime.now().millisecondsSinceEpoch}.m4a";

// //     await tts.synthesizeToFile(textCtrl.text, audioPath!);

// //     await NotificationService.show(
// //       "📢 School Announcement",
// //       textCtrl.text,
// //     );

// //     setState(() {});
// //   }

// //   Future<void> shareToWhatsApp() async {
// //     if (audioPath == null) return;

// //     await Share.shareXFiles(
// //       [XFile(audioPath!, mimeType: "audio/mp4")],
// //       text: "📢 School Announcement",
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Announcements")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: textCtrl,
// //               maxLines: 4,
// //               decoration: const InputDecoration(
// //                 border: OutlineInputBorder(),
// //                 labelText: "Enter announcement text",
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: generateAudio,
// //               child: const Text("Generate Audio"),
// //             ),
// //             ElevatedButton(
// //               onPressed: shareToWhatsApp,
// //               child: const Text("Share to WhatsApp"),
// //             ),
// //             if (audioPath != null)
// //               ListTile(
// //                 leading: const Icon(Icons.play_arrow),
// //                 title: const Text("Play Audio"),
// //                 onTap: () => tts.speak(textCtrl.text),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// /* ===================== ANNOUNCEMENTS ===================== */


// class AdminAnnouncementScreen extends StatefulWidget {
//   const AdminAnnouncementScreen({super.key});

//   @override
//   State<AdminAnnouncementScreen> createState() =>
//       _AdminAnnouncementScreenState();
// }

// class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
//   final TextEditingController textCtrl = TextEditingController();
//   final FlutterTts tts = FlutterTts();
//   final AudioPlayer audioPlayer = AudioPlayer();

//     String? audioPath;
//   bool isSelected = false;
//   bool _isGenerating = false;

//   @override
//   void initState() {
//     super.initState();
//     _initTts();
//   }

// Future<void> _initTts() async {
//   try {
//     await tts.setLanguage("en-IN");
//     await tts.setSpeechRate(0.45);
//     await tts.setVolume(1.0);
//     await tts.setPitch(1.0);

//     // Try to use Google TTS engine explicitly (very helpful on Samsung & many devices)
//     String? defaultEngine = await tts.getDefaultEngine;
//     await tts.setEngine(defaultEngine ?? "com.google.android.tts");

//     print("TTS engine set to: ${await tts.getDefaultEngine}");
//   } catch (e) {
//     print("TTS init error: $e");
//   }
// }
// //   void initState() {
// //     super.initState();
// //     tts.setLanguage("en-IN");
// //     tts.setSpeechRate(0.45);
// //     // In initState()
// // await tts.setEngine(await tts.getDefaultEngine ?? "com.google.android.tts");
// // await tts.setVolume(1.0);
// // await tts.setPitch(1.0);
// //   }
//   Future<void> generateAudio() async {
//   if (textCtrl.text.trim().isEmpty) return;

//   final dir = await getApplicationDocumentsDirectory();
//   final timestamp = DateTime.now().millisecondsSinceEpoch;
//   audioPath = "${dir.path}/$timestamp.mp4";   // ← .wav

//   // Ensure directory exists
//   await Directory(dir.path).create(recursive: true);
//   setState(() {
//     _isGenerating = true;
//   });
//   try {
//   await tts.awaitSpeakCompletion(true);
//   await tts.synthesizeToFile(textCtrl.text, audioPath!);

//     final file = File(audioPath!);
//     if (await file.exists()) {
//       print("✅ Audio saved successfully: ${audioPath} (${await file.length()} bytes)");
//       setState(() {
//         isSelected = false;
      
//       });
//     } else {
//       print("❌ File not found after synthesizeToFile");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to generate audio file")),
//       );
//     }
//   } catch (e) {

//     print("TTS Error: $e");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("TTS Error: $e")),

//     );
//   }finally {
//     setState(() {
//       _isGenerating = false;
//     });
//   }
// }

//   Future<void> playAudio() async {
//   if (audioPath == null) return;
//   final file = File(audioPath!);
//   if (!await file.exists()) {
//     print("File does not exist: $audioPath");
//     return;
//   }
//   await audioPlayer.stop();
//   await audioPlayer.play(DeviceFileSource(audioPath!));
// }

// Future<void> shareSelectedAudio() async {
//   if (!isSelected || audioPath == null) return;
//   final file = File(audioPath!);
//   if (!await file.exists()) return;

//   await Share.shareXFiles(
//     [XFile(audioPath!, mimeType: "audio/mp4")],   // ← changed
//     text: "📢 School Announcement",
//   );
// }
//   // Future<void> generateAudio() async {
//   //   if (textCtrl.text.trim().isEmpty) return;

//   //   final dir = await getApplicationDocumentsDirectory();
//   //   audioPath =
//   //       "${dir.path}/announcement_${DateTime.now().millisecondsSinceEpoch}.m4a";

//   //   await tts.awaitSpeakCompletion(true);
//   //   await tts.synthesizeToFile(textCtrl.text, audioPath!);

//   //   setState(() {
//   //     isSelected = false;
//   //   });
//   // }

//   // Future<void> playAudio() async {
//   //   if (audioPath == null) return;
//   //   await audioPlayer.stop();
//   //   await audioPlayer.play(DeviceFileSource(audioPath!));
//   // }

//   // Future<void> shareSelectedAudio() async {
//   //   if (!isSelected || audioPath == null) return;

//   //   await Share.shareXFiles(
//   //     [
//   //       XFile(
//   //         audioPath!,
//   //         mimeType: "audio/mp4",
//   //       ),
//   //     ],
//   //     text: "📢 School Announcement",
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Announcements")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: textCtrl,
//               maxLines: 4,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Enter announcement text",
//               ),
//             ),
//             const SizedBox(height: 16),

//             ElevatedButton(
//               onPressed: _isGenerating ? null : generateAudio,
//               child: _isGenerating ? const CircularProgressIndicator() : const Text("Generate Audio"),
//             ),

//             if (audioPath != null) ...[
//               const SizedBox(height: 20),

//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: ListTile(
//                   leading: Checkbox(
//                     value: isSelected,
//                     onChanged: (val) {
//                       setState(() => isSelected = val ?? false);
//                     },
//                   ),
//                   title: const Text("Announcement Audio"),
//                  // subtitle: Text(audioPath!.split('/').last),
//                  subtitle: Text(audioPath!.split('/').last),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.play_arrow),
//                     onPressed: playAudio,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               ElevatedButton.icon(
//                 icon: const Icon(Icons.share),
//                 label: const Text("Share (WhatsApp / Email)"),
//                 onPressed: shareSelectedAudio,
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }



///grok code

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_poc/services/tts_native_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
void main() {
  runApp(const TeacherApp());
}

class TeacherApp extends StatelessWidget {
  const TeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teacher Portal',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A5AE0)),
        useMaterial3: true,
        cardTheme:  CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ────────────────────────────────────────────────
//                  LOGIN SCREEN
// ────────────────────────────────────────────────
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  final _teachers = {
    'teacher1': {'pass': '1234', 'name': 'Mr. Rajesh Kumar'},
    'teacher2': {'pass': '5678', 'name': 'Ms. Priya Sharma'},
  };

  void _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));

    final user = _usernameCtrl.text.trim();
    final pass = _passwordCtrl.text.trim();

    if (_teachers.containsKey(user) && _teachers[user]!['pass'] == pass) {
      final name = _teachers[user]!['name']!;
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(teacherName: name)),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo[900]!, Colors.indigo[400]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.school_rounded, size: 68, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 24),
                      const Text('Teacher Login', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _usernameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          icon: _loading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                              : const Icon(Icons.login),
                          label: Text(_loading ? 'Signing in...' : 'Login'),
                          onPressed: _loading ? null : _login,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────
//                  HOME SCREEN
// ────────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  final String teacherName;

  const HomeScreen({super.key, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DashboardHeader(teacherName: teacherName),
              const SizedBox(height: 16),
              const TodaySchedule(),
              const SizedBox(height: 24),
              const QuickActions(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  final String teacherName;

  const DashboardHeader({super.key, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A5AE0), Color(0xFF8E7BFF)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 30),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacherName,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Mathematics Teacher',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.notifications, color: Colors.white),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoTile(title: 'Today', value: 'Monday'),
              InfoTile(title: 'Classes', value: '5'),
              InfoTile(title: 'Periods', value: '6'),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class TodaySchedule extends StatelessWidget {
  const TodaySchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text("Today's Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              Text('View All', style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          _scheduleCard(Colors.blue, 'Mathematics', '08:00 - 09:00', '10-A'),
          _scheduleCard(Colors.green, 'Algebra', '09:15 - 10:15', '9-B'),
          _scheduleCard(Colors.purple, 'Statistics', '11:00 - 12:00', '11-C'),
          _scheduleCard(Colors.orange, 'Lunch Break', '12:00 - 01:00', ''),
          _scheduleCard(Colors.pink, 'Calculus', '01:00 - 02:00', '12-A'),
        ],
      ),
    );
  }

  Widget _scheduleCard(Color color, String subject, String time, String cls) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 10, color: color.withOpacity(0.15))],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.book, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                cls.isEmpty ? time : 'Class $cls • $time',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.05,
            children: [
              _ActionTile(
                title: "Attendance",
                icon: Icons.check_circle_rounded,
                color: Colors.indigo,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceScreen())),
              ),
              _ActionTile(
                title: "Announcements",
                icon: Icons.campaign_rounded,
                color: Colors.deepPurple,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AnnouncementScreen())),
              ),
              _ActionTile(title: "Timetable", icon: Icons.calendar_month, color: Colors.purple),
              _ActionTile(title: "Assignments", icon: Icons.assignment_turned_in, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────
//               ATTENDANCE SCREEN
// ────────────────────────────────────────────────
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? selectedClass;
  String? selectedSubject;
  List<Map<String, dynamic>> students = [];
  Map<String, int> report = {};

  final Map<String, List<Map<String, dynamic>>> classStudents = {
    '10-A': [
      {'roll': 1, 'name': 'Aarav', 'gender': 'Boy', 'present': true},
      {'roll': 2, 'name': 'Ananya', 'gender': 'Girl', 'present': true},
      {'roll': 3, 'name': 'Rohan', 'gender': 'Boy', 'present': true},
      {'roll': 4, 'name': 'Priya', 'gender': 'Girl', 'present': true},
      {'roll': 5, 'name': 'Vikram', 'gender': 'Boy', 'present': true},
    ],
    '9-B': [
      {'roll': 1, 'name': 'Sneha', 'gender': 'Girl', 'present': true},
      {'roll': 2, 'name': 'Arjun', 'gender': 'Boy', 'present': true},
      {'roll': 3, 'name': 'Meera', 'gender': 'Girl', 'present': true},
    ],
  };

  final List<String> subjects = ['Mathematics', 'Science', 'English', 'Social Science'];

  void _generateReport() {
    int present = students.where((s) => s['present']).length;
    int absent = students.length - present;
    int boysPresent = students.where((s) => s['gender'] == 'Boy' && s['present']).length;
    int boysAbsent = students.where((s) => s['gender'] == 'Boy' && !s['present']).length;
    int girlsPresent = students.where((s) => s['gender'] == 'Girl' && s['present']).length;
    int girlsAbsent = students.where((s) => s['gender'] == 'Girl' && !s['present']).length;

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
        title: Text('Attendance Report', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Class: $selectedClass  •  Subject: $selectedSubject'),
              const SizedBox(height: 16),
              Text('Total: ${students.length}   Present: ${report['present']}   Absent: ${report['absent']}'),
              Text('Boys: ${report['boysPresent']} present • ${report['boysAbsent']} absent'),
              Text('Girls: ${report['girlsPresent']} present • ${report['girlsAbsent']} absent'),
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
                        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      PieChartSectionData(
                        value: report['absent']!.toDouble(),
                        color: Colors.red,
                        title: 'Absent\n${report['absent']}',
                        radius: 80,
                        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Class', prefixIcon: Icon(Icons.class_)),
              value: selectedClass,
              items: classStudents.keys.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val;
                  students = List.from(classStudents[val] ?? []);
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Subject', prefixIcon: Icon(Icons.book)),
              value: selectedSubject,
              items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => selectedSubject = val),
            ),
            const SizedBox(height: 20),
            if (students.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, i) {
                    final s = students[i];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(s['name'][0]),
                          backgroundColor: s['gender'] == 'Boy' ? Colors.blue[200] : Colors.pink[200],
                        ),
                        title: Text('${s['roll']}. ${s['name']} (${s['gender']})'),
                        trailing: Switch(
                          value: s['present'],
                          onChanged: (v) => setState(() => s['present'] = v),
                          activeColor: Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (selectedClass != null && selectedSubject != null && students.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text('Generate Report'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _generateReport,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────
//              ANNOUNCEMENT SCREEN
// ────────────────────────────────────────────────
// class AnnouncementScreen extends StatefulWidget {
//   const AnnouncementScreen({super.key});

//   @override
//   State<AnnouncementScreen> createState() => _AnnouncementScreenState();
// }

// class _AnnouncementScreenState extends State<AnnouncementScreen> {
//   final _textController = TextEditingController();
//   final _tts = FlutterTts();
//   final _audioPlayer = AudioPlayer(); // ← just_audio player

//   String? _audioPath;
//   bool _generating = false;
//   bool _ready = false;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _initTts();
//     _initAudioPlayer();
//   }

//   Future<void> _initTts() async {
//     await _tts.setLanguage("en-IN");
//     await _tts.setSpeechRate(0.48);
//     await _tts.setPitch(1.02);

//     if (Platform.isIOS) {
//       await _tts.setIosAudioCategory(
//         IosTextToSpeechAudioCategory.playback,
//         [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker],
//       );
//     }
//   }

//   void _initAudioPlayer() {
//     _audioPlayer.playerStateStream.listen((state) {
//       if (mounted) {
//         setState(() {
//           _isPlaying = state.playing;
//         });
//       }

//       // When playback finishes
//       if (state.processingState == ProcessingState.completed) {
//         if (mounted) {
//           setState(() => _isPlaying = false);
//         }
//       }
//     });
//   }

//   Future<void> _generateAudio() async {
//     final text = _textController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       _generating = true;
//       _ready = false; // reset previous audio
//     });

//     try {
//       final dir = await getApplicationDocumentsDirectory();
//       final ts = DateTime.now().millisecondsSinceEpoch;
//       _audioPath = "${dir.path}/announcement_$ts.m4a";

//       print("Saving to: $_audioPath");

//       await _tts.awaitSynthCompletion(true);
//       await _tts.synthesizeToFile(text, _audioPath!);

//       await Future.delayed(const Duration(milliseconds: 800));

//       // Optional: try to verify file exists
//       final file = File(_audioPath!);
//       if (await file.exists()) {
//         print("File created successfully, size: ${await file.length()} bytes");
//       } else {
//         print("Warning: File reported as created but not found on disk");
//       }

//       if (mounted) {
//         setState(() {
//           _ready = true;
//           _generating = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Audio generated successfully")),
//         );
//       }
//     } catch (e) {
//       print("TTS generation error: $e");
//       if (mounted) {
//         setState(() => _generating = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to generate audio: $e")),
//         );
//       }
//     }
//   }

//   Future<void> _playSavedAudio() async {
//     if (_audioPath == null || !_ready) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No audio generated yet")),
//       );
//       return;
//     }

//     try {
//       final file = File(_audioPath!);
//       if (!await file.exists()) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Audio file not found on device")),
//         );
//         return;
//       }

//       await _audioPlayer.setFilePath(_audioPath!);
//       await _audioPlayer.play();

//       setState(() => _isPlaying = true);
//     } catch (e) {
//       print("Playback error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Cannot play audio: $e")),
//       );
//     }
//   }

//   Future<void> _stopAudio() async {
//     await _audioPlayer.stop();
//     setState(() => _isPlaying = false);
//   }

//   Future<void> _shareToWhatsApp() async {
//     if (_audioPath == null || !_ready) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Generate audio first")),
//       );
//       return;
//     }

//     try {
//       final file = File(_audioPath!);
//       if (!await file.exists()) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Audio file not found")),
//         );
//         return;
//       }

//       print("Sharing file: $_audioPath");

//       await Share.shareXFiles(
//         [XFile(_audioPath!, mimeType: 'audio/mp4')],
//         text: "📢 School Announcement\n\n${_textController.text}",
//         subject: "School Announcement Audio",
//       );
//     } catch (e) {
//       print("Share error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Share failed: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Create Announcement")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: _textController,
//               maxLines: 6,
//               decoration: const InputDecoration(
//                 labelText: "Announcement text",
//                 border: OutlineInputBorder(),
//                 alignLabelWithHint: true,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   icon: _generating
//                       ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2.4))
//                       : const Icon(Icons.record_voice_over),
//                   label: Text(_generating ? "Generating..." : "Generate Audio"),
//                   onPressed: _generating ? null : _generateAudio,
//                 ),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.share),
//                   label: const Text("Share WhatsApp"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green[700],
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: _shareToWhatsApp,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),
//             if (_ready)
//               Card(
//                 color: Colors.green[50],
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   leading: Icon(
//                     _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
//                     color: Colors.green,
//                     size: 40,
//                   ),
//                   title: Text(
//                     _isPlaying ? "Playing announcement..." : "Play generated audio",
//                   ),
//                   onTap: _isPlaying ? _stopAudio : _playSavedAudio,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _tts.stop();
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
// // class AnnouncementScreen extends StatefulWidget {
// //   const AnnouncementScreen({super.key});

// //   @override
// //   State<AnnouncementScreen> createState() => _AnnouncementScreenState();
// // }

// // class _AnnouncementScreenState extends State<AnnouncementScreen> {
// //   final _textController = TextEditingController();
// //   final _tts = FlutterTts();

// //   String? _audioPath;
// //   bool _generating = false;
// //   bool _ready = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initTts();
// //   }

// //   Future<void> _initTts() async {
// //     await _tts.setLanguage("en-IN");
// //     await _tts.setSpeechRate(0.48);
// //     await _tts.setPitch(1.02);

// //     if (Platform.isIOS) {
// //       await _tts.setIosAudioCategory(
// //         IosTextToSpeechAudioCategory.playback,
// //         [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker],
// //       );
// //     }
// //   }

// // Future<bool> _requestPermission() async {
// //   if (Platform.isAndroid) {
// //     final androidInfo = await DeviceInfoPlugin().androidInfo;
// //     if (androidInfo.version.sdkInt >= 29) {  // Android 10+
// //       return true;  // Scoped storage: no permission needed for app docs dir
// //     } else {
// //       // Only for very old Android <10 — rare in 2026
// //       var status = await Permission.storage.request();
// //       return status.isGranted;
// //     }
// //   }
// //   return true;
// // }
// // Future<void> _generateAudio() async {
// //   final text = _textController.text.trim();
// //   if (text.isEmpty) return;

// //   setState(() => _generating = true);

// //   try {
// //     // Skip permission entirely — not needed here
// //     final dir = await getApplicationDocumentsDirectory();
// //     final ts = DateTime.now().millisecondsSinceEpoch;
// //     _audioPath = "${dir.path}/announcement_$ts.m4a";

// //     print("Saving to: $_audioPath");  // Debug log

// //     await _tts.awaitSynthCompletion(true);
// //     await _tts.synthesizeToFile(text, _audioPath!);

// //     await Future.delayed(const Duration(milliseconds: 700));

// //     if (mounted) {
// //       setState(() {
// //         _ready = true;
// //         _generating = false;
// //       });
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Audio generated & saved!")),
// //       );
// //     }
// //   } catch (e) {
// //     print("TTS error: $e");
// //     if (mounted) {
// //       setState(() => _generating = false);
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Failed to generate audio: $e")),
// //       );
// //     }
// //   }
// // }
// //   // Future<void> _generateAudio() async {
// //   //   final text = _textController.text.trim();
// //   //   if (text.isEmpty) return;
// //   //     print("Generating audio for text: $text");

// //   //   setState(() => _generating = true);

// //   //   try {
// //   //     if (!await _requestPermission()) {
// //   //       print("Storage permission denied");
// //   //       if (mounted) {
// //   //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Storage permission denied")));
// //   //       }
// //   //       return;
// //   //     }

// //   //     final dir = await getApplicationDocumentsDirectory();
// //   //     final ts = DateTime.now().millisecondsSinceEpoch;
// //   //     _audioPath = "${dir.path}/announcement_$ts.mp4";

// //   //     await _tts.awaitSynthCompletion(true);
// //   //     await _tts.synthesizeToFile(text, _audioPath!);

// //   //     await Future.delayed(const Duration(milliseconds: 700));

// //   //     if (mounted) {
// //   //       print("Audio generated at: $_audioPath");
// //   //       setState(() {
// //   //         _ready = true;
// //   //         _generating = false;
// //   //       });
// //   //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Audio ready")));
// //   //     }
// //   //   } catch (e) {
// //   //     print("Error generating audio: $e");
// //   //     if (mounted) {
// //   //       setState(() => _generating = false);
// //   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
// //   //     }
// //   //   }
// //   // }


// //   Future<void> _shareToWhatsApp() async {
// //     print("Sharing to WhatsApp...");
// //     if (_audioPath == null || !_ready) {
// //       print("Audio not ready for sharing");
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Generate audio first")));
// //       return;
// //     }

// //     try {
// //       print(  "Preparing to share audio: $_audioPath");
// //       await Share.shareXFiles(
        
// //         [XFile(_audioPath!, mimeType: 'audio/mp4')],
// //         text: "📢 School Announcement\n\n${_textController.text}",
// //       );
// //     } catch (e) {
// //       print("Error sharing audio: $e");
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Share failed: $e")));
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Create Announcement")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _textController,
// //               maxLines: 6,
// //               decoration: const InputDecoration(
// //                 labelText: "Announcement text",
// //                 border: OutlineInputBorder(),
// //                 alignLabelWithHint: true,
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 ElevatedButton.icon(
// //                   icon: _generating
// //                       ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2.4))
// //                       : const Icon(Icons.record_voice_over),
// //                   label: Text(_generating ? "Generating..." : "Generate Audio"),
// //                   onPressed: _generating ? null : _generateAudio,
// //                 ),
// //                 ElevatedButton.icon(
// //                   icon: const Icon(Icons.share),
// //                   label: const Text("Share WhatsApp"),
// //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700], foregroundColor: Colors.white),
// //                   onPressed: _shareToWhatsApp,
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 32),
// //             if (_ready)
// //               ListTile(
// //                 leading: const Icon(Icons.play_circle_fill_rounded, color: Colors.green, size: 40),
// //                 title: const Text("Play generated announcement"),
// //                 onTap: () => _tts.speak(_textController.text),
// //                 tileColor: Colors.green[50],
// //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _textController.dispose();
// //     _tts.stop();
// //     super.dispose();
// //   }
// // }


// //anouncemnt 


// class Announcement {
//   final String text;
//   final DateTime timestamp;

//   Announcement({required this.text, required this.timestamp});
// }

// class AnnouncementScreen extends StatefulWidget {
//   const AnnouncementScreen({super.key});

//   @override
//   State<AnnouncementScreen> createState() => _AnnouncementScreenState();
// }

// class _AnnouncementScreenState extends State<AnnouncementScreen> {
//   final _textController = TextEditingController();
//   final _tts = FlutterTts();
//   final List<Announcement> _announcements = [];

//   bool _generating = false;

//   @override
//   void initState() {
//     super.initState();
//     _initTts();
//   }

//   Future<void> _initTts() async {
//     await _tts.setLanguage("en-IN");
//     await _tts.setSpeechRate(0.48);
//     await _tts.setPitch(1.02);
//   }

//   Future<void> _generateAndSaveAnnouncement() async {
//     final text = _textController.text.trim();
//     if (text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter announcement text")),
//       );
//       return;
//     }

//     setState(() => _generating = true);

//     // Simulate generation delay
//     await Future.delayed(const Duration(milliseconds: 800));

//     setState(() {
//       _announcements.insert(
//         0,
//         Announcement(text: text, timestamp: DateTime.now()),
//       );
//       _textController.clear();
//       _generating = false;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("✅ Announcement saved successfully")),
//     );
//   }

//   Future<void> _speak(String text) async {
//     await _tts.speak(text);
//   }

//   Future<void> _shareAnnouncement(String text) async {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.message, color: Colors.green),
//               title: const Text("Share to WhatsApp"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 await Share.share(
//                   "📢 School Announcement:\n\n$text",
//                   subject: "School Announcement",
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.email, color: Colors.blue),
//               title: const Text("Share via Email"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 await Share.share(
//                   "School Announcement:\n\n$text",
//                   subject: "School Announcement from Teacher",
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.copy),
//               title: const Text("Copy Text"),
//               onTap: () {
//                 Navigator.pop(context);
//                 // You can add Clipboard.setData here if needed
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Text copied")),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Announcements")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _textController,
//               maxLines: 5,
//               decoration: const InputDecoration(
//                 labelText: "Enter announcement",
//                 border: OutlineInputBorder(),
//                 hintText: "e.g. Hello, tomorrow is holiday",
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 icon: _generating
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                       )
//                     : const Icon(Icons.record_voice_over),
//                 label: Text(_generating ? "Saving..." : "Generate & Save Announcement"),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 onPressed: _generating ? null : _generateAndSaveAnnouncement,
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Saved Announcements",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Expanded(
//               child: _announcements.isEmpty
//                   ? const Center(child: Text("No announcements yet"))
//                   : ListView.builder(
//                       itemCount: _announcements.length,
//                       itemBuilder: (context, index) {
//                         final ann = _announcements[index];
//                         return Card(
//                           margin: const EdgeInsets.only(bottom: 12),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   ann.text,
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   "${ann.timestamp.hour}:${ann.timestamp.minute.toString().padLeft(2, '0')}  •  ${ann.timestamp.day}/${ann.timestamp.month}/${ann.timestamp.year}",
//                                   style: const TextStyle(color: Colors.grey, fontSize: 13),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.play_circle_fill, color: Colors.green),
//                                       onPressed: () => _speak(ann.text),
//                                       tooltip: "Play announcement",
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.share, color: Colors.blue),
//                                       onPressed: () => _shareAnnouncement(ann.text),
//                                       tooltip: "Share",
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _tts.stop();
//     super.dispose();
//   }
// }


class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final _textController = TextEditingController();
  final _audioPlayer = AudioPlayer(); // just_audio

  String? _audioPath;
  bool _generating = false;
  bool _ready = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
      if (state.processingState == ProcessingState.completed) {
        setState(() => _isPlaying = false);
      }
    });
  }

  Future<void> _generateAudio() async {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter text first")));
      return;
    }

    setState(() {
      _generating = true;
      _ready = false;
    });

    try {
      final savedPath = await TtsNativeService.synthesizeAndSave(text: text);

      if (savedPath != null && File(savedPath).existsSync()) {
        setState(() {
          _audioPath = savedPath;
          _ready = true;
          _generating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Audio saved: ${savedPath.split('/').last}")),
        );
      } else {
        throw Exception("Audio file not created");
      }
    } catch (e) {
      print("Generation failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to generate audio: $e")),
      );
      setState(() => _generating = false);
    }
  }

  Future<void> _playAudio() async {
    if (_audioPath == null || !_ready) return;

    try {
      await _audioPlayer.setFilePath(_audioPath!);
      await _audioPlayer.play();
      setState(() => _isPlaying = true);
    } catch (e) {
      print("Play error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Playback failed: $e")));
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() => _isPlaying = false);
  }

  Future<void> _shareAudio() async {
    if (_audioPath == null || !_ready) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No audio to share")));
      return;
    }

    final file = File(_audioPath!);
    if (!await file.exists()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Audio file missing")));
      return;
    }

    try {
      await Share.shareXFiles(
        [XFile(_audioPath!, mimeType: 'audio/wav')],
        text: "📢 School Announcement\n\n${_textController.text}",
        subject: "School Announcement Audio",
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Share failed: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Announcement")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: "Announcement text",
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: _generating
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2.4))
                      : const Icon(Icons.record_voice_over),
                  label: Text(_generating ? "Generating..." : "Generate Audio"),
                  onPressed: _generating ? null : _generateAudio,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text("Share"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700], foregroundColor: Colors.white),
                  onPressed: _shareAudio,
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_ready)
              Card(
                color: Colors.green[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(
                    _isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                    color: Colors.green,
                    size: 40,
                  ),
                  title: Text(_isPlaying ? "Playing..." : "Play generated audio"),
                  subtitle: Text(_audioPath!.split('/').last, maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: _isPlaying ? _stopAudio : _playAudio,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}