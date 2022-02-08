import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mightyweb/main.dart';

// ignore: must_be_immutable
class Loaders extends StatefulWidget {
  String? name;

  Loaders({this.name = 'Circle'});

  @override
  _LoadersState createState() => _LoadersState();
}

class _LoadersState extends State<Loaders> {
  @override
  Widget build(BuildContext context) {
    var name = widget.name;

    Widget child = Container();

    if (name == 'RotatingPlane') {
      child = SpinKitRotatingPlain(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'DoubleBounce') {
      child = SpinKitDoubleBounce(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'Wave') {
      child = SpinKitWave(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'WanderingCubes') {
      child = SpinKitWanderingCubes(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'Pulse') {
      child = SpinKitPulse(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'ChasingDots') {
      child = SpinKitChasingDots(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'FadingFour') {
      child = SpinKitFadingFour(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'Circle') {
      child = SpinKitCircle(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'CubeGrid') {
      child = SpinKitCubeGrid(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'FadingCircle') {
      child = SpinKitFadingCircle(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'FoldingCube') {
      child = SpinKitFoldingCube(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'RotatingCircle') {
      child = SpinKitRotatingCircle(
        size: 30.0,
        color: appStore.primaryColors,
      );
    } else if (name == 'Ring') {
      child = SpinKitRing(
        size: 30.0,
        color: appStore.primaryColors,
      );
    }
    return Center(
      child: Container(
        height: 150,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
