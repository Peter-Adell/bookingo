import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50, child: Center(child: CircularProgressIndicator())),
        );
      });
}


