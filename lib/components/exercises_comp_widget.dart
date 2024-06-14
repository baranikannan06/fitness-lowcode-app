import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'exercises_comp_model.dart';
export 'exercises_comp_model.dart';

class ExercisesCompWidget extends StatefulWidget {
  const ExercisesCompWidget({super.key});

  @override
  State<ExercisesCompWidget> createState() => _ExercisesCompWidgetState();
}

class _ExercisesCompWidgetState extends State<ExercisesCompWidget> {
  late ExercisesCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExercisesCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF3C5B6F),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Add (${_model.total?.toString()})',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
          StreamBuilder<List<ExercisesRecord>>(
            stream: queryExercisesRecord(),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitCircle(
                      color: FlutterFlowTheme.of(context).primary,
                      size: 50.0,
                    ),
                  ),
                );
              }
              List<ExercisesRecord> listViewExercisesRecordList =
                  snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listViewExercisesRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewExercisesRecord =
                      listViewExercisesRecordList[listViewIndex];
                  return Theme(
                    data: ThemeData(
                      checkboxTheme: const CheckboxThemeData(
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      unselectedWidgetColor:
                          FlutterFlowTheme.of(context).secondaryText,
                    ),
                    child: CheckboxListTile(
                      value: _model.checkboxListTileValueMap[
                              listViewExercisesRecord] ??=
                          FFAppState()
                              .workout
                              .exercises
                              .map((e) => e.exerciseRef?.id)
                              .withoutNulls
                              .toList()
                              .contains(listViewExercisesRecord.reference.id),
                      onChanged: (newValue) async {
                        setState(() => _model.checkboxListTileValueMap[
                            listViewExercisesRecord] = newValue!);
                        if (newValue!) {
                          _model.total = _model.total! + 1;
                          setState(() {});
                          FFAppState().updateWorkoutStruct(
                            (e) => e
                              ..updateExercises(
                                (e) => e.add(ExerciseStruct(
                                  exerciseRef:
                                      listViewExercisesRecord.reference,
                                  sets: functions.createSets(),
                                )),
                              ),
                          );
                          setState(() {});
                        } else {
                          _model.total = _model.total! + -1;
                          setState(() {});
                        }
                      },
                      title: Text(
                        listViewExercisesRecord.name,
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                      subtitle: Text(
                        listViewExercisesRecord.bodyPart,
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      activeColor: const Color(0xFF153448),
                      checkColor: FlutterFlowTheme.of(context).info,
                      dense: false,
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
