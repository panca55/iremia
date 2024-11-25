import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/provider/question_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/diagnose_result.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class QuestionnairePage extends StatefulWidget {
  static String routeName = '/questionnaire-page';
  final int? questionId;

  const QuestionnairePage({super.key, this.questionId});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  late QuestionProvider questionProvider;
  late String? currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    currentUser = FirebaseAuth.instance.currentUser?.uid;
  }
  @override
  Widget build(BuildContext context) {
    final questionId = widget.questionId;

    if (questionId == null) {
      return const Scaffold(
        body: Center(
          child: Text('Pertanyaan tidak ditemukan.'),
        ),
      );
    }

    final userId = FirebaseAuth.instance.currentUser;
    final currentUser = userId?.uid;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('User tidak ditemukan. Mohon login kembali.'),
        ),
      );
    }

    final question = questionProvider.getQuestionById(widget.questionId!);
    // ignore: unnecessary_null_comparison
    if (question == null) {
      return const Scaffold(
        body: Center(
          child: Text('Pertanyaan tidak ditemukan.'),
        ),
      );
    }

    final currentIndex = questionProvider.questions
        .indexWhere((q) => q.questionId == questionId);
    final isLastQuestion =
        currentIndex == questionProvider.questions.length - 1;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 52, left: 20, right: 20),
        color: GlobalColorTheme.primaryColor,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                      PersistentNavBarNavigator.pop(context);
                  },
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: const Center(
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.blue, size: 17),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                StrokeText(
                  text: 'Kuesioner Diagnosa Anxiety',
                  textStyle: GoogleFonts.poppins(
                    fontSize: 20,
                    color: GlobalColorTheme.primaryColor,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                  strokeColor: Colors.white,
                  strokeWidth: 3,
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Pertanyaan
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                question.questionText!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Pilihan jawaban
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: question.answers!.length,
                itemBuilder: (context, index) {
                  final answer = question.answers![index];
                  final cfUser = answer['cfUser'];
                  final bai = answer['bai'];

                  return GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      // Simpan jawaban
                      questionProvider.saveAnswer(question.questionId!, cfUser, bai);

                      // Jika pertanyaan terakhir
                      if (isLastQuestion) {
                        // Hitung CF akhir
                        questionProvider.calculateFinalCF();
                        questionProvider.calculateTotalBai();

                        // Simpan hasil diagnosis ke Firestore
                        await questionProvider.saveDiagnosis(currentUser);

                        // Ambil ID diagnosis terbaru
                        final latestDiagnosis = await questionProvider
                            .getLatestDiagnosis(currentUser);

                        // Navigasi ke hasil diagnosa
                        
                          Navigator.pushReplacementNamed(
                            // ignore: use_build_context_synchronously
                            context,
                            DiagnoseResult.routeName,
                            arguments: latestDiagnosis?.diagnosisId ?? '',
                          );
                      } else {
                        // Navigasi ke pertanyaan berikutnya
                        final nextQuestionId = questionProvider
                            .questions[currentIndex + 1].questionId;
                        
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionnairePage(
                                questionId: nextQuestionId,
                              ),
                            ),
                          );
                        
                      }

                      // Tampilkan notifikasi jawaban yang dipilih
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Anda memilih: ${answer['text']}',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        answer['text'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
