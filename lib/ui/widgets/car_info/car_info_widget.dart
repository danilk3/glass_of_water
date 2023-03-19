import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/widgets/car_info/car_info_model.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';
import '../../themes/text_style.dart';

class CarInfoWidget extends StatelessWidget {
  const CarInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CarInfoModel>();
    return Scaffold(
        backgroundColor: AppColors.mainLightGrey,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text(
                'engine hui',
                style: AppTextStyle.inputLabelStyle,
              ),
              const SizedBox(height: 7),
              TextField(
                controller: model.textController,
                decoration: AppTextStyle.inputDecoration,
              ),
            ],
          ),
        ),
    );
  }
}
