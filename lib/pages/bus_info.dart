import 'package:flutter/material.dart';
import 'package:tarvel_mate/pages/design_tm.dart';

class BusInfo extends StatefulWidget {
  const BusInfo({super.key});

  @override
  State<BusInfo> createState() => _BusInfoState();
}

class _BusInfoState extends State<BusInfo> {

  final List<Map<String, String>> items = [
    {
      'title': 'Hino RK1J',
      'subtitle': 'Popular Student Bus',
      'description': 'The Hino RK1J is one of the most common buses used for student transportation in Bangladesh. Known for its reliability and durability in Bangladeshi road conditions.',
      'image': 'https://live.staticflickr.com/1625/24952336546_f8730e7aba_b.jpg'
    },
    {
      'title': 'Toyota Coaster',
      'subtitle': 'Premium Student Transport',
      'description': 'The Toyota Coaster is a higher-end option for student transportation, often used by prestigious institutions. Features comfortable seating and better suspension.',
      'image': 'https://media.toyota-gib.com/web/models/coaster/hzb70-zgmss/hzb70-zgmss-g1.webp'
    },
    {
      'title': 'Nissan Civilian',
      'subtitle': 'Mid-range Student Bus',
      'description': 'The Nissan Civilian is another popular choice for school buses in Bangladesh. It offers a balance between affordability and comfort for daily student commutes.',
      'image': 'https://www.nissanbd.com/assets/img/civilian/sx-new.jpg'
    },
    {
      'title': 'Mitsubishi Fuso',
      'subtitle': 'Durable School Bus',
      'description': 'Mitsubishi Fuso buses are widely used for student transportation due to their rugged build quality and ability to handle Bangladesh\'s diverse road conditions.',
      'image': 'https://www.borokomotors.com/wp-content/uploads/2023/05/Mitsubishi-Fuso-FUSO-2022-30-Seater-BUS-Light-Duty-MANUAL-5-SPEED-4.2L-4X2-DIESEL.jpg'
    },
    {
      'title': 'Ashok Leyland',
      'subtitle': 'Economical Choice',
      'description': 'Ashok Leyland buses from India are becoming increasingly popular in Bangladesh as cost-effective options for student transportation with decent comfort levels.',
      'image': 'https://5.imimg.com/data5/UH/MK/DX/SELLER-23845287/ashok-leyland-12m-fe-diesel-bus.png'
    },
    {
      'title': 'TATA Starbus',
      'subtitle': 'Modern School Bus',
      'description': 'The TATA Starbus is a newer model being adopted by some institutions, featuring improved safety features and more comfortable seating arrangements.',
      'image': 'https://buscdn.cardekho.com/in/tata/starbus-city/tata-starbus-city.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppbarTop(),
      // drawer: DrawerD(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomCard(
              title: items[index]['title']!,
              subtitle: items[index]['subtitle']!,
              description: items[index]['description']!,
              imageUrl: items[index]['image']!,
            ),
          );
        },
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        // Handle tap action
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _isPressed ? 0.98 : 1.0,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  widget.imageUrl,
                  height: 150,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error, color: Colors.red),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}