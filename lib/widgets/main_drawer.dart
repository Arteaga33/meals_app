import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: tapHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          _buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              //Navigator.of(context).pushNamed('/');
              Navigator.of(context).pushReplacementNamed('/');//To avoid stacking too many pages.
            },
          ),
          _buildListTile(
            'Settings',
            Icons.settings,
            () {
              // Navigator.of(context).pushNamed('/filters');
              Navigator.of(context).pushReplacementNamed('/filters');//USeful for auth.
            },
          ),
        ],
      ),
    );
  }
}
