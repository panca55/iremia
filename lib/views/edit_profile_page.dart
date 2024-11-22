import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/models/user_model.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  static const routname = '/edit-profile-page';
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _valKelamin;
  final List<String> _listKelamin = ["Laki-laki", "Perempuan"];
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<UserModel>(context, listen: false);
    final heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26),
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
          Center(
            child: Text(
              'Nama Pengguna',
              style: GoogleFonts.poppins(
                  color: const Color(0xFFAAAAAA),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'emailpengguna@gmail.com',
              style: GoogleFonts.poppins(
                  color: const Color(0xFF000000),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: heightScreen / 14,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 29),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Nama Lengkap',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )),
                    TextField(
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
                                color: GlobalColorTheme.primaryColor,
                                width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.errorColor, width: 1)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                                    'Usia',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextField(
                                keyboardType: TextInputType.number,
                                maxLengthEnforcement: MaxLengthEnforcement.none,
                                textInputAction: TextInputAction.next,
                                maxLength: 2,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
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
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
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
                                        width: 1)),
                              ),
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
                              value: _valKelamin,
                              items: _listKelamin.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _valKelamin = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Email',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )),
                    TextField(
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
                                color: GlobalColorTheme.primaryColor,
                                width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: GlobalColorTheme.errorColor, width: 1)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Password',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )),
                    Consumer<UserModel>(
                      builder: (BuildContext context, value, Widget? child) {
                        return TextField(
                          obscureText: registerProvider.isHide ? true : false,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Password',
                              hintText: 'Masukkan Password',
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.5)),
                              labelStyle:
                                  GoogleFonts.poppins(color: Colors.black),
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
                                icon: registerProvider.isHide
                                    ? const Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility,
                                        color: GlobalColorTheme.primaryColor),
                                onPressed: () {
                                  registerProvider.isHidePassword();
                                },
                              )),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Konfirmasi Password',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )),
                    Consumer<UserModel>(
                      builder: (BuildContext context, value, Widget? child) {
                        return TextField(
                          obscureText: registerProvider.isHide ? true : false,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Password',
                              hintText: 'Masukkan Password',
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.5)),
                              labelStyle:
                                  GoogleFonts.poppins(color: Colors.black),
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
                                icon: registerProvider.isHide
                                    ? const Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility,
                                        color: GlobalColorTheme.primaryColor),
                                onPressed: () {
                                  registerProvider.isHidePassword();
                                },
                              )),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: heightScreen / 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.popUntilFirstScreenOnSelectedTabScreen(
                      context,
                      routeName:
                          "/",
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal:22.5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: GlobalColorTheme.errorColor, width: 2)
                    ),
                    child: Text('KELUAR',
                        style: GoogleFonts.poppins(
                            color: GlobalColorTheme.errorColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  )),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.5, horizontal: 22.5),
                    decoration: BoxDecoration(
                      color: GlobalColorTheme.successColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 0.8)
                    ),
                    child: Text('SIMPAN',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
