
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors/app_colors.dart';

class ProductQuatity extends StatefulWidget {
  final int productQuatity;
  const ProductQuatity({
    super.key,
    required this.productQuatity,
  });

  @override
  State<ProductQuatity> createState() => _ProductQuatityState();
}

class _ProductQuatityState extends State<ProductQuatity> {
  int quatity = 1;
  @override
  void initState() {
    quatity = widget.productQuatity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kLightBlackColor.withOpacity(0.05),
          ),
          splashRadius: 20,
          onPressed: () {
            if (quatity > 1) {
              setState(() {
                quatity--;
              });
            }
          },
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(
          width: 20,
        ),
        MediumText(
          middleTitle: quatity.toString(),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kPrimaryColor.withOpacity(0.1),
          ),
          splashRadius: 20,
          onPressed: () {
            setState(() {
              quatity++;
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
