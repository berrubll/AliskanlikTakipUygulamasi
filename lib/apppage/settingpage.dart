import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Geri navigasyon
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Genel"),
          const SizedBox(height: 8),
          _buildGeneralSettings(context),
          const SizedBox(height: 16),
          _buildSectionTitle("Hakkımızda"),
          const SizedBox(height: 8),
          _buildAboutUsSettings(context),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bölüm Başlığı
  // ---------------------------------------------------------------------------
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Genel Ayarlar Bölümü
  // ---------------------------------------------------------------------------
  Widget _buildGeneralSettings(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          title: "Genel",
          leadingIcon: Icons.chat_bubble_outline,
          trailingWidget: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildSwitchTile(
          title: "Koyu Mod",
          leadingIcon: Icons.dark_mode_outlined,
          value: false,
          onChanged: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildListTile(
          title: "Güvenlik",
          leadingIcon: Icons.lock_outline,
          trailingWidget: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildListTile(
          title: "Bildirim Ayarları",
          leadingIcon: Icons.notifications_outlined,
          trailingWidget: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildSwitchTile(
          title: "Ses Ayarları",
          leadingIcon: Icons.volume_up_outlined,
          value: true,
          onChanged: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildSwitchTile(
          title: "Dinlenme Modu",
          leadingIcon: Icons.beach_access_outlined,
          value: false,
          onChanged: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Hakkımızda Bölümü
  // ---------------------------------------------------------------------------
  Widget _buildAboutUsSettings(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          title: "Bizi Puanla",
          leadingIcon: Icons.star_outline,
          trailingWidget: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildListTile(
          title: "Arkadaşlarınla Paylaş",
          leadingIcon: Icons.share_outlined,
          trailingWidget: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildListTile(
          title: "Hakkımızda",
          leadingIcon: Icons.info_outline,
          trailingWidget: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
        _buildListTile(
          title: "Destek",
          leadingIcon: Icons.support_agent_outlined,
          trailingWidget: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Yakında Eklenicek")));
          },
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // ListTile Yardımcı Widget'ı
  // ---------------------------------------------------------------------------
  Widget _buildListTile({
    required String title,
    required IconData leadingIcon,
    required Widget trailingWidget,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(title),
        trailing: trailingWidget,
        onTap: onTap,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SwitchTile Yardımcı Widget'ı
  // ---------------------------------------------------------------------------
  Widget _buildSwitchTile({
    required String title,
    required IconData leadingIcon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(title),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
