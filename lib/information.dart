import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';
import 'models/informations.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final informationsBox = Boxes.getInformations();

  Widget alertDialog(BuildContext context, Informations box) {
    return AlertDialog(
      title: const Text("จัดการข้อมูล"),
      content: const Text("หากยังไม่ต้องการลบหรือส่งรายงานให้กด ปิดหน้านี้"),
      actions: [
        TextButton(
          child: const Text("ลบรายงาน", style: TextStyle(color: Colors.red)),
          onPressed: () {
            box.delete();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("ปิดหน้านี้"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text("ส่งรายงาน", style: TextStyle(color: Colors.green)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลล่าสุด'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder<Box<Informations>>(
          valueListenable: informationsBox.listenable(),
          builder: (context, box, _) {
            final informations = box.values.toList().cast<Informations>();
            if (informations.isEmpty) {
              return const Text(
                'ไม่มีข้อมูล',
                style: TextStyle(fontSize: 25.0),
              );
            }
            return ListView.builder(
              itemCount: informations.length,
              itemBuilder: ((context, index) {
                final box = informations[index];
                // return ListTile(
                //   title: Text("ชื่องาน: ${box.name}"),
                //   subtitle: Text("รายละเอียด: ${box.description}"),
                //   trailing: Text('ระดับ: ${box.rate}'),
                //   leading: const Icon(Icons.history_sharp),
                // );
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromARGB(255, 48, 94, 163),
                          Color.fromARGB(255, 49, 142, 235),
                          Color.fromARGB(255, 104, 187, 255),
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                        )
                      ]),
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                      child: const Icon(Icons.document_scanner_outlined,
                          color: Colors.white),
                    ),
                    title: Text(
                      "ชื่องาน: ${box.name}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Text('ระดับ: ${box.rate}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    subtitle: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'รายละเอียด: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                  fontSize: 17)),
                          TextSpan(
                              text: box.description,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70)),
                        ],
                      ),
                    ),
                    onTap: () => {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alertDialog(context, box);
                        },
                      )
                    },
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
