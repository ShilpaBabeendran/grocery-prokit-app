import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/auth/auth_service.dart';
import 'package:grocery_app/auth/lgin_screen.dart';
import 'package:grocery_app/auth/signup_screen.dart';
import 'package:grocery_app/pages/cart_screen.dart';
import 'package:grocery_app/pages/order_history_screen.dart';
import 'package:grocery_app/pages/profile/profile_screen.dart';
import 'package:grocery_app/pages/wishlist_screen.dart';
import 'package:grocery_app/provider/order_provider.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/services/cart_provider.dart';
import 'package:grocery_app/provider/theme_provider.dart';
import 'package:grocery_app/provider/whishlist_provider.dart';
import 'package:grocery_app/widgets/view_all_screen.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/pages/home_screen.dart';
import 'firebase_options.dart';
import 'core/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const GroceryApp(),
    ),
  );
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: ThemeData.dark(),
        themeMode: context.watch<ThemeProvider>().isDark
            ? ThemeMode.dark
            : ThemeMode.light,
        routes: {
          "/": (context) => const CheckUserData(),
          "/login": (context) => const LoginScreen(),
          "/signup": (context) => const SignUpScreen(),
          "/home": (context) => const HomeScreen(),
          "/cart": (context) => const CartScreen(),
          "/profile": (context) => const ProfileScreen(),
          "/orderhistory": (context) => const OrderHistoryScreen(),
          "/wishlist": (context) => const WishlistScreen(),
          "/viewall": (context) => const ViewAllScreen(),
        },
      ),
    );
  }
}

class CheckUserData extends StatefulWidget {
  const CheckUserData({super.key});

  @override
  State<CheckUserData> createState() => _CheckUserDataState();
}

class _CheckUserDataState extends State<CheckUserData> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      final isLoggedIn = await AuthServiceHelper.isUserLoggedIn();
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          isLoggedIn ? "/home" : "/login",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
