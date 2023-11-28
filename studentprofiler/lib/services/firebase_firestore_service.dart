import 'package:studentprofiler/models/teacher_model.dart';

class FirebaseFirestoreService {
  // final CollectionReference _studentsCollection =
  //     FirebaseFirestore.instance.collection('students');
  String errorMessage = 'No Error Message';
  bool isLoading = false;

  String defaultUserAvatar =
      'https://firebasestorage.googleapis.com/v0/b/ggez-network.appspot.com/o/users%2Fsample_user_avatar.png?alt=media&token=8b938493-dec6-4fe7-bdd3-6bbb08f3a9c3';

  // --------------------------- Firebase Add User To Firestore ---------------------------
  Future firebaseAddTeacherToFirestore(TeacherModel teacherModel) async {}

  // // --------------------------- Firebase Update User Profile To Firestore ---------------------------
  // Future firebaseUpdateUserProfileToFirestore(
  //     String updatedName,
  //     String updatedAddress,
  //     String updatedContactNumber,
  //     String about,
  //     BuildContext context) async {
  //   try {
  //     await _usersCollection
  //         .doc(_firebaseAuth.currentUser?.uid.toString())
  //         .update({
  //       "accountType": "New User",
  //       "name": updatedName,
  //       "contactNumber": updatedContactNumber,
  //       "address": updatedAddress,
  //       "about": about,
  //       'lastAppeared': DateTimeChecker().dateTimeNow,
  //       //'coins': 1.2,
  //       //'verified': false,
  //       //'profileImage': defaultUserAvatar,
  //     }).then((value) {
  //       debugPrint(
  //           "------------ !!! User Profile Update - SUCCESS ------------");
  //       PageNavigation(context).goToLastPage();
  //       PageNavigation(context).goToLastPage();
  //       //displayFirestoreSuccess(context);
  //     });
  //   } on FirebaseException catch (firestoreError) {
  //     debugPrint("------------ ??? User Profile Update - FAILED ------------");
  //     debugPrint("Fail Reason: $firestoreError");
  //     findFirestoreError(firestoreError, context);
  //   }
  // }
  //
  // // --------------------------- Firebase Update User Followings ---------------------------
  // Future firebaseUpdateUserFollowingsToFirestore(
  //     String followType,
  //     String followID,
  //     String followName,
  //     String followCategory,
  //     bool isFollowing,
  //     BuildContext context) async {
  //   try {
  //     if (isFollowing) {
  //       await _usersCollection
  //           .doc(_firebaseAuth.currentUser?.uid.toString())
  //           .collection(followType)
  //           .doc(followID)
  //           .set({
  //         "uuid": _firebaseAuth.currentUser?.uid.toString(),
  //         "followType": followType,
  //         "followID": followID,
  //         "followName": followName,
  //         "followCategory": followCategory,
  //         'startToFollowDate': DateTimeChecker().dateTimeNow,
  //       }).then((value) {
  //         debugPrint(
  //             "------------ !!! User Follow $followID - SUCCESS ------------");
  //         //displayFirestoreSuccess(context);
  //         CWMessagePopups(message: "Started to Follow").cwSnackbar(context);
  //         firebaseManageUserCoinsToFirestore(4.8, context);
  //       });
  //     } else {
  //       await _usersCollection
  //           .doc(_firebaseAuth.currentUser?.uid.toString())
  //           .collection(followType)
  //           .doc(followID)
  //           .delete()
  //           .then((value) {
  //         debugPrint(
  //             "------------ !!! User Unfollow $followID - SUCCESS ------------");
  //         //displayFirestoreSuccess(context);
  //         CWMessagePopups(message: "Started to Unfollow").cwSnackbar(context);
  //         firebaseManageUserCoinsToFirestore(1.2, context);
  //       });
  //     }
  //   } on FirebaseException catch (firestoreError) {
  //     debugPrint(
  //         "------------ !!! User Follow $followID - FAILED ------------");
  //     debugPrint("Fail Reason: $firestoreError");
  //     findFirestoreError(firestoreError, context);
  //   }
  // }
  //
  // // --------------------------- Firebase Add Order Details To Firestore ---------------------------
  // Future firebaseAddOrderDetailsToFirestore(
  //     String sizeName,
  //     int itemCount,
  //     StoreModel storeModel,
  //     List shippingDetails,
  //     String orderID,
  //     String paymentID,
  //     BuildContext context) async {
  //   try {
  //     // ADD TO USER'S COLLECTION
  //     await _usersCollection
  //         .doc(_firebaseAuth.currentUser?.uid.toString())
  //         .collection('orders')
  //         .doc(orderID)
  //         .set({
  //       "contactAddress": shippingDetails[4],
  //       "contactCity": shippingDetails[5],
  //       "contactEmail": shippingDetails[2],
  //       "contactFirstName": shippingDetails[0],
  //       "contactLastName": shippingDetails[1],
  //       "contactNumber": shippingDetails[3],
  //       'deliveryAddress': shippingDetails[6],
  //       'deliveryCity': shippingDetails[7],
  //       'itemID': storeModel.id,
  //       'itemName': storeModel.name,
  //       'itemQuantity': itemCount,
  //       'itemSize': sizeName,
  //       'itemType': storeModel.type,
  //       'itemUnitPrice': storeModel.priceLKR,
  //       'orderDate': DateTimeChecker().dateTimeNow,
  //       'orderID': orderID,
  //       'paymentID': paymentID,
  //       'totalAmount': storeModel.priceLKR * itemCount,
  //       'userID': _firebaseAuth.currentUser?.uid.toString(),
  //     }).then((value) {
  //       debugPrint(
  //           "------------ !!! Add order details to user's collection - SUCCESS ------------");
  //       // ADD TO ORDERS COLLECTION
  //       try {
  //         // ADD TO USER'S COLLECTION
  //         _ordersCollection.doc(orderID).set({
  //           "contactAddress": shippingDetails[4],
  //           "contactCity": shippingDetails[5],
  //           "contactEmail": shippingDetails[2],
  //           "contactFirstName": shippingDetails[0],
  //           "contactLastName": shippingDetails[1],
  //           "contactNumber": shippingDetails[3],
  //           'deliveryAddress': shippingDetails[6],
  //           'deliveryCity': shippingDetails[7],
  //           'itemID': storeModel.id,
  //           'itemName': storeModel.name,
  //           'itemQuantity': itemCount,
  //           'itemSize': sizeName,
  //           'itemType': storeModel.type,
  //           'itemUnitPrice': storeModel.priceLKR,
  //           'orderDate': DateTimeChecker().dateTimeNow,
  //           'orderID': orderID,
  //           'paymentID': paymentID,
  //           'totalAmount': storeModel.priceLKR * itemCount,
  //           'userID': _firebaseAuth.currentUser?.uid.toString(),
  //         }).then((value) {
  //           debugPrint(
  //               "------------ !!! Add order details to order's collection - SUCCESS ------------");
  //           //ALL ARE SUCCESS
  //           debugPrint(
  //               "------------ !!! Add order 100% - SUCCESS ------------");
  //           CWMessagePopups(message: "Order Success").cwAlertDialogLoading(
  //               context,
  //               false,
  //               "Your order $orderID is complete. Check your email for the payment receipt.",
  //               () {
  //             SendOrderSuccessNotification()
  //                 .playNotification(GenerateOrderId().ggezOrderId());
  //             PageNavigation(context).goToBottomNavigationTabPage();
  //           }, 'assets/icons/icons8_ok_50px.png');
  //           firebaseManageUserCoinsToFirestore(36.8, context);
  //         });
  //       } on FirebaseException catch (firestoreError) {
  //         debugPrint(
  //             "------------ !!! Add order details to order's collection - FAILED ------------");
  //         debugPrint("Fail Reason: $firestoreError");
  //         findFirestoreError(firestoreError, context);
  //       }
  //     });
  //   } on FirebaseException catch (firestoreError) {
  //     debugPrint(
  //         "------------ !!! Add order details to user's collection - FAILED ------------");
  //     debugPrint("Fail Reason: $firestoreError");
  //     findFirestoreError(firestoreError, context);
  //   }
  // }
  //
  // // --------------------------- Firebase Register for Event To Firestore ---------------------------
  // Future firebaseAddEventRegistrationToFirestore(
  //     EventsModel eventsModel, BuildContext context) async {
  //   try {
  //     // ADD TO USER'S COLLECTION
  //     await _usersCollection
  //         .doc(_firebaseAuth.currentUser?.uid.toString())
  //         .collection('events')
  //         .doc(eventsModel.id)
  //         .set({
  //       "eventID": eventsModel.id,
  //       "eventName": eventsModel.name,
  //       'registeredDate': DateTimeChecker().dateTimeNow,
  //       'registerID': GenerateGgezEventRegisterID().ggezEventId(),
  //       'userID': _firebaseAuth.currentUser?.uid.toString(),
  //     }).then((value) {
  //       debugPrint(
  //           "------------ !!! Add register details to user's collection - SUCCESS ------------");
  //       // ADD TO ORDERS COLLECTION
  //       try {
  //         // ADD TO USER'S COLLECTION
  //         _eventsCollection
  //             .doc(eventsModel.id)
  //             .collection('registers')
  //             .doc(_firebaseAuth.currentUser?.uid.toString())
  //             .set({
  //           "eventID": eventsModel.id,
  //           "eventName": eventsModel.name,
  //           'registeredDate': DateTimeChecker().dateTimeNow,
  //           'registerID': GenerateGgezEventRegisterID().ggezEventId(),
  //           'userID': _firebaseAuth.currentUser?.uid.toString(),
  //         }).then((value) {
  //           debugPrint(
  //               "------------ !!! Add register details to event's collection - SUCCESS ------------");
  //           //ALL ARE SUCCESS
  //           debugPrint(
  //               "------------ !!! Add register 100% - SUCCESS ------------");
  //           CWMessagePopups(message: "register Success").cwAlertDialogLoading(
  //               context,
  //               false,
  //               "Your event registration is under review. We will response within few days",
  //               () {
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //           }, 'assets/icons/icons8_ok_50px.png');
  //         });
  //       } on FirebaseException catch (firestoreError) {
  //         debugPrint(
  //             "------------ !!! Add register details to event's collection - FAILED ------------");
  //         debugPrint("Fail Reason: $firestoreError");
  //         findFirestoreError(firestoreError, context);
  //       }
  //     });
  //   } on FirebaseException catch (firestoreError) {
  //     debugPrint(
  //         "------------ !!! Add register details to user's collection - FAILED ------------");
  //     debugPrint("Fail Reason: $firestoreError");
  //     findFirestoreError(firestoreError, context);
  //   }
  // }
  //
  // // --------------------------- Firebase Manage User Coins To Firestore ---------------------------
  // Future firebaseManageUserCoinsToFirestore(
  //     double coins, BuildContext context) async {
  //   try {
  //     // ADD TO USER'S COLLECTION
  //     await _usersCollection
  //         .doc(_firebaseAuth.currentUser?.uid.toString())
  //         .update({
  //       "coins": coins,
  //     }).then((value) {
  //       debugPrint(
  //           "------------ !!! Update user coin value - SUCCESS ------------");
  //       CWMessagePopups(message: "Coins Updated").cwAlertDialogLoading(context,
  //           false, "Your GGEZ loyal coins has been updated successfully", () {
  //         Navigator.pop(context);
  //       }, 'assets/icons/icons8_ok_50px.png');
  //     });
  //   } on FirebaseException catch (firestoreError) {
  //     debugPrint(
  //         "------------ !!! Update user coin value - FAILED ------------");
  //     debugPrint("Fail Reason: $firestoreError");
  //     findFirestoreError(firestoreError, context);
  //   }
  // }
}
