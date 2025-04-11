import 'package:algebra_task/gaussian_jordan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoefficientsScreen extends StatefulWidget {
  final int numVariables; // Number of variables passed from the previous screen

  const CoefficientsScreen({super.key, required this.numVariables});

  @override
  _CoefficientsScreenState createState() => _CoefficientsScreenState();
}

class _CoefficientsScreenState extends State<CoefficientsScreen> {
  List<List<TextEditingController>> controllers =
      []; // To store controllers for each text field
  String result = ""; // Variable to store the result

  @override
  void initState() {
    super.initState();
    // Initialize controllers based on the number of variables
    for (int i = 0; i < widget.numVariables; i++) {
      controllers.add(List.generate(
        widget.numVariables + 1, // +1 for the result column
        (index) => TextEditingController(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFe1d8d3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 12, 154, 219),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        centerTitle: true,
        title: const Text(
          "أدخل المعاملات",
          style: TextStyle(
            fontSize: 22,
            color: Color.fromARGB(255, 12, 154, 219),
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/back.jpg",
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        widget.numVariables,
                        (i) {
                          return Row(
                            children: List.generate(
                              widget.numVariables + 1, // +1 for result column
                              (j) {
                                return Container(
                                  color: const Color(0xFFe1d8d3),
                                  margin: const EdgeInsets.all(4.0),
                                  width: 70,
                                  child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: controllers[i][j],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: 'x ${i + 1},${j + 1}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Display the result here
                  Text(
                    result,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            // Step 1: Retrieve the coefficients matrix
                            List<List<double>> coefficientsMatrix = [];
                            List<double> constantsMatrix = [];

                            for (int i = 0; i < widget.numVariables; i++) {
                              List<double> row = [];
                              for (int j = 0; j < widget.numVariables; j++) {
                                double value =
                                    double.tryParse(controllers[i][j].text) ??
                                        0.0;
                                row.add(value);
                              }
                              coefficientsMatrix.add(row);

                              // Step 2: Get the constant values (last column)
                              double constant = double.tryParse(controllers[i]
                                          [widget.numVariables]
                                      .text) ??
                                  0.0;
                              constantsMatrix.add(constant);
                            }

                            // Step 3: Solve the system using GaussianJordan
                            String res = GaussianJordan.solve(
                              coefficientsMatrix,
                              constantsMatrix,
                            );

                            // Set the result string
                            result = res;
                          });
                        },
                        child: Container(
                          width: 150,
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
