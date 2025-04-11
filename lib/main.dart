import 'package:algebra_task/cutsom_text_field.dart';
import 'package:algebra_task/final_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController _textController = TextEditingController();

  void _navigateToNewScreen() {
    final inputText = _textController.text;
    try {
      if (inputText.isEmpty || int.parse(inputText) < 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('رجاءً ادخل قيمة موجبة'),
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CoefficientsScreen(numVariables: int.parse(inputText)),
        ),
      );
    } catch (e) {
      const MyApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(8),
        color: const Color(0xFFdccfc7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 154, 219),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Text(  
                  "مرحبا بك",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            CustomTextField(
              hint: "ادخل عدد المتغيرات",
              controller: _textController,
            ),
            const Expanded(
              child: SizedBox(
                height: 18,
              ),
            ),
            MaterialButton(
              onPressed: _navigateToNewScreen,
              child: Container(
                width: 100,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 12, 154, 219),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "تأكيد",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
