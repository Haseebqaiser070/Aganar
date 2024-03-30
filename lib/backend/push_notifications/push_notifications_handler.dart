import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          child: Image.asset(
            'assets/images/a_ganar_logo_grande_sin_fondo.png',
            fit: BoxFit.scaleDown,
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'Detalles': (data) async => DetallesWidget(
        sorteo: getParameter(data, 'sorteo'),
      ),
  'LoginSignin': (data) async => LoginSigninWidget(),
  'perfil': (data) async => PerfilWidget(),
  'historico': (data) async => HistoricoWidget(
        misSorteos: await getDocumentParameter(
            data, 'misSorteos', SorteosRecord.fromSnapshot),
      ),
  'profileSettings': (data) async => ProfileSettingsWidget(),
  'crearSorteo': (data) async => CrearSorteoWidget(),
  'adminSorteos': (data) async => AdminSorteosWidget(),
  'listaSorteos': (data) async => ListaSorteosWidget(),
  'editSorteo': (data) async => EditSorteoWidget(
        editSorteos: getParameter(data, 'editSorteos'),
      ),
  'usersList': (data) async => UsersListWidget(),
  'addUserSorteo': (data) async => AddUserSorteoWidget(
        sorteoAdd: getParameter(data, 'sorteoAdd'),
      ),
  'appReviews': (data) async => AppReviewsWidget(),
  'sorteoUsersList': (data) async => SorteoUsersListWidget(
        usersInLottery: getParameter(data, 'usersInLottery'),
      ),
  'notifications': (data) async => NotificationsWidget(),
  'successImage': (data) async => SuccessImageWidget(
        numberSorteo: getParameter(data, 'numberSorteo'),
      ),
  'sorteoV2': (data) async => SorteoV2Widget(
        sorteoRuleta: getParameter(data, 'sorteoRuleta'),
      ),
  'selectEmojiEfectivo': (data) async => SelectEmojiEfectivoWidget(
        sorteo: getParameter(data, 'sorteo'),
      ),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};

    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
