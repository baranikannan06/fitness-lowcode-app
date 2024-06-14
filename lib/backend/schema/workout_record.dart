import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkoutRecord extends FirestoreRecord {
  WorkoutRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "exercises" field.
  List<ExerciseStruct>? _exercises;
  List<ExerciseStruct> get exercises => _exercises ?? const [];
  bool hasExercises() => _exercises != null;

  // "duration" field.
  int? _duration;
  int get duration => _duration ?? 0;
  bool hasDuration() => _duration != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _exercises = getStructList(
      snapshotData['exercises'],
      ExerciseStruct.fromMap,
    );
    _duration = castToType<int>(snapshotData['duration']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('workout')
          : FirebaseFirestore.instance.collectionGroup('workout');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('workout').doc(id);

  static Stream<WorkoutRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorkoutRecord.fromSnapshot(s));

  static Future<WorkoutRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WorkoutRecord.fromSnapshot(s));

  static WorkoutRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WorkoutRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorkoutRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorkoutRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorkoutRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorkoutRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWorkoutRecordData({
  String? name,
  DateTime? timestamp,
  int? duration,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'timestamp': timestamp,
      'duration': duration,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorkoutRecordDocumentEquality implements Equality<WorkoutRecord> {
  const WorkoutRecordDocumentEquality();

  @override
  bool equals(WorkoutRecord? e1, WorkoutRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.timestamp == e2?.timestamp &&
        listEquality.equals(e1?.exercises, e2?.exercises) &&
        e1?.duration == e2?.duration;
  }

  @override
  int hash(WorkoutRecord? e) => const ListEquality()
      .hash([e?.name, e?.timestamp, e?.exercises, e?.duration]);

  @override
  bool isValidKey(Object? o) => o is WorkoutRecord;
}
