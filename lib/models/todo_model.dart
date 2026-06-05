

class CategoryModel {
  String description;
  String iconPath;
  bool boxIsSelected = false;

  CategoryModel({
  required this.description, 
  required this.iconPath, 
  required this.boxIsSelected
  });
  


  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    
    categories.add(
      CategoryModel(
        description: 'Salads',
        iconPath: 'assets/images/salads.png',
        boxIsSelected: false
      )
    );
   
    return categories;
  }
}