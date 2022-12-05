import 'package:flutter/material.dart';

class CategoryIconModel {
  final String name;
  final String assetIcon;
  final Color color;

  CategoryIconModel(
      {required this.assetIcon, required this.name, required this.color});

  static List<CategoryIconModel> categoriesIcon = [
    CategoryIconModel(
        assetIcon: 'assets/icons/food.svg',
        name: 'Foods',
        color: const Color(0xffffd700)),
    CategoryIconModel(
        assetIcon: 'assets/icons/gadget.svg',
        name: 'Gadget',
        color: const Color(0xff3d6cb9)),
    CategoryIconModel(
        assetIcon: 'assets/icons/gift.svg',
        name: 'Gift',
        color: const Color(0xff05f649)),
    CategoryIconModel(
        assetIcon: 'assets/icons/car.svg',
        name: 'Car',
        color: const Color(0xfffa1515)),
    CategoryIconModel(
        assetIcon: 'assets/icons/house.svg',
        name: 'House',
        color: const Color(0xfff706fc)),
    CategoryIconModel(
        assetIcon: 'assets/icons/gift.svg',
        name: 'Souvenir',
        color: const Color(0xff05f649)),
    CategoryIconModel(
        assetIcon: 'assets/icons/gadget.svg',
        name: 'Tablet',
        color: const Color(0xff3d6cb9)),
    CategoryIconModel(
        assetIcon: 'assets/icons/food.svg',
        name: 'Drinks',
        color: const Color(0xffffd700)),
  ];
}
