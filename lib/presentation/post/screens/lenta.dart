import 'package:flutter/material.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/presentation/post/screens/clubs.dart';
import 'package:xylo/presentation/post/screens/events.dart';
import 'package:xylo/presentation/post/screens/recommendation.dart';

class Lenta extends StatefulWidget {
  const Lenta({super.key});

  @override
  State<Lenta> createState() => _LentaState();
}

class _LentaState extends State<Lenta> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        bottom: TabBar(
          overlayColor: WidgetStateColor.transparent,
          controller: _tabController,
          indicatorColor: Colors.white,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Recommendation"),
            Tab(text: "Clubs"),
            Tab(text: "Events"),
          ],
        ),
      ),
      body: Padding(
        padding: padding,
        child: TabBarView(
          controller: _tabController,
          children: const [
            Recommendation(),
            Clubs(),
            Events(),
          ],
        ),
      ),
    );
  }
}
