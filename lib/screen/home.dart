import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:system_alert_window/system_alert_window.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  bool granted = false;
  // bool _hasPermission = false;

  // String _platformVersion = 'Unknown';
  bool _isShowingWindow = false;
  bool _isUpdatedWindow = false;
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

// First function to get the app running in background
  Future<bool> _getBackgroundPermission() async {
    bool _bgEnabled = false;
    bool _hasPermissions = await FlutterBackground.hasPermissions;

    print('Has Permission: $_hasPermissions');

    if (_hasPermissions) {
      const androidConfig = FlutterBackgroundAndroidConfig(
        notificationTitle: "flutter_background example app",
        notificationText:
            "Background notification for keeping the example app running in the background",
        notificationImportance: AndroidNotificationImportance.Default,
        notificationIcon: AndroidResource(
            name: 'background_icon',
            defType: 'drawable'), // Default is ic_launcher from folder mipmap
      );
      bool _initialize =
          await FlutterBackground.initialize(androidConfig: androidConfig);

      print('Has Initialized $_initialize');

      if (_initialize) {
        _bgEnabled = await FlutterBackground.enableBackgroundExecution();

        print('Has Enabled $_bgEnabled');
      }
    }

    return _bgEnabled;
  }

// Used by Phone state
  Future<bool> _requestPermission() async {
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

// Used by System alert window
  void callBackFunction(String tag) {
    WidgetsFlutterBinding.ensureInitialized();
    switch (tag) {
      case "simple_button":
        print("Simple button has been clicked");
        break;
      case "focus_button":
        print("Focus button has been clicked");
        break;
      case "personal_btn":
        print("Personal button has been clicked");
        break;
      default:
        print("OnClick event of $tag");
    }
  }

// Used by system alert window
  // Future<void> _initPlatformState() async {
  //   await SystemAlertWindow.enableLogs(true);
  //   String? platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     platformVersion = await SystemAlertWindow.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //   setState(() {
  //     _platformVersion = platformVersion!;
  //   });
  // }

// Used by system alert window
  Future<void> _requestPermissions() async {
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
  }

// Used by Phone state
  void setStream() {
    PhoneState.phoneStateStream.listen((event) {
      setState(() {
        if (event != null) {
          status = event;
        }
      });
    });
  }

// Used by system alert window
  void _showOverlayWindow() {
    if (!_isShowingWindow) {
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
            tag: "personal_btn"),
        buttonPosition: ButtonPosition.TRAILING,
      );
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
                text: "Send Messgae",
                fontSize: 12,
                textColor: const Color.fromRGBO(250, 139, 97, 1),
              ),
              tag: "send_message",
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
                  startColor: Color.fromRGBO(250, 139, 97, 1),
                  endColor: Color.fromRGBO(247, 28, 88, 1),
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
          prefMode: prefMode);

      setState(() {
        _isShowingWindow = true;
      });
    } else if (!_isUpdatedWindow) {
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
                    text: "Updated body",
                    fontSize: 12,
                    textColor: Colors.black45),
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
                  textColor: Color.fromRGBO(250, 139, 97, 1)),
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
                  startColor: Color.fromRGBO(250, 139, 97, 1),
                  endColor: Color.fromRGBO(247, 28, 88, 1),
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
          prefMode: prefMode);
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    setState(() {
      _appLifecycleState = state;
    });
    if (Platform.isIOS) setStream();
    if (state == AppLifecycleState.paused) {
      print('AppLifecycleState state: Paused');
    }
    if (state == AppLifecycleState.resumed) {
      print('AppLifecycleState state: Resumed');
    }
    if (state == AppLifecycleState.detached) {
      print('AppLifecycleState state: Detached');
    }
    if (state == AppLifecycleState.inactive) {
      print('AppLifecycleState state: Inactive');
    }
    super.didChangeAppLifecycleState(state);
  }

  void _callAllFunction() async {
    bool _hasPhoneStatePermission = false;
    bool _hasBackgroundPermission = await _getBackgroundPermission();
    if (_hasBackgroundPermission) {
      _hasPhoneStatePermission = await _requestPermission();
    }
    if (_hasPhoneStatePermission) {
      setStream();
    }
    switch (status) {
      case PhoneStateStatus.NOTHING:
        return;
      case PhoneStateStatus.CALL_INCOMING:
        return;
      case PhoneStateStatus.CALL_STARTED:
        return;
      case PhoneStateStatus.CALL_ENDED:
        return;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    SystemAlertWindow.requestPermissions;
    SystemAlertWindow.registerOnClickListener(callBackFunction);
    if (Platform.isIOS) setStream();

    _callAllFunction();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone State"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Status of call",
              style: TextStyle(fontSize: 24),
            ),
            Icon(
              getIcons(),
              color: getColor(),
              size: 80,
            ),
          ],
        ),
      ),
    );
  }

  IconData getIcons() {
    switch (status) {
      case PhoneStateStatus.NOTHING:
        SystemAlertWindow.closeSystemWindow();
        return Icons.clear;
      case PhoneStateStatus.CALL_INCOMING:
        return Icons.add_call;
      case PhoneStateStatus.CALL_STARTED:
        return Icons.call;
      case PhoneStateStatus.CALL_ENDED:
        SystemAlertWindow.closeSystemWindow();
        return Icons.call_end;
    }
  }

  Color getColor() {
    switch (status) {
      case PhoneStateStatus.NOTHING:
      case PhoneStateStatus.CALL_ENDED:
        return Colors.red;
      case PhoneStateStatus.CALL_INCOMING:
        return Colors.green;
      case PhoneStateStatus.CALL_STARTED:
        return Colors.orange;
    }
  }
}
