// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primera_app/views/comments_screen.dart';
import 'package:primera_app/views/home_screen.dart';
import 'package:primera_app/views/stats_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [HomeScreen(), const StatsScreen(), const CommentsScreen()];
}
