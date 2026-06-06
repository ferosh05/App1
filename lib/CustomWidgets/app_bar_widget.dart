import 'package:flutter/material.dart';



class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: double.infinity,
      child: Center(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,size: 18,)),
            SizedBox(width: mediaquery.width * 0.10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}