import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:urban_grocers/Data_Model/Items.dart';
import 'package:urban_grocers/Data_Model/ItemsProviders.dart';

class confirmGoodsScreen extends StatelessWidget {
  const confirmGoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int tempsum;

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        titleSpacing: 0.0,
        title: Image.asset(
          "assets/list.jpg",
          fit: BoxFit.contain,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<ItemsProviders>(
          builder: (context, ItemsProviders data, child) {
            int sum = 0;
            return data.getItems.length != 0
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.getItems.length,
                            itemBuilder: (context, index) {
                              sum = sum +
                                  int.parse(data.getItems[index].description);

                              print('The sum is : $sum');

                              return Column(
                                children: [
                                  CardList(data.getItems[index], index),
                                ],
                              );
                            }),
                      ),
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            child: const Text('Total'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('The total sum is $sum'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            },
                          )
                          // ElevatedButton(
                          //     onPressed: () {
                          //       print('The second sum is : $sum');

                          //     },
                          //     child: Text('Total'))
                          )
                    ],
                  )
                : Center(
                    child: Text("Add Items Now"),
                  );
          },
        ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final Items items;
  int index;

  CardList(this.items, this.index);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          backgroundColor: Colors.redAccent,
          icon: Icons.delete,
          label: 'Delete',
          onPressed: (context) => {
            Provider.of<ItemsProviders>(context, listen: false)
                .removeItems(index),
          },
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListTile(
          leading: Icon(Icons.list_alt),
          title: Text(items.title),
          subtitle: Text(items.description),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
