import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    required this.actions,
  });

  final Widget? title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth * 0.04, // Izquierda
        screenHeight * 0.065, // Arriba
        screenWidth * 0.04, // Derecha
        0, // Abajo
      ),
      child: AppBar(
        backgroundColor: const Color.fromARGB(1, 1, 1, 1),
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
