import 'package:flutter/cupertino.dart';

class UpperDiagonalClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.lineTo(0, size.height / 1.7);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);
    // path.close();
    path.lineTo(0, size.height / 1.75);
    path.lineTo(size.width / 1.5, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LowerDiagonalClipPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width - (size.width / 1.5), size.height);
    path.lineTo(0, size.height-(size.height/4.75));
    //path.lineTo(size.width, (size.height / 4.75));
    path.close();
    // path.moveTo(0, (size.height / 1.75) + 20);
    // path.lineTo(0, (size.height));
    // path.lineTo(size.width / 1.5 - 20, (size.height));
    // path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class UpperDiagonalClipPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 1.5, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, (size.height / 4.75));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LowerDiagonalClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - (size.height / 1.75));
    path.lineTo(size.width - (size.width / 1.5), 0);
    // path.lineTo(size.width/1.5-20, 0);
    // path.lineTo(size.width, size.height/1.75);
    // path.lineTo(size.width,size.height);
    // path.lineTo(0,size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
