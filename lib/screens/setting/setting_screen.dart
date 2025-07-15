import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const _SectionTitle(title: "Account"),
          const _SettingsTile(
            icon: Icons.person_outline,
            title: "Personal Information",
            subtitle: "Manage your personal information",
          ),
          const _SettingsTile(
            icon: Icons.lock_outline,
            title: "Password",
            subtitle: "Change your password",
          ),
          const _SettingsTile(
            icon: Icons.credit_card_outlined,
            title: "Payment Methods",
            subtitle: "Manage your payment methods",
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: "App Preferences"),
          const _SettingsTile(
            icon: Icons.notifications_none,
            title: "Notifications",
            subtitle: "Customize your notification settings",
          ),
          const _SettingsTile(
            icon: Icons.brightness_6_outlined,
            title: "Display",
            subtitle: "Adjust display settings like theme",
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: "Support & Help"),
          const _SettingsTile(
            icon: Icons.help_outline,
            title: "Help Center",
            subtitle: "Access help resources and FAQs",
          ),
          const _SettingsTile(
            icon: Icons.support_agent,
            title: "Contact Support",
            subtitle: "Contact support for assistance",
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      onTap: () {
        // TODO: Sayfa navigasyonları eklenecek
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
