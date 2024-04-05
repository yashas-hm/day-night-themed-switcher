import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode theme = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: theme,
      home: Scaffold(
        body: Center(
          child: DayNightSwitch(
            // duration: Duration(milliseconds: 800),
            // initiallyDark: true,
            size: 80,
            onChange: (dark) => setState(() {
              if (dark) {
                theme = ThemeMode.dark;
              } else {
                theme = ThemeMode.light;
              }
            }),
          ),
        ),
      ),
    );
  }
}
