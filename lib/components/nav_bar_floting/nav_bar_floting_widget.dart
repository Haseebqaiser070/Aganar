import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/user/app_reviews/app_reviews_widget.dart';
import '/user/historico/historico_widget.dart';
import '/user/inicio/inicio_widget.dart';
import '/user/perfil/perfil_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_bar_floting_model.dart';
export 'nav_bar_floting_model.dart';

class NavBarFlotingWidget extends StatefulWidget {
  const NavBarFlotingWidget({Key? key}) : super(key: key);

  @override
  _NavBarFlotingWidgetState createState() => _NavBarFlotingWidgetState();
}

class _NavBarFlotingWidgetState extends State<NavBarFlotingWidget> {
  late NavBarFlotingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarFlotingModel());

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

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 26.0),
      child: Container(
        width: double.infinity,
        height: 70.0,
        constraints: BoxConstraints(
          maxWidth: 600.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Color(0x19000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(40.0),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                hoverIconColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(
                  Icons.home_filled,
                  color: valueOrDefault<Color>(
                    FFAppState().selectedMnu == 'home'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : FlutterFlowTheme.of(context).grayIcon,
                    FlutterFlowTheme.of(context).grayIcon,
                  ),
                  size: 25.0,
                ),
                onPressed: () async {
                  setState(() {
                    FFAppState().selectedMnu = 'home';
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InicioWidget(),
                    ),
                  );
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                hoverColor: Color(0xDBFFFFFF),
                hoverIconColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(
                  Icons.history_sharp,
                  color: valueOrDefault<Color>(
                    FFAppState().selectedMnu == 'historial'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : FlutterFlowTheme.of(context).grayIcon,
                    FlutterFlowTheme.of(context).grayIcon,
                  ),
                  size: 30.0,
                ),
                onPressed: () async {
                  setState(() {
                    FFAppState().selectedMnu = 'historial';
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoricoWidget(),
                    ),
                  );
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                hoverColor: Color(0xDBFFFFFF),
                hoverIconColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(
                  Icons.person,
                  color: valueOrDefault<Color>(
                    FFAppState().selectedMnu == 'perfil'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : FlutterFlowTheme.of(context).grayIcon,
                    FlutterFlowTheme.of(context).grayIcon,
                  ),
                  size: 30.0,
                ),
                onPressed: () async {
                  setState(() {
                    FFAppState().selectedMnu = 'perfil';
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilWidget(),
                    ),
                  );
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                hoverColor: Color(0xDBFFFFFF),
                hoverIconColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(
                  Icons.rate_review,
                  color: valueOrDefault<Color>(
                    FFAppState().selectedMnu == 'reviews'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : FlutterFlowTheme.of(context).grayIcon,
                    FlutterFlowTheme.of(context).grayIcon,
                  ),
                  size: 30.0,
                ),
                onPressed: () async {
                  setState(() {
                    FFAppState().selectedMnu = 'reviews';
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppReviewsWidget(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
