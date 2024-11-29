// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremia/models/articles_model.dart';
import 'package:iremia/provider/articles_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/admin/widgets/navbar_admin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddArticle extends StatefulWidget {
  static const routname = '/add-article';
  const AddArticle({super.key});

  @override
  State<AddArticle> createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  final _authorController = TextEditingController();
  final _titleController = TextEditingController();
  final _publishController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _authorController.dispose();
    _titleController.dispose();
    _publishController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  Future<void> pickImage() async {
    try {
      if (Platform.isAndroid) {
        await requestPermission();
      }
      if(Platform.isWindows){
        await requestPermission();
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
  Future<String?> uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first.')),
      );
      return null;
    }

    setState(() {
    });

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'uploads/$fileName';

      await Supabase.instance.client.storage
          .from('articlesimage') // Replace 'images' with your bucket name
          .upload(path, _imageFile!);
      final fileUrl = Supabase.instance.client.storage
          .from('articlesimage')
          .getPublicUrl(path);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully! File: $path')),
      );
      return fileUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: ${e.toString()}')),
      );
      return null;
    } finally {
      setState(() {
      });
    }
  }
  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isDenied ||
          await Permission.photos.isPermanentlyDenied) {
        await Permission.photos.request();
      }
    }
  }

  void _showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Upload Gambar',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: GestureDetector(
            onTap: ()async{
              await pickImage().then((value) {
                Navigator.of(context).pop();
              });
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: _imageFile != null
                    ? DecorationImage(
                        image: FileImage(_imageFile!), fit: BoxFit.cover)
                    : null,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: GlobalColorTheme.primaryColor, width: 1),
              ),
              child: Center(
                child: _imageFile == null
                    ? Text(
                      'Ketuk untuk upload gambar',
                      style: GoogleFonts.poppins(
                          color: GlobalColorTheme.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final articlesProvider =
        Provider.of<ArticlesProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Tambah Artikel',
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Upload Gambar Artikel'),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: _imageFile != null ? DecorationImage(image:FileImage(_imageFile!), fit: BoxFit.cover) : null,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: GlobalColorTheme.primaryColor, width: 1),
                  ),
                  child: GestureDetector(
                    onTap:_showModal,
                    child: Center(
                      child: _imageFile == null ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      color: GlobalColorTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)
                    ),
                    child: Text('Upload Gambar', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),)
                    ) : null,
                    ),
                  ),
                ),
                // Judul Artikel
                _buildLabel('Judul Artikel'),
                _buildTextFormField(
                  controller: _titleController,
                  hintText: 'Masukkan judul artikel',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Judul tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 20),

                // Nama Author dan Tahun Publish
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Nama Author'),
                          _buildTextFormField(
                            controller: _authorController,
                            hintText: 'Masukkan nama author',
                            validator: (value) => value == null || value.isEmpty
                                ? 'Nama author tidak boleh kosong'
                                : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Tahun Publish'),
                          _buildTextFormField(
                            controller: _publishController,
                            hintText: 'Tahun publish',
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Tahun tidak boleh kosong'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Isi Artikel
                _buildLabel('Isi Artikel'),
                _buildTextFormField(
                  controller: _contentController,
                  hintText: 'Masukkan isi artikel',
                  maxLength: 2000,
                  maxLines: 5,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Isi artikel tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 30),

                // Tombol Submit
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      String? imageUrl = await uploadImage();
                      try {
                        ArticlesModel newArticle = ArticlesModel(
                          author: _authorController.text,
                          title: _titleController.text,
                          content: _contentController.text,
                          publish: _publishController.text,
                          image: imageUrl,
                          dateCreated: DateTime.now()
                        );
                          ScaffoldMessenger.of(context).showSnackBar(
                            _buildSnackBar('Berhasil menambah artikel',
                                GlobalColorTheme.successColor),
                          );
                          await articlesProvider
                            .addArticle(newArticle);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).popUntil(ModalRoute.withName(NavbarAdmin.routname));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          _buildSnackBar('Gagal menambah artikel: $e',
                              GlobalColorTheme.errorColor),
                        );
                      }
                    }
                  },
                  child: Container(
                    width: 122,
                    height: 40,
                    decoration: BoxDecoration(
                      color: GlobalColorTheme.successColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'SUBMIT',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper untuk Label
  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper untuk TextFormField
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLength = 255,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5)),
        labelStyle: GoogleFonts.poppins(color: Colors.black),
        alignLabelWithHint: false,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: GlobalColorTheme.errorColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: GlobalColorTheme.primaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: GlobalColorTheme.errorColor, width: 1),
        ),
      ),
      validator: validator,
    );
  }

  SnackBar _buildSnackBar(String message, Color backgroundColor) {
    return SnackBar(
      dismissDirection: DismissDirection.up,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      content: Text(
        message,
        style: GoogleFonts.poppins(color: Colors.white),
      ),
    );
  }
}
