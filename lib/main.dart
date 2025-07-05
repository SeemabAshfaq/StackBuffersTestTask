import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stack_buffer_test_task/firebase_options.dart';
import 'package:stack_buffer_test_task/models/product_model.dart';
import 'package:stack_buffer_test_task/viewmodels/bottom_nav_bar_viewmodel.dart';
import 'package:stack_buffer_test_task/viewmodels/favourite_viewmodel.dart';
import 'package:stack_buffer_test_task/viewmodels/product_viewmodel.dart';
import 'package:stack_buffer_test_task/viewmodels/setting_viewmodel.dart';
import 'package:stack_buffer_test_task/views/bottom_nav_bar_screen.dart';
import 'package:stack_buffer_test_task/views/product_details_screen.dart';
import 'package:stack_buffer_test_task/views/splash_screen.dart';
import 'package:stack_buffer_test_task/views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => FavouriteViewmodel()),
        ChangeNotifierProxyProvider<ProductViewModel, BottomNavProvider>(
          create: (context) => BottomNavProvider(
            productProvider: Provider.of<ProductViewModel>(
              context,
              listen: false,
            ),
          ),
          update: (_, product, __) =>
              BottomNavProvider(productProvider: product),
        ),
        ChangeNotifierProvider(create: (_) => SettingViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            // You can keep using GetX for navigation if needed
            debugShowCheckedModeBanner: false,
            title: 'Test Task',
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/navbar': (context) => BottomNavBar(),
              '/productDetails': (context) {
                final product =
                    ModalRoute.of(context)!.settings.arguments as ProductModel;
                return ProductDetailScreen(product: product);
              },
            },
          );
        },
      ),
    );
  }
}
