import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/utils/core.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    required this.text,
    this.textColor,
    this.height,
    this.width,
  });
  final Function()? onPressed;
  final Color? backgroundColor;
  final String text;
  final Color? textColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: textColor ?? AppColors.whiteColor,
              ),
        ),
      ),
    );
  }
}
