import { v4 as uuidv4 } from 'uuid';
import {DateTime} from 'luxon'

export default (Order) => {

  const orders = [
    new Order('7d822bc6-75ce-4e06-be64-6db18477f97f', DateTime.fromFormat('2023-01-24', 'yyyy-MM-dd'), 'a35ce12d-d52b-4a07-90ad-68e985b779e7', '5', 'fe523f18-6b19-44e0-b156-446edc0e6862'),
    new Order('1dcfacd0-43a9-47d5-932e-11eb124f50cc', DateTime.fromFormat('2023-02-08', 'yyyy-MM-dd'), 'a35ce12d-d52b-4a07-90ad-68e985b779e7', '1', '63dcff89-47c5-4365-875d-8934a250d0fe'),
    new Order('72c00698-bb07-4ae9-bc50-c1731ada0226', DateTime.fromFormat('2023-03-15', 'yyyy-MM-dd'), 'dc466424-4297-481a-a8de-aa0898852da1', '8', 'fe523f18-6b19-44e0-b156-446edc0e6862')
  ];
  
  const findOrder = (id) => {
    return orders.find((o) => o.id === id);
  }

  const listOrders = () => {
    return orders;
  };

  const createOrder = (orderData) => {
    const order = new Order(
      uuidv4(),
      orderData.orderDate,
      orderData.recipeId,
      orderData.quantity,
      orderData.userId
    );

    orders.push(order);

    return order;
  }

  const updateOrder = (id, orderData) => {
    let foundOrderIdx = orders.findIndex(o => o.id === id)

    if (foundOrderIdx > -1) {
      orders[foundOrderIdx] = {...orders[foundOrderIdx], ...orderData, id};
      return orders[foundOrderIdx];
    }

    return null;
  }

  const deleteOrder = (id) => {
    let orderToDeleteIndex = orders.findIndex((o) => o.id === id);

    if (orderToDeleteIndex > -1) {
      let deletedOrder = orders.splice(orderToDeleteIndex, 1)[0];
      return deletedOrder;
    }

    return null;
  }

  return {
    listOrders,
    findOrder,
    createOrder,
    updateOrder,
    deleteOrder
  };
};
