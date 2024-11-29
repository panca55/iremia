import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:iremia/controllers/user_controller.dart';
import 'package:iremia/firebase_options.dart';
import 'package:iremia/models/diagnose_model.dart';
import 'package:iremia/models/question_model.dart';
import 'package:iremia/models/user_model.dart';
import 'package:iremia/provider/articles_provider.dart';
import 'package:iremia/provider/latest_diagnoses_provider.dart';
import 'package:iremia/provider/question_provider.dart';
import 'package:iremia/views/admin/add_article.dart';
import 'package:iremia/views/admin/admin_home_page.dart';
import 'package:iremia/views/admin/diagnose_result_admin.dart';
import 'package:iremia/views/admin/diagnose_result_all.dart';
import 'package:iremia/views/admin/widgets/navbar_admin.dart';
import 'package:iremia/views/article_page.dart';
import 'package:iremia/views/diagnose_history.dart';
import 'package:iremia/views/diagnose_result.dart';
import 'package:iremia/views/edit_profile_page.dart';
import 'package:iremia/views/login_page.dart';
import 'package:iremia/views/questionaire_page.dart';
import 'package:iremia/views/register_page.dart';
import 'package:iremia/views/admin/users_diagnose_history.dart';
import 'package:iremia/views/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await initializeDateFormatting('id_ID', null);
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await Supabase.initialize(
    url: 'https://owwgdyjhgorcqxnhvjlo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im93d2dkeWpoZ29yY3F4bmh2amxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI3MzAxNDcsImV4cCI6MjA0ODMwNjE0N30.bkuKKFS6j0gjiV9wW5hZyYk2vlGKNhjjCtngGtZ4lJU',
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => UserModel()),
                ChangeNotifierProvider(create: (_) => ArticlesProvider()),
                ChangeNotifierProvider(create: (_) => QuestionProvider()),
                ChangeNotifierProvider(create: (_) => QuestionModel()),
                ChangeNotifierProvider(create: (_) => DiagnosisModel()),
                ChangeNotifierProvider(create: (_) => UserController()),
                ChangeNotifierProvider(create: (_) => LatestDiagnosesProvider()),
              ],
              child: const MyApp(),
            ),
          ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        ArticlePage.routeName: (context) => const ArticlePage(),
        LoginPage.routname: (context) => const LoginPage(),
        RegisterPage.routname: (context) => const RegisterPage(),
        EditProfilePage.routname: (context) => const EditProfilePage(),
        QuestionnairePage.routeName: (context) => const QuestionnairePage(),
        DiagnoseResult.routeName: (context) =>  const DiagnoseResult(),
        DiagnoseHistory.routename: (context) =>  const DiagnoseHistory(),
        Navbar.routname: (context) =>  Navbar(),
        AdminHomePage.routename: (context) =>  const AdminHomePage(),
        UsersDiagnoseHistory.routename: (context) =>  const UsersDiagnoseHistory(),
        NavbarAdmin.routname: (context) =>  NavbarAdmin(),
        DiagnoseResultAll.routeName: (context) =>  const DiagnoseResultAll(),
        DiagnoseResultAdmin.routeName: (context) =>  const DiagnoseResultAdmin(),
        AddArticle.routname: (context) =>  const AddArticle(),
      },
    );
  }
}
