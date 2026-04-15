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
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder, // EKRANDA TELEFON KORINISHINI BERADI
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

  Widget _buildAppleBody() {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Sozlamalar', style: TextStyle(letterSpacing: -0.5)),
            backgroundColor: Color(0xF2F2F2F7),
            border: null,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CupertinoListSection.insetGrouped(
                backgroundColor: CupertinoColors.systemGroupedBackground,
                children: [
                   CupertinoListTile.notched(
                    title: const Text('Wi-Fi', style: TextStyle(fontWeight: FontWeight.w400)),
                    itemSize: 52,
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(CupertinoIcons.wifi, color: Colors.white, size: 18),
                    ),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('WIKKI', style: TextStyle(color: CupertinoColors.systemGrey)),
                        SizedBox(width: 4),
                        CupertinoListTileChevron(),
                      ]
                    ),
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Bluetooth', style: TextStyle(fontWeight: FontWeight.w400)),
                    itemSize: 52,
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(CupertinoIcons.bluetooth, color: Colors.white, size: 18),
                    ),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Yoniq', style: TextStyle(color: CupertinoColors.systemGrey)),
                        SizedBox(width: 4),
                        CupertinoListTileChevron(),
                      ]
                    ),
                  ),
                   CupertinoListTile.notched(
                    title: const Text('Mobil Ma\'lumotlar', style: TextStyle(fontWeight: FontWeight.w400)),
                    itemSize: 52,
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGreen,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(CupertinoIcons.antenna_radiowaves_left_right, color: Colors.white, size: 18),
                    ),
                    trailing: const CupertinoListTileChevron(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CupertinoListSection.insetGrouped(
                backgroundColor: CupertinoColors.systemGroupedBackground,
                children: [
                   CupertinoListTile.notched(
                    title: const Text('Umumiy', style: TextStyle(fontWeight: FontWeight.w400)),
                    itemSize: 52,
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(CupertinoIcons.settings, color: Colors.white, size: 18),
                    ),
                    trailing: const CupertinoListTileChevron(),
                  ),
                   CupertinoListTile.notched(
                    title: const Text('Displey va Yorqinlik', style: TextStyle(fontWeight: FontWeight.w400)),
                    itemSize: 52,
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(CupertinoIcons.textformat_size, color: Colors.white, size: 18),
                    ),
                    trailing: const CupertinoListTileChevron(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialBody() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Sozlamalar'),
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  'Tarmoq va internet',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.wifi, size: 24, color: Theme.of(context).colorScheme.primary),
                ),
                title: const Text('Wi-Fi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                subtitle: const Text('Ulangan (WIKKI)'),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.bluetooth, size: 24, color: Theme.of(context).colorScheme.primary),
                ),
                title: const Text('Bluetooth', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                onTap: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(left: 72, right: 24, top: 8, bottom: 8),
                child: Divider(height: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  'Qurilma',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.display_settings, size: 24, color: Theme.of(context).colorScheme.primary),
                ),
                title: const Text('Displey', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                subtitle: const Text('Yorqinlik, Fon rasmi'),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.volume_up, size: 24, color: Theme.of(context).colorScheme.primary),
                ),
                title: const Text('Ovoz va tebranish', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                onTap: () {},
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isApple = DesignSDK.currentStyle == AppDesignStyle.apple;

    Widget bodyContent;
    if (_currentIndex == 0) {
      bodyContent = isApple ? _buildAppleBody() : _buildMaterialBody();
    } else {
      bodyContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
               isApple ? CupertinoIcons.square_stack_3d_up_slash : Icons.hourglass_empty,
               size: 80,
               color: isApple ? CupertinoColors.systemGrey2 : Colors.grey.shade400,
             ),
             const SizedBox(height: 24),
             Text(
               'Bu sahifa bo\'sh',
               style: TextStyle(
                 fontSize: 20, 
                 fontWeight: FontWeight.w500,
                 color: isApple ? CupertinoColors.black : Colors.black87,
               ),
             ),
             const SizedBox(height: 12),
             Text(
               'Boshqa menyuni tanlang yoki\ndizaynni almashtiring.',
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: 15,
                 color: isApple ? CupertinoColors.systemGrey : Colors.grey.shade600,
               ),
             ),
             const SizedBox(height: 48),
             DesignButton(
               onPressed: widget.toggleStyle,
               child: const Text("Apple / M3 Almahtirish", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
             ),
          ],
        ),
      );
    }

    if (isApple) {
      return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: Column(
          children: [
            Expanded(child: bodyContent),
            CupertinoTabBar(
              currentIndex: _currentIndex,
              backgroundColor: const Color(0xF0F2F2F7), // Apple iOS tabBar color
              activeColor: CupertinoColors.activeBlue,
              inactiveColor: CupertinoColors.systemGrey,
              border: const Border(top: BorderSide(color: Color(0x33000000), width: 0.5)),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  activeIcon: Icon(CupertinoIcons.settings_solid),
                  label: 'Sozlamalar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search),
                  label: 'Qidiruv',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  activeIcon: Icon(CupertinoIcons.person_solid),
                  label: 'Profil',
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Material 3 Style
    return Scaffold(
      body: bodyContent,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        elevation: 3,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Sozlamalar',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Qidiruv',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.toggleStyle,
        elevation: 4,
        child: const Icon(Icons.format_paint),
      ),
    );
  }
}
