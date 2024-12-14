part of 'pages.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  // Pages for the bottom navigation
  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    // Wrap ShippingCalculatorPage with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (_) => ShippingViewModel(),
      child: const ShippingCalculatorPage(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBack(
        child: _pages[_selectedIndex],
        waitForSecondBackPress: 4,
        onFirstBackPress: () {
          return Fluttertoast.showToast(
            msg: "Press back again to close the app!",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.blueGrey,
            textColor: Colors.white,
            fontSize: 14,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Cost Info',
          ),
        ],
      ),
    );
  }
}
