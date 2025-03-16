import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/theme/appcolor.dart';

void showCategorySelection(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Appcolor.secodary, // Match theme
        child: Container(
          height: 556,
          width: 327,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Choose Category",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryItem(category: categories[index]);
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.primary,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text("Add Category",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class Category {
  final String name;
  final String iconPath;

  Category({required this.name, required this.iconPath,});
}

List<Category> categories = [
  Category(
    name: "Grocery",
    iconPath: "assets/Categories screen svg/grocery.svg",
  ),
  Category(
    name: "Work",
    iconPath: "assets/Categories screen svg/work.svg",
  ),
  Category(
    name: "Sport",
    iconPath: "assets/Categories screen svg/sport.svg",
  ),
  Category(
    name: "Design",
    iconPath: "assets/Categories screen svg/design.svg",
  ),
  Category(
    name: "University",
    iconPath: "assets/Categories screen svg/university.svg",
  ),
  Category(
    name: "Social",
    iconPath: "assets/Categories screen svg/social.svg",
  ),
  Category(
    name: "Music",
    iconPath: "assets/Categories screen svg/music.svg",
  ),
  Category(
    name: "Health",
    iconPath: "assets/Categories screen svg/health.svg",
  ),
  Category(
    name: "Movie",
    iconPath: "assets/Categories screen svg/movie.svg",
  ),
  Category(
    name: "Home",
    iconPath: "assets/Categories screen svg/home.svg",
  ),
  Category(
    name: "Create New",
    iconPath: "assets/Categories screen svg/create new.svg",
  ),
];

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          category.iconPath,
          height: 54,
          width: 54,
        ),
        SizedBox(height: 5),
        Text(category.name,
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
