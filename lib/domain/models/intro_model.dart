class IntroModel {
  final String introImage;
  final String introTitle;
  final String introDecription;
  IntroModel({
    required this.introImage,
    required this.introTitle,
    required this.introDecription,
  });
}

final List<IntroModel> introPageList = [
  IntroModel(
    introTitle: "Définir votre position",
    introDecription:
        "Autorisez l'application à accéder à votre position actuelle et choisissez ce que vous voulez dans la boutique",
    introImage: "assets/icons/undraw_my_location_re_r52x.svg",
  ),
  IntroModel(
    introTitle: "Passez votre commande",
    introDecription:
        "Mettez tout ce que vous voulez dans le panier et confirmez votre commande avec succès",
    introImage: "assets/icons/undraw_reminder_re_fe15.svg",
  ),
  IntroModel(
    introTitle: "Recevez votre commande",
    introDecription:
        "Toutes nos félicitations! Votre commande sera à votre porte aussi vite que possible",
    introImage: "assets/icons/undraw_order_delivered_re_v4ab.svg",
  ),
];
