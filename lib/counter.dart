import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widget_lifecycle/custom_toast.dart';
import 'package:widget_lifecycle/fetch_data.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  // one-time Initialization
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      // CustomToast.showCustomToast("InitState: Widget is created");
      print('InitState: Widget is created');
    }
  }

  // Building the user interface
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      // CustomToast.showCustomToast("Build: Building the user interface");
      print('Build: Building the user interface');
    }
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text("Counter App"),
        elevation: 2.0,
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Counter: $_counter',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.brown,
              disabledForegroundColor: Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataFetchingWidget(),
                ),
              );
            },
            child: const Text(
              "Next Screen",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        elevation: 2.0,
        onPressed: () {
          // Updating the state
          setState(() {
            _counter++;

            if (kDebugMode) {
              print("SetState: Updating the state");
              didUpdateWidget(widget);
            }
          });
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  // Rebuilding when the widget is updated
  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kDebugMode) {
      print("DidUpdateWidget: Widget is updated");
    }
  }

  // Deactivation
  @override
  void deactivate() {
    super.deactivate();

    if (kDebugMode) {
      print(
          "Deactivate: Widget is removed from the widget tree or pushed off-screen");
    }
  }

  // Removal and cleanup
  @override
  void dispose() {
    super.dispose();

    if (kDebugMode) {
      print("Dispose: Widget is disposed, releasing resources");
    }
  }
}
