import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

mixin Toast {
  showLoading() {
    BotToast.showCustomLoading(toastBuilder: (callback) {
      return _loading();
    });
  }

  hideLoading() {
    BotToast.closeAllLoading();
  }

  showToast(String text) {
    BotToast.showText(text: text);
  }

  _loading() {
    return Stack(
      children: [
        Center(
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(1.0, 1.0),
                    color: const Color(0xFF7C7C7C).withOpacity(0.17),
                  ),
                ],
              )),
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
