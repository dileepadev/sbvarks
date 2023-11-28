import 'package:flutter/material.dart';

import '../models/student_model.dart';
import '../theme/app_theme.dart';
import 'activity_page.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({super.key, required this.studentModel});

  final StudentModel studentModel;

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(widget.studentModel.picture),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.studentModel.firstName} ${widget.studentModel.lastName}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.studentModel.grade,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.studentModel.index,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }

  Widget varkValues({required List value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value[0],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value[1],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value[2],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value[3],
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget varkTypes({required List type}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type[0],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          type[1],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          type[2],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          type[3],
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget varkBehaviour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "VARK Behaviour",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                varkTypes(
                  type: ["Visual", "Aural", "Read/Write", "Kinesthetic"],
                ),
                const SizedBox(
                  width: 40,
                ),
                varkValues(
                  value: [
                    "${widget.studentModel.valueV}%",
                    "${widget.studentModel.valueA}%",
                    "${widget.studentModel.valueR}%",
                    "${widget.studentModel.valueK}%"
                  ],
                ),
              ],
            ),
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                color: widget.studentModel.varkType == "Visual"
                    ? Colors.blue
                    : widget.studentModel.varkType == "Auditory"
                        ? Colors.green
                        : widget.studentModel.varkType == "Reading/Writing"
                            ? Colors.orange
                            : widget.studentModel.varkType == "Kinesthetic"
                                ? Colors.red
                                : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  widget.studentModel.varkType,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Card planCard({
    required String title,
    required String subtitle,
    required Function() onTap,
  }) {
    // Ensure the subtitle length does not exceed 20 characters
    String truncatedSubtitle =
        subtitle.length > 36 ? '${subtitle.substring(0, 36)}...' : subtitle;

    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          truncatedSubtitle,
          style: const TextStyle(
            fontSize: 16,
            color: AppThemeData.textGreyDark,
          ),
        ),
        trailing: const Icon(Icons.more_vert_rounded),
      ),
    );
  }

  Widget studyPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Suggested Study Plan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Mathematics",
          style: TextStyle(
            color: AppThemeData.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        planCard(
          title: "Visual Activities",
          subtitle: "Diagrams, charts, graphs, flow charts, etc.",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityPage(
                    studentID: widget.studentModel.index,
                    activityType: "Visual"),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        planCard(
          title: "Auditory Activities",
          subtitle: "Sound, rhyme, music, etc.",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityPage(
                    studentID: widget.studentModel.index,
                    activityType: "Auditory"),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        planCard(
          title: "Read/Write Activities",
          subtitle: "Lists, headings, dictionaries, etc.",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityPage(
                    studentID: widget.studentModel.index,
                    activityType: "Reading/Writing"),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        planCard(
          title: "Kinesthetic Activities",
          subtitle: "Practical sessions, models, real-life examples",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityPage(
                    studentID: widget.studentModel.index,
                    activityType: "Kinesthetic"),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Student Details',
            style: TextStyle(color: AppThemeData.textPrimary),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppThemeData.iconSecondary,
            ),
          ),
          elevation: 0,
          backgroundColor: AppThemeData.appBarLight),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                header(),
                const SizedBox(
                  height: 40,
                ),
                varkBehaviour(),
                const SizedBox(
                  height: 40,
                ),
                studyPlans(),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
