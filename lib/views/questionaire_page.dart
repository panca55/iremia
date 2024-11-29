import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iremia/provider/question_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/diagnose_result.dart';
import 'package:provider/provider.dart';

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
  int? selectedAnswerIndex;
  final Set<int> _visitedQuestions = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    currentUser = FirebaseAuth.instance.currentUser?.uid;
  }

  void _navigateToQuestion(int questionId) {
    setState(() {
      _visitedQuestions
          .add(questionId); // Tandai halaman ini sebagai dikunjungi
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionnairePage(
          questionId: questionId,
        ),
      ),
    );
  }

  void _resetQuestionnaire() {
    setState(() {
      // Hapus semua data visitedQuestions
      _visitedQuestions.clear();

      // Reset semua jawaban di provider
      questionProvider.resetAnswers();
    });
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

    final question = questionProvider.getQuestionById(widget.questionId!);

    final currentIndex = questionProvider.questions
        .indexWhere((q) => q.questionId == questionId);
    final isFirstQuestion = currentIndex == 0;
    final isLastQuestion =
        currentIndex == questionProvider.questions.length - 1;

    // Jika ada jawaban yang sudah dipilih sebelumnya, atur sebagai selected
    selectedAnswerIndex = questionProvider.getSelectedAnswerIndex(questionId);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 52, left: 20, right: 20, bottom: 80),
        color: GlobalColorTheme.primaryColor,
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()   {Navigator.pop(context);_resetQuestionnaire();},
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
                Text(
                  'Pertanyaan ${currentIndex + 1} / ${questionProvider.questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                  final isSelected = selectedAnswerIndex == index;

                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        selectedAnswerIndex = index;
                        _visitedQuestions.add(question.questionId!);
                      });

                      // Simpan jawaban yang dipilih
                      questionProvider.saveAnswer(
                        question.questionId!,
                        answer['cfUser'],
                        answer['bai'],
                        index,
                      );

                      // Navigasi ke halaman berikutnya
                      if (!isLastQuestion) {
                        final nextQuestionId = questionProvider
                            .questions[currentIndex + 1].questionId;
                        _navigateToQuestion(nextQuestionId!);
                      } else {
                        // Hitung hasil dan reset data
                        questionProvider.calculateFinalCF();
                        questionProvider.calculateTotalBai();
                        await questionProvider
                            .saveDiagnosis(currentUser!)
                            .then((value) => _resetQuestionnaire());

                        final latestDiagnosis = await questionProvider
                            .getLatestDiagnosis(currentUser!);

                        Navigator.pushReplacementNamed(
                          // ignore: use_build_context_synchronously
                          context,
                          DiagnoseResult.routeName,
                          arguments: latestDiagnosis?.diagnosisId ?? '',
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? GlobalColorTheme.primaryColor
                            : Colors.white, // Warna saat dipilih
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.white
                              : GlobalColorTheme
                                  .primaryColor, // Border saat dipilih
                          width: 2,
                        ),
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
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Tombol Prev dan Next
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!isFirstQuestion)
                  GestureDetector(
                    onTap: () {
                      final prevQuestionId = questionProvider
                          .questions[currentIndex - 1].questionId;
                      _navigateToQuestion(prevQuestionId!);
                    },
                    child:  Container(
                      decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(8),
                    ),
                      padding: const EdgeInsets.all(10),child: Icon(Icons.arrow_back_ios_new, color: GlobalColorTheme.primaryColor,)),
                  ),  
                if (selectedAnswerIndex != null && !isLastQuestion)
                  GestureDetector(
                    onTap: () {
                      final nextQuestionId = questionProvider
                          .questions[currentIndex + 1].questionId;
                      _navigateToQuestion(nextQuestionId!);
                    },
                    child:  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: GlobalColorTheme.primaryColor,
                            ),
                          ],
                        )),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
