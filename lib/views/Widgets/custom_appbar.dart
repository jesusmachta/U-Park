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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
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
