import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';

// Calculate dominant color from ImageProvider
Future<Color> getImagePalette (ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator = await PaletteGenerator
      .fromImageProvider(imageProvider);
  return paletteGenerator.dominantColor!.color;
}

String getRegionImageUrl(String name) {
  switch (name) {
    case 'Africa':
      return 'images/regions/africa.svg';
    case 'Americas':
      return 'images/regions/america.svg';
    case 'Asia':
      return 'images/regions/asia.svg';
    case 'Europe':
      return 'images/regions/europe.svg';
    case 'Oceania':
      return 'images/regions/oceania.svg';
    default:
      return 'images/regions/world.svg';
  }
}