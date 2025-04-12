import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart'; // Using icons_plus

class ContactUsSimplePage extends StatelessWidget {
  const ContactUsSimplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- !! REPLACE WITH YOUR ACTUAL CONTACT DETAILS !! ---
    const String contactEmail = "support@travelmateapp.com";
    const String contactPhone = "+8801712345678"; // Example BD Number format
    const String contactAddress = "123 App Street, Ashulia, Dhaka, Bangladesh";
    const String contactWebsite = "www.travelmateapp.com";
    // -------------------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        elevation: 1,
      ),
      body: ListView( // Use ListView for potential scrolling
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // --- Email ---
          _buildContactTile(
            context: context,
            icon: Iconsax.direct_right_outline, // Or Icons.email_outlined
            title: 'Email', // Simplified title
            subtitle: contactEmail,
          ),
          const Divider(), // Separator

          // --- Phone ---
          _buildContactTile(
            context: context,
            icon: Iconsax.call_outline, // Or Icons.phone_outlined
            title: 'Phone', // Simplified title
            subtitle: contactPhone,
          ),
          const Divider(),

          // --- Address ---
          _buildContactTile(
            context: context,
            icon: Iconsax.location_outline, // Or Icons.location_on_outlined
            title: 'Office Address', // Simplified title
            subtitle: contactAddress,
          ),
          const Divider(),

          // --- Website ---
          _buildContactTile(
            context: context,
            icon: Iconsax.global_outline, // Or Icons.language_outlined
            title: 'Website', // Simplified title
            subtitle: contactWebsite,
          ),

          // You can add more simple text sections if needed
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "For support, please reach out via email or phone during business hours.",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  // Helper widget for consistent contact list tiles (without onTap)
  Widget _buildContactTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      // No onTap property here - the tile is not tappable
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    );
  }
}