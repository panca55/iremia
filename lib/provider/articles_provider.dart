import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iremia/models/articles_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ArticlesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<ArticlesModel> _articles = [];
  List<ArticlesModel> get articleList => _articles;

  int _selectedArticle = -1;
  int get selectedArticle => _selectedArticle;

  void setSelectedArticle(int index) {
    _selectedArticle = index;
    notifyListeners();
  }

  /// Tambah Artikel ke Firestore dan UI
  Future<void> addArticle(ArticlesModel article) async {
    try {
      // Tambahkan ke Firestore
      final docRef = _firestore.collection('articles').doc();
      final newArticle = article.copyWith(id: docRef.id);
      await docRef.set(newArticle.toFirestore());

      // Tambahkan ke UI
      _articles.insert(0, newArticle); // Tambah di awal daftar
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding article: $e');
      throw Exception('Gagal menambah artikel');
    }
  }

  /// Ambil Semua Artikel dari Firestore dan Sinkronkan ke UI
  Future<void> fetchArticles() async {
    try {
      final snapshot = await _firestore.collection('articles').get();
      _articles.clear();

      // Konversi data dari Firestore ke model
      for (var doc in snapshot.docs) {
        final article = ArticlesModel.fromFirestore(doc.data());
        _articles.add(article);
      }

      notifyListeners(); // Perbarui UI
    } catch (e) {
      debugPrint('Error fetching articles: $e');
      throw Exception('Gagal mengambil artikel');
    }
  }

  /// Update Artikel di Firestore dan UI
  Future<void> updateArticle(String id, ArticlesModel updatedArticle) async {
    try {
      // Update di Firestore
      final docRef = _firestore.collection('articles').doc(id);
      await docRef.update(updatedArticle.toFirestore());

      // Update di UI
      final index = _articles.indexWhere((article) => article.id == id);
      if (index != -1) {
        _articles[index] = updatedArticle;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating article: $e');
      throw Exception('Gagal memperbarui artikel');
    }
  }

  /// Hapus Artikel dari Firestore, Supabase, dan UI
  Future<void> deleteArticle(String articleId, String? imagePath) async {
    try {
      // Hapus artikel dari Firestore
      await _firestore.collection('articles').doc(articleId).delete();

      // Hapus gambar dari Supabase (jika ada)
      if (imagePath != null && imagePath.isNotEmpty) {
        final oldPath = imagePath.split('/').last;
        await Supabase.instance.client.storage
            .from('articlesimage')
            .remove(['uploads/$oldPath']);
      }

      // Hapus dari UI
      _articles.removeWhere((article) => article.id == articleId);
      notifyListeners(); // Perbarui UI
    } catch (e) {
      debugPrint('Gagal menghapus artikel: $e');
      throw Exception('Gagal menghapus artikel: $e');
    }
  }
}
