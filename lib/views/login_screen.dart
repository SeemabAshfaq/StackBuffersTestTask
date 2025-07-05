import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stack_buffer_test_task/core/colors.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/reusable_button.dart';
import '../widgets/reusable_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: SingleChildScrollView(
                child: Consumer<LoginViewModel>(
                  builder: (context, vm, _) {
                    return Form(
                      key: vm.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? whiteColor : blackColor,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          ReusableTextField(
                            controller: vm.emailController,
                            labelText: 'Email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (GetUtils.isEmail(value) == false) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          ReusableTextField(
                            controller: vm.passwordController,
                            labelText: 'Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          vm.isLoading == false
                              ? ReusableButton(
                                  text: 'Login',

                                 
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: whiteColor,
                                  ),
                                  onPressed: () {
                                    if (vm.loginFormKey.currentState!
                                        .validate()) {
                                      vm.login(context);
                                    }
                                  },
                                )
                              : SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: mainGreenColor,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
