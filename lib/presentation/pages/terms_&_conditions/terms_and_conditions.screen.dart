import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/welcome_page/welcome_page.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';


class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool isAcceptChecked = false;

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kScaffoldColor,
       appBar: AppBar(
        title: Text('Termes et Conditions'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
            
          
             const SizedBox(height: 20),
          // const Text(
          //   '''
          // Veuillez lire attentivement ces termes et conditions avant d'utiliser cette application.
          
          // 1. Introduction
          // En accédant à l'application ou en l'utilisant, vous acceptez d'être lié par ces termes et conditions. Si vous n'êtes pas d'accord avec une partie des conditions, vous ne devez pas accéder à l'application.
          
          // 2. Droits de propriété intellectuelle
          // Le contenu de l'application, y compris les textes, images et tout autre matériel, est la propriété ou est sous licence du développeur de l'application.
          
          // 3. Responsabilités de l'utilisateur
          // Vous ne devez pas abuser de l'application ou de son contenu. Cela inclut tout usage illégal ou interdit de l'application.
          
          // 4. Politique de confidentialité
          // Notre politique de confidentialité explique comment nous traitons vos informations personnelles. En utilisant l'application, vous acceptez la collecte et l'utilisation des informations conformément à notre politique de confidentialité.
          
         
          //   ''',
          //   style: TextStyle(fontSize: 17),
          // ),
          

RichText(
  text: const TextSpan(
    style: TextStyle(fontSize: 17, color: Colors.black), // Style par défaut
    children: <TextSpan>[
      TextSpan(
        text: 'Veuillez lire attentivement ces termes et conditions avant d\'utiliser cette application.\n\n',
        style: TextStyle(fontWeight: FontWeight.bold), // Gras pour le titre
      ),
      TextSpan(
        text: '1. Introduction\n',
        style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor), // Titre bleu et gras
      ),
      TextSpan(
        text:
            'En accédant à l\'application ou en l\'utilisant, vous acceptez d\'être lié par ces termes et conditions. '
            'Si vous n\'êtes pas d\'accord avec une partie des conditions, vous ne devez pas accéder à l\'application.\n\n',
        style: TextStyle(color: Colors.black87), // Texte normal
      ),
      TextSpan(
        text: '2. Droits de propriété intellectuelle\n',
        style: TextStyle(fontWeight: FontWeight.bold, color:kPrimaryColor), // Titre bleu et gras
      ),
      TextSpan(
        text:
            'Le contenu de l\'application, y compris les textes, images et tout autre matériel, est la propriété ou est sous licence du développeur de l\'application.\n\n',
        style: TextStyle(color: Colors.black87),
      ),
      TextSpan(
        text: '3. Responsabilités de l\'utilisateur\n',
        style: TextStyle(fontWeight: FontWeight.bold, color:kPrimaryColor),
      ),
      TextSpan(
        text:
            'Vous ne devez pas abuser de l\'application ou de son contenu. Cela inclut tout usage illégal ou interdit de l\'application.\n\n',
        style: TextStyle(color: Colors.black87),
      ),
      TextSpan(
        text: '4. Politique de confidentialité\n',
        style: TextStyle(fontWeight: FontWeight.bold, color:kPrimaryColor),
      ),
      TextSpan(
        text:
            'Notre politique de confidentialité explique comment nous traitons vos informations personnelles. '
            'En utilisant l\'application, vous acceptez la collecte et l\'utilisation des informations conformément à notre politique de confidentialité.\n\n',
        style: TextStyle(color: Colors.black87),
      ),
     
    ],
  ),
),

               Row(
                    children: [
                      Checkbox(
                        value: isAcceptChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isAcceptChecked = value!;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "Veuillez accepter nos termes et conditions",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
  onPressed: isAcceptChecked
      ? () {
          // Rediriger vers la page suivante en utilisant Navigator.push
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SelectedRoleScreen()), // Remplacer par la page cible
          // );

                   Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()), // Remplacer par la page cible
          );
 
        }
      : null, // Désactiver le bouton si la case n'est pas cochée
  child: Text("Accepter et continuer",
   style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
  
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: isAcceptChecked ?   kPrimaryColor : Colors.grey, // Couleur du bouton
  ),
),
  
            ],
          ),
        ),
      ),
    );
  }
}
