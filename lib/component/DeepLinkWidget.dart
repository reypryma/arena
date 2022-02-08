import 'package:flutter/material.dart';
import 'package:mightyweb/main.dart';
import 'package:mightyweb/utils/bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';


class DeepLinkWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(height: 0);
        } else {
          if(snapshot.data!.isNotEmpty){
            appStore.setDeepLinkURL(snapshot.data!.toString());
            log("Deep link:"+snapshot.data!.toString());
            log("AppStore Deep link:"+appStore.deepLinkURL.toString());
         }
          return SizedBox();
        }
      },
    );
  }
}