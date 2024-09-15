import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FireStore {
  Future save(String collection,String id,Map<String, dynamic> data) async{
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .set(data);
  }

  Future<Stream<QuerySnapshot>> select(String collection) async {
    return FirebaseFirestore.instance.collection(collection).snapshots();
  }

  Future<DocumentSnapshot> selectSingeData(String collection,String id) async {
    return FirebaseFirestore.instance.collection(collection).doc(id).get();
  }

  Future<String> uploadFileFromFireStorage(String filePath,Uint8List fileData) async{
     TaskSnapshot uploadTask =  await FirebaseStorage.instance.ref(filePath).putData(fileData,SettableMetadata(contentType: "image/jpeg"));
     String imageUrl = await uploadTask.ref.getDownloadURL();
     return imageUrl;
  }

  Future deleteFileFromFireStorage(String filePath) async {
    return await FirebaseStorage.instance.ref(filePath).delete();
  }

  Future update(String collection,String id,Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance.collection(collection).doc(id).update(data);
  }

  Future deleteEmployeeDetails(String id) async   {
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }
}