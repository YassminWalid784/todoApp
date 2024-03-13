import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../models/task_model.dart';
import '../services/snack_bar_service.dart';
import '../utils/extract_date_time.dart';

class FirebaseUtils {
  //in dart object
  // to database map

  // object -> convert -> Map (to firestore)
  // Map -> convert -> object -> (from firestore)

  CollectionReference<TaskModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  Future<void> addNewTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc();

    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  Future<List<TaskModel>> getDataFromFireStore(DateTime dateTime) async {
    var collectionRef = getCollectionReference().where(
      "dateTime",
      isEqualTo: extractDateTime(dateTime).millisecondsSinceEpoch,
    );
    var data = await collectionRef.get();

    var tasksList = data.docs.map((e) => e.data()).toList();

    return tasksList;
  }

  Stream<QuerySnapshot<TaskModel>> getStreamDataFromFireStore(
      DateTime dateTime) {
    var collectionRef = getCollectionReference().where(
      "dateTime",
      isEqualTo: extractDateTime(dateTime).millisecondsSinceEpoch,
    );
    var data = collectionRef.snapshots();
    return data;
  }

  Future<void> deleteTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
  }

  Future<void> updateTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.update({
      "isDone": true,
    });
  }


  Future<void>editTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.update({
      "title": taskModel.title,
      "description": taskModel.description,
      "dateTime": taskModel.dateTime.millisecondsSinceEpoch,
    });
  }
  Future<bool> createNewAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user);
      EasyLoading.dismiss();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBarService.showErrorMessage("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackBarService.showErrorMessage(
            'The account already exists for that email.');
      }
      EasyLoading.dismiss();
      return Future.value(false);
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  Future<bool> signIN(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      EasyLoading.dismiss();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SnackBarService.showErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');

        SnackBarService.showErrorMessage(
            'Wrong password provided for that user.');
      }
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }
}
