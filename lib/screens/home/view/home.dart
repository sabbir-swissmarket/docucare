import 'dart:async';

import 'package:docucare/custom_widgets/loader.dart';
import 'package:docucare/screens/home/models/folder_model.dart';
import 'package:docucare/screens/home/provider/home_provider.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeNotifierProvider.notifier).loadData(ref);
      startTimer(ref);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Future<void> startTimer(WidgetRef ref) async {
    _timer = Timer.periodic(const Duration(hours: 1), (timer) async {
      await ref.read(homeNotifierProvider.notifier).getAccessToken(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(userNameProvider);
    final folderList = ref.watch(folderListProvider);
    final storageQuota = ref.watch(storageQuotaProvder);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          HomeState state = ref.watch(homeNotifierProvider);
          if (state is InitHomeState) {
            return const SizedBox.shrink();
          } else if (state is LoadingHomeState) {
            return const Center(child: Loader());
          } else if (state is LoadedHomeState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, $userName',
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
                            storageQuota,
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: folderList.length,
                      itemBuilder: (context, index) {
                        return _buildCategoryCard(folderList[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ErrorHomeState) {
            ref.read(homeNotifierProvider.notifier).showError(state.message);
          }
          return const SizedBox.shrink();
        },
      )),
    );
  }

  Widget _buildCategoryCard(FolderModel category) {
    final notifier = ref.read(homeNotifierProvider.notifier);
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
            category.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            notifier.getDateTime(category.createdTime),
            style: const TextStyle(fontSize: 12, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}

// final List<Map<String, String>> categories = [
//   {'title': 'Personal Documents', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Financial Documents', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Health Documents', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Educational Documents', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Legal Documents', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Professional Documents', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Residential & Vehicle', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Travel & Residence', 'date': '12/10/2024, 5:42 PM'},
//   {'title': 'Other', 'date': '12/10/2024, 5:42 PM'},
// ];
