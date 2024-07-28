import 'package:flutter/material.dart';
import 'package:news/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodels/signup_provider.dart';

class SignupScreen extends StatelessWidget {
  // Define a GlobalKey to manage the Form state
  final _formKey = GlobalKey<FormState>();

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
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start, // Aligns to the left
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'MyNews',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0c54BE),
                    ),
                  ),
                ),
                SizedBox(height: 176.h),
                Column(
                  children: <Widget>[
                    Consumer<SignupProvider>(
                      builder: (context, provider, _) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          onChanged: provider.setName,
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Consumer<SignupProvider>(
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
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0.h,horizontal:5.w), // Decrease vertical padding to reduce height
                          ),
                          style:TextStyle(color:Colors.black, fontFamily: 'Poppins',fontSize:10.sp),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            // Check if the email address is valid
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          onChanged: provider.setEmail,
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Consumer<SignupProvider>(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            // Optionally, you can add more complex password validations here
                            return null;
                          },
                          onChanged: provider.setPassword,
                        );
                      },
                    ),
                    SizedBox(height: 180.h),
                    SizedBox(
                      width: screenWidth / 2,
                      height: screenHeight * 0.07,
                      child: Consumer<SignupProvider>(
                        builder: (context, provider, _) {
                          return ElevatedButton(
                            child: Text('Signup'),
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
                                // If the form is valid, trigger the signup action
                                provider.signup(context);
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
                        Text('Already have an account?',style:TextStyle(color:Colors.black),),
                        TextButton(
                          onPressed: () {
                            // Handle login action
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginView()),
                            );
                          },
                          child: Text(
                            'Login',
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
