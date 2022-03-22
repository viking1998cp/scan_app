import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:flutter/material.dart';

class InputMatchNameDialog extends StatefulWidget {
  final String hintText;
  final Function(String text) okClick;
  const InputMatchNameDialog(
      {Key? key, required this.hintText, required this.okClick})
      : super(key: key);

  @override
  _InputMatchNameDialogState createState() => _InputMatchNameDialogState();
}

class _InputMatchNameDialogState extends State<InputMatchNameDialog> {
  TextEditingController _tvName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: 140,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TransactionKey.loadLanguage(context, TransactionKey.name),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                height: 36,
                child: TextField(
                  controller: _tvName,
                  scrollPadding: EdgeInsets.zero,
                  autocorrect: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      // labelText: 'Description',
                      // focusedBorder: InputBorder.none,
                      hintText: widget.hintText),
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      color: Colors.brown,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      TransactionKey.loadLanguage(
                              context, TransactionKey.selectCancel)
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      widget.okClick(_tvName.text);
                      Navigator.pop(context);
                    },
                    child: Text(
                      TransactionKey.loadLanguage(
                              context, TransactionKey.selectOk)
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
