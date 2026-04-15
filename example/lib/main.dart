import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:design_sdk/design_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppDesignStyle _currentStyle = AppDesignStyle.material3;

  void _toggleStyle() {
    setState(() {
      _currentStyle = _currentStyle == AppDesignStyle.material3
          ? AppDesignStyle.apple
          : AppDesignStyle.material3;
      DesignSDK.currentStyle = _currentStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design SDK Example',
      theme: DesignSDK.theme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        toggleStyle: _toggleStyle,
        currentStyleName: _currentStyle.name,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleStyle;
  final String currentStyleName;

  const MyHomePage({
    super.key,
    required this.toggleStyle,
    required this.currentStyleName,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isApple = DesignSDK.currentStyle == AppDesignStyle.apple;

    // Body content changes based on selected tab
    Widget bodyContent;
    if (_currentIndex == 0) {
      bodyContent = ListView.builder(
        itemCount: 20, // 20 ta sun'iy element list (Demo UX)
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isApple 
                ? CupertinoColors.systemGrey5 
                : Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                isApple ? CupertinoIcons.person : Icons.person,
                color: isApple 
                  ? CupertinoColors.activeBlue 
                  : Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text('Ro\'yxat elementi ${index + 1}'),
            subtitle: const Text('UX ni tekshirish uchun qo\'shilgan'),
            trailing: Icon(
              isApple ? CupertinoIcons.right_chevron : Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {},
          );
        },
      );
    } else {
      bodyContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
               isApple ? CupertinoIcons.square_stack_3d_up_slash : Icons.hourglass_empty,
               size: 60,
               color: Colors.grey,
             ),
             const SizedBox(height: 20),
             const Text(
               'Bu sahifa hali bo\'sh',
               style: TextStyle(fontSize: 18, color: Colors.grey),
             ),
             const SizedBox(height: 20),
             DesignButton(
               onPressed: widget.toggleStyle,
               child: const Text("Dizaynni almashtirish"),
             ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hozirgi Stil: ${widget.currentStyleName}'),
        actions: [
          IconButton(
            icon: Icon(isApple ? CupertinoIcons.paintbrush : Icons.palette),
            onPressed: widget.toggleStyle,
            tooltip: "Stilni o'zgartirish",
          ),
        ],
      ),
      body: bodyContent,
      // DOCK / Bottom Navigation Bar
      bottomNavigationBar: isApple
          ? CupertinoTabBar(
              currentIndex: _currentIndex,
              backgroundColor: CupertinoColors.systemGroupedBackground,
              activeColor: CupertinoColors.activeBlue,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: 'Asosiy',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search),
                  label: 'Qidiruv',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: 'Sozlamalar',
                ),
              ],
            )
          : NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Asosiy',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Qidiruv',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Sozlamalar',
                ),
              ],
            ),
      floatingActionButton: isApple 
        ? null 
        : FloatingActionButton(
            onPressed: widget.toggleStyle,
            tooltip: 'Stilni o\'zgartish',
            child: const Icon(Icons.color_lens),
          ),
    );
  }
}
