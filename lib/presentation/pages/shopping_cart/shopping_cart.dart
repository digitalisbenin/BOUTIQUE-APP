import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_all_users_cart_product_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_bonus_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_bonus.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_shopping.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/singin_page/singin_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/check_out/payment_method/kkiapay_sample.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/shopping_cart/widgets/single_shopping_cart.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/user_orders/order_successfully/order_successfully.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/input_field.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kkiapay_flutter_sdk/src/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ShoppingCartModel> articlesList = [];
  bool isLoading = true;
  String errorMessage = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  // bonus
  TextEditingController bonusUserController = TextEditingController();

  String? transactionId;

  int? userBonus;

  int initialBonus = 0;

  @override
  void initState() {
    super.initState();
    _fetchCartProducts();
    _fetchUserBonus(); 
  }

  Future<void> _fetchCartProducts() async {
    setState(() {
      isLoading = true;
    });
    ApiResponse response = await getAllUsersCartProducts();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['panier'] as List<dynamic>;
      articlesList = myData
          .map<ShoppingCartModel>((json) => ShoppingCartModel.fromJson(json))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = response.error!;
      });
    }
  }

  Future<void> _fetchUserBonus() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse response = await getUserBonus();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      Map<String, dynamic> bonusData = jsonResponse['bonus'] as Map<String, dynamic>;
      BonusModel bonus = BonusModel.fromJson(bonusData);

      setState(() {
        userBonus = bonus.bonus;
        isLoading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = response.error!;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double deliveryFee = 1000.00;
    double subTotalCost = articlesList.fold(
        0,
        (total, item) =>
            total + item.productModel.prixVenteArticle! * item.quantite);
    double total = subTotalCost + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const LargeText(largeTitle: "Panier d'achat"),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_basket_outlined),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    articlesList.length.toString(),
                    textAlign: TextAlign.center,
                    style: AppStyle.titleSmall(context)!
                        .copyWith(color: kWhiteColor),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : articlesList.isEmpty
              ? Center(
                  child: Text(
                    "Votre panier est vide.\nCommencez à ajouter des articles pour les voir ici",
                    textAlign: TextAlign.center,
                    style: AppStyle.titleMedium(context),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchCartProducts,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: articlesList.length,
                          itemBuilder: (context, index) {
                            final item = articlesList[index];
                            return SingleShoppingCartWidget(
                              shoppingCartProduct: item,
                              onQuantityUpdated: _fetchCartProducts,
                            );
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sous total",
                                        style: AppStyle.titleSmall(context)!
                                            .copyWith(
                                          color: kLightBlackColor,
                                        ),
                                      ),
                                      Text(
                                        "${subTotalCost.toStringAsFixed(0)} FCFA",
                                        style: AppStyle.titleMedium(context)!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Livraison",
                                        style: AppStyle.titleSmall(context)!
                                            .copyWith(
                                          color: kLightBlackColor,
                                        ),
                                      ),
                                      Text(
                                        "${deliveryFee.toStringAsFixed(0)} FCFA",
                                        style: AppStyle.titleMedium(context)!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Coût total",
                                        style: AppStyle.titleSmall(context)!
                                            .copyWith(
                                          color: kLightBlackColor,
                                        ),
                                      ),
                                      Text(
                                        "${total.toStringAsFixed(0)} FCFA",
                                        style: AppStyle.titleMedium(context)!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                
                                  const Divider(),
                                  (userBonus != null && userBonus! >= 5000) ?
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: articlesList.isNotEmpty
                                        ? () {
                                          
                                          double newTotalCost;

                                          if (subTotalCost > userBonus!) {
                                            newTotalCost = subTotalCost - userBonus!;
                                          } else {
                                            newTotalCost = subTotalCost + userBonus!;
                                          }

                                            void successCallback(
                                                response, context) {
                                              switch (response['status']) {
                                                case PAYMENT_CANCELLED:
                                                  debugPrint(PAYMENT_CANCELLED);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text(PAYMENT_CANCELLED),
                                                  ));
                                                  break;

                                                case PENDING_PAYMENT:
                                                  debugPrint(PENDING_PAYMENT);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text(PENDING_PAYMENT),
                                                  ));
                                                  break;

                                                case PAYMENT_INIT:
                                                  debugPrint(PAYMENT_INIT);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(PAYMENT_INIT),
                                                  ));
                                                  break;

                                                case PAYMENT_SUCCESS:
                                                  transactionId =
                                                      response['transactionId'];
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderSuccessfully(
                                                        amount: response[
                                                                'requestData']
                                                            ['amount'],
                                                        transactionId:
                                                            transactionId
                                                                .toString(),
                                                        userAdresse:
                                                            _addressController
                                                                .text
                                                                .toString(),
                                                        userPhone:
                                                            _contactController
                                                                .text
                                                                .toString(),
                                                                userBonus: userBonus.toString(),
                                                      ),
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text(PAYMENT_SUCCESS),
                                                  ));
                                                  break;

                                                case PAYMENT_FAILED:
                                                  debugPrint(PAYMENT_FAILED);
                                                  break;

                                                default:
                                                  break;
                                              }
                                            }

                                            Future<bool>
                                                openKkiapayPayment() async {
                                              // Créez une instance KKiaPay avec le montant actuel
                                              final kkiapay = KKiaPay(
                                                  amount: newTotalCost.toInt(),
                                                  countries: const ["BJ"],
                                                  phone: _contactController.text
                                                      .trim()
                                                      .toString(),
                                                  name: "",
                                                  email: "",
                                                  reason: 'transaction reason',
                                                  data: 'Fake data',
                                                  sandbox: false,
                                                  apikey:
                                                      '943b0af31e7672babe8b44e740cccf63dd66532b',
                                                  callback: successCallback,
                                                  theme: defaultTheme,
                                                  paymentMethods: const [
                                                    "momo",
                                                    "card"
                                                  ]);

                                              // Ouvrez l'écran Kkiapay
                                              final success =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        KkiapaySample(
                                                            kkiapay: kkiapay)),
                                              );

                                              return success ?? false;
                                            }

                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              30)),
                                                ),
                                                builder:
                                                    (BuildContext context) {
                                                  return DraggableScrollableSheet(
                                                    expand: false,
                                                    initialChildSize: 0.53,
                                                    maxChildSize: 0.9,
                                                    minChildSize: 0.32,
                                                    builder: (context,
                                                            scrollController) =>
                                                        SingleChildScrollView(
                                                      controller:
                                                          scrollController,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          SizedBox(
                                                            height: SizeConfigs
                                                                    .screenHeight! *
                                                                0.02,
                                                          ),
                                                          const Center(
                                                            child: LargeText(
                                                                largeTitle:
                                                                    "Informations de livraison"),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfigs
                                                                    .screenHeight! *
                                                                0.03,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Form(
                                                              key: _formKey,
                                                              child: Column(
                                                                children: [
                                                                  InputField(
                                                                      bgColor:
                                                                          kWhiteColor,
                                                                      label:
                                                                          "Adresse",
                                                                      controller:
                                                                          _addressController),
                                                                  SizedBox(
                                                                    height: SizeConfigs
                                                                            .screenHeight! *
                                                                        0.02,
                                                                  ),
                                                                  InputField(
                                                                      bgColor:
                                                                          kWhiteColor,
                                                                      label:
                                                                          "Téléphone",
                                                                      controller:
                                                                          _contactController),
                                                                  SizedBox(
                                                                    height: SizeConfigs
                                                                            .screenHeight! *
                                                                        0.03,
                                                                  ),
                                                                  PrimaryButton(
                                                                      buttonTitle:
                                                                          "Commander Maintenant",
                                                                      onPressed:
                                                                          () async {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          _formKey
                                                                              .currentState!
                                                                              .save();

                                                                          await openKkiapayPayment();
                                                                        } else if (_addressController.text.isEmpty ||
                                                                            _contactController.text.isEmpty) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Tout les champs sont obligtoires'),
                                                                          ));
                                                                        }
                                                                      })
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        : null,
                                          child: const Text(
                                            "Utiliser le bonus",
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontFamily: "PoppinsSemiBold",
                                                fontWeight: FontWeight.w600),
                                          )),
                                      Text(
                                        "$userBonus FCFA",
                                        style: AppStyle.titleMedium(context)!
                                            .copyWith(),
                                      ),
                                    ],
                                  ) : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  PrimaryButton(
                                    buttonTitle: "Passer la commande",
                                    onPressed: articlesList.isNotEmpty
                                        ? () {
                                            void successCallback(
                                                response, context) {
                                              switch (response['status']) {
                                                case PAYMENT_CANCELLED:
                                                  debugPrint(PAYMENT_CANCELLED);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text(PAYMENT_CANCELLED),
                                                  ));
                                                  break;

                                                case PENDING_PAYMENT:
                                                  debugPrint(PENDING_PAYMENT);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text(PENDING_PAYMENT),
                                                  ));
                                                  break;

                                                case PAYMENT_INIT:
                                                  debugPrint(PAYMENT_INIT);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(PAYMENT_INIT),
                                                  ));
                                                  break;

                                                case PAYMENT_SUCCESS:
                                                  transactionId =
                                                      response['transactionId'];
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderSuccessfully(
                                                        amount: response[
                                                                'requestData']
                                                            ['amount'],
                                                        transactionId:
                                                            transactionId
                                                                .toString(),
                                                        userAdresse:
                                                            _addressController
                                                                .text
                                                                .toString(),
                                                        userPhone:
                                                            _contactController
                                                                .text
                                                                .toString(),
                                                                userBonus: initialBonus.toString(),
                                                      ),
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content:
                                                        Text(PAYMENT_SUCCESS),
                                                  ));
                                                  break;

                                                case PAYMENT_FAILED:
                                                  debugPrint(PAYMENT_FAILED);
                                                  break;

                                                default:
                                                  break;
                                              }
                                            }

                                            Future<bool>
                                                openKkiapayPayment() async {
                                              // Créez une instance KKiaPay avec le montant actuel
                                              final kkiapay = KKiaPay(
                                                  amount: subTotalCost.toInt(),
                                                  countries: const ["BJ"],
                                                  phone: _contactController.text
                                                      .trim()
                                                      .toString(),
                                                  name: "",
                                                  email: "",
                                                  reason: 'transaction reason',
                                                  data: 'Fake data',
                                                  sandbox: false,
                                                  apikey:
                                                      '943b0af31e7672babe8b44e740cccf63dd66532b',
                                                  callback: successCallback,
                                                  theme: defaultTheme,
                                                  paymentMethods: const [
                                                    "momo",
                                                    "card"
                                                  ]);

                                              // Ouvrez l'écran Kkiapay
                                              final success =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        KkiapaySample(
                                                            kkiapay: kkiapay)),
                                              );

                                              return success ?? false;
                                            }

                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              30)),
                                                ),
                                                builder:
                                                    (BuildContext context) {
                                                  return DraggableScrollableSheet(
                                                    expand: false,
                                                    initialChildSize: 0.53,
                                                    maxChildSize: 0.9,
                                                    minChildSize: 0.32,
                                                    builder: (context,
                                                            scrollController) =>
                                                        SingleChildScrollView(
                                                      controller:
                                                          scrollController,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          SizedBox(
                                                            height: SizeConfigs
                                                                    .screenHeight! *
                                                                0.02,
                                                          ),
                                                          const Center(
                                                            child: LargeText(
                                                                largeTitle:
                                                                    "Informations de livraison"),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfigs
                                                                    .screenHeight! *
                                                                0.03,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Form(
                                                              key: _formKey,
                                                              child: Column(
                                                                children: [
                                                                  InputField(
                                                                      bgColor:
                                                                          kWhiteColor,
                                                                      label:
                                                                          "Adresse",
                                                                      controller:
                                                                          _addressController),
                                                                  SizedBox(
                                                                    height: SizeConfigs
                                                                            .screenHeight! *
                                                                        0.02,
                                                                  ),
                                                                  InputField(
                                                                      bgColor:
                                                                          kWhiteColor,
                                                                      label:
                                                                          "Téléphone",
                                                                      controller:
                                                                          _contactController),
                                                                  SizedBox(
                                                                    height: SizeConfigs
                                                                            .screenHeight! *
                                                                        0.03,
                                                                  ),
                                                                  PrimaryButton(
                                                                      buttonTitle:
                                                                          "Commander Maintenant",
                                                                      onPressed:
                                                                          () async {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          _formKey
                                                                              .currentState!
                                                                              .save();
                                                                              showDialog(
  context: context,
  builder: (context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: SizeConfigs.screenHeight! * 0.33,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                right: 5,
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Votre commande est bien reçue et est en cours de traitement',
                        ),
                      ),
                    );
                                           Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderSuccessfully(
                                                        
                                                        transactionId:
                                                            transactionId
                                                                .toString(),
                                                        userAdresse:
                                                            _addressController
                                                                .text
                                                                .toString(),
                                                        userPhone:
                                                            _contactController
                                                                .text
                                                                .toString(),
                                                                userBonus: initialBonus.toString(),
                                                      ),
                                                    ),
                                                  );
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("MTN"),
                          Row(
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: "*880*41*456789*Montant#"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Le code a été copié dans le presse-papier',
                                      ),
                                    ),
                                  );
                                },
                                child: SelectableText(
                                  "*880*41*456789*Montant#",
                                  style: TextStyle(
                                    fontSize: SizeConfigs.screenHeight! * 0.02,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: "*880*41*456789*Montant#"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Le code a été copié dans le presse-papier'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          const Text("MOOV"),
                          Row(
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: "*880*41*456789*Montant#"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Le code a été copié dans le presse-papier',
                                      ),
                                    ),
                                  );
                                },
                                child: SelectableText(
                                  "*880*41*456789*Montant#",
                                  style: TextStyle(
                                    fontSize: SizeConfigs.screenHeight! * 0.02,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: "*880*41*456789*Montant#"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Le code a été copié dans le presse-papier'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          const Text("CELTIIS"),
                          Row(
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: "*880*41*456789*Montant#"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Le code a été copié dans le presse-papier',
                                      ),
                                    ),
                                  );
                                },
                                child: SelectableText(
                                  "*880*41*456789*Montant#",
                                  style: TextStyle(
                                    fontSize: SizeConfigs.screenHeight !* 0.02,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: "*880*41*456789*Montant#"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Le code a été copié dans le presse-papier'),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);


                                                                          // await openKkiapayPayment();
                                                    
                                                                        } else if (_addressController.text.isEmpty ||
                                                                            _contactController.text.isEmpty) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Tout les champs sont obligtoires'),
                                                                          ));
                                                                        }
                                                                      })
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
    );
  }
}
