import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/Widgets/simpletext.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/presentation/Driver/StatusScreen.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
         minimum: EdgeInsets.all(10), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            titleText("Locate"),
            const SimpleText(lable: "Available Mechanics Around"),
            Container(
              height: 450,
              color: Colors.amber,
              child: Image.network(
                  fit: BoxFit.cover,
                  "https://www.google.com/maps/d/u/0/thumbnail?mid=1uD9FtjLONCK4Hazcf36xDQ7Xa8Y&hl=en"),
            ),
            Primarybutton(
                bordercolor: Colors.black,
                borderwidth: 2,
                size: 390,
                colors: Colors.white,
                label: "REQUEST MECHANIC",
                onpressed: () {
                  //loaderIndicator(context);
                 
                  Routes.instance
                      .push(widget: StatusScreen(), context: context);
                },
                fontsize: 18,
                Textcolor: Colors.black)
          ],
        ),
      ),
    );
  }

  loaderIndicator(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      content: SizedBox(
        width:
            10.0, // Set the width and height to the same value to make it square
        height: 50.0,
        child: Builder(
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 10, 207, 131),
              ),
            );
          },
        ),
      ),
    );
    showDialog(
      
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }
}
