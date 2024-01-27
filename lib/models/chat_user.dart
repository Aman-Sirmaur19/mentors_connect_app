import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ChatUser extends Equatable {
  final String id;
  final String photoUrl;
  final String displayName;

  // final String phoneNumber;
  // final String aboutMe;

  const ChatUser({
    required this.id,
    required this.photoUrl,
    required this.displayName,
    // required this.phoneNumber,
    // required this.aboutMe,
  });

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    // String? phoneNumber,
    // String? email,
  }) =>
      ChatUser(
        id: id ?? this.id,
        photoUrl: photoUrl ?? this.photoUrl,
        displayName: nickname ?? displayName,
        // phoneNumber: phoneNumber ?? this.phoneNumber,
        // aboutMe: email ?? aboutMe,
      );

  Map<String, dynamic> toJson() => {
    'username': displayName,
    'image_url': photoUrl,
    // FirestoreConstants.phoneNumber: phoneNumber,
    // FirestoreConstants.aboutMe: aboutMe,
  };

  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String image_url = "";
    String username = "";
    // String phoneNumber = "";
    // String aboutMe = "";

    try {
      image_url = snapshot.get('image_url');
      username = snapshot.get('username');
      // phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
      // aboutMe = snapshot.get(FirestoreConstants.aboutMe);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
      id: snapshot.id,
      photoUrl: image_url,
      displayName: username,
      // phoneNumber: phoneNumber,
      // aboutMe: aboutMe
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    photoUrl,
    displayName,
    // phoneNumber,
    // aboutMe,
  ];
}