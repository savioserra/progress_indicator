import 'package:flutter/material.dart';
import 'package:level_indicator/widgets/drawer.dart';

class HeaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF62258A),
                  Color(0xFFFC0F77),
                ],
              ),
            ),
            height: 200.0,
          ),
        ],
      ),
    );
  }
}
