import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/utils/core.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onPressed});
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.all(Radius.circular(44)),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 7),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: onPressed,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
