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
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          scrollDirection: Axis.horizontal,
          // Affichage des plats par catégories
          children: List.generate(categories.length, (index) {
            Category category = categories[index];
            return Container(
              color: category.color,
              width: 50,
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

                      if (category == Category.plat) {
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
                              Text(plat.image),
                              Text(plat.title),
                              Text(plat.description),
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
      )
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
  pouce(title: 'Pouce', image: 'pouce.png', price: 4.50, description: 'Un pouce bien grillé à la graisse humaine', category: Category.entree),
  cartilage(title: 'Pignons de cartilage', image: 'cartilage.png', price: 5.50, description: 'Des pignons de cartilage de nez, rôti à la broche', category: Category.entree),
  mollet(title: 'Mollet', image: 'mollet.png', price: 13.50, description: 'Un bon mollet poêlé accompagné d\'une salade de cheveux blond', category: Category.plat),
  ribs(title: 'Ribs', image: 'ribs.png', price: 14.50, description: 'Des ribs de côtes cuites au grill accompagné d\'une mixture d\'ongle sués', category: Category.plat),
  oreille(title: 'Crème d\'oreille', image: 'oreille.png', price: 6.50, description: 'Une crème d\'oreilles caramélisées avec du pain brioché', category: Category.dessert),
  graisse(title: 'Glace à la graisse', image: 'graisse.png', price: 5.50, description: 'Une glace de graisse, saveurs disponibles: américains, allemands, et français.', category: Category.dessert);


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