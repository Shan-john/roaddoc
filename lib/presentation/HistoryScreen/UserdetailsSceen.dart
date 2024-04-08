
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/models/user_model/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel userModel;
  const UserDetailScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Routes.instance.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: Center(
          child: Container(
           height: 400 ,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
                
              ),
              boxShadow:listoBoxshadow, 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextConfortaa("Details", 30),
                Gap(20),
                RowMaptile(
                  icon: Icons.person_3_outlined,
                  value: userModel.name!,
                  size: 25,
                ),
                Gap(10),
                RowMaptile(
                  icon: Icons.mail_outlined,
                  value: userModel.mailid!,
                  size: 25,
                ),
                   Gap(10),RowMaptile(
                  icon:  Icons.vpn_key_outlined,
                  value: userModel.id.toString(),
                  size: 25 ,
                ),
                  Gap(10), RowMaptile(
                  icon: Icons.call_outlined,
                  value: userModel.phoneNumber.toString(),
                  size: 25,
                ),
                   Gap(10),
              userModel.inspectionCategory != null?   RowMaptile(
                  icon:  Icons.category_outlined,
                  value: userModel.inspectionCategory.toString(),
                  size: 25 ,
                ): SizedBox(),
                   Gap(10),
            userModel.inspectionmessage != null?      RowMaptile(
                  icon:  Icons.message_outlined,
                  value: userModel.inspectionmessage.toString(),
                  size: 25 ,
                ):SizedBox(),
                  
              ],
            ),
          ),
        ));
  }
}

class RowMaptile extends StatelessWidget {
  final IconData icon;
  final String value;
  final double size;
  const RowMaptile(
      {required this.icon, required this.value, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        Row(
          children: [
            Icon(icon),
            Gap(5),
            TextConfortaa(value, 18),
          ],
        ),
        Gap(15)
      ],
    );
  }
}
