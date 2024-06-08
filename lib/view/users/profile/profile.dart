import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/view/users/profile/involve.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = context.watch<AuthViewModel>().userCurrentModel;
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add your log out logic here
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              margin: const EdgeInsets.only(
                top: 40,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  ),
                ],
                image: DecorationImage(
                  image:
                      AssetImage(user.avatarUrl ?? 'assets/images/avatar.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              user.fullname ?? '',
              style: const TextStyle(
                fontFamily: "Montserrat",
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              user.roles!.join(", "),
              style: const TextStyle(
                fontFamily: "Montserrat",
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "PROFILE",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    listProfile(Icons.person, "Full Name", user.fullname ?? ''),
                    listProfile(Icons.email, "Email", user.email ?? ''),
                    listProfile(
                        Icons.badge,
                        "Account Type",
                        user.pro != null && user.pro == true
                            ? 'Pro'
                            : 'Regular'), // Check user.pro != null before using/ Kiểm tra user.pro != null trước khi sử dụng
                    const SizedBox(height: 20),
                    if (user.pro != null &&
                        user.pro ==
                            false) // Kiểm tra user.pro != null trước khi sử dụng
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/bill');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => bill()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFF416FDF), // Set the button color to blue
                        ),
                        child: Text(
                          'Upgrade to Premium',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        authViewModel.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Set the button color to red
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listProfile(IconData icon, String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
