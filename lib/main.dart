import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() => runApp(TestScreen());

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  static const headers = [
    SizedBox(),
    GridHeader('SVG'),
    GridHeader('PNG'),
    GridHeader('SVG - tall'),
    GridHeader('PNG - tall'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemCount: headers.length + BoxFit.values.length * headers.length,
          padding: EdgeInsets.all(50),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: headers.length,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            if (index < headers.length) return headers[index];

            final column = index % headers.length;
            final fit = BoxFit.values[index ~/ headers.length - 1];

            switch (column) {
              case 1:
                return Tile(
                  child: SvgPicture.asset(
                    'images/test_rectangle.svg',
                    fit: fit,
                  ),
                );
              case 2:
                return Tile(
                  child: Image.asset(
                    'images/test_rectangle.png',
                    fit: fit,
                  ),
                );
              case 3:
                return Tile(
                  child: SvgPicture.asset(
                    'images/tall_test_rectangle.svg',
                    height: 200,
                    width: 50,
                    fit: fit,
                  ),
                );
              case 4:
                return Tile(
                  child: Image.asset(
                    'images/tall_test_rectangle.png',
                    height: 200,
                    width: 50,
                    fit: fit,
                  ),
                );
              default:
                return GridHeader(fit.toString());
            }
          },
        ),
      ),
    );
  }
}

class GridHeader extends StatelessWidget {
  const GridHeader(
    this.string, {
    Key? key,
  }) : super(key: key);

  final String string;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(string));
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredBox(
        color: Colors.blue,
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 5,
                maxWidth: 300,
                minHeight: 300,
                maxHeight: 300,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
