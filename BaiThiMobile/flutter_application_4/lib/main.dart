import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'models/pixabay_image.dart';
import 'screens/home_screens.dart';
import 'screens/login_screens.dart';
import 'screens/register_screens.dart';
import 'screens/favorites_screens.dart';
import 'screens/my_uploads_screens.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
        Locale('zh', 'CN'),
      ],
      path: 'assets/l10n',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _registeredEmail;
  String? _registeredPassword;
  String? _currentUserEmail;
  bool _isDarkMode = false;
  bool _isInitialized = false;

  final List<PixabayImage> _favoriteImages = [];
  final List<Uint8List> _uploadedImages = [];

  String _currentPage = 'login';

  @override
  void initState() {
    super.initState();
    _loadSavedAccount();
  }

  Future<void> _loadSavedAccount() async {
    final account = await AuthService.getRegisteredAccount();
    if (account != null && mounted) {
      setState(() {
        _registeredEmail = account['email'];
        _registeredPassword = account['password'];
        _isInitialized = true;
      });
    } else {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'app_title'.tr(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: _buildPage(),
    );
  }

  Widget _buildPage() {
    switch (_currentPage) {
      case 'login':
        return LoginScreen(
          registeredEmail: _registeredEmail,
          registeredPassword: _registeredPassword,
          onLoginSuccess: (email) {
            setState(() {
              _currentUserEmail = email;
              _currentPage = 'home';
            });
          },
          onNavigateToRegister: () {
            setState(() {
              _currentPage = 'register';
            });
          },
        );

      case 'register':
        return RegisterScreen(
          onRegister: (email, password) {
            setState(() {
              _registeredEmail = email;
              _registeredPassword = password;
            });
          },
          onBackToLogin: () {
            setState(() {
              _currentPage = 'login';
            });
          },
        );

      case 'favorites':
        return FavoritesScreen(
          favorites: _favoriteImages,
          onBack: () {
            setState(() {
              _currentPage = 'home';
            });
          },
          isFavorite: _isFavorite,
          onToggleFavorite: _toggleFavorite,
        );

      case 'uploads':
        return MyUploadsScreen(
          images: _uploadedImages,
          onBack: () {
            setState(() {
              _currentPage = 'home';
            });
          },
          onAddUploads: _addUploads,
        );

      case 'home':
      default:
        return HomeScreen(
          favorites: _favoriteImages,
          onToggleFavorite: _toggleFavorite,
          isFavorite: _isFavorite,
          onViewFavorites: () {
            setState(() {
              _currentPage = 'favorites';
            });
          },
          onViewUploads: () {
            setState(() {
              _currentPage = 'uploads';
            });
          },
          onLogout: _handleLogout,
          isDarkMode: _isDarkMode,
          onToggleDarkMode: () {
            setState(() {
              _isDarkMode = !_isDarkMode;
            });
          },
        );
    }
  }

  void _handleLogout() {
    setState(() {
      _currentUserEmail = null;
      _favoriteImages.clear();
      _uploadedImages.clear();
      _currentPage = 'login';
    });
  }

  bool _isFavorite(PixabayImage image) {
    return _favoriteImages.any((img) => img.id == image.id);
  }

  void _toggleFavorite(PixabayImage image) {
    setState(() {
      final index = _favoriteImages.indexWhere((img) => img.id == image.id);
      if (index >= 0) {
        _favoriteImages.removeAt(index);
      } else {
        _favoriteImages.add(image);
      }
    });
  }

  void _addUploads(List<Uint8List> newImages) {
    setState(() {
      _uploadedImages.addAll(newImages);
    });
  }
}
