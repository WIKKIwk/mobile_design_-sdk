import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:design_sdk/design_sdk.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppDesignStyle _currentStyle = AppDesignStyle.grainyGradient;

  void _toggleStyle() {
    setState(() {
      if (_currentStyle == AppDesignStyle.apple) {
        _currentStyle = AppDesignStyle.material3;
      } else if (_currentStyle == AppDesignStyle.material3) {
        _currentStyle = AppDesignStyle.grainyGradient;
      } else {
        _currentStyle = AppDesignStyle.apple;
      }
      DesignSDK.currentStyle = _currentStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStyle == AppDesignStyle.apple) {
      return CupertinoApp(
        title: 'Design SDK Pro Demo',
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.activeBlue,
          scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
          barBackgroundColor: Color(0xF2F2F2F7),
        ),
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: MyHomePageApple(toggleStyle: _toggleStyle),
      );
    }

    return MaterialApp(
      title: 'Design SDK Pro Demo',
      theme: DesignSDK.theme,
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: _currentStyle == AppDesignStyle.grainyGradient 
          ? MyHomePageGrainy(toggleStyle: _toggleStyle) 
          : MyHomePageMaterial(toggleStyle: _toggleStyle),
    );
  }
}

class MyHomePageGrainy extends StatefulWidget {
  final VoidCallback toggleStyle;

  const MyHomePageGrainy({super.key, required this.toggleStyle});

  @override
  State<MyHomePageGrainy> createState() => _MyHomePageGrainyState();
}

class _MyHomePageGrainyState extends State<MyHomePageGrainy> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (_currentIndex == 0) {
      bodyContent = CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Ro\'yxatlar (Grainy)', style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [
              IconButton(onPressed: widget.toggleStyle, icon: const Icon(Icons.apple))
            ],
            pinned: true,
            backgroundColor: Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: Colors.white.withOpacity(0.15),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle),
                          child: const Icon(Icons.star, color: Colors.white),
                        ),
                        title: Text('Ro\'yxat elementi ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('UX ni tekshirish uchun', style: TextStyle(color: Colors.white.withOpacity(0.8))),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white.withOpacity(0.6)),
                        onTap: () {},
                      ),
                    ),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      );
    } else {
      bodyContent = SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              leading: const Icon(Icons.format_paint, color: Colors.white),
              title: const Text('Apple (iOS) ga almashtirish', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
              onTap: widget.toggleStyle,
            )
          ],
        ),
      );
    }

    return GrainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: bodyContent,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.list), selectedIcon: Icon(Icons.view_list), label: 'Ro\'yxat'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Sozlamalar'),
          ],
        ),
      ),
    );
  }
}


class MyHomePageApple extends StatefulWidget {
  final VoidCallback toggleStyle;

  const MyHomePageApple({super.key, required this.toggleStyle});

  @override
  State<MyHomePageApple> createState() => _MyHomePageAppleState();
}

class _MyHomePageAppleState extends State<MyHomePageApple> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_dash),
            label: 'Ro\'yxat',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Sozlamalar',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        if (index == 1) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Sozlamalar'),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Hozirgi Stil: Apple (iOS)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  CupertinoButton.filled(
                    onPressed: widget.toggleStyle,
                    child: const Text('Android (M3) ga almashtirish'),
                  ),
                ],
              ),
            ),
          );
        }

        return CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Ro\'yxat (Apple)'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: widget.toggleStyle,
                  child: const Text('M3 Style', style: TextStyle(fontSize: 14)),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 40.0),
                  child: CupertinoListSection.insetGrouped(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    children: List.generate(20, (i) {
                      return CupertinoListTile.notched(
                        title: Text(
                          'Ro\'yxat elementi ${i + 1}',
                          style: const TextStyle(fontWeight: FontWeight.w400, letterSpacing: -0.41),
                        ),
                        subtitle: const Text(
                          'UX ni tekshirish uchun',
                          style: TextStyle(color: CupertinoColors.systemGrey),
                        ),
                        leading: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(6)),
                          child: const Icon(CupertinoIcons.person, color: CupertinoColors.white, size: 18),
                        ),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () {},
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyHomePageMaterial extends StatefulWidget {
  final VoidCallback toggleStyle;

  const MyHomePageMaterial({super.key, required this.toggleStyle});

  @override
  State<MyHomePageMaterial> createState() => _MyHomePageMaterialState();
}

class _MyHomePageMaterialState extends State<MyHomePageMaterial> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (_currentIndex == 0) {
      bodyContent = CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Ro\'yxatlar (M3)'),
            actions: [
              IconButton(onPressed: widget.toggleStyle, icon: const Icon(Icons.star, color: Colors.pink))
            ],
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                  ),
                  title: Text('Ro\'yxat elementi ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text('UX ni tekshirish uchun'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                );
              },
              childCount: 20,
            ),
          ),
        ],
      );
    } else {
      bodyContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hozirgi Stil: Material 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: widget.toggleStyle,
              icon: const Icon(Icons.star),
              label: const Text("Grainy Gradient ga almashtirish"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: bodyContent,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), selectedIcon: Icon(Icons.view_list), label: 'Ro\'yxat'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Sozlamalar'),
        ],
      ),
    );
  }
}
