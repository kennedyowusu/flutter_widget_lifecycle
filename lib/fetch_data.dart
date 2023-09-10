import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widget_lifecycle/custom_toast.dart';

class DataFetchingWidget extends StatefulWidget {
  const DataFetchingWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataFetchingWidgetState createState() => _DataFetchingWidgetState();
}

class _DataFetchingWidgetState extends State<DataFetchingWidget> {
  List<String> data = [];
  bool isLoading = true;

  // Initialization
  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  // Fetching data from a web API
  Future<void> fetchDataFromApi() async {
    try {
      final http.Response response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        for (var item in jsonData) {
          data.add(item['title']);
        }
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  // Building the user interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Data Fetching App"),
          elevation: 2.0,
          backgroundColor: Colors.teal,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.brown,
              ),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.teal, width: 1),
                    ),
                    child: Text(
                      "$index - ${data[index]}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Deactivation
  @override
  void deactivate() {
    super.deactivate();

    // CustomToast.showCustomToast(
    //     "Deactivate: Widget is removed from the widget tree or pushed off-screen");

    print(
        'Deactivate: Widget is removed from the widget tree or pushed off-screen');
  }

  // Removal and cleanup
  @override
  void dispose() {
    super.dispose();
    // CustomToast.showCustomToast(
    //     "Dispose: Widget is disposed, releasing resources");

    print("Dispose: Widget is disposed, releasing resources");
  }
}
