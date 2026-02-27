import 'package:flutter/material.dart';
import 'package:school_poc/screens/teachers/Attendace_Screen.dart';
import 'package:school_poc/screens/teachers/Grades_Screen.dart';
import 'package:school_poc/screens/teachers/Homework_Screen.dart';
import 'package:school_poc/widgets/Responsive_Wrapper.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> teacherData;

  const HomeScreen({super.key, required this.teacherData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      body: SafeArea(
        child: ResponsiveWrapper(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DashboardHeader(
                  teacherName: teacherData['name'] ?? '',
                  classes:
                      List<String>.from(teacherData['assignedClasses'] ?? []),
                  subjects:
                      List<String>.from(teacherData['assignedSubjects'] ?? []),
                ),
                const SizedBox(height: 24),
                const TodaySchedule(),
                const SizedBox(height: 24),
                const QuickActions(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  final String teacherName;
  final List<String> classes;
  final List<String> subjects;
  String today = DateFormat('EEEE').format(DateTime.now());
  Widget _transparentClassBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  DashboardHeader({
    super.key,
    required this.teacherName,
    required this.classes,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE').format(DateTime.now());

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
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacherName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subjects.isEmpty ? "Teacher" : subjects.join(", "),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.notifications, color: Colors.white),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoTile(title: 'Today', value: today),
              InfoTile(
                title: 'Classes',
                value: Wrap(
                  spacing: 10,
                  children: classes.isEmpty
                      ? [_transparentClassBadge("Class 6")]
                      : classes
                          .map((c) => _transparentClassBadge("Class $c"))
                          .toList(),
                ),
              ),
              InfoTile(title: 'Periods', value: '6'),
            ],
          ),

          const SizedBox(height: 16),

         
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final dynamic value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        if (value is String)
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )
        else
          value,
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
              Text("Today's Schedule",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.book, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text(
                cls.isEmpty ? time : 'Class $cls ',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(cls.isEmpty ? '' : 'Time: $time',
                  style: const TextStyle(color: Colors.grey)),
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
          const Text("Quick Actions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2;

              if (constraints.maxWidth > 1100) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth > 700) {
                crossAxisCount = 3;
              }

              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.1,
                children: [
                  _ActionTile(
                    title: "Attendance",
                    icon: Icons.person,
                    color: const Color(0xFF3F51B5),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AttendanceScreen())),
                  ),
                  // _ActionTile(
                  //   title: "Announcements",
                  //   icon: Icons.message,
                  //   color: const Color(0xFFFF9700),
                  //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AnnouncementScreen())),
                  // ),
                  _ActionTile(
                    title: "HomeWork",
                    icon: Icons.book,
                    color: const Color(0xFF9C28B1),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TeacherHomeworkScreen())),
                  ),
                  _ActionTile(
                    title: "Grades",
                    icon: Icons.star_border,
                    color: const Color(0xFF4CB050),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TeacherGradesScreen())),
                  ),
                  // _ActionTile(title: "Attendance Report", icon: Icons.admin_panel_settings, color: const Color(0xFF607D8B),
                  //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminDashboardScreen())),),
                  // _ActionTile(title: "Fees Remaining", icon: Icons.money_off_csred, color: const Color(0xFF009688), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeesRemainingScreen())),),
                ],
              );
            },
          )
          
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
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
