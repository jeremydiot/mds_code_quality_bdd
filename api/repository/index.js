import recipeRepo from './recipeRepo.js';
import userRepo from './userRepo.js'

export default (model) => ({
  recipeRepo: recipeRepo(model.Recipe),
  userRepo : userRepo(model.User)
});
