import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'package:caller/caller.dart';

void callBack(String tag) {
  WidgetsFlutterBinding.ensureInitialized();
  log(tag);
  switch (tag) {
    case "simple_button":
    case "updated_simple_button":
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
      break;
    case "focus_button":
      log("Focus button has been called");
      break;
    default:
      log("OnClick event of $tag");
  }
}

void isShowingWindowCorrespondence(SystemWindowPrefMode prefMode) {
  SystemWindowHeader header = SystemWindowHeader(
      title: SystemWindowText(
          text: "Incoming Call", fontSize: 10, textColor: Colors.black45),
      padding: SystemWindowPadding.setSymmetricPadding(12, 12),
      subTitle: SystemWindowText(
          text: "9898989899",
          fontSize: 14,
          fontWeight: FontWeight.BOLD,
          textColor: Colors.black87),
      decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
      button: SystemWindowButton(
        text: SystemWindowText(
            text: "Personal", fontSize: 10, textColor: Colors.black45),
        tag: "personal_btn",
      ),
      buttonPosition: ButtonPosition.TRAILING);
  SystemWindowBody body = SystemWindowBody(
    rows: [
      EachRow(
        columns: [
          EachColumn(
            text: SystemWindowText(
                text: "Some body", fontSize: 12, textColor: Colors.black45),
          ),
        ],
        gravity: ContentGravity.CENTER,
      ),
      EachRow(columns: [
        EachColumn(
            text: SystemWindowText(
                text: "Long data of the body",
                fontSize: 12,
                textColor: Colors.black87,
                fontWeight: FontWeight.BOLD),
            padding: SystemWindowPadding.setSymmetricPadding(6, 8),
            decoration: SystemWindowDecoration(
                startColor: Colors.black12, borderRadius: 25.0),
            margin: SystemWindowMargin(top: 4)),
      ], gravity: ContentGravity.CENTER),
      EachRow(
        columns: [
          EachColumn(
            text: SystemWindowText(
                text: "Notes", fontSize: 10, textColor: Colors.black45),
          ),
        ],
        gravity: ContentGravity.LEFT,
        margin: SystemWindowMargin(top: 8),
      ),
      EachRow(
        columns: [
          EachColumn(
            text: SystemWindowText(
                text: "Some random notes.",
                fontSize: 13,
                textColor: Colors.black54,
                fontWeight: FontWeight.BOLD),
          ),
        ],
        gravity: ContentGravity.LEFT,
      ),
    ],
    padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
  );
  SystemWindowFooter footer = SystemWindowFooter(
      buttons: [
        SystemWindowButton(
          text: SystemWindowText(
              text: "Simple button",
              fontSize: 12,
              textColor: const Color.fromRGBO(250, 139, 97, 1)),
          tag: "simple_button",
          padding:
              SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
          width: 0,
          height: SystemWindowButton.WRAP_CONTENT,
          decoration: SystemWindowDecoration(
              startColor: Colors.white,
              endColor: Colors.white,
              borderWidth: 0,
              borderRadius: 0.0),
        ),
        SystemWindowButton(
          text: SystemWindowText(
              text: "Focus button", fontSize: 12, textColor: Colors.white),
          tag: "focus_button",
          width: 0,
          padding:
              SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
          height: SystemWindowButton.WRAP_CONTENT,
          decoration: SystemWindowDecoration(
              startColor: const Color.fromRGBO(250, 139, 97, 1),
              endColor: const Color.fromRGBO(247, 28, 88, 1),
              borderWidth: 0,
              borderRadius: 30.0),
        )
      ],
      padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
      decoration: SystemWindowDecoration(startColor: Colors.white),
      buttonsPosition: ButtonPosition.CENTER);
  SystemAlertWindow.showSystemWindow(
    height: 230,
    header: header,
    body: body,
    footer: footer,
    margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
    gravity: SystemWindowGravity.TOP,
    notificationTitle: "Incoming Call",
    notificationBody: "+1 646 980 4741",
    prefMode: prefMode,
  );
}

