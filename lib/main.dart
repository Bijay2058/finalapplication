import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/login.dart';
import 'package:untitled2/register.dart';
import 'package:untitled2/screens/discover_screen.dart';
import 'screens/home.dart';
import 'screens/news_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'list_provider.dart';



void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp( MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  // private navigators
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const ScaffoldWithNavBarTabItem(

        initialLocation: '/a',
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/b',
        icon: Icon(LucideIcons.newspaper),
        label: 'Section B',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/c',
        icon: Icon(LucideIcons.compass),
        label: 'discover ',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/d',
        icon: Icon(Icons.calendar_month),
        label: 'Calender',
      ),
    ];

    final goRouter = GoRouter(
      initialLocation: '/l',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(tabs: tabs, child: child);
          },
          routes: [
            GoRoute(
                path: '/l',
                pageBuilder: (context, state) =>
                    NoTransitionPage(key: state.pageKey, child: LoginScreen(),)

            ),

            GoRoute(
                path: '/r',
                pageBuilder: (context, state) =>
                    NoTransitionPage(key: state.pageKey, child: RegistrationScreen(),)

            ),
            // Products
            GoRoute(
                path: '/a',
                pageBuilder: (context, state) =>
                    NoTransitionPage(key: state.pageKey, child: const HomeScreen(),)

            ),
            // Shopping Cart
            GoRoute(
              path: '/b',
              pageBuilder: (context, state) =>
                  NoTransitionPage(key: state.pageKey, child: const NewsScreen()),
            ),
            GoRoute(
              path: '/c',
              pageBuilder: (context, state) =>
                  NoTransitionPage(key: state.pageKey, child: const discoverscreen()),
            ),


          ],
        ),
      ],
    );

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=>MovieListProvider()),ChangeNotifierProvider(create: (context)=>completedMovieListProvider()),ChangeNotifierProvider(create: (context)=>laterMovieListProvider()),],
      child: MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
      ),
    );
  }
}

/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}



class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar(
      {Key? key, required this.child, required this.tabs})
      : super(key: key);
  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _locationToTabIndex(String location) {
    final index =
    widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  void _onItemTapped(BuildContext context, int tabIndex) {
    // Only navigate if the tab index has changed
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: widget.tabs,
        onTap: (index) => _onItemTapped(context, index),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        backgroundColor: Color.fromRGBO(17, 26, 41, 0.9),
      ),
    );
  }
}


