import 'package:flutter/material.dart';
import 'package:flutter_sertifikasi/DaftarBarang.dart';

void main() {
  runApp(home());
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //   'assets/your_logo.png', // Replace with your app's logo
            //   width: 150,
            //   height: 150,
            // ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Our Sales App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the 'Daftar Barang' (Product List) page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const daftarbarang(),
                  ),
                );
              },
              child: const Text(
                'Daftar Barang',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
