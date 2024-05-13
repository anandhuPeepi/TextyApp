import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class ChatRecord extends FirestoreRecord {
  ChatRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "userAuth" field.
  DocumentReference? _userAuth;
  DocumentReference? get userAuth => _userAuth;
  bool hasUserAuth() => _userAuth != null;

  // "userOpposite" field.
  DocumentReference? _userOpposite;
  DocumentReference? get userOpposite => _userOpposite;
  bool hasUserOpposite() => _userOpposite != null;

  // "lastMsg" field.
  String? _lastMsg;
  String get lastMsg => _lastMsg ?? '';
  bool hasLastMsg() => _lastMsg != null;

  // "messageTime" field.
  DateTime? _messageTime;
  DateTime? get messageTime => _messageTime;
  bool hasMessageTime() => _messageTime != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  void _initializeFields() {
    _userAuth = snapshotData['userAuth'] as DocumentReference?;
    _userOpposite = snapshotData['userOpposite'] as DocumentReference?;
    _lastMsg = snapshotData['lastMsg'] as String?;
    _messageTime = snapshotData['messageTime'] as DateTime?;
    _user = snapshotData['user'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat');

  static Stream<ChatRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatRecord.fromSnapshot(s));

  static Future<ChatRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatRecord.fromSnapshot(s));

  static ChatRecord fromSnapshot(DocumentSnapshot snapshot) => ChatRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatRecordData({
  DocumentReference? userAuth,
  DocumentReference? userOpposite,
  String? lastMsg,
  DateTime? messageTime,
  DocumentReference? user,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userAuth': userAuth,
      'userOpposite': userOpposite,
      'lastMsg': lastMsg,
      'messageTime': messageTime,
      'user': user,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatRecordDocumentEquality implements Equality<ChatRecord> {
  const ChatRecordDocumentEquality();

  @override
  bool equals(ChatRecord? e1, ChatRecord? e2) {
    return e1?.userAuth == e2?.userAuth &&
        e1?.userOpposite == e2?.userOpposite &&
        e1?.lastMsg == e2?.lastMsg &&
        e1?.messageTime == e2?.messageTime &&
        e1?.user == e2?.user;
  }

  @override
  int hash(ChatRecord? e) => const ListEquality().hash(
      [e?.userAuth, e?.userOpposite, e?.lastMsg, e?.messageTime, e?.user]);

  @override
  bool isValidKey(Object? o) => o is ChatRecord;
}
