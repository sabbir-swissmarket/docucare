import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Alvis',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/drive-logo.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '2.5GB / 15GB',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'DocuCare',
                style: AppStyles.headline4,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(categories[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, String> category) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/folder.png',
            width: 30,
            height: 30,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 10),
          Text(
            category['title']!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            category['date']!,
            style: const TextStyle(fontSize: 12, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> categories = [
  {'title': 'Personal Documents', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Financial Documents', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Health Documents', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Educational Documents', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Legal Documents', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Professional Documents', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Residential & Vehicle', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Travel & Residence', 'date': '12/10/2024, 5:42 PM'},
  {'title': 'Other', 'date': '12/10/2024, 5:42 PM'},
];
