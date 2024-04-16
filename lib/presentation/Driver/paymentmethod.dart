
import 'package:flutter/material.dart';
import 'package:flutter_upi_pay/Src/payment.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/home.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/provider/provider.dart';
import 'package:intl/intl.dart';
class PaymentMethodScreen extends StatelessWidget {
  final String inceptioncategory;
  final String inspectionMessage;
  final String amount;
  PaymentMethodScreen(
      {super.key,
      required this.inceptioncategory,
      required this.inspectionMessage,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: false, context);
    UserModel mechUser = appProvider.currentAvailableMechUser;
    FlutterPayment flutterPayment = FlutterPayment();
//  UPIAppList(onClick: (upiApp) async {
//         FlutterPayUpiManager.startPayment(
//         paymentApp: upiApp.app!,
//         payeeVpa: payeeVpa!,
//         payeeName: payeeName!,
//         transactionId: transactionId!,
//         payeeMerchantCode: payeeMerchantCode!,
//         description: description!,
//         amount: amount!,
//         response: (UpiResponse response) {
//           // TODO: add your success logic here
//         },
//         error: (e) {
//           // TODO: add your exception logic here
//         print(e.toString());
//         });
// }),

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                TextConfortaa(text: "Payment", size: 40),
                Gap(10),
                Center(
                  child: Primarybutton(
                    size: 390,
                    colors: Color.fromARGB(255, 0, 255, 179),
                    label: "Direct Payment",
                    onpressed: () {
                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('dd/MM/yyyy').format(now);
                    
                      UserModel UpdatedMechUser = mechUser.copyWith(
                          inspectionCategory: inceptioncategory,
                          inspectionmessage: inspectionMessage,
                          paymentmethod: "Direct Payment",
                          date: formattedDate,
                          amount: amount);
                      UserModel UpdatedDriverUser =
                          appProvider.getuserInfromation.copyWith(
                              inspectionCategory: inceptioncategory,
                              inspectionmessage: inspectionMessage,
                              paymentmethod: "Direct Payment",
                              date:  formattedDate,
                              amount: amount);

                      FirebasefirestoreHelper.instance.uploadhistory(
                          updatedDriverUser: UpdatedDriverUser,
                          updatedMechUser: UpdatedMechUser);
                      appProvider.removecurrentavailableMech(
                          driverUser: UpdatedDriverUser);
                      appProvider.removeCurrenAcceptedDriverDetails(
                          mechUser: mechUser);
                      Routes.instance.pushandRemoveUntil(
                          widget: Mainscreen(
                             ),
                          context: context);
                    },
                    fontsize: 18,
                    Textcolor: Colors.black,
                    bordercolor: Colors.black,
                    borderwidth: 2,
                    height: 100,
                  ),
                ),
                Gap(10),
                Gap(20),
                Center(
                    child: Primarybutton(
                  size: 390,
                  colors: Colors.white,
                  label: "UPI Payment",
                  onpressed: () async {
                    launchUPIApp(
                        upi_id: "9497711275@jupiteraxis",
                        name: "shanjohn",
                        code: "dddddd",
                        transactionid: "transactionid",
                        transaction_reference: "transaction_reference",
                        transaction_amount: "1");
                    //        flutterPayment.launchUpi(
                    // upiId: 
                    // name: "shan",
                    // amount: "1",
                    // message: "test",
                    // currency: "INR");
                    // Routes.instance.push(
                    //     widget: pay(
                    //       title: "ssss",
                    //     ),
                    //     context: context);
                    //  initiateTransaction();

                    // UserModel UpdatedMechUser = mechUser.copyWith(
                    //   inspectionCategory: inceptioncategory,
                    //   inspectionmessage: inspectionMessage,
                    // );
                    // UserModel UpdatedDriverUser =
                    //     appProvider.getuserInfromation.copyWith(
                    //   inspectionCategory: inceptioncategory,
                    //   inspectionmessage: inspectionMessage,
                    // );

                    // FirebasefirestoreHelper.instance.uploadhistory(
                    //     updatedDriverUser: UpdatedDriverUser,
                    //     updatedMechUser: UpdatedMechUser);
                    // appProvider.removecurrentavailableMech(
                    //     driverUser: UpdatedDriverUser);
                    // appProvider.removeCurrenAcceptedDriverDetails(
                    //     mechUser: mechUser);
                    // Routes.instance.pushandRemoveUntil(
                    //     widget: Mainscreen(
                    //         userModel: appProvider.getuserInfromation),
                    //     context: context);
                  },
                  fontsize: 18,
                  Textcolor: Colors.black,
                  bordercolor: Colors.black,
                  borderwidth: 2,
                  height: 100,
                )),
                Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class pay extends StatefulWidget {
//   const pay({super.key, required this.title});
//   final String title;
//   @override
//   State<pay> createState() => _payState();
// }

// class _payState extends State<pay> {
//   List<UpiApp> upiAppsData = [];
//   List<UpiIosModel> iosUpiList =[];
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       fetchUpiAppsData();
//     });
//     super.initState();
//   }

//   Future<void> fetchUpiAppsData() async {
//     // final fetchUpiApps = UpiChooser();
//     // upiAppsData = await fetchUpiApps.getUpiAppList();
//     upiAppsData = await FlutterPayUpiManager.getListOfAndroidUpiApps();
//     iosUpiList = await FlutterPayUpiManager.getListOfIosUpiApps();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: upiAppsData == null
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               shrinkWrap: true,
//               itemCount: upiAppsData!.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//                 childAspectRatio: 1.2,
//                 crossAxisCount: 4,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 return InkWell(
//                   onTap: () {
//                     print(upiAppsData[index].app);
//                     //  UPIAppList(onClick: (upiApp) async {
//                     FlutterPayUpiManager.startPayment(
//                         paymentApp: upiAppsData[index].app!,
//                         payeeVpa: upiAppsData[index].name!,
//                         payeeName: "shan john!",
//                         transactionId: "transactionId",
//                         payeeMerchantCode: "payeeMerchantCode!",
//                         description: "description",
//                         amount: "1",
//                         response: (UpiResponse response, String message) {
//                           print("hhaha ${response.status}");
//                         },
//                         error: (  e) {
//                           // TODO: add your exc
//                           print("hhaha  ");

//                           print(e.toString());
//                         });
//                     // });
//                   },
//                   child: SizedBox(
//                     height: 80,
//                     width: 80,
//                     child: Card(
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Image.memory(
//                               upiAppsData[index].icon!,
//                               height: 42,
//                             ),
//                             Text('${upiAppsData[index].name}'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class PaymentMethodScreens extends StatefulWidget {
//    final String inceptioncategory;
//   final String inspectionMessage;
//   final String amount;
// PaymentMethodScreens({   required this.inceptioncategory, required this.inspectionMessage, required this.amount});
//   @override
//   _PaymentMethodScreensState createState() => _PaymentMethodScreensState();
// }

// class _PaymentMethodScreensState extends State<PaymentMethodScreens> {
//   Future<UpiResponse>? _transaction;
//   UpiIndia _upiIndia = UpiIndia();
//   List<UpiApp>? apps;
//   AppProvider? appProvider;
//   UserModel? mechUser;

//   TextStyle header = TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );

//   TextStyle value = TextStyle(
//     fontWeight: FontWeight.w400,
//     fontSize: 14,
//   );

//   @override
//   void initState() {
//     appProvider = Provider.of(listen: false, context);
//     mechUser = appProvider?.currentAvailableMechUser;
//     _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
//       setState(() {
//         apps = value;
//       });
//     }).catchError((e) {
//       apps = [];
//     });
//     super.initState();
//   }

//   Future<UpiResponse> initiateTransaction(UpiApp app) async {
//     return _upiIndia.startTransaction(
//       app: app,
//       receiverUpiId: "9497711275@jupiteraxis",
//       receiverName: appProvider!.currentAvailableMechUser.name?? "shan",
//       transactionRefId: 'TestingUpiIndiaPlugin',
//       transactionNote: 'Service.',
//       amount: 1 ,
//     );
//   }

//   Widget displayUpiApps() {
//     if (apps == null)
//       return Center(child: CircularProgressIndicator());
//     else if (apps!.length == 0)
//       return Center(
//         child: Text(
//           "No apps found to handle transaction.",
//           style: header,
//         ),
//       );
//     else
//       return Align(
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Wrap(
//             children: apps!.map<Widget>((UpiApp app) {
//               return GestureDetector(
//                 onTap: () {
//                   _transaction = initiateTransaction(app);
//                   setState(() {});
//                 },
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Image.memory(
//                         app.icon,
//                         height: 60,
//                         width: 60,
//                       ),
//                       Text(app.name),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//   }

//   String _upiErrorHandler(error) {
//     switch (error) {
//       case UpiIndiaAppNotInstalledException:
//         return 'Requested app not installed on device';
//       case UpiIndiaUserCancelledException:
//         return 'You cancelled the transaction';
//       case UpiIndiaNullResponseException:
//         return 'Requested app didn\'t return any response';
//       case UpiIndiaInvalidParametersException:
//         return 'Requested app cannot handle the transaction';
//       default:
//         return 'An Unknown error has occurred';
//     }
//   }

//   void _checkTxnStatus(
//     String status,
//   ) {
//     switch (status) {
//       case UpiPaymentStatus.SUCCESS:
//         UserModel UpdatedMechUser = mechUser!.copyWith(
//           inspectionCategory: widget.inceptioncategory,
//           inspectionmessage: widget.inspectionMessage,
//         );
//         UserModel UpdatedDriverUser = appProvider!.getuserInfromation.copyWith(
//           inspectionCategory: widget.inceptioncategory,
//           inspectionmessage: widget.inspectionMessage,
//         );

//         FirebasefirestoreHelper.instance.uploadhistory(
//             updatedDriverUser: UpdatedDriverUser,
//             updatedMechUser: UpdatedMechUser);
//         appProvider?.removecurrentavailableMech(driverUser: UpdatedDriverUser);
//         appProvider?.removeCurrenAcceptedDriverDetails(mechUser: mechUser!);
//         Routes.instance.pushandRemoveUntil(
//             widget: Mainscreen(userModel: appProvider!.getuserInfromation),
//             context: context);
//         showMessage('Transaction Successful');
//         break;
//       case UpiPaymentStatus.SUBMITTED:
//         showMessage('Transaction Submitted');
//         break;
//       case UpiPaymentStatus.FAILURE:
//         showMessage('Transaction Failed');
//         break;
//       default:
//         showMessage('Received an Unknown transaction status');
//     }
//   }

//   Widget displayTransactionData(title, body) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("$title: ", style: header),
//           Flexible(
//               child: Text(
//             body,
//             style: value,
//           )),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('UPI'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: displayUpiApps(),
//           ),
//           Expanded(
//             child: FutureBuilder(
//               future: _transaction,
//               builder:
//                   (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: Text(
//                         _upiErrorHandler(snapshot.error.runtimeType),
//                         style: header,
//                       ), // Print's text message on screen
//                     );
//                   }

//                   // If we have data then definitely we will have UpiResponse.
//                   // It cannot be null
//                   UpiResponse _upiResponse = snapshot.data!;

//                   // Data in UpiResponse can be null. Check before printing
//                   String txnId = _upiResponse.transactionId ?? 'N/A';
//                   String resCode = _upiResponse.responseCode ?? 'N/A';
//                   String txnRef = _upiResponse.transactionRefId ?? 'N/A';
//                   String status = _upiResponse.status ?? 'N/A';
//                   String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
//                   _checkTxnStatus(
//                     status,
//                   );

//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         displayTransactionData('Transaction Id', txnId),
//                         displayTransactionData('Response Code', resCode),
//                         displayTransactionData('Reference Id', txnRef),
//                         displayTransactionData('Status', status.toUpperCase()),
//                         displayTransactionData('Approval No', approvalRef),
//                       ],
//                     ),
//                   );
//                 } else
//                   return Center(
//                     child: Text(''),
//                   );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class PaymentMethodScreens extends StatelessWidget {
//   const PaymentMethodScreens({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter pay',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
//         useMaterial3: true,
//       ),
//       home: const pay(title: 'Flutter UPI Pay'),
//     );
//   }
// }

// class pay extends StatefulWidget {
//   const pay({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<pay> createState() => _payState();
// }

// class _payState extends State<pay> {
//   FlutterPayment flutterPayment = FlutterPayment();

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the pay object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Initiate UPI payment from Flutter',
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           flutterPayment.launchUpi(
//               upiId: "test@oksbi",
//               name: "tester",
//               amount: "100",
//               message: "test",
//               currency: "INR");
//         },
//         tooltip: '',
//         child: const Icon(Icons.monetization_on_outlined),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
