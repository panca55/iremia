// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/controllers/user_controller.dart';
import 'package:iremia/models/user_model.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/login_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const routname = '/register-page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usiaController = TextEditingController();
  String? _valKelamin;

  final List<String> _listKelamin = ["Laki-laki", "Perempuan"];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usiaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserController>(context);
    final heightScreen = MediaQuery.of(context).size.height;
    final registerProvider = Provider.of<UserModel>(context);
    final userController = Provider.of<UserController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26),
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
            SizedBox(
              height: heightScreen / 14,
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
                    child: Text('Register',
                        style: GoogleFonts.poppins(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Nama Lengkap
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Nama Lengkap',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Nama Lengkap',
                      hintText: 'Masukkan nama lengkap',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.5)),
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
                              color: GlobalColorTheme.primaryColor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: GlobalColorTheme.errorColor, width: 1)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Usia dan Jenis Kelamin
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(0),
                        width: 107,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Usi',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )),
                            TextFormField(
                              controller: _usiaController,
                              keyboardType: TextInputType.number,
                              maxLengthEnforcement:MaxLengthEnforcement.none,
                              textInputAction: TextInputAction.next,
                              maxLength: 2,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                labelText: 'Usia',
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.5)),
                                labelStyle:
                                    GoogleFonts.poppins(color: Colors.black),
                                alignLabelWithHint: false,
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: GlobalColorTheme.errorColor,
                                        width: 1)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
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
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Usia tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: _valKelamin,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                alignLabelWithHint: false,
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: GlobalColorTheme.errorColor,
                                        width: 1)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: GlobalColorTheme.primaryColor,
                                        width: 1)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: GlobalColorTheme.errorColor,
                                        width: 1))),
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 13),
                            enableFeedback: true,
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            isExpanded: false,
                            dropdownColor: Colors.white,
                            hint: Text(
                              "Pilih Jenis Kelamin",
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 13),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            items: _listKelamin.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valKelamin = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Pilih jenis kelamin';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Email
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Email',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Email',
                      hintText: 'Masukkan email',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.5)),
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
                              color: GlobalColorTheme.primaryColor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: GlobalColorTheme.errorColor, width: 1)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Password
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Password',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: registerProvider.isHide ? true : false,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Password',
                        hintText: 'Masukkan Password',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.5)),
                        labelStyle: GoogleFonts.poppins(color: Colors.black),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.errorColor, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.primaryColor,
                                width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.errorColor, width: 1)),
                        suffixIcon: IconButton(
                              icon: registerProvider.isHide
                                  ? const Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility,
                                      color: GlobalColorTheme.primaryColor),
                              onPressed: () {
                                registerProvider.isHidePassword();
                              },
                            )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password harus minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Konfirmasi Password
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Konfirmasi Password',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: registerProvider.isHide ? true : false,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Konfirmasi Password',
                        hintText: 'Masukkan Password',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.5)),
                        labelStyle: GoogleFonts.poppins(color: Colors.black),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.errorColor, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.primaryColor,
                                width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.errorColor, width: 1)),
                                suffixIcon: IconButton(
                              icon: registerProvider.isHide
                                  ? const Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility,
                                      color: GlobalColorTheme.primaryColor),
                              onPressed: () {
                                registerProvider.isHidePassword();
                              },
                            ),),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Password tidak sesuai';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Tombol Register
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // Buat UserModel dari inputan form
                        UserModel userModel = UserModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          usia: _usiaController.text,
                          jenisKelamin: _valKelamin,
                        );

                        final success =
                            await userController.registerUser(userModel);
                        if (success) {
                            Navigator.pushReplacementNamed(
                              context, LoginPage.routname);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Registrasi berhasil')),);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registrasi gagal')),
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
                        'REGISTER',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen / 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun? ',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LoginPage.routname);
                          },
                          child: Text('Masuk',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
