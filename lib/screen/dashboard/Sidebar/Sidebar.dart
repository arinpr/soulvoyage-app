
import 'package:flutter/material.dart';
import 'package:soulvoyage/screen/dashboard/Sidebar/components/Body.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Body()));
  }
}