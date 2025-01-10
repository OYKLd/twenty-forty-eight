import 'package:flutter/material.dart';

// Dimensions du plateau
const int gridSize = 4;

// Valeurs initiales des tuiles
const List<int> initialTileValues = [2, 4];

// Durée des animations
const Duration animationDuration = Duration(milliseconds: 200);

// Espacement entre les tuiles
const double tileSpacing = 8.0;

// Styles de texte
const TextStyle tileTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle scoreTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

// Couleurs des tuiles en fonction de leur valeur
const Map<int, Color> tileColors = {
  2: Color(0xFFEEE4DA),
  4: Color(0xFFEDE0C8),
  8: Color(0xFFF2B179),
  16: Color(0xFFF59563),
  32: Color(0xFFF67C5F),
  64: Color(0xFFF65E3B),
  128: Color(0xFFEDCF72),
  256: Color(0xFFEDCC61),
  512: Color(0xFFEDC850),
  1024: Color(0xFFEDC53F),
  2048: Color(0xFFEDC22E),
};

// Couleur par défaut pour les tuiles non définies
const Color defaultTileColor = Color(0xFFCDC1B4);

// Couleurs de l'interface utilisateur
const Color gridBackgroundColor = Color(0xFFBBADA0);
const Color emptyTileColor = Color(0xFFCCC0B3);
const Color appBarColor = Color(0xFF8F7A66);
