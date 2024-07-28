// views/login_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/views/signup_screen.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_provider.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F9FD),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'MyNews',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0c54BE),
                    ),
                  ),
                ),
                SizedBox(height: 180.h),
                Column(
                  children: <Widget>[
                    Consumer<LoginProvider>(
                      builder: (context, provider, _) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0.h,horizontal:5.w),
                          ),
                          style:TextStyle(color:Colors.black, fontFamily: 'Poppins',fontSize:10.sp),
                          onChanged: provider.setEmail,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Simple email validation
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Consumer<LoginProvider>(
                      builder: (context, provider, _) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0.h,horizontal:5.w),
                          ),
                          obscureText: true,
                          style:TextStyle(color:Colors.black, fontFamily: 'Poppins',fontSize:10.sp),
                          onChanged: provider.setPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 240.h),
                    SizedBox(
                      width: screenWidth / 2,
                      height: screenHeight * 0.07,
                      child: Consumer<LoginProvider>(
                        builder: (context, provider, _) {
                          return ElevatedButton(
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF0c54BE),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              textStyle: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Perform login action
                                context.read<LoginProvider>().login(context);
                              }
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('New here?',style:TextStyle(color:Colors.black),),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: Color(0xFF0c54BE),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
