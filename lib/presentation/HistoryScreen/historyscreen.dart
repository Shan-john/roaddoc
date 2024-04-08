import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/presentation/HistoryScreen/UserdetailsSceen.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';

import '../../models/user_model/user_model.dart';

class HistoryScreen extends StatelessWidget {
  final List<UserModel> UserHistory;
  const HistoryScreen({super.key, required this.UserHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextConfortaa("History", 20),
          leading: IconButton(
              onPressed: () {
                Routes.instance.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              final data = UserHistory[index];
              return InkWell(
                onTap: () {
                  Routes.instance.push(
                      widget: UserDetailScreen(
                        userModel: data,
                      ),
                      context: context);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color.fromARGB(255, 252, 252, 252),
                    boxShadow: listoBoxshadow,
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 37,
                        child: TextConfortaa("${index + 1}", 20),
                      ),
                      title: TextConfortaa(data.name.toString(), 20),
                      subtitle: TextConfortaa("+91 ${data.phoneNumber}", 18),
                      trailing: TextConfortaa(data.inspectionmessage!, 20)),
                ),
              );
            },
            separatorBuilder: (context, Index) {
              return Gap(10);
            },
            itemCount: UserHistory.length));
  }
}

// SizedBox(
//         height: 300 ,
//         child: ListView(padding: EdgeInsets.zero, children: <Widget>[
//           ListView.builder(
//               itemBuilder: (context, index) {
//                 final data = UserHistory[index];
//                 return InkWell(
//                   onTap: () async {
//                     //Position position = await getlocation();
        
//                     // Routes.instance.push(
//                     //     widget: DriverRequesDetailsScreen(
//                     //       data: data,
//                     //     ),
//                     //     context: context);
//                   },
                  // child: 
//                 );
//               },
//               // separatorBuilder: (context, index) {
//               //   return Gap(10);
//               // },
//               itemCount: UserHistory.length),
//         ]),
//       ),