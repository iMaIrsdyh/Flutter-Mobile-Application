import 'package:flutter/material.dart';
// NIM: 2411533018

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Kabataku',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // NIM: 2411533018

  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();

  String _operator = '+';
  String _hasil = '0';
  String _persamaan = 'Masukkan dua angka untuk memulai';

  void _hitung() {
    final double? angka1 = double.tryParse(_angka1Controller.text);
    final double? angka2 = double.tryParse(_angka2Controller.text);

    // Validasi input
    if (angka1 == null || angka2 == null) {
      setState(() {
        _hasil = '!';
        _persamaan = 'Masukkan angka yang valid';
      });
      return;
    }

    double hasil;

    // Operasi kabataku
    switch (_operator) {
      case '×':
        hasil = angka1 * angka2;
        break;

      case '÷':
        if (angka2 == 0) {
          setState(() {
            _hasil = '!';
            _persamaan = 'Pembagian dengan nol tidak diperbolehkan';
          });
          return;
        }
        hasil = angka1 / angka2;
        break;

      case '+':
        hasil = angka1 + angka2;
        break;

      case '−':
        hasil = angka1 - angka2;
        break;

      default:
        hasil = 0;
    }

    setState(() {
      _hasil = _formatHasil(hasil);
      _persamaan =
          '${_formatHasil(angka1)} $_operator ${_formatHasil(angka2)} = $_hasil';
    });
  }

  String _formatHasil(double angka) {
    if (angka == angka.toInt()) {
      return angka.toInt().toString();
    }

    return angka.toStringAsFixed(2);
  }

  void _reset() {
    setState(() {
      _angka1Controller.clear();
      _angka2Controller.clear();
      _operator = '+';
      _hasil = '0';
      _persamaan = 'Masukkan dua angka untuk memulai';
    });
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Kalkulator Kabataku',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3949AB),
                      Color(0xFF5C6BC0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.20),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calculate_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Kalkulator\nKabataku',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kali • Bagi • Tambah • Kurang',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // JUDUL INPUT
              const Text(
                'Masukkan Angka',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 15),

              // INPUT ANGKA PERTAMA
              _buildInputField(
                controller: _angka1Controller,
                label: 'Angka Pertama',
                icon: Icons.looks_one_rounded,
              ),

              const SizedBox(height: 14),

              // INPUT ANGKA KEDUA
              _buildInputField(
                controller: _angka2Controller,
                label: 'Angka Kedua',
                icon: Icons.looks_two_rounded,
              ),

              const SizedBox(height: 25),

              // PILIH OPERASI
              const Text(
                'Pilih Operasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  _buildOperatorButton(
                    symbol: '×',
                    label: 'Kali',
                  ),
                  const SizedBox(width: 10),
                  _buildOperatorButton(
                    symbol: '÷',
                    label: 'Bagi',
                  ),
                  const SizedBox(width: 10),
                  _buildOperatorButton(
                    symbol: '+',
                    label: 'Tambah',
                  ),
                  const SizedBox(width: 10),
                  _buildOperatorButton(
                    symbol: '−',
                    label: 'Kurang',
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // TOMBOL HITUNG
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _hitung,
                  icon: const Icon(Icons.calculate_rounded),
                  label: const Text(
                    'Hitung',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3949AB),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // TOMBOL RESET
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text(
                    'Reset',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3949AB),
                    side: const BorderSide(
                      color: Color(0xFF3949AB),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // HASIL
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'HASIL PERHITUNGAN',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      _hasil,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3949AB),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _persamaan,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // INFORMASI
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Color(0xFF3949AB),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Kabataku merupakan operasi dasar matematika yang terdiri dari perkalian, pembagian, penjumlahan, dan pengurangan.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF303F9F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET INPUT
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFE0E3EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFF3949AB),
            width: 2,
          ),
        ),
      ),
    );
  }

  // WIDGET PILIHAN OPERATOR
  Widget _buildOperatorButton({
    required String symbol,
    required String label,
  }) {
    final bool selected = _operator == symbol;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _operator = symbol;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF3949AB) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: selected
                  ? const Color(0xFF3949AB)
                  : const Color(0xFFE0E3EB),
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Text(
                symbol,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF3949AB),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Colors.white70
                      : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}