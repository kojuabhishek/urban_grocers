import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_grocers/Data_Model/ItemsProviders.dart';
import 'package:urban_grocers/screens/AddItem.dart';
import 'package:urban_grocers/screens/GoodsScreen.dart';
import 'package:urban_grocers/screens/MessageScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreennState();
}

class _HomeScreennState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    GoodsScreen(),
    MessageScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogBox(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 105, 125, 240),
      ),
      appBar: AppBar(centerTitle: true, title: Text("Urban Grocers")),
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "List",
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Completed",
                backgroundColor: Colors.green),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}

void showDialogBox(BuildContext context) {
  TextEditingController _titlecontrol = new TextEditingController();
  TextEditingController _desccontrol = new TextEditingController();
  AlertDialog notedialog = AlertDialog(
    title: Text("Add an Item"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _titlecontrol,
          decoration: InputDecoration(hintText: "Enter a title"),
        ),
        TextField(
            controller: _desccontrol,
            decoration: InputDecoration(hintText: "Enter description")),
      ],
    ),
    actions: [
      ElevatedButton(
          onPressed: () {
            Provider.of<ItemsProviders>(context, listen: false)
                .addItems(_titlecontrol.text, _desccontrol.text);
            Navigator.of(context).pop();
          },
          child: Text("ADD Items"))
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return notedialog;
      });
}
