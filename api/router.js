
export default (controlers, app) => {
  app.get('/status', controlers.statusCtrl.getStatus);
  app.get('/recipes', controlers.recipeCtrl.listRecipes);
  app.get('/recipes/:id', controlers.recipeCtrl.getRecipe);
  app.post('/recipes', controlers.recipeCtrl.createRecipe);
  app.put('/recipes/:id', controlers.recipeCtrl.updateRecipe);
  app.delete('/recipes/:id', controlers.recipeCtrl.deleteRecipe);
}
