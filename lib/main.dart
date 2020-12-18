import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/services/auth_service.dart';
import 'package:todos/locator.dart';
import 'package:todos/ui/todos_body.dart';
import 'core/providers/todo_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  runApp(MyTodosApp());
}

class MyTodosApp extends StatelessWidget {
  final MaterialColor manabie = const MaterialColor(0xFF395AD2, {
    50: Color.fromRGBO(57, 90, 210, .1),
    100: Color.fromRGBO(57, 90, 210, .2),
    200: Color.fromRGBO(57, 90, 210, .3),
    300: Color.fromRGBO(57, 90, 210, .4),
    400: Color.fromRGBO(57, 90, 210, .5),
    500: Color.fromRGBO(57, 90, 210, .6),
    600: Color.fromRGBO(57, 90, 210, .7),
    700: Color.fromRGBO(57, 90, 210, .8),
    800: Color.fromRGBO(57, 90, 210, .9),
    900: Color.fromRGBO(57, 90, 210, 1),
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<TodoProvider>()),
        StreamProvider<User>(
            create: (_) => locator<AuthService>().userStream()),
      ],
      child: MaterialApp(
        title: 'Todos',
        theme: ThemeData(
            accentColor: Color(0xFF3ACD96),
            primarySwatch: manabie,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.montserratTextTheme()),
        home: MyHomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user != null
        ? Scaffold(
            bottomNavigationBar: SizedBox(
              height: 56,
              child: BottomNavigationBar(
                unselectedItemColor: Colors.grey[400],
                onTap: onTabTapped,
                currentIndex: _currentIndex,
                fixedColor: Theme.of(context).primaryColor.withOpacity(.8),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: new Icon(FontAwesomeIcons.solidCalendarCheck),
                      label: "Complete"),
                  BottomNavigationBarItem(
                      icon: new Icon(FontAwesomeIcons.solidListAlt),
                      label: "All"),
                  BottomNavigationBarItem(
                      icon: new Icon(FontAwesomeIcons.solidCalendarTimes),
                      label: "Incomplte")
                ],
              ),
            ),
            body: TodosBody(_currentIndex),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );

    // return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //   builder: (context, state) {
    //     if (state is Authenticated) {
    //       return Scaffold(
    //         bottomNavigationBar: SizedBox(
    //           height: 56,
    //           child: BottomNavigationBar(
    //             unselectedItemColor: Colors.grey[400],
    //             onTap: onTabTapped,
    //             currentIndex: _currentIndex,
    //             fixedColor: Theme.of(context).primaryColor.withOpacity(.8),
    //             items: <BottomNavigationBarItem>[
    //               BottomNavigationBarItem(
    //                   icon: new Icon(FontAwesomeIcons.solidCalendarCheck),
    //                   label: "Complete"),
    //               BottomNavigationBarItem(
    //                   icon: new Icon(FontAwesomeIcons.solidListAlt),
    //                   label: "All"),
    //               BottomNavigationBarItem(
    //                   icon: new Icon(FontAwesomeIcons.solidCalendarTimes),
    //                   label: "Incomplte")
    //             ],
    //           ),
    //         ),
    //         body: TodosBody(),
    //       );
    //     }
    //     if (state is Unauthenticated) {
    //       return Center(
    //         child: Text('Could not authenticate with Firestore'),
    //       );
    //     }
    //     return Container(
    //         color: Theme.of(context).primaryColor,
    //         child: Center(child: Image.asset('assets/m_splash')));
    //   },
    // );
  }
}
