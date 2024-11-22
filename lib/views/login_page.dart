// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/controllers/user_controller.dart';
import 'package:iremia/models/user_model.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/register_page.dart';
import 'package:iremia/views/widgets/navbar.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routname = '/login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    
    @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<UserController>(context);
    final loginProvider = Provider.of<UserModel>(context);
    final userController = Provider.of<UserController>(context, listen: false);
    final heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              Center(
                child: Text(
                  'IREMIA',
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF40BFFF),
                      fontSize: 33,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 29),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: GlobalColorTheme.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text('Login',
                          style: GoogleFonts.poppins(
                              fontSize: 26,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Email', style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),)),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: 'Email',
                            hintText: 'Masukkan email',
                            hintStyle: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5)),
                            labelStyle: GoogleFonts.poppins(color: Colors.black),
                            alignLabelWithHint: false,
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: GlobalColorTheme.errorColor, width: 1)),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: GlobalColorTheme.primaryColor,
                                    width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: GlobalColorTheme.errorColor, width: 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Password', style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),)),
                        TextField(
                          controller: _passwordController,
                          obscureText: loginProvider.isHide ? true : false,
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: 'Password',
                              hintText: 'Masukkan Password',
                              hintStyle: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5)),
                              labelStyle: GoogleFonts.poppins(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: GlobalColorTheme.errorColor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: GlobalColorTheme.primaryColor,
                                      width: 1)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: GlobalColorTheme.errorColor,
                                      width: 1)),
                              suffixIcon: IconButton(
                                icon: loginProvider.isHide
                                    ? const Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility,
                                        color: GlobalColorTheme.primaryColor),
                                onPressed: () {
                                  loginProvider.isHidePassword();
                                },
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ))),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();
              
                              final success =
                                  await userController.loginUser(email, password);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login berhasil')),
                                );
                                  Navigator.pushReplacementNamed(context, Navbar.routname);
                                // Navigate to Home Page
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login gagal')),
                                );
                              }
                            }
                          },
                          child: Container(
                            width: 122,
                            height: 40,
                            decoration: BoxDecoration(
                                color: GlobalColorTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ]),
                            child: Center(
                                child: Text(
                              'MASUK',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: heightScreen/3.5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, RegisterPage.routname);
                      },
                      child: Text('Daftar',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.bold)))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
