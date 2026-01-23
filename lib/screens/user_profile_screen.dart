import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatar-${user.email}',
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.pictureLarge),
                onBackgroundImageError: (_, __) {},
              ),
            ),
            const SizedBox(height: 24),
            Text(
              user.fullName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(user.email),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(user.phone),
              subtitle: const Text('Phone'),
            ),
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: Text(user.cell),
              subtitle: const Text('Mobile'),
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: Text('${user.city}, ${user.country}'),
              subtitle: const Text('Location'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(user.title.isNotEmpty ? user.title : '—'),
              subtitle: const Text('Title'),
            ),
          ],
        ),
      ),
    );
  }
}