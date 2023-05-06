
export default class Order {
  /**
   * Constructeur
   * @constructor
   *
   * @param {String} id        - Identifiant de la commande
   * @param {Date} orderDate - Date de commande
   * @param {String} recipeId  - Recette commandée
   * @param {Int}    quantity  - Quantité commandée
   * @param {String}   userId    - Utilisateur qui commande
   */
  constructor(id, orderDate, recipeId, quantity, userId) {
    this.id        = id;
    this.orderDate = orderDate;
    this.recipeId  = recipeId;
    this.quantity  = quantity;
    this.userId    = userId;
  }
}
