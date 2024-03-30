import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/components/cash_pay_instructions/cash_pay_instructions_widget.dart';
import '/components/custom_alert_stripe/custom_alert_stripe_widget.dart';
import '/components/select_tickets/select_tickets_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_method_model.dart';
export 'payment_method_model.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({
    Key? key,
    this.sorteo,
    this.user,
  }) : super(key: key);

  final DocumentReference? sorteo;
  final DocumentReference? user;

  @override
  _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  late PaymentMethodModel _model;
  int selectedAmount = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentMethodModel());

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

    return StreamBuilder<SorteosRecord>(
      stream: SorteosRecord.getDocument(widget.sorteo!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 26.0,
              height: 26.0,
              child: SpinKitDoubleBounce(
                color: FlutterFlowTheme.of(context).primary,
                size: 26.0,
              ),
            ),
          );
        }
        final containerSorteosRecord = snapshot.data!;
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 600.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0x3B1D2429),
                offset: Offset(0.0, -3.0),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Container(
                          width: 50.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFE0E3E7),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        isDismissible: false,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: CashPayInstructionsWidget(),
                          );
                        },
                      ).then((value) => setState(() {}));
                    },
                    text: 'Pagar en Efectivo',
                    icon: FaIcon(
                      FontAwesomeIcons.euroSign,
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Montserrat',
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await enterPayment(containerSorteosRecord.valorSorteo.round());

                    if(selectedAmount != 0){
                      DocumentReference selectTicketRef = firestore.collection("sorteos").doc(containerSorteosRecord.uid).collection("selectedTickets").doc();
                      await selectTicketRef.set({
                        'payment': selectedAmount,
                        'usuario': currentUserReference,
                      }).then((value){
                        print("User Added Successfully.");
                      });
                      final paymentResponse = await processStripePayment(
                        context,
                        amount: valueOrDefault<int>(
                          (selectedAmount * 100).round(),
                          0,
                        ),
                        currency: 'EUR',
                        customerEmail: currentUserEmail,
                        customerName: currentUserDisplayName,
                        description: containerSorteosRecord.nombreSorteo,
                        allowGooglePay: false,
                        allowApplePay: false,
                        buttonColor: FlutterFlowTheme.of(context).primary,
                        buttonTextColor:
                        Colors.blueAccent,
                      );
                      if (paymentResponse.paymentId == null) {
                        if (paymentResponse.errorMessage != null) {
                          showSnackbar(
                            context,
                            'Error: ${paymentResponse.errorMessage}',
                          );
                        }
                        return;
                      }
                      _model.paymentId = paymentResponse.paymentId!;

                      await actions.generarBoletos(
                        context,
                      );
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        isDismissible: false,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SelectTicketsWidget(
                              sorteo: containerSorteosRecord,
                              SelectedTicketRef: selectTicketRef,
                            ),
                          );
                        },
                      ).then((value) => setState(() {}));

                      await currentUserReference!.update({
                        'mis_sorteos': FieldValue.arrayUnion([widget.sorteo]),
                      });
                      await storePayment(currentUserReference!, widget.sorteo!, selectedAmount,true);

                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        isDismissible: false,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: CustomAlertStripeWidget(
                              sorteoAddUser: containerSorteosRecord.reference,
                              title: 'Registro',
                              body: 'Ya estas participando.',
                            ),
                          );
                        },
                      ).then((value) => setState(() {}));

                      setState(() {});
                    }
                  },
                  text: 'Pagar con Stripe',
                  icon: FaIcon(
                    FontAwesomeIcons.solidCreditCard,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 60.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Montserrat',
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: 'Cancelar',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Noto Sans Hebrew',
                            color: FlutterFlowTheme.of(context).secondary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
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
        );
      },
    );
  }


  Future storePayment(DocumentReference userRef,DocumentReference ruffelRef,int amount,bool isParticipate)async{
    print("payment saving..");
    Map<String,dynamic> paymentModel = {
      'userRef': userRef,
      'ruffelRef': ruffelRef,
      'amount': amount,
      'isParticipate': isParticipate,
      'createdAt': FieldValue.serverTimestamp(),
    };
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("payments").add(paymentModel).then((value){
      print("payment store successfull");
    }).catchError((e){
      print("errorr: $e");
    });
  }


  enterPayment(int price){
    List<int> possibleAmounts = [];
    for(int i =1; i<=10; i++){
      possibleAmounts.add(price*i);
    }
    return showModalBottomSheet(context: context, builder: (context){
      return Container(
        height: 300,
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        child: Column(
          children: [
            Text("Engresa la cantidad de emojis",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            SizedBox(
              height: 200,
              child: GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 5,
                children: possibleAmounts.map((e){
                  return amountButton(e, (){
                    selectedAmount = e;
                    Navigator.pop(context);
                  });
                }).toList(),
              ),
            ),
            // TextFormField(
            //   validator: (v){
            //     if(v == "" || v == null){
            //       return "Please Enter Price";
            //     }
            //     if(int.parse(v) < price){
            //       return "El monto mínimo del sorteo es $price";
            //     }
            //   },
            //   controller: amountC,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     hintText: "Enter Amount.",
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10,),
            // InkWell(
            //   onTap: (){
            //     if(formKey.currentState!.validate()){
            //     Navigator.pop(context);
            //     }
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            //     decoration: BoxDecoration(
            //         color: FlutterFlowTheme.of(
            //             context)
            //             .primary,
            //         borderRadius: BorderRadius.circular(10)
            //     ),
            //     alignment: Alignment.center,
            //     child: Text("Agregar",style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold
            //     ),),
            //   ),
            // ),
          ],
        ),
      );
    });
  }

  Widget amountButton(int amount, Function() fnc){
    return InkWell(
      onTap: fnc,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: FlutterFlowTheme.of(
                context)
                .secondaryBackground,
            boxShadow: [
              BoxShadow(color: Colors.white12,offset: Offset(2,2), blurRadius: 5,spreadRadius: 4)
            ]
        ),
        alignment: Alignment.center,
        child: Text("€$amount",style: TextStyle(
            color: Colors.white
        ),),
      ),
    );
  }
}