void isUpdatedWindow(SystemWindowPrefMode prefMode) {
  SystemWindowHeader header = SystemWindowHeader(
      title: SystemWindowText(
          text: "Outgoing Call", fontSize: 10, textColor: Colors.black45),
      padding: SystemWindowPadding.setSymmetricPadding(12, 12),
      subTitle: SystemWindowText(
          text: "8989898989",
          fontSize: 14,
          fontWeight: FontWeight.BOLD,
          textColor: Colors.black87),
      decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
      button: SystemWindowButton(
          text: SystemWindowText(
              text: "Personal", fontSize: 10, textColor: Colors.black45),
          tag: "personal_btn"),
      buttonPosition: ButtonPosition.TRAILING);
  SystemWindowBody body = SystemWindowBody(
    rows: [
      EachRow(
        columns: [
          EachColumn(
            text: SystemWindowText(
                text: "Updated body", fontSize: 12, textColor: Colors.black45),
          ),
        ],
        gravity: ContentGravity.CENTER,
      ),
      EachRow(columns: [
        EachColumn(
            text: SystemWindowText(
                text: "Updated long data of the body",
                fontSize: 12,
                textColor: Colors.black87,
                fontWeight: FontWeight.BOLD),
            padding: SystemWindowPadding.setSymmetricPadding(6, 8),
            decoration: SystemWindowDecoration(
                startColor: Colors.black12, borderRadius: 25.0),
            margin: SystemWindowMargin(top: 4)),
      ], gravity: ContentGravity.CENTER),
      EachRow(
        columns: [
          EachColumn(
            text: SystemWindowText(
                text: "Notes", fontSize: 10, textColor: Colors.black45),
          ),
        ],
        gravity: ContentGravity.LEFT,
        margin: SystemWindowMargin(top: 8),
      ),
      EachRow(
        columns: [
          EachColumn(
            text: SystemWindowText(
                text: "Updated random notes.",
                fontSize: 13,
                textColor: Colors.black54,
                fontWeight: FontWeight.BOLD),
          ),
        ],
        gravity: ContentGravity.LEFT,
      ),
    ],
    padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
  );
  SystemWindowFooter footer = SystemWindowFooter(
      buttons: [
        SystemWindowButton(
          text: SystemWindowText(
              text: "Updated Simple button",
              fontSize: 12,
              textColor: const Color.fromRGBO(250, 139, 97, 1)),
          tag: "updated_simple_button",
          padding:
              SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
          width: 0,
          height: SystemWindowButton.WRAP_CONTENT,
          decoration: SystemWindowDecoration(
              startColor: Colors.white,
              endColor: Colors.white,
              borderWidth: 0,
              borderRadius: 0.0),
        ),
        SystemWindowButton(
          text: SystemWindowText(
              text: "Focus button", fontSize: 12, textColor: Colors.white),
          tag: "focus_button",
          width: 0,
          padding:
              SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
          height: SystemWindowButton.WRAP_CONTENT,
          decoration: SystemWindowDecoration(
              startColor: const Color.fromRGBO(250, 139, 97, 1),
              endColor: const Color.fromRGBO(247, 28, 88, 1),
              borderWidth: 0,
              borderRadius: 30.0),
        )
      ],
      padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
      decoration: SystemWindowDecoration(startColor: Colors.white),
      buttonsPosition: ButtonPosition.CENTER);
  SystemAlertWindow.updateSystemWindow(
    height: 230,
    header: header,
    body: body,
    footer: footer,
    margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
    gravity: SystemWindowGravity.TOP,
    notificationTitle: "Outgoing Call",
    notificationBody: "+1 646 980 4741",
    prefMode: prefMode,
  );
}

