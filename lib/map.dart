import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_project/bottom_nav_bar.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late MapOptions options;

  @override
  void initState() {
    super.initState();
    options = MapOptions(
      center: LatLng(33.8869, 9.5375), // Update to Tunisia's coordinates
      zoom: 7.0, // Adjust the zoom level as desired
    );
  }

  int _selectedIndex = 0;
  List<BottomNavItem> navItems = [
    BottomNavItem(
      icon: Icons.person,
      label: 'Account',
      route: '/user',
    ),
    BottomNavItem(
      icon: Icons.home,
      label: 'Home',
      route: '/dashboard',
    ),
    BottomNavItem(
      icon: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
    BottomNavItem(
      icon: Icons.notifications,
      label: 'Notification',
      route: '/notification',
    ),
  ];

  void _onItemTapped(int index, BuildContext context) {
    // Add BuildContext parameter
    switch (navItems[index].route) {
      case '/dashboard':
        Navigator.pushNamed(context, 'dashboard');
        break;
      case '/user':
        Navigator.pushNamed(context, 'user');
        break;
      case '/settings':
        Navigator.pushNamed(context, 'settings');
        break;
      case '/notification':
        Navigator.pushNamed(context, 'notification');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 1,
        title: Text('Tunisie Telecom Locations'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(36.8061, 10.1692), // Update to Tunis coordinates
          zoom: 11.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/amenmelki/clhwk0ytx028w01pgb43pa8i1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW1lbm1lbGtpIiwiYSI6ImNsZWgzeXVjdjBjcnozeW14c3BjNW42MGsifQ.Z9Isfs8sjZR5rj4ZKvKVdQ',
            additionalOptions: {
              'access token':
                  'pk.eyJ1IjoiYW1lbm1lbGtpIiwiYSI6ImNsZWgzeXVjdjBjcnozeW14c3BjNW42MGsifQ.Z9Isfs8sjZR5rj4ZKvKVdQ',
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.86721972847452, 10.154509386556413),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.green,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.84144362231133, 10.181643977247337),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.green,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.84348038933258, 10.110624691697785),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.844469675662694, 10.24042449339232),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.8167648208775, 10.161308423788032),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.814290685263906, 10.18232362977667),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.8553509805326, 10.162544612375598),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.80614563825613, 10.085998978246067),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(36.80851650393715, 10.101319756083623),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  size: 50.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        iconSize: 30,
        selectedItemColor: Colors.black38,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          _onItemTapped(index, context);
        },
        items: navItems
            .map(
              (navItem) => BottomNavigationBarItem(
                icon: Icon(navItem.icon),
                label: navItem.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
