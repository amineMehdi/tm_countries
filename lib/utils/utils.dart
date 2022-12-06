import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';

// Calculate dominant color from ImageProvider
Future<Color> getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
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

String parsePopulation(int population) {
  if (population < 1000) {
    return population.toString();
  } else if (population < 1000000) {
    return "${(population / 1000).toStringAsFixed(1)}K";
  } else if (population < 1000000000) {
    return "${(population / 1000000).toStringAsFixed(1)}M";
  } else {
    return "${(population / 1000000000).toStringAsFixed(1)}B";
  }
}

String parseArea(double area) {
  return "${(area / 1000).toStringAsFixed(1)} km²";
}