import 'package:flutter/material.dart';

/// Instagram editörü ortak sabitler. Sadece UI/stil; state yok.
class InstagramEditorUtils {
  InstagramEditorUtils._();

  /// Instagram Estetik seçili kart gradienti (mor → pembe → turuncu)
  static const LinearGradient instagramGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF6366F1), Color(0xFFD946EF), Color(0xFFF97316)],
  );

  static const Color instagramAccent = Color(0xFF6366F1);
}