Future<void> callerCallbackHandler(
  CallerEvent event,
  String number,
  int duration,
) async {
  print('eventttttttttttt');
  if (event == CallerEvent.incoming) {
    print('incoming call');
  } else {
    print('not incoming');
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;
  PhoneStateStatus status = PhoneStateStatus.NOTHING;

  String _platformVersion = 'Unknown';
  bool _isShowingWindow = false;
  bool _isUpdatedWindow = false;
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    // _disableBackgroundPermission();
    super.dispose();
  }

  Future<void> _initPlatformState() async {
    // Draw over system alert window
    String platformVersion;
    try {
      platformVersion = await SystemAlertWindow.platformVersion as String;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future _requestWindowOverlayPermissions() async {
    // to request permission from the user to allow app draw over other apps
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
  }

  void _showOverLayWindow() {
    if (!_isShowingWindow) {
      isShowingWindowCorrespondence(prefMode);
      setState(() {
        _isShowingWindow = true;
      });
    } else if (!_isUpdatedWindow) {
      isUpdatedWindow(prefMode);
      setState(() {
        _isUpdatedWindow = true;
      });
    } else {
      setState(() {
        _isShowingWindow = false;
        _isUpdatedWindow = false;
      });
      SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
    }
  }

  void _closeOverlayWindow() {
    setState(() {
      _isShowingWindow = false;
      _isUpdatedWindow = false;
    });
    SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
  }

  Future<bool> _requestPhonePermissionAndReturnBooleanStatus() async {
    //request phone call permission
    var _status = await Permission.phone.request();

    switch (_status) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        return false;
      case PermissionStatus.granted:
        return true;
    }
  }

  Future<void> setStream() async {
    // listen to phone state stream
    bool response = await _requestPhonePermissionAndReturnBooleanStatus();
    if (!Platform.isIOS) {
      if (!response) return;
    }
    PhoneState.phoneStateStream.listen((event) {
      setState(() {
        if (event != null) {
          _checkPhoneStatusAndRenderCorrespondingEntity(event);
        }
      });
    });
  }

  void _checkPhoneStatusAndRenderCorrespondingEntity(PhoneStateStatus status) {
    if (status == PhoneStateStatus.CALL_INCOMING) {
      _showOverLayWindow();
    } else if (status == PhoneStateStatus.CALL_ENDED) {
      _closeOverlayWindow();
    }
  }

  Future<bool> _initializeFlutterBackgroundAndReturnStatus() async {
    const androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "flutter_background example app",
      notificationText:
          "Background notification for keeping the example app running in the background",
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(
        name: 'background_icon',
        defType: 'drawable',
      ), // Default is ic_launcher from folder mipmap
    );

    bool success =
        await FlutterBackground.initialize(androidConfig: androidConfig);
    return success;
  }

  Future<void> _enableBackgroundPermission() async {
    bool response = await _initializeFlutterBackgroundAndReturnStatus();
    if (response) {
      var hasPermissions = await FlutterBackground.hasPermissions;

      print("Has permissions $hasPermissions");

      if (hasPermissions) {
        final backgroundExecution =
            await FlutterBackground.enableBackgroundExecution();

        print("Background $backgroundExecution");

        if (backgroundExecution) {
          await setStream();
        }
      }
    }
  }

  void _disableBackgroundPermission() async {
    await FlutterBackground.disableBackgroundExecution();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _requestAllPermissions();
  }

  void _requestAllPermissions() async {
    await _initPlatformState();
    await _requestWindowOverlayPermissions();
    await _requestPhonePermissionAndReturnBooleanStatus();
    await SystemAlertWindow.registerOnClickListener(callBack);
    await setStream();
    await _enableBackgroundPermission();
    // await _startCaller();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('System Alert Window Example App'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MaterialButton(
                  onPressed: _showOverLayWindow,
                  textColor: Colors.white,
                  child: !_isShowingWindow
                      ? const Text("Show system alert window")
                      : !_isUpdatedWindow
                          ? const Text("Update system alert window")
                          : const Text("Close system alert window"),
                  color: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
