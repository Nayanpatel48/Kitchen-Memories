import 'package:flutter/material.dart';
import 'package:kitchen_memory/views/addRecipe/form_1.dart';
import 'package:kitchen_memory/views/addRecipe/form_2.dart';
import 'package:kitchen_memory/views/addRecipe/form_3.dart';
import 'package:kitchen_memory/views/addRecipe/form_4.dart';
import 'package:kitchen_memory/views/addRecipe/form_5.dart';
import 'package:kitchen_memory/views/addRecipe/form_6.dart';
import 'package:kitchen_memory/views/widgets/step_tab.dart';

class MainForm extends StatelessWidget {
  const MainForm({super.key});

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 6;

    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 25),
            indicatorSize: TabBarIndicatorSize.label,
            tabAlignment: TabAlignment.center,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withValues(),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            indicatorPadding: EdgeInsets.zero,

            tabs: <Widget>[
              StepTab(text: '1'),
              StepTab(text: '2'),
              StepTab(text: '3'),
              StepTab(text: '4'),
              StepTab(text: '5'),
              StepTab(text: '6'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Form1(),
            Form2(),
            Form3(),
            Form4(),
            Form5(),
            Form6(),
          ],
        ),
      ),
    );
  }
}
