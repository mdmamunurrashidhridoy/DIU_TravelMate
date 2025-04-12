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
      'title': 'Mountain View',
      'subtitle': 'Swiss Alps',
      'description': 'Beautiful mountain landscape with snow-covered peaks and clear blue sky.',
      'image': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80'
    },
    {
      'title': 'Beach Paradise',
      'subtitle': 'Maldives',
      'description': 'White sandy beach with crystal clear water and palm trees.',
      'image': 'https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80'
    },
    {
      'title': 'City Lights',
      'subtitle': 'New York',
      'description': 'Night view of skyscrapers with colorful lights reflecting on the river.',
      'image': 'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80'
    },
    {
      'title': 'Forest Trail',
      'subtitle': 'Amazon Rainforest',
      'description': 'Mysterious green forest with sunlight filtering through the trees.',
      'image': 'https://images.unsplash.com/photo-1448375240586-882707db888b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80'
    },
    {
      'title': 'Desert Sunset',
      'subtitle': 'Sahara',
      'description': 'Golden sand dunes under a spectacular sunset with dramatic clouds.',
      'image': 'https://images.unsplash.com/photo-1517649763962-0c623066013b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80'
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