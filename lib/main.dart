import 'package:flutter/material.dart';
import 'package:primera_app/views/Widgets/navigation_menu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yblzauqjxgmejjukplix.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlibHphdXFqeGdtZWpqdWtwbGl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0MTY5MjUsImV4cCI6MjA0Mzk5MjkyNX0.09RA0WlPdtmVm7f7O-so8omxQx4ppOLtZgtxCiAoLDw',
  );
  //Aqui se debe correr el proyecto
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: NavigationMenu());
  }
}
