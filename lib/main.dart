import 'package:beunique/providers/passionsProvider.dart';
import 'package:beunique/providers/profileProvider.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:beunique/ui/pages/passions.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PassionsProvider()),
      ],
      child: ConnectivityAppWrapper(
        app: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test App',
          theme:ThemeData(
              primaryColor: Colors.blue),
          home: Passions(),
        ),
      ),
    );
  }
}
