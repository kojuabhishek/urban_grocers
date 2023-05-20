
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:isar/isar.dart';
import 'package:urban_grocers/Models/items.dart';
import 'package:urban_grocers/screens/HOME_SCREEN.dart';


class InsertRecord extends StatefulWidget {
  final Isar isar;
  final Items_2? data;

  const InsertRecord({this.data, required this.isar, super.key});

  @override
  State<InsertRecord> createState() => _InsertRecordState();
}

class _InsertRecordState extends State<InsertRecord> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();

  String buttonName = "Insert";
  late Isar isar;

  @override
  void initState() {
    super.initState();
    isar = widget.isar;
    if (widget.data != null) {
      buttonName = "Update";
      nameController.text = widget.data!.name;
      priceController.text = widget.data!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                  labelText: 'City', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // OutlinedButton(
                //     onPressed: () {
                //       _generateRandom();
                //     },
                //     child: Text("Random")),
                ElevatedButton(
                    onPressed: () {
                      if (buttonName == "Insert") {
                        _insert(nameController.text, priceController.text);
                      } else {
                        _update(widget.data!.id, nameController.text,
                            priceController.text);
                      }
                    },
                    child: Text("${buttonName}"))
              ],
            )
          ],
        ),
      )),
    );
  }

  _update(var updateId, String valueName, String valueDescription) async {
    if (updateId != 0) {
      final data = Items_2(id: updateId, name: valueName, description: valueDescription);
      await isar.writeTxn(() async {
        data.id = await isar.items_2s.put(data);
        data.id = await isar.items_2s.put(data);
        print("Updated ID: ${data.id}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisplayRecords(isar: isar)));
      });
    }
  }

  

  _insert(String valueName, String valueDescription) async {
    final data = Items_2(name: valueName, description: valueDescription);
    isar.writeTxn(() async {
      data.id = await isar.items_2s.put(data);
      print("last inserted ID: ${data.id}");
      nameController.text = "";
      priceController.text = "";
    });
  }
}
