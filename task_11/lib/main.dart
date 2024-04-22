import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PTSans'),
      home: const MyCard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              SizedBox(height: 10),
              Text(
                'Тиунов Вадим',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0,
                  color: AppColors.head,
                ),
              ),
              SizedBox(height: 15),
              CardSection(
                icon: 'assets/icons/face.svg',
                title: 'О себе',
                content:
                    'Я - будущий энтузиаст мобильной разработки с глубоким интересом к созданию интуитивно понятных и функциональных пользовательских интерфейсов. Стремлюсь к максимальной производительности и качеству продукта. Люблю работать в команде и готов к новым профессиональным вызовам.',
              ),
              SizedBox(height: 15),
              CardSection(
                icon: 'assets/icons/pallete.svg',
                title: 'Увлечения',
                content:
                    'В свободное время я предпочитаю активный отдых на природе или путешествия с друзьями.',
              ),
              SizedBox(height: 15),
              CardSection(
                icon: 'assets/icons/code.svg',
                title: 'Опыт в разработке',
                content:
                    'Занимаюсь внедрением и развитием различных информационных продуктов и систем для интернет провайдера.',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  final String icon;
  final String title;
  final String content;

  const CardSection({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: SvgPicture.asset(
        icon,
        width: 40,
        colorFilter: const ColorFilter.mode(AppColors.icon, BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
          color: AppColors.head,
        ),
      ),
      subtitle: Text(
        content,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}

abstract class AppColors {
  static const head = Color(0xff080869);
  static const icon = Colors.orange;
  static const background = Color.fromARGB(255, 209, 203, 203);
}
