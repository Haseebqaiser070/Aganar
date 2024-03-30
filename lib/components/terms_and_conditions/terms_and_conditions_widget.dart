import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'terms_and_conditions_model.dart';
export 'terms_and_conditions_model.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsWidgetState createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  late TermsAndConditionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsAndConditionsModel());

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 8.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0x98101213),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: 600.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0x33000000),
                            offset: Offset(0.0, 5.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Terminos y Condiciones',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMediumFamily,
                                                fontSize: 25.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(FlutterFlowTheme
                                                            .of(context)
                                                        .headlineMediumFamily),
                                            color: Colors.black87
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Text(
                                'Última actualización: 24 de abril de 2023\n\n\n1.- Aceptación de los Términos y Condiciones\nAl utilizar nuestra aplicación “Aganar” (en adelante, “la Aplicación”), usted acepta y se compromete a cumplir con los siguientes Términos y Condiciones de Uso (en adelante, “Términos”). Por favor, lea estos Términos detenidamente antes de usar la Aplicación. Si no está de acuerdo con estos Términos, no debe utilizar la Aplicación.\n\n2.- Descripción del servicio\nLa Aplicación es una plataforma que permite a los usuarios participar en sorteos de productos, agendar servicios y obtener información sobre promociones y ofertas especiales. Para ello, la Aplicación recopila información pública y privada de los usuarios, incluyendo su dirección de correo electrónico y otros datos personales.\n\n3.- Registro y datos de usuario\nPara acceder y utilizar la Aplicación, deberá registrarse y proporcionar información veraz, precisa, actualizada y completa sobre usted, incluyendo su nombre, dirección de correo electrónico y otros datos personales que se soliciten en el proceso de registro. Usted es responsable de mantener actualizada y correcta la información proporcionada.\n\n4.- Privacidad\nNuestra Política de Privacidad explica cómo recopilamos, utilizamos y protegemos su información personal. Al utilizar la Aplicación, usted acepta y consiente el uso de sus datos conforme a nuestra Política de Privacidad.\n\n5.-Condiciones de los sorteos\nPara participar en los sorteos de productos, debe seguir las instrucciones y cumplir con los requisitos establecidos en las reglas de cada sorteo. Nos reservamos el derecho de descalificar a cualquier usuario que no cumpla con dichos requisitos o que infrinja estos Términos.\n\n6.- Uso de los servicios\nAl agendar servicios a través de la Aplicación, usted acepta cumplir con los términos y condiciones específicos aplicables a cada servicio, incluyendo los horarios, precios, políticas de cancelación y otros términos relevantes.\n\n7.- Derechos de propiedad intelectual\nTodos los contenidos y materiales disponibles en la Aplicación, incluyendo, pero no limitado a, texto, gráficos, logotipos, imágenes y software, son propiedad de \"Aganar\" o de sus respectivos propietarios y están protegidos por las leyes de derechos de autor y otras leyes de propiedad intelectual aplicables.\n\n8.- Limitación de responsabilidad\nEn ningún caso, \"Aganar\" será responsable por daños directos, indirectos, incidentales, especiales, ejemplares o consecuentes (incluyendo, pero no limitado a, la pérdida de beneficios, datos o interrupción de negocio) que resulten del uso o la imposibilidad de usar la Aplicación.\n\n9.-Modificación de los Términos\nNos reservamos el derecho de modificar estos Términos en cualquier momento y a nuestro exclusivo criterio. Si realizamos cambios en estos Términos, le notificaremos mediante la publicación de la nueva versión en la Aplicación. Su utilización continuado de la Aplicación después de la publicación de los cambios constituirá su aceptación de dichos cambios.\n\n10.- Legislación aplicable y jurisdicción\nEstos Términos se regirán e interpretarán de conformidad con las leyes del país en el que se encuentre registrada la empresa propietaria de \"Aganar\" (en adelante, \"el País\"), sin tener en cuenta sus disposiciones sobre conflictos de leyes. Cualquier controversia o reclamación que surja de o en relación con estos Términos, incluyendo su validez, interpretación, ejecución o incumplimiento, se someterá a la jurisdicción exclusiva de los tribunales del País.\n\n11.- Terminación\nNos reservamos el derecho de suspender o cancelar su acceso a la Aplicación en cualquier momento y por cualquier motivo, incluyendo, pero no limitado a, el incumplimiento de estos Términos. La terminación de su acceso a la Aplicación no afectará a los derechos y obligaciones que hayan surgido antes de dicha terminación.\n\n12.- Indemnización\nUsted acepta indemnizar, defender y mantener indemne a \"Aganar\" y a sus afiliados, directores, empleados, representantes y licenciantes de y contra cualquier reclamación, responsabilidad, daño, pérdida o gasto, incluyendo honorarios razonables de abogados, que surjan o estén relacionados de alguna manera con su uso de la Aplicación, su incumplimiento de estos Términos o cualquier actividad ilegal realizada a través de su cuenta.\n\n13.- Disposiciones generales\nSi alguna disposición de estos Términos es declarada inválida o inaplicable por un tribunal de jurisdicción competente, dicha disposición se eliminará de estos Términos y las disposiciones restantes continuarán en pleno vigor y efecto.\nLa falta de \"Aganar\" en ejercer o hacer valer cualquier derecho o disposición de estos Términos no constituirá una renuncia a dicho derecho o disposición.\nEstos Términos, junto con la Política de Privacidad y cualquier otro acuerdo aplicable, constituyen el acuerdo completo entre usted y \"Aganar\" con respecto a su uso de la Aplicación y reemplazan todos los acuerdos anteriores y contemporáneos, ya sean escritos u orales, con respecto a dicho uso.\n\n14.- Contacto\nSi tiene alguna pregunta o inquietud sobre estos Términos o su uso de la Aplicación, por favor póngase en contacto con nuestro equipo de atención al cliente a través de la información de contacto proporcionada en la Aplicación.',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    text: 'Entiendo',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 24.0, 24.0, 24.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Colors.white,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily),
                                          ),
                                      elevation: 1.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
