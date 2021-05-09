import 'package:covid_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> myCategories = List<CategoryModel>();
  CategoryModel categoryModel;

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Business";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/flagged/photo-1584036561584-b03c19da874c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2978&q=80";
  myCategories.add(categoryModel);
  return myCategories;
}
