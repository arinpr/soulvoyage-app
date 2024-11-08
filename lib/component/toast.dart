import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showCustomToast({
  // required BuildContext context,
  required String title,
  required ToastificationType type,
}) {
  // final size = MediaQuery.of(context).size;

  toastification.show(
    type: type,
    style: ToastificationStyle.flatColored,
    alignment: Alignment.topCenter,
    margin:const EdgeInsets.symmetric(
      horizontal: 45,
      vertical: 50,
    ),
    showProgressBar: true,
    showIcon: true,
   
    title: Text(title),
    autoCloseDuration: const Duration(seconds: 3),
  );
}
