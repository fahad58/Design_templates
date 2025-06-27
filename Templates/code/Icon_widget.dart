// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

enum IconPosition { top, left, right }

class icon_widget_box extends StatelessWidget {
  final Widget title;
  final Widget? description;
  final Widget? icon;
  final IconPosition iconPosition;
  final Widget? button;

  final double? cardWidth;
  final EdgeInsetsGeometry? cardMargin;
  final AlignmentGeometry? cardAlignment;

  const icon_widget_box({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.iconPosition = IconPosition.top,
    this.button,
    this.cardWidth,
    this.cardMargin,
    this.cardAlignment,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        if (description != null) ...[
          const SizedBox(height: 8),
          description!,
        ],
        if (button != null) ...[
          const SizedBox(height: 20),
          button!,
        ],
      ],
    );

    Widget cardChild;
    if (icon != null) {
      switch (iconPosition) {
        case IconPosition.left:
          cardChild = Row(
            children: [
              icon!,
              const SizedBox(width: 16),
              Expanded(child: content),
            ],
          );
          break;
        case IconPosition.right:
          cardChild = Row(
            children: [
              Expanded(child: content),
              const SizedBox(width: 16),
              icon!,
            ],
          );
          break;
        case IconPosition.top:
          cardChild = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon!,
              const SizedBox(height: 16),
              content,
            ],
          );
      }
    } else {
      cardChild = content;
    }

    return Align(
      alignment: cardAlignment ?? Alignment.center,
      child: Container(
        margin: cardMargin ?? const EdgeInsets.all(16),
        width: cardWidth ?? 400,
        child: cardChild,
      ),
    );
  }
}
.............................................................................
  $$$$$ DUMMY DATA MAIN.DART WHICH YOU CAN COUSTOMIZE ACCORDING TO YOU $$$$$
//  import 'package:flutter/material.dart';
// import 'icon_widget.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Wellness Card Demo',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: const Color(0xFFF8F9FA),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   width: 350,
//                   margin: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(24),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(30),
//                   child: icon_widget_box(
//                     title: const Text(
//                       'Wellness Tool',
//                       style: TextStyle(
//                         fontFamily: "Italic",
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//                     description: const Text(
//                       'Your personalized wellness companion',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black54,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                     icon: Container(
//                       width: 70,
//                       height: 70,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: const LinearGradient(
//                           colors: [Colors.pinkAccent, Colors.redAccent],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 12,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.favorite,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                     ),
//                     button: ElevatedButton(
//                       onPressed: () {
//                         print('Get Started pressed');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       ),
//                       child: const Text('Get Started'),
//                     ),
//                     cardAlignment: Alignment.center,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
