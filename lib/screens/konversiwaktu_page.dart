import 'package:flutter/material.dart';

class KonverterWaktuPage extends StatefulWidget {
  const KonverterWaktuPage({super.key});

  @override
  State<KonverterWaktuPage> createState() => _KonverterWaktuPageState();
}

class _KonverterWaktuPageState extends State<KonverterWaktuPage> {
  final TextEditingController inputController = TextEditingController();
  double result = 0;
  String errorText = '';

  String fromUnit = 'Tahun (yr)';
  String toUnit = 'Detik (sec)';

  final Map<String, double> timeUnits = {
    'Tahun (yr)': 31536000, // 365 hari
    'Hari (day)': 86400,
    'Jam (hr)': 3600,
    'Menit (min)': 60,
    'Detik (sec)': 1,
  };

  void convert() {
    final input = double.tryParse(inputController.text);
    if (input == null) {
      setState(() {
        result = 0;
        errorText = 'Masukkan angka yang valid';
      });
      return;
    }

    final fromValue = timeUnits[fromUnit]!;
    final toValue = timeUnits[toUnit]!;

    setState(() {
      result = input * fromValue / toValue;
      errorText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'MENU KONVERSI WAKTU',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1D1C4C), Color(0xFFC474E6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Masukkan Nilai Waktu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: inputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan nilai',
                    border: const OutlineInputBorder(),
                    errorText: errorText.isEmpty ? null : errorText,
                  ),
                  onChanged: (_) => convert(),
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: fromUnit,
                  isExpanded: true,
                  items: timeUnits.keys.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      fromUnit = value!;
                      convert();
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Icon(Icons.swap_vert, size: 32, color: Colors.black87),
                const SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  controller:
                      TextEditingController(text: result.toStringAsFixed(2)),
                  decoration: const InputDecoration(
                    labelText: 'Hasil konversi',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: toUnit,
                  isExpanded: true,
                  items: timeUnits.keys.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      toUnit = value!;
                      convert();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
