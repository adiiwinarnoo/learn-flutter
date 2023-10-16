import 'package:flutter/material.dart';

class HomePagge extends StatefulWidget {
  const HomePagge({super.key});

  @override
  State<HomePagge> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePagge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressBar = isLoading
        ? const Align(
            alignment: Alignment.center,
            child: LinearProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
            ),
          )
        : SizedBox.shrink();

    Widget gridView = !isLoading
        ? Expanded( 
         child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(10, (index) {
              return Center(
                child: Text(
                  "item $index",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            }),
          ),
        )
        : SizedBox.shrink();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [progressBar,gridView],
          ),
        ),
      ),
    );
  }
}
