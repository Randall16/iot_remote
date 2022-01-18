import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:iot_remote/RemoteButton.dart';
import 'package:iot_remote/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



const Color buttonColor = Color(0xFF2D2D2D);
const Color buttonOutlineColor = Color(0xff3d3d3d);

const Color backGroundColor = Color(0xFF141414);

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          backgroundColor: backGroundColor
      ),
      home: const RemotePage(title: 'IoT Remote'),
    );
  }
}

class RemotePage extends StatefulWidget {
  const RemotePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RemotePage> createState() => _RemotePageState();

}

class _RemotePageState extends State<RemotePage> {

  final String _ip_key = 'IoT_Remote_IP_Address';
  late final RemoteService remoteService;

  void _handleButtonPress(RemoteButton remoteButton) async {
    final callSucceeded = await remoteService.sendButton(remoteButton);
    if (callSucceeded) {
      HapticFeedback.lightImpact();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error! Please make sure wifi is turned on and the '
              'proper ip address is set'))
      );
    }
  }

  void _setIpAddress(String ip) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(_ip_key, ip);
    remoteService.setIpAddress(ip);
  }

  var numberButtonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(60, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      primary: buttonColor,
      side: const BorderSide(color: buttonOutlineColor)
  );

  var numberButtonTextStyle = const TextStyle(color: Colors.white);

  var volAndChButtonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(65, 100),
      primary: buttonColor,
      side: const BorderSide(color: buttonOutlineColor)
  );

  void handleClick(String value) {
    switch (value) {
      case 'Set IP':
        _displayTextInputDialog(context);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _createRemoteService();
  }

  void _createRemoteService() async {
    final sp = await SharedPreferences.getInstance();
    final ip = sp.getString(_ip_key) ?? '192.168.254.10';
    remoteService = RemoteService(ip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.tv, color: Colors.deepPurple),
        title: Text(widget.title),
        backgroundColor: backGroundColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Set IP'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: backGroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(style: numberButtonStyle,
                    onPressed: () => _handleButtonPress(RemoteButton.one),
                    child: Text('1', style: numberButtonTextStyle)
                ),
                ElevatedButton(style: numberButtonStyle,
                    child: Text('2', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.two)
                    ),
                ElevatedButton(style: numberButtonStyle,
                    child: Text('3', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.three)
                    )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(style: numberButtonStyle,
                    child: Text('4', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.four)),
                ElevatedButton(style: numberButtonStyle,
                    child: Text('5', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.five)),
                ElevatedButton(style: numberButtonStyle,
                    child: Text('6', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.six))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(style: numberButtonStyle,
                    child: Text('7', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.seven)),
                ElevatedButton(style: numberButtonStyle,
                    child: Text('8', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.eight)),
                ElevatedButton(style: numberButtonStyle,
                    child: Text('9', style: numberButtonTextStyle),
                    onPressed: () => _handleButtonPress(RemoteButton.nine))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(height: 40),
                    ElevatedButton(style: volAndChButtonStyle,
                        child: const Text('Vol+'),
                        onPressed: () => _handleButtonPress(RemoteButton.volumeUp)),
                    const SizedBox(height: 25),
                    ElevatedButton(style: volAndChButtonStyle,
                        child: const Text('Vol-'),
                        onPressed: () => _handleButtonPress(RemoteButton.volumeDown))
                  ],
                ),
                Container(
                    child: Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(style: numberButtonStyle,
                                child: Text('0', style: numberButtonTextStyle),
                                onPressed: () => _handleButtonPress(RemoteButton.zero)
                            ),
                            //SizedBox(height: 10),
                            IconButton(padding: EdgeInsets.zero,
                                icon: const Icon(Icons.arrow_drop_up_sharp),
                                iconSize: 70,
                                color: Colors.deepPurple,
                                onPressed: () => _handleButtonPress(RemoteButton.up)
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.arrow_left_sharp),
                                    iconSize: 70,
                                    color: Colors.deepPurple,
                                    onPressed: () => _handleButtonPress(RemoteButton.left)
                                ),
                                ElevatedButton(style: numberButtonStyle,
                                    child: Text(
                                        'OK', style: numberButtonTextStyle),
                                    onPressed: () => _handleButtonPress(RemoteButton.select)
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.arrow_right),
                                    iconSize: 70,
                                    color: Colors.deepPurple,
                                    onPressed: () => _handleButtonPress(RemoteButton.right)
                                ),
                              ],
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                iconSize: 70,
                                color: Colors.deepPurple,
                                onPressed: () => _handleButtonPress(RemoteButton.down)
                            ),
                          ],
                        )
                    )
                ),
                Column(
                  children: [
                    const SizedBox(height: 40),
                    ElevatedButton(style: volAndChButtonStyle,
                        child: const Text('Ch+'),
                        onPressed: () => _handleButtonPress(RemoteButton.channelUp)),
                    const SizedBox(height: 25),
                    ElevatedButton(style: volAndChButtonStyle,
                        child: const Text('Ch-'),
                        onPressed: () => _handleButtonPress(RemoteButton.channelDown))
                  ],
                ),
                const Spacer()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(flex: 1),
                Center(
                  child: Ink(
                      decoration: BoxDecoration(
                          color: buttonColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: buttonOutlineColor)
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.volume_off),
                        color: Colors.grey,
                        iconSize: 35,
                        onPressed: () => _handleButtonPress(RemoteButton.mute),
                      ),
                    ),
                ),
                const Spacer(flex: 2),
                Center(
                  child: Ink(
                    decoration: BoxDecoration(
                        color: buttonColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: buttonOutlineColor)
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.power_settings_new),
                      color: Colors.red,
                      iconSize: 45,
                      onPressed: () => _handleButtonPress(RemoteButton.power),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Center(
                  child: Ink(
                    decoration: BoxDecoration(
                        color: buttonColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: buttonOutlineColor)
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.input),
                      color: Colors.grey,
                      iconSize: 35,
                      onPressed: () => _handleButtonPress(RemoteButton.input),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
            const SizedBox(width: double.infinity, height: 1)
          ],
        ),
      ),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();
  String valueText = '';

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter IP Address'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              TextButton(onPressed: () {
                _setIpAddress(valueText);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('IP has been set')));
                Navigator.pop(context);
              }, child: const Text('Confirm'))
            ],
          );
        });
  }
}
