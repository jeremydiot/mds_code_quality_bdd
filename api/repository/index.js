import recipeRepo from './recipeRepo.js';

export default (model) => ({
  recipeRepo: recipeRepo(model.Recipe)
});
