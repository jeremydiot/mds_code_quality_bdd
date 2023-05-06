import {DateTime} from 'luxon'


export default (orderRepo, userRepo, recipeRepo) => {
  const listOrders = (_, res) => {
    const orders = orderRepo.listOrders().map(order => {
      return {...order, orderDate: order.orderDate.toFormat('yyyy-MM-dd') }
    });
    
    res.send({
      data: orders
    });
  };

  const getOrder = (req, res) => {
    const id = req.params.id;
    const order = orderRepo.findOrder(id);
    
    if (order) {
      return res.send({
        data: {...order, orderDate: order.orderDate.toFormat('yyyy-MM-dd') }
      });
    }

    res.status(404).send({
      error: `Order with id ${id} not found`
    });
  }

  const createOrder = (req, res) => {
    const orderDate = DateTime.fromFormat(req.body.orderDate, 'yyyy-MM-dd'); 
    if (!orderDate.isValid) return res.status(400).send({error: 'OrderDate format incorrect (yyyy-mm-dd)'})
    if (userRepo.findUser(req.body.userId) === undefined) return res.status(404).send({error:  `User with id ${req.body.userId} not found`})
    if (recipeRepo.findRecipe(req.body.recipeId) === undefined) return res.status(404).send({error:  `Recipe with id ${req.body.recipeId} not found`})

    const order = orderRepo.createOrder({...req.body, orderDate });

    res.status(201).send({
      data: {...order, orderDate: order.orderDate.toFormat('yyyy-MM-dd') }
    });
  }

  const updateOrder = (req, res) => {
    const id = req.params.id;

    const orderDate = DateTime.fromFormat(req.body.orderDate, 'yyyy-MM-dd'); 
    if (!orderDate.isValid) return res.status(400).send({error: 'OrderDate format incorrect (yyyy-mm-dd)'})
    if (userRepo.findUser(req.body.userId) === undefined) return res.status(404).send({error:  `User with id ${req.body.userId} not found`})
    if (recipeRepo.findRecipe(req.body.recipeId) === undefined) return res.status(404).send({error:  `Recipe with id ${req.body.recipeId} not found`})

    const order = orderRepo.updateOrder(id, {...req.body, orderDate });

    
    if (order) {
      return res.send({
        data: {...order, orderDate: order.orderDate.toFormat('yyyy-MM-dd') }
      });
    }

    res.status(404).send({
      error: `Order with id ${id} not found`
    });
  }

  const deleteOrder = (req, res) => {
    const id = req.params.id;
    const deletedOrder = orderRepo.deleteOrder(id);

    if (deletedOrder) {
      return res.send({
        meta: {
          deleted: {...deletedOrder, orderDate: deletedOrder.orderDate.toFormat('yyyy-MM-dd') }
        }
      });
    }

    res.status(404).send({
      error: `Order with id ${id} not found`
    });
  }

  return {
    listOrders,
    getOrder,
    createOrder,
    updateOrder,
    deleteOrder,
  };
}