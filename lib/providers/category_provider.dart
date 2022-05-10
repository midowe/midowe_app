import 'dart:convert';

import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/base_provider.dart';

class CategoryProvider extends BaseProvider {
  Future<List<Category>> fetchCategories() async {
    return [
      Category(
          id: 'saude',
          name: 'Saude',
          description: 'Saude, Medicação',
          requireApproval: false),
      Category(
          id: 'musica',
          name: 'Musca',
          description: 'Musca, Arte, Cultura',
          requireApproval: false),
      Category(
          id: 'projectos',
          name: 'Projectos',
          description: 'Iniciativas diferenes',
          requireApproval: false),
    ];
  }

  Future<Category> fetchCategoryById(String categoryId) async {
    return Category(
        id: 'saude',
        name: 'Saude',
        description: 'Saude, Medicação',
        requireApproval: false);
  }
}
