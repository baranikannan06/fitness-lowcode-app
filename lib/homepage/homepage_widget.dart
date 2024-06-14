import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  late HomepageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WorkoutRecord>>(
      stream: queryWorkoutRecord(
        parent: currentUserReference,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xFF3C5B6F),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitCircle(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        List<WorkoutRecord> homepageWorkoutRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFF3C5B6F),
            appBar: AppBar(
              backgroundColor: const Color(0xFF153448),
              automaticallyImplyLeading: false,
              title: Text(
                'DashBoard',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                    child: Text(
                      'Workout Summary',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Outfit',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: SizedBox(
                      width: 398.0,
                      height: 230.0,
                      child: FlutterFlowBarChart(
                        barData: [
                          FFBarChartData(
                            yData: functions.getFrequency(
                                homepageWorkoutRecordList
                                    .map((e) => e.timestamp)
                                    .withoutNulls
                                    .toList()),
                            color: const Color(0xFF153448),
                          )
                        ],
                        xLabels: functions.getLabels(),
                        barWidth: 16.0,
                        barBorderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                        groupSpace: 8.0,
                        alignment: BarChartAlignment.spaceAround,
                        chartStylingInfo: ChartStylingInfo(
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          showGrid: true,
                          borderColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          borderWidth: 1.0,
                        ),
                        axisBounds: const AxisBounds(),
                        xAxisLabelInfo: const AxisLabelInfo(
                          showLabels: true,
                          labelInterval: 10.0,
                        ),
                        yAxisLabelInfo: const AxisLabelInfo(
                          showLabels: true,
                          labelInterval: 10.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
