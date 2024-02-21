class apiList {
  var articleApi = 'https://65d549733f1ab8c63436ae8e.mockapi.io/api/article';
  final String nutritionApi = 'http://localhost:5000/api/nutrition';
  final String ingredientApi = 'http://localhost:5000/api/ingredient';
  final String recipeApi = 'http://localhost:5000/api/recipe';

  String getArticleApi() {
    return articleApi;
  }

  String getNutritionApi() {
    return nutritionApi;
  }

  String getIngredientApi() {
    return ingredientApi;
  }

  String getRecipeApi() {
    return recipeApi;
  }
}
