import 'package:flutter/material.dart';

// NIM: 2411533018
void main() => runApp(const MyApp());

// NIM: 2411533018
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Basic Form'),
        ),
        body: const MyForm(),
      ),
    );
  }
}

// NIM: 2411533018
class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

// NIM: 2411533018
class _MyFormState extends State<MyForm> {
  // Controller digunakan untuk mengambil input dari user.
  // NIM: 2411533018
  final TextEditingController _textEditingController =
      TextEditingController();

  // NIM: 2411533018
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Masukkan nama anda :'),

          const SizedBox(
            height: 10,
          ),

          // NIM: 2411533018
          TextField(
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              hintText: 'Misalnya urname',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            controller: _textEditingController,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              print('Sedang mengetik teks: $text');
            },
          ),

          const SizedBox(
            height: 20,
          ),

          // NIM: 2411533018
          ElevatedButton(
            onPressed: () {
              // Mengambil nilai yang dimasukkan user.
              String inputText = _textEditingController.text;

              // Menampilkan hasil input menggunakan SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Nama anda adalah, $inputText'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
            ),
            child: const Text('Tampilkan nama'),
          ),
        ],
      ),
    );
  }
}