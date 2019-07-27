import 'package:flutter/material.dart';

class HeaderScreen extends StatefulWidget {
  @override
  HeaderScreenState createState() => HeaderScreenState();
}

class HeaderScreenState extends State<HeaderScreen> {
  ScrollController controller;

  double height = 0;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(setHeight);

    super.initState();
  }

  void setHeight() {
    setState(() {
      height = controller.offset > 200 ? 200 : controller.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: [
          HeaderTitle(position: height * .2),
          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildListDelegate(
              [
                Container(color: Colors.red),
                Container(color: Colors.purple),
                Container(color: Colors.green),
                Container(color: Colors.orange),
                Container(color: Colors.yellow),
                Container(color: Colors.pink),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    @required this.position,
  });

  final double position;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "13,93",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 38,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text(
                "pts",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        Text(
          "pts",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
