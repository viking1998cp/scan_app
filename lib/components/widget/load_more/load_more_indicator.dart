import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadMoreIndicator extends StatelessWidget {
  const LoadMoreIndicator({Key? key}) : super(key: key);
  Widget loadMoreIndicator(String title) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Container(
            child: JumpingDotsProgressIndicator(
              fontSize: 20.0,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loadMoreIndicator(
        TransactionKey.loadLanguage(context, TransactionKey.loadingData));
  }
}
