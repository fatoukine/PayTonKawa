import 'package:flutter/material.dart';

const baseUrl = 'https://615f5fb4f7254d0017068109.mockapi.io/api/v1/products';

const blue = Color.fromARGB(255, 30, 49, 157);
const black = Color.fromARGB(255, 0, 0, 0);
const grey = Color.fromARGB(255, 181, 181, 181);
const white = Color.fromARGB(255, 255, 255, 255);
const lightBlue = Color.fromARGB(255, 60, 235, 255);
const red = Color.fromARGB(255, 255, 87, 87);
const brown = Color.fromARGB(255, 139, 69, 19);

var loading = true;

newSnackBar(BuildContext context, {title}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: blue,
      content: Text(
        title,
      ),
    ),
  );
}