import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/women/44.jpg"),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bessie Cooper", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("bessie@mail.com", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfileScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(Icons.notifications, "Notification"),
                _buildProfileOption(Icons.download, "Downloaded Books"),
                _buildProfileOption(Icons.settings, "App Settings"),
                Divider(),
                _buildProfileOption(Icons.article, "Terms & Conditions"),
                _buildProfileOption(Icons.privacy_tip, "Privacy Policy"),
                _buildProfileOption(Icons.help, "Help & Support"),
                _buildProfileOption(Icons.logout, "Sign Out", isLogout: true),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Set active index for profile
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(title, style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
