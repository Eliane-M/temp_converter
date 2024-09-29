import 'package:flutter/material.dart';

void main() => runApp(const TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({Key? key}) : super(key: key);

  @override
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  bool _isFahrenheitToCelsius = true;
  final TextEditingController _temperatureController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  void _convert() {
    if (_temperatureController.text.isEmpty) return;

    double inputTemp = double.parse(_temperatureController.text);
    double convertedTemp;
    String operation;

    if (_isFahrenheitToCelsius) {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      operation = 'Fahrenheit to Celsius';
    } else {
      convertedTemp = inputTemp * 9 / 5 + 32;
      operation = 'Celsius to Fahrenheit';
    }

    setState(() {
      _result = convertedTemp.toStringAsFixed(2);
      _history.insert(0, '$operation: ${inputTemp.toStringAsFixed(1)} => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Converter')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Fahrenheit to Celsius'),
                        Switch(
                          value: _isFahrenheitToCelsius,
                          onChanged: (value) {
                            setState(() {
                              _isFahrenheitToCelsius = value;
                            });
                          },
                        ),
                        const Text('Celsius to Fahrenheit'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _temperatureController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter temperature',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _convert,
                      child: const Text('Convert'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Result: $_result',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text('History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _history.length,
                        itemBuilder: (context, index) {
                          return Text(_history[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}