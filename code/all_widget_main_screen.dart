import 'package:flutter/material.dart';
import 'icon_widget.dart'; // Ensure this exports a class named IconWidgetBox
import 'custom_text_widget.dart';
import 'blocks_chart_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Two Cards Layout',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Two Cards Layout'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            icon_widget_box(
                              title: const Text(
                                'Good Morning',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              description: const Text(
                                'Sarah',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  height: 1.5,
                                ),
                              ),
                              icon: const Icon(Icons.sunny, size: 30, color: Colors.yellow),
                              iconPosition: IconPosition.bottomRight,
                              titlePosition: TitlePosition.topLeft,
                              descriptionPosition: DescriptionPosition.bottomLeft,
                              showCard: false,
                              cardWidth: 800,
                              cardHeight: 100,
                            ),
                            Flexible(
                              child: icon_widget_box(
                                icon: const Icon(Icons.star, size: 20, color: Colors.amber),
                                iconPosition: IconPosition.left,
                                titlePosition: TitlePosition.topCenter,
                                title: const Text(
                                  'Today\'s Affirmation',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: "Roboto", height: 1.5, color: Colors.black),
                                ),
                                description: const Text(
                                  '"You are worthy of love, peace, and all the good things life has to offer."',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                                descriptionPosition: DescriptionPosition.bottomRight,
                              ),
                            ),
                            CustomTextWidget(
                              title: const Text(
                                'How are you feeling today?',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              showCard: false,
                            ),
                            const SizedBox(height: 16),
                            icon_widget_box(
                              iconLabelPairs: const [
                                {'icon': Text('😄', style: TextStyle(fontSize: 32)), 'label': Text('Happy')},
                                {'icon': Text('😢', style: TextStyle(fontSize: 32)), 'label': Text('Sad')},
                                {'icon': Text('😠', style: TextStyle(fontSize: 32)), 'label': Text('Angry')},
                                {'icon': Text('😌', style: TextStyle(fontSize: 32)), 'label': Text('Relaxed')},
                              ],
                              description: null,
                              iconPosition: IconPosition.top,
                              titlePosition: TitlePosition.bottomCenter,
                              cardElevation: 4,
                              cardBorderRadius: const BorderRadius.all(Radius.circular(20)),
                              cardPadding: const EdgeInsets.all(8),
                              cardWidth: 800,
                              cardHeight: 94,
                              cardColor: Colors.white,
                            ),
                            CustomTextWidget(
                              title: const Text(
                                'Wellness Tools',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              showCard: false,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 1.1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  icon_widget_box(
                                    titleUnderIcon: true,
                                    title: const Text(
                                      'Journal',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    description: const Text(
                                      'Express your thoughts',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    icon: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE3E3FA),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.book, color: Colors.deepPurple, size: 20),
                                    ),
                                    cardAlignment: Alignment.center,
                                  ),
                                  icon_widget_box(
                                    titleUnderIcon: true,
                                    title: const Text(
                                      'Meditation',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    description: const Text(
                                      'Find inner peace',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    icon: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD8F5E1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.self_improvement,
                                          color: Color(0xFF2AA972), size: 20),
                                    ),
                                    cardAlignment: Alignment.center,
                                  ),
                                  icon_widget_box(
                                    titleUnderIcon: true,
                                    title: const Text(
                                      'Favourites ',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    description: const Text(
                                      'Set a daily reminder ',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    icon: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD8F5E1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.favorite_border,
                                          color: Color(0xFF2AA972), size: 20),
                                    ),
                                    cardAlignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextWidget(
                              title: Text(
                                'Your Progress',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              description: Text(
                                'Track your progress with these cards.',
                                style: TextStyle(fontSize: 14),
                              ),
                              showCard: false,
                            ),
                            SizedBox(height: 28.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: CustomTextWidget(
                                    title: Text(
                                      '7',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    description: Text(
                                      'Days Tracked',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                    titlePosition: TextPosition.center,
                                    showCard: true,
                                    height: 70,
                                    width: 80,
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextWidget(
                                    title: Text(
                                      '4.2',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    description: Text(
                                      'Average Mood',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                    titlePosition: TextPosition.center,
                                    showCard: true,
                                    height: 70,
                                    width: 80,
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextWidget(
                                    title: Text(
                                      '85%',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 18, 110, 26),
                                      ),
                                    ),
                                    description: Text(
                                      'Goals achieved',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                    titlePosition: TextPosition.center,
                                    showCard: true,
                                    height: 70,
                                    width: 85,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 26.0),
                            BlocksChartWidget(
                              data: [10, 25, 35, 45, 55, 40, 30],
                              labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                              backgroundColor: Color.fromARGB(255, 12, 12, 12),
                              cardColor: Colors.white,
                              width: 400,
                              height: 250,
                              barColor: Colors.orange,
                              barColors: [
                                Colors.red,
                                Colors.orange,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue,
                                Colors.indigo,
                                Colors.purple,
                              ],
                              labelColor: Color.fromARGB(255, 10, 10, 10),
                              labelFontSize: 14,
                              maxBarHeight: 150,
                              baseHeight: 50,
                              labelHeight: 25,
                              barWidth: 30,
                              barSpacing: 20,
                              yAxisWidth: 50,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                              titleWidget: Text(
                                'Weekly Mood Chart',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              indexValue: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
