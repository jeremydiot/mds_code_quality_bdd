import { v4 as uuidv4 } from 'uuid';
import {DateTime} from 'luxon'

export default (User) => {

  const users = [
    new User('5793ee17-5d65-4e73-92fd-6c4d9fef96a8', 'GOUPIL', 'Alban', DateTime.fromFormat('1995-11-17', 'yyyy-MM-dd'), '3 rue des aubépines 44300 Nantes', '+33634689374', 'alban.goupil@gmail.com'),
    new User('fe523f18-6b19-44e0-b156-446edc0e6862', 'GROLLIER', 'Théo', DateTime.fromFormat('1989-03-04', 'yyyy-MM-dd'), '18 boulevard des trois croix 35000 Rennes', '0657836652', 'theo.grollier@gmail.com'),
    new User('63dcff89-47c5-4365-875d-8934a250d0fe', 'BLANCHARD', 'Hugo', DateTime.fromFormat('1996-06-30', 'yyyy-MM-dd'), '14 allée oseraie 94260 fresnes', '0033678398215', 'hugo.blanchard@gmail.com')
  ];
  
  const findUser = (id) => {
    return users.find((u) => u.id === id);
  }

  const listUsers = () => {
    return users;
  };

  const createUser = (userData) => {
    const user = new User(
      uuidv4(),
      userData.lastName,
      userData.firstName,
      userData.birthDate,
      userData.address,
      userData.phone,
      userData.email
    );

    users.push(user);
    return user;
  }

  const updateUser = (id, userData) => {
    let foundUserIdx = users.findIndex(u => u.id === id)

    if (foundUserIdx > -1) {
      users[foundUserIdx] = {...users[foundUserIdx], ...userData, id};
      return users[foundUserIdx];
    }

    return null;
  }

  const deleteUser = (id) => {
    let userToDeleteIndex = users.findIndex((b) => b.id === id);

    if (userToDeleteIndex > -1) {
      let deletedUser = users.splice(userToDeleteIndex, 1)[0];
      return deletedUser;
    }

    return null;
  }

  return {
    listUsers,
    findUser,
    createUser,
    updateUser,
    deleteUser
  };
};
