import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_handler.dart';
import '/components/custom_alert/custom_alert_widget.dart';
import '/components/recuperar_clave/recuperar_clave_widget.dart';
import '/components/terms_and_conditions/terms_and_conditions_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/inicio/inicio_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_signin_model.dart';
export 'login_signin_model.dart';

class LoginSigninWidget extends StatefulWidget {
  const LoginSigninWidget({Key? key}) : super(key: key);

  @override
  _LoginSigninWidgetState createState() => _LoginSigninWidgetState();
}

class _LoginSigninWidgetState extends State<LoginSigninWidget>
    with TickerProviderStateMixin {
  late LoginSigninModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginSigninModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    _model.emailAddressController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
    _model.emailAddressCreateController ??= TextEditingController();
    _model.passwordCreateController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xB1FFFFFF),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/loginbg1.jpg',
                  filterQuality: FilterQuality.high,
                ).image,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 50.0, 0.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200.0),
                            child: Image.asset(
                              'assets/images/a_ganar_logo_grande_sin_fondo.png',
                              width: 300.0,
                              height: 300.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 550.0,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 15.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment(0.0, 0),
                              child: TabBar(
                                isScrollable: true,
                                labelColor:
                                FlutterFlowTheme.of(context).accent3,
                                labelPadding:
                                EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                labelStyle: TextStyle(
                                    color: FlutterFlowTheme.of(context).accent3,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                ),
                                unselectedLabelStyle: TextStyle(
                                    color: Colors.black12
                                ),
                                indicatorColor:
                                FlutterFlowTheme.of(context).accent3,
                                tabs: [
                                  Tab(
                                    text: 'Login',
                                  ),
                                  Tab(
                                    text: 'Registro',
                                  ),
                                ],
                                controller: _model.tabBarController,
                                onTap: (value) => setState(() {}),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _model.tabBarController,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 24.0, 24.0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                          child: TextFormField(
                                            controller: _model
                                                .emailAddressController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle: FlutterFlowTheme
                                                  .of(context)
                                                  .bodySmall,
                                              hintText:
                                              'Ingresa tu Email...',
                                              hintStyle: FlutterFlowTheme
                                                  .of(context)
                                                  .bodySmall
                                                  .override(
                                                fontFamily:
                                                'Montserrat',
                                                color:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .secondaryText,
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodySmallFamily),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .primaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                      context).secondaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              errorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(20.0, 24.0,
                                                  20.0, 24.0),
                                            ),
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF0F1113),
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMediumFamily),
                                            ),
                                            maxLines: null,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            validator: _model
                                                .emailAddressControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 12.0, 0.0, 0.0),
                                          child: TextFormField(
                                            controller:
                                            _model.passwordController,
                                            obscureText:
                                            !_model.passwordVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'Clave',
                                              labelStyle: FlutterFlowTheme
                                                  .of(context)
                                                  .bodySmall,
                                              hintText:
                                              'Ingresa tu clave...',
                                              hintStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodySmall
                                                  .override(
                                                fontFamily:
                                                'Montserrat',
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodySmallFamily),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .primaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                      context).secondaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              errorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(20.0, 24.0,
                                                  20.0, 24.0),
                                              suffixIcon: InkWell(
                                                onTap: () => setState(
                                                      () => _model
                                                      .passwordVisibility =
                                                  !_model
                                                      .passwordVisibility,
                                                ),
                                                focusNode: FocusNode(
                                                    skipTraversal: true),
                                                child: Icon(
                                                  _model.passwordVisibility
                                                      ? Icons
                                                      .visibility_outlined
                                                      : Icons
                                                      .visibility_off_outlined,
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .grayIcon,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF0F1113),
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMediumFamily),
                                            ),
                                            keyboardType: TextInputType
                                                .visiblePassword,
                                            validator: _model
                                                .passwordControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 26.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              Future Function() _navigate =
                                                  () async {};

                                              final user = await authManager
                                                  .signInWithEmail(
                                                context,
                                                _model
                                                    .emailAddressController
                                                    .text,
                                                _model.passwordController
                                                    .text,
                                              );
                                              if (user == null) {
                                                return;
                                              }

                                              _navigate = () => Navigator
                                                  .pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PushNotificationsHandler(
                                                        child:
                                                        InicioWidget(),
                                                      ),
                                                ),
                                                    (r) => false,
                                              );
                                              if (!currentUserEmailVerified) {
                                                await authManager
                                                    .sendEmailVerification();
                                                await authManager.signOut();
                                                _navigate = () => Navigator
                                                    .pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginSigninWidget(),
                                                  ),
                                                      (r) => false,
                                                );
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  isDismissible: false,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () => FocusScope
                                                          .of(context)
                                                          .requestFocus(_model
                                                          .unfocusNode),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                            context),
                                                        child:
                                                        CustomAlertWidget(
                                                          title:
                                                          'Verifica tu Email',
                                                          body:
                                                          'Tu email aun no ha sido verificado, por favor revisa tu correo, incluido tu bandeja de Spam...',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    setState(() {}));
                                              }

                                              await _navigate();
                                            },
                                            text: 'Iniciar Sesion',
                                            options: FFButtonOptions(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24.0, 24.0,
                                                  24.0, 24.0),
                                              iconPadding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0,
                                                  0.0, 0.0),
                                              color: Colors.white,
                                              textStyle:TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryBackground
                                              ),
                                              elevation: 1.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                Color(0x00FFFFFF),
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => FocusScope
                                                        .of(context)
                                                        .requestFocus(_model
                                                        .unfocusNode),
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                          context),
                                                      child: Container(
                                                        height: 350.0,
                                                        child:
                                                        RecuperarClaveWidget(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  setState(() {}));
                                            },
                                            text:
                                            'Olvidaste tu contraseña?',
                                            options: FFButtonOptions(
                                              width: 230.0,
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              iconPadding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0,
                                                  0.0, 0.0),
                                              color: Colors.white,
                                              textStyle: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryBackground
                                              ),
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .secondaryBackground,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 24.0, 24.0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                          child: TextFormField(
                                            controller: _model
                                                .emailAddressCreateController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle: FlutterFlowTheme
                                                  .of(context)
                                                  .bodySmall,
                                              hintText:
                                              'Ingresa tu Email.',
                                              hintStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodySmall
                                                  .override(
                                                fontFamily:
                                                'Montserrat',
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodySmallFamily),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .primaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                      context).secondaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              errorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(20.0, 24.0,
                                                  20.0, 24.0),
                                            ),
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF0F1113),
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMediumFamily),
                                            ),
                                            maxLines: null,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            validator: _model
                                                .emailAddressCreateControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 12.0, 0.0, 0.0),
                                          child: TextFormField(
                                            controller: _model
                                                .passwordCreateController,
                                            obscureText: !_model
                                                .passwordCreateVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'Clave',
                                              labelStyle: FlutterFlowTheme
                                                  .of(context)
                                                  .bodySmall,
                                              hintText:
                                              'Ingresa tu clave...',
                                              hintStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodySmall
                                                  .override(
                                                fontFamily:
                                                'Montserrat',
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodySmallFamily),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .primaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                      context).secondaryBackground,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              errorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(20.0, 24.0,
                                                  20.0, 24.0),
                                              suffixIcon: InkWell(
                                                onTap: () => setState(
                                                      () => _model
                                                      .passwordCreateVisibility =
                                                  !_model
                                                      .passwordCreateVisibility,
                                                ),
                                                focusNode: FocusNode(
                                                    skipTraversal: true),
                                                child: Icon(
                                                  _model.passwordCreateVisibility
                                                      ? Icons
                                                      .visibility_outlined
                                                      : Icons
                                                      .visibility_off_outlined,
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF0F1113),
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMediumFamily),
                                            ),
                                            keyboardType: TextInputType
                                                .visiblePassword,
                                            validator: _model
                                                .passwordCreateControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 12.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                  CheckboxThemeData(
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          0.0),
                                                    ),
                                                  ),
                                                  unselectedWidgetColor:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .accent3,
                                                ),
                                                child: Checkbox(
                                                  value: _model
                                                      .checkboxValue ??=
                                                  false,
                                                  onChanged:
                                                      (newValue) async {
                                                    setState(() => _model
                                                        .checkboxValue =
                                                    newValue!);
                                                  },
                                                  activeColor:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .primaryBackground,
                                                ),
                                              ),
                                              InkWell(
                                                splashColor:
                                                Colors.transparent,
                                                focusColor:
                                                Colors.transparent,
                                                hoverColor:
                                                Colors.transparent,
                                                highlightColor:
                                                Colors.transparent,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled:
                                                    true,
                                                    backgroundColor:
                                                    Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () => FocusScope
                                                            .of(context)
                                                            .requestFocus(_model
                                                            .unfocusNode),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                              context),
                                                          child:
                                                          TermsAndConditionsWidget(),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      setState(() {}));
                                                },
                                                child: AutoSizeText(
                                                  'Aceptar los terminos y condiciones.',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 24.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              Future Function() _navigate =
                                                  () async {};
                                              if (_model.checkboxValue!) {
                                                final user = await authManager
                                                    .createAccountWithEmail(
                                                  context,
                                                  _model
                                                      .emailAddressCreateController
                                                      .text,
                                                  _model
                                                      .passwordCreateController
                                                      .text,
                                                );
                                                if (user == null) {
                                                  return;
                                                }

                                                await UsersRecord.collection
                                                    .doc(user.uid)
                                                    .update(
                                                    createUsersRecordData(
                                                      activo: true,
                                                    ));

                                                _navigate = () => Navigator
                                                    .pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PushNotificationsHandler(
                                                          child:
                                                          InicioWidget(),
                                                        ),
                                                  ),
                                                      (r) => false,
                                                );
                                                if (!currentUserEmailVerified) {
                                                  await authManager
                                                      .signOut();
                                                  _navigate = () =>
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginSigninWidget(),
                                                        ),
                                                            (r) => false,
                                                      );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(
                                                    context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Debes aceptar los terminos y condiciones!!!',
                                                      style: TextStyle(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondary,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primary,
                                                  ),
                                                );
                                              }

                                              await _navigate();
                                            },
                                            text: 'Crear Cuenta',
                                            options: FFButtonOptions(
                                              width: 230.0,
                                              height: 50.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              iconPadding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0,
                                                  0.0, 0.0),
                                              color: Colors.white,
                                              textStyle: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryBackground
                                              ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text("O inicia sesión con",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap:()async{
                                          final user = await authManager.signInWithGoogle(context);
                                          if (user == null) {
                                            return;
                                          }
                                          print(user.email);


                                          DocumentSnapshot userdoc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();


                                          if(userdoc.exists){
                                            print("login");
                                            Navigator
                                                .pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PushNotificationsHandler(
                                                      child:
                                                      InicioWidget(),
                                                    ),
                                              ),
                                                  (r) => false,
                                            );

                                          }
                                          else{
                                            print("Signup");
                                            await UsersRecord.collection
                                                .doc(user.uid)
                                                .update(
                                                createUsersRecordData(
                                                  activo: true,
                                                ));

                                            Navigator
                                                .pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PushNotificationsHandler(
                                                      child:
                                                      InicioWidget(),
                                                    ),
                                              ),
                                                  (r) => false,
                                            );
                                          }
                                        },
                                        child: SizedBox(
                                          height: 35,width: 35,
                                          child: Image.asset('assets/images/google.png'),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
