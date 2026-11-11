import 'package:flutter/material.dart';

void main() {
  runApp(const TaxoraApp());
}

class TaxoraApp extends StatelessWidget {
  const TaxoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxora',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769D2)),
      ),
      home: const SalaryCalculatorPage(),
    );
  }
}

class SalaryCalculatorPage extends StatefulWidget {
  const SalaryCalculatorPage({super.key});

  @override
  State<SalaryCalculatorPage> createState() => _SalaryCalculatorPageState();
}

class _SalaryCalculatorPageState extends State<SalaryCalculatorPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  double? netSalary;
  double? taxAmount;
  double? taxRate;
  String employeeName = '';
  String? errorMessage;

  @override
  void dispose() {
    nameController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  double calculateTaxRate(double salary) {
    if (salary <= 500) {
      return 0.03;
    } else if (salary <= 1000) {
      return 0.07;
    } else if (salary <= 1500) {
      return 0.09;
    } else if (salary <= 2000) {
      return 0.11;
    } else if (salary <= 2500) {
      return 0.13;
    } else if (salary <= 3000) {
      return 0.15;
    } else {
      return 0.17;
    }
  }

  void calculateSalary() {
    FocusScope.of(context).unfocus();

    String name = nameController.text.trim();
    double? salary = double.tryParse(salaryController.text.trim());

    if (name.isEmpty) {
      setState(() {
        errorMessage = 'Please enter the employee name.';
        netSalary = null;
      });
      return;
    }

    if (salary == null || salary <= 0) {
      setState(() {
        errorMessage = 'Please enter a valid salary.';
        netSalary = null;
      });
      return;
    }

    double rate = calculateTaxRate(salary);
    double deduction = salary * rate;
    double finalSalary = salary - deduction;

    setState(() {
      employeeName = name;
      taxRate = rate;
      taxAmount = deduction;
      netSalary = finalSalary;
      errorMessage = null;
    });
  }

  void resetCalculator() {
    setState(() {
      nameController.clear();
      salaryController.clear();
      employeeName = '';
      netSalary = null;
      taxAmount = null;
      taxRate = null;
      errorMessage = null;
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FD),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1769D2), Color(0xFF104A9D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Taxora',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Calculate employee salary deductions easily.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "Enter Employee's Name:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF24344D),
                    ),
                  ),
                  const SizedBox(height: 9),

                  TextField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'e.g. Ihab El Ali',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF1769D2),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE1E9F3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFF1769D2),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    "Enter Employee's Salary:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF24344D),
                    ),
                  ),
                  const SizedBox(height: 9),

                  TextField(
                    controller: salaryController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: 'e.g. 1560',
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: Color(0xFF1769D2),
                      ),
                      suffixText: 'USD',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE1E9F3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFF1769D2),
                          width: 1.5,
                        ),
                      ),
                    ),
                    onSubmitted: (_) => calculateSalary(),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: calculateSalary,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1769D2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          child: const Text(
                            'Enter',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: resetCalculator,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1769D2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Color(0xFF1769D2)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (errorMessage != null) ...[
                    const SizedBox(height: 18),
                    Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],

                  if (netSalary != null) ...[
                    const SizedBox(height: 26),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFDCEBE2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF249B61),
                            size: 38,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Calculation Completed',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF24344D),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            "$employeeName's Salary After Reduction Is",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF53657D),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${netSalary!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF249B61),
                            ),
                          ),
                          const Divider(height: 28),
                          _resultRow(
                            'Tax Rate',
                            '${(taxRate! * 100).toStringAsFixed(0)}%',
                          ),
                          const SizedBox(height: 12),
                          _resultRow(
                            'Tax Deduction',
                            '\$${taxAmount!.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  const Text(
                    'Taxora – Salary Tax Calculator',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF8998AA), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF53657D), fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF24344D),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
