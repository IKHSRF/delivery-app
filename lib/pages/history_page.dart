import 'package:flutter/material.dart';
import 'package:shop/widgets/empty_item_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: EmptyItemPage(
          screenSize: screenSize,
          pageTitle: 'History',
          imagePath: 'assets/icons/order history.svg',
        ),
      ),
    );
  }
}
