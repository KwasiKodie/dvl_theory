import 'package:flutter/material.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},

        leading: CircleAvatar(
          backgroundColor: Colors.red.withOpacity(0.12),

          child: const Icon(Icons.logout, color: Colors.red),
        ),

        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),

        subtitle: const Text('Logout from your account'),
      ),
    );
  }
}
