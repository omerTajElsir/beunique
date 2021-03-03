import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:beunique/ui/pages/passions.dart';
import 'package:beunique/ui/theme/appTheme.dart';
import 'package:provider/provider.dart';

import 'core/providers/passionsProvider.dart';
import 'core/providers/profileProvider.dart';

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
          theme: appTheme(),
          home: Passions(),
        ),
      ),
    );
  }
}
