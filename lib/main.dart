import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/routes/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String token;
final _storage = new FlutterSecureStorage();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await _storage.read(key: "token");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kPrimaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: token == null ? "/login" : "/tasks",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
