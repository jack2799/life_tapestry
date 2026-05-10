import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/entry_provider.dart';
import 'screens/home_screen.dart';

// Color palette matching web design
class AppColors {
  static const Color background = Color(0xFFF5F3F0);
  static const Color health = Color(0xFFD4EDD9);
  static const Color work = Color(0xFFD4E1F5);
  static const Color relationships = Color(0xFFF5D4DC);
  static const Color primaryButton = Color(0xFF4A6B7A);
  static const Color filterActive = Color(0xFF1A1A1A);
  static const Color filterInactive = Color(0xFFE8E8E8);
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EntriesNotifier())],
      child: MaterialApp(
        title: 'Life Tapestry',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: false,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButton,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
