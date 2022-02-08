import 'package:flutter/material.dart';
import 'package:mightyweb/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class ErrorScreen extends StatefulWidget {
  static String tag = '/ErrorScreen';
  final String? error;

  ErrorScreen({this.error});

  @override
  ErrorScreenState createState() => ErrorScreenState();
}

class ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ic_error, height: 250, width: context.width()),
            16.height,
            Text(widget.error.validate(), style: boldTextStyle(size: 20),textAlign: TextAlign.center).center().paddingOnly(left: 16,right: 16),
          ],
        ),
      ),
    );
  }
}
