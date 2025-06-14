import 'package:cardiovascular_risk_prediction/api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers for the six input fields
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController prevalentHypController = TextEditingController();
  final TextEditingController totCholController = TextEditingController();
  final TextEditingController sysBPController = TextEditingController();
  final TextEditingController diaBPController = TextEditingController();

  String? predictionResult;
  Map<String, dynamic>? probabilities;

  // Function to perform prediction
  Future<void> _predict() async {
    // Validate input
    if (ageController.text.isEmpty ||
        sexController.text.isEmpty ||
        prevalentHypController.text.isEmpty ||
        totCholController.text.isEmpty ||
        sysBPController.text.isEmpty ||
        diaBPController.text.isEmpty) {
      _showError('Please fill in all fields.');
      return;
    }

    // Parse input features
    List<double> features = [
      double.parse(ageController.text),
      double.parse(sexController.text),
      double.parse(prevalentHypController.text),
      double.parse(totCholController.text),
      double.parse(sysBPController.text),
      double.parse(diaBPController.text),
    ];

    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Call the API
      var result = await PredictionService.predict(features);

      if (!mounted) return; // Ensure widget is still mounted
      Navigator.pop(context); // Remove loading indicator

      // Update state with prediction result
      setState(() {
        predictionResult = result['prediction'].toString();
        probabilities = result['probabilities'];
      });

      // Show the result dialog
      _showResult();
    } catch (e) {
      if (!mounted) return; // Ensure widget is still mounted
      Navigator.pop(context); // Remove loading indicator
      _showError(e.toString());
    }
  }

  // Function to show an error dialog
  void _showError(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Function to display the prediction result
  void _showResult() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Prediction Result'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Predicted Class: $predictionResult'),
            const SizedBox(height: 8),
            if (probabilities != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Probabilities:'),
                  Text('Class 0: ${probabilities!['Class 0'].toStringAsFixed(4)}'),
                  Text('Class 1: ${probabilities!['Class 1'].toStringAsFixed(4)}'),
                ],
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Cardiovascular Risk Prediction',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Feature Values',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                  hintText: 'Enter age (in years)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: sexController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sex',
                  hintText: 'Enter sex (0 for Male, 1 for Female)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: prevalentHypController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prevalent Hypertension',
                  hintText: '1 for Yes, 0 for No',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: totCholController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Total Cholesterol',
                  hintText: 'Enter total cholesterol level',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: sysBPController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Systolic Blood Pressure',
                  hintText: 'Enter systolic blood pressure (mmHg)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: diaBPController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Diastolic Blood Pressure',
                  hintText: 'Enter diastolic blood pressure (mmHg)',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _predict,
                  icon: const Icon(Icons.analytics),
                  label: const Text('Predict'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
