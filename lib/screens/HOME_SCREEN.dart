import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:urban_grocers/Data_Model/Items.dart';
import 'package:urban_grocers/Data_Model/ItemsProviders.dart';
import 'package:urban_grocers/Models/items.dart';
import 'package:urban_grocers/screens/AddItem.dart';
import 'package:urban_grocers/screens/ConfirmScreen/confirmGoods.dart';
import 'package:urban_grocers/screens/FirstScreen.dart';

class DisplayRecords extends StatefulWidget {
  Isar isar;
  final Items_2? data;

  DisplayRecords({this.data, required this.isar, super.key});

  @override
  State<DisplayRecords> createState() => _DisplayRecordsState();
}

class _DisplayRecordsState extends State<DisplayRecords> {
  late Isar isar;
  @override
  void initState() {
    super.initState();
    isar = widget.isar;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Urban Grocers"),
      ),
      //   IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => InsertRecord(isar: isar),
      //             ));
      //       },
      //       icon: Icon(Icons.add))
      // ]),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => confirmGoodsScreen())
                      //(route) => false
                      );
                },
                child: Icon(Icons.list),
              )), //button first

          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InsertRecord(
                              isar: isar,
                            )),
                  );
                },
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.add),
              )), // button second

          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "btn3",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstScreen()),
                  );
                },
                backgroundColor: Colors.deepOrangeAccent,
                child: Icon(Icons.history),
              )), // button third

          // Add more buttons here
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
              child: StreamBuilder(
                  stream: execQuery(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Items_2>> arrData) {
                    if (arrData.hasData) {
                      return ListView.builder(
                          itemCount: arrData.data!.length,
                          itemBuilder: (context, index) {
                            return _displayData(arrData.data![index]);
                          });
                    } else {
                      return Center(
                        child: Text("No Data Found"),
                      );
                    }
                  })),
        ),
      ),
    );
  }

  Widget _displayData(Items_2 data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            backgroundColor: Colors.greenAccent,
            icon: Icons.check,
            label: 'Done',
            onPressed: (context) => {
              Provider.of<ItemsProviders>(context, listen: false)
                  .addItems(data.name, data.description)
            },
          )
        ]),
        child: InkWell(
          onTap: () {
            print(data.id);
          },
          child: Card(
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(children: [
                Text(
                  "${data.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${data.description}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InsertRecord(
                                      isar: isar,
                                      data: data,
                                    )));
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.green,
                    ),
                    IconButton(
                        onPressed: () {
                          _delete(data);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red)
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  _delete(Items_2 data) async {
    await isar.writeTxn(() async {
      await isar.items_2s.delete(data.id!);
    });
  }

  Stream<List<Items_2>> execQuery() {
    return isar.items_2s
        .where(sort: Sort.asc)
        .build()
        .watch(fireImmediately: true);
  }
}
