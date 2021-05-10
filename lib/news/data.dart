import 'package:covid_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  // ignore: deprecated_member_use
  List<CategoryModel> myCategories = List<CategoryModel>();
  CategoryModel categoryModel;
  //1
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Вакцина";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1613758947307-f3b8f5d80711?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80";
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Путешествия";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1653&q=80";
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Финансы";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1591696205602-2f950c417cb9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80";
  myCategories.add(categoryModel);
  return myCategories;
}
