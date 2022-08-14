import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';
import 'information.dart';
import 'models/informations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(InformationsAdapter());
  await Hive.openBox<Informations>("informations");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DB Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyHomePage(),
        '/information': (context) => const Information(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  List<String> dropDownOptions = ['ดี', 'พอใช้', 'แย่'];
  late String dropDownSelectValue;

  final informationsBox = Boxes.getInformations();
  Map<String, dynamic> newInformation = {};

  @override
  void initState() {
    dropDownSelectValue = dropDownOptions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${informationsBox.values}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าแรก'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'แบบฟอร์มบันทึกข้อมูล',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "ชื่องาน",
                    border: OutlineInputBorder(),
                    helperText: "ชื่องานสำหรับบันทึกผล",
                  ),
                  onSaved: (value) {
                    newInformation["name"] = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดใส่ข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "รายละเอียด",
                    border: OutlineInputBorder(),
                    helperText: "รายละเอียดของงาน",
                  ),
                  onSaved: (value) {
                    newInformation["description"] = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดใส่ข้อมูล';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("ผลการประเมิณ"),
                    const SizedBox(width: 10.0),
                    DropdownButton<String>(
                      value: dropDownSelectValue,
                      icon: const Icon(Icons.arrow_drop_down_rounded,
                          color: Colors.blueAccent),
                      elevation: 16,
                      style: const TextStyle(color: Colors.blueGrey),
                      underline: Container(
                        height: 2,
                        color: Colors.lightBlueAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownSelectValue = newValue!;
                        });
                      },
                      items: dropDownOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: 50,
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!
                          .save(); // save into newInformation variable
                      debugPrint('$newInformation');
                      final information = Informations(
                        name: newInformation['name'],
                        description: newInformation['description'],
                        rate: dropDownSelectValue,
                      );
                      informationsBox.add(information);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pass Validate')),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "บันทึกผล",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/information');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "ดูข้อมูลล่าสุด",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
