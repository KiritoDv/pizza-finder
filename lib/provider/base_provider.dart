import 'package:pizza_finder/provider/signin_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BaseProvider extends StatelessWidget {

  final Widget router;

  BaseProvider({this.router});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider())
      ],
      child: this.router,
    );
  }
}