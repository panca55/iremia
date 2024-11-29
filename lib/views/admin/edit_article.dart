// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremia/models/articles_model.dart';
import 'package:iremia/provider/articles_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditArticle extends StatefulWidget {
  static const routname = '/edit-article';
  final ArticlesModel article;

  const EditArticle({super.key, required this.article});

  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _authorController;
  late TextEditingController _titleController;
  late TextEditingController _publishController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _authorController = TextEditingController(text: widget.article.author);
    _titleController = TextEditingController(text: widget.article.title);
    _publishController = TextEditingController(text: widget.article.publish);
    _contentController = TextEditingController(text: widget.article.content);
  }

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
      await requestPermission();
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

  Future<String?> uploadImage(String? existingPath) async {
    if (_imageFile == null) {
      return existingPath; // Jika gambar tidak diubah, gunakan gambar yang lama.
    }

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'uploads/$fileName';

      await Supabase.instance.client.storage
          .from('articlesimage')
          .upload(path, _imageFile!);

      final fileUrl = Supabase.instance.client.storage
          .from('articlesimage')
          .getPublicUrl(path);

      // Hapus file lama jika ada
      if (existingPath != null) {
        final oldPath = existingPath.split('/').last;
        await Supabase.instance.client.storage
            .from('articlesimage')
            .remove(['uploads/$oldPath']);
      }

      return fileUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return existingPath; // Jika upload gagal, gunakan gambar lama.
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
          'Edit Artikel',
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
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: _imageFile != null
                          ? DecorationImage(
                              image: FileImage(_imageFile!), fit: BoxFit.cover)
                          : widget.article.image != null
                              ? DecorationImage(
                                  image: NetworkImage(widget.article.image!),
                                  fit: BoxFit.cover)
                              : null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: GlobalColorTheme.primaryColor, width: 1),
                    ),
                    child: Center(
                      child: _imageFile == null &&
                              (widget.article.image == null ||
                                  widget.article.image!.isEmpty)
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: GlobalColorTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white)),
                              child: Text(
                                'Upload Gambar',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Form Inputs
                _buildLabel('Judul Artikel'),
                _buildTextFormField(
                  controller: _titleController,
                  hintText: 'Masukkan judul artikel',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Judul tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 20),

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

                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      String? imageUrl =
                          await uploadImage(widget.article.image);
                      try {
                        ArticlesModel updatedArticle = ArticlesModel(
                          id: widget.article.id,
                          author: _authorController.text,
                          title: _titleController.text,
                          content: _contentController.text,
                          publish: _publishController.text,
                          image: imageUrl,
                          dateCreated: widget.article.dateCreated,
                        );

                        await articlesProvider.updateArticle(widget.article.id!,updatedArticle);

                        ScaffoldMessenger.of(context).showSnackBar(
                          _buildSnackBar('Artikel berhasil diperbarui',
                              GlobalColorTheme.successColor),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          _buildSnackBar('Gagal memperbarui artikel: $e',
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

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLength = 100,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: GlobalColorTheme.primaryColor)),
      ),
    );
  }

  SnackBar _buildSnackBar(String message, Color backgroundColor) {
    return SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
