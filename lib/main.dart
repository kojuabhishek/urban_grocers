import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:urban_grocers/Data_Model/ItemsProviders.dart';
import 'package:urban_grocers/Models/items.dart';
import 'package:urban_grocers/screens/FirstScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:urban_grocers/screens/HOME_SCREEN.dart';
import 'package:urban_grocers/screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await Isar.open([Items_2Schema],
      directory: (await getApplicationDocumentsDirectory()).path);
  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({required this.isar, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemsProviders(),
      child: MaterialApp(
        title: 'Urban Grocers',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: DisplayRecords(isar: isar),
      ),
    );
  }
}
