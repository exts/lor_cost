import 'package:flutter/material.dart';
import 'package:lorcost/components/card_data_loader.dart';
import 'package:lorcost/domain/deck/providers/deck_list_provider.dart';
import 'package:lorcost/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(LorCostApp());
}

class LorCostApp extends StatelessWidget {
  // This widget is the root of your application.
  LorCostApp() {}
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DeckListProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
