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
                  color: Colors.orange,
                  child: SvgPicture.asset(
                    'images/test_rectangle.svg',
                    fit: fit,
                    // height: 25,
                    // width: 25,
                  ),
                );
              case 2:
                return Tile(
                  color: Colors.orange,
                  child: Image.asset(
                    'images/test_rectangle.png',
                    fit: fit,
                    // height: 25,
                    // width: 25,
                  ),
                );
              case 3:
                return Tile(
                  child: SvgPicture.asset(
                    'images/tall_test_rectangle.svg',
                    fit: fit,
                    // height: 25,
                    // width: 25,
                  ),
                );
              case 4:
                return Tile(
                  child: Image.asset(
                    'images/tall_test_rectangle.png',
                    fit: fit,
                    // height: 25,
                    // width: 25,
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

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.child,
    this.color = Colors.blue,
  }) : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredBox(
        color: color,
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 100,
                maxWidth: 100,
                minHeight: 10,
                maxHeight: 100,
              ),
              child: child,
            ),
          ),
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


// @override
//   Widget build(BuildContext context) {
//     late Widget child;
//     if (_picture != null) {
//       final Rect viewport = Offset.zero & _picture!.viewport.size;

//       child = SizedBox(
//         width: widget.width,
//         height: widget.height,
//         child: FittedBox(
//           fit: widget.fit,
//           alignment: widget.alignment,
//           clipBehavior: widget.clipBehavior,
//           child: SizedBox.fromSize(
//             size: viewport.size,
//             child: RawPicture(
//               _picture,
//               matchTextDirection: widget.matchTextDirection,
//               allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
//             ),
//           ),
//         ),
//       );

//       if (widget.pictureProvider.colorFilter == null &&
//           widget.colorFilter != null) {
//         child = UnboundedColorFiltered(
//           colorFilter: widget.colorFilter,
//           child: child,
//         );
//       }
//     } else {
//       child = widget.placeholderBuilder == null
//           ? _getDefaultPlaceholder(context, widget.width, widget.height)
//           : widget.placeholderBuilder!(context);
//     }
//     if (!widget.excludeFromSemantics) {
//       child = Semantics(
//         container: widget.semanticsLabel != null,
//         image: true,
//         label: widget.semanticsLabel == null ? '' : widget.semanticsLabel,
//         child: child,
//       );
//     }
//     return child;
//   }