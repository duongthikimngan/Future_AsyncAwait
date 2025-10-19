import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilderDemo(),
    );
  }
}

class FutureBuilderDemo extends StatelessWidget {
  const FutureBuilderDemo({super.key});

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    final url = Uri.parse(
      'https://api.myjson.online/v1/records/d534b8f3-20e3-4b61-8a8b-b0dcba97ecbf',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['record'] == null ||
          (data['record'] is Map && data['record'].isEmpty)) {
        return '';
      }
      return const JsonEncoder.withIndent('  ').convert(data['record']);
    } else {
      throw Exception('Lỗi server: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEMO FutureBuilder',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } 

            else if (snapshot.hasError) {
              return Text(
                'Lỗi: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            } 

            else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Text(
                  snapshot.data!,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            } 

            else {
              return const Text(
                'Không có dữ liệu',
                style: TextStyle(fontSize: 20, color: Colors.purple),
              );
            }
          },
        ),
      ),
    );
  }
}
