import 'package:flutter/material.dart';

import 'cowpay_example.dart';
import 'text_input_view.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFeesOnMerchant = false;
  String merchantCode = const String.fromEnvironment("merchantCode");
  String merchantHash = const String.fromEnvironment("hashKey");
  String merchantMobileNumber = const String.fromEnvironment("merchantMobile");
  String merchantIconLink =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cowpay'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(
                          child: Text("Is fees on customer",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                      Switch(
                        value: isFeesOnMerchant,
                        onChanged: (value) {
                          setState(() {
                            isFeesOnMerchant = value;
                          });
                        },
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue.withOpacity(0.5),
                        inactiveTrackColor: Colors.blue.withOpacity(0.3),
                      )
                    ],
                  ),
                  const AppTextField().buildMainFormTextField(
                      value: merchantCode,
                      fieldData: const FieldData(
                        label: "merchant code",
                      ),
                      onChange: (value) {
                        setState(() {
                          merchantCode = value;
                        });
                      }),
                  const AppTextField().buildMainFormTextField(
                      value: merchantMobileNumber,
                      fieldData: const FieldData(
                        label: "merchant mobile number",
                      ),
                      onChange: (value) {
                        setState(() {
                          merchantMobileNumber = value;
                        });
                      }),
                  const AppTextField().buildMainFormTextField(
                      value: merchantHash,
                      fieldData: const FieldData(
                        label: "hash key",
                      ),
                      onChange: (value) {
                        setState(() {
                          merchantHash = value;
                        });
                      }),
                  const AppTextField().buildMainFormTextField(
                      value: merchantIconLink,
                      fieldData: const FieldData(
                        label: "Icon Link",
                      ),
                      onChange: (value) {
                        setState(() {
                          merchantIconLink = value;
                        });
                      }),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 300,
            child: ElevatedButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CowpayExample(
                                args: Args(
                                  isFeesOnMerchant: isFeesOnMerchant,
                                  merchantCode: merchantCode,
                                  merchantHash: merchantHash,
                                  merchantMobileNumber: merchantMobileNumber,
                                  merchantIconLink: merchantIconLink,
                                ),
                              )),
                    ),
                child: const Text('Launch Cowpay')),
          ),
        ],
      ),
    );
  }
}

class Args {
  bool isFeesOnMerchant;
  String merchantCode;
  String merchantHash;
  String merchantMobileNumber;
  String merchantIconLink;

  Args({
    this.isFeesOnMerchant = false,
    required this.merchantCode,
    required this.merchantHash,
    required this.merchantMobileNumber,
    required this.merchantIconLink,
  });
}
