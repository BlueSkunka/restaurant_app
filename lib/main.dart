import 'package:flutter/material.dart';

void main() => runApp(RestaurantApp());

class RestaurantApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Restaurant());
  }
}

class Restaurant extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  // Liste des différentes catégories de plats
  List<Category> categories = [Category.entree, Category.plat, Category.dessert];

  // Remplissage des listes de plats selon leur catégorie
  List<Plate> entres = Plate.values.where((plate) => plate.category == Category.entree).toList();
  List<Plate> plats = Plate.values.where((plate) => plate.category == Category.plat).toList();
  List<Plate> desserts = Plate.values.where((plate) => plate.category == Category.dessert).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gourmet Brasserie'),),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        // Affichage des catégories
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,

          ),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          // Affichage des plats par catégories
          itemBuilder: (BuildContext context, int index) {
            Category category = categories[index];
            return Container(
              color: category.color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 2,
                children: [
                  Text(category.title),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // A définir automatiquement après
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      Plate plat;

                      if (category == Category.entree) {
                        plat = entres[index];
                      } else if (category == Category.plat) {
                        plat = plats[index];
                      } else {
                        plat = desserts[index];
                      }

                      // Carte d'un plat
                      return Card(
                        margin: const EdgeInsets.all(20),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  plat.image,
                                width: 100,
                                height: 100,
                              ),
                              Text(
                                plat.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(plat.description,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.blueGrey
                                ),
                              ),
                              Text(plat.price.toString())
                            ],
                          ),
                        ),
                      );
                  })
                ],
              ),
            );
          }),
        ),
      );
  }
}

enum Category {
  entree(title: 'Entrées', color: Colors.green),
  plat(title: 'Plats', color: Colors.yellow),
  dessert(title: 'Desserts', color: Colors.red);

  const Category({
    required this.title,
    required this.color
});

  final String title;
  final MaterialColor color;
}

enum Plate {
  pouce(title: 'Pouce', image: 'https://static.vecteezy.com/system/resources/thumbnails/009/308/374/small_2x/thumb-up-on-transparent-background-file-png.png', price: 4.50, description: 'Un pouce bien grillé à la graisse humaine', category: Category.entree),
  cartilage(title: 'Pignons de cartilage', image: 'https://cdn.3d4medical.com/complete_anatomy-userdata/video-sticky/61/326c4900eb.webp', price: 5.50, description: 'Des pignons de cartilage de nez, rôti à la broche', category: Category.entree),
  mollet(title: 'Mollet', image: 'https://www.osteopathes.paris/wp-content/uploads/2022/12/Douleur-mollet.png', price: 13.50, description: 'Un bon mollet poêlé accompagné d\'une salade de cheveux blond', category: Category.plat),
  ribs(title: 'Ribs de côtes', image: 'https://lh5.googleusercontent.com/proxy/6ldecagohf34CCDVnPzIwimkSek1MUpC3N7O61sQa-7AwZBqxCnTInkGG9O_GQGkiNub3RsWqEPE8Bbupc6e-KIjKg', price: 14.50, description: 'Des ribs de côtes cuites au grill accompagné d\'une mixture d\'ongle sués', category: Category.plat),
  oreille(title: 'Crème d\'oreille', image: 'https://static.vecteezy.com/system/resources/previews/046/340/292/non_2x/ear-clipart-design-illustration-free-png.png', price: 6.50, description: 'Une crème d\'oreilles caramélisées avec du pain brioché', category: Category.dessert),
  graisse(title: 'Glace à la graisse', image: 'https://www.chirurgie-plastique-france.com/wp-content/uploads/2022/05/liposuccion-ventre-marseille.webp', price: 5.50, description: 'Une glace de graisse, saveurs disponibles: américains, allemands, et français.', category: Category.dessert);


  final String title;
  final String image;
  final double price;
  final String description;
  final Category category;

  const Plate({
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.category
  });

}