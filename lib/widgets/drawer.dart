import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.0),
          title: Text("Indicator"),
          onTap: () => Navigator.of(context).pushReplacementNamed("/"),
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.0),
          title: Text("Header"),
          onTap: () => Navigator.of(context).pushReplacementNamed("/header"),
        )
      ],
    );
  }
}
