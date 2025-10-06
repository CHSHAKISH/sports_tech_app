import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

const String skillsJsonData = '''
[
  {"name": "Dribbling", "level": "Basic", "image": "assets/images/dribble.png"},
  {"name": "Passing", "level": "Basic", "image": "assets/images/passing.png"},
  {"name": "Shooting", "level": "Basic", "image": "assets/images/shooting.png"},
  {"name": "Vault", "level": "Intermediate", "image": "assets/images/vault.png"},
  {"name": "Tackling", "level": "Intermediate", "image": "assets/images/tackling.png"},
  {"name": "Jumping", "level": "Intermediate", "image": "assets/images/jumping.png"},
  {"name": "Agility", "level": "Advanced", "image": "assets/images/agility.png"},
  {"name": "Strategy", "level": "Advanced", "image": "assets/images/strategy.png"},
  {"name": "Endurance", "level": "Advanced", "image": "assets/images/endurance.png"}
]
''';

class Skill {
  final String name;
  final String level;
  final String image;

  Skill({required this.name, required this.level, required this.image});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      level: json['level'],
      image: json['image'],
    );
  }
}

void main() {
  runApp(const SportsTechApp());
}

class SportsTechApp extends StatelessWidget {
  const SportsTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sports Tech Skills',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF333333)),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: const SkillScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SkillScreen extends StatelessWidget {
  const SkillScreen({super.key});

  Map<String, List<Skill>> _groupSkillsByLevel(List<dynamic> skillsData) {
    final Map<String, List<Skill>> groupedSkills = {
      'Basic': [],
      'Intermediate': [],
      'Advanced': [],
    };

    for (var skillJson in skillsData) {
      final skill = Skill.fromJson(skillJson);
      if (groupedSkills.containsKey(skill.level)) {
        groupedSkills[skill.level]!.add(skill);
      }
    }
    return groupedSkills;
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> decodedJson = jsonDecode(skillsJsonData);
    final groupedSkills = _groupSkillsByLevel(decodedJson);

    const levelOrder = ['Basic', 'Intermediate', 'Advanced'];

    const levelColors = {
      'Basic': Color(0xFF007BFF), // A brighter blue
      'Intermediate': Color(0xFFFFC107), // A vibrant gold
      'Advanced': Color(0xFFDC3545), // A strong, clear red
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports Skills', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        elevation: 4.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF857A6), Color(0xFFFF5858)], // Sporty gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: levelOrder.length,
        itemBuilder: (context, index) {
          final level = levelOrder[index];
          final skillsForLevel = groupedSkills[level]!;

          return skillsForLevel.isNotEmpty
              ? SkillCarousel(
              title: level,
              skills: skillsForLevel,
              color: levelColors[level]!)
              : const SizedBox.shrink();
        },
      ),
    );
  }
}

class SkillCarousel extends StatelessWidget {
  final String title;
  final List<Skill> skills;
  final Color color;

  const SkillCarousel(
      {super.key,
        required this.title,
        required this.skills,
        required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
          ),
        ),

        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return SkillCard(skill: skills[index], levelColor: color);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}


class SkillCard extends StatelessWidget {
  final Skill skill;
  final Color levelColor;

  const SkillCard({super.key, required this.skill, required this.levelColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: levelColor, width: 2.5),
        ),
        elevation: 8.0,
        shadowColor: Colors.black.withOpacity(0.2),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              skill.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.sports_soccer, color: Colors.grey[400], size: 48),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    color: Colors.black.withOpacity(0.4),
                    child: Text(
                      skill.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

