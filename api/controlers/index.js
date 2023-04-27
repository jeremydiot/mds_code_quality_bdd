import statusCtrl from './statusCtrl.js';
import recipeCtrl from './recipeCtrl.js';

export default (repository) => ({
  statusCtrl,
  recipeCtrl: recipeCtrl(repository.recipeRepo)
});
