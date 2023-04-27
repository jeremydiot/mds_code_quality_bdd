import {DateTime} from 'luxon'


export default (userRepo) => {
  const listUsers = (_, res) => {
    const users = userRepo.listUsers().map(user => {
      return {...user, birthDate: user.birthDate.toFormat('yyyy-MM-dd') }
    });

    res.send({
      data: users
    });
  };

  const getUser = (req, res) => {
    const id = req.params.id;
    const user = userRepo.findUser(id);
    
    if (user) {
      return res.send({
        data: {...user, birthDate: user.birthDate.toFormat('yyyy-MM-dd') }
      });
    }

    res.status(404).send({
      error: `User with id ${id} not found`
    });
  }

  const createUser = (req, res) => {
    const user = userRepo.createUser({...req.body, birthDate: DateTime.fromFormat(req.body.birthDate, 'yyyy-MM-dd') });

    res.status(201).send({
      data: {...user, birthDate: user.birthDate.toFormat('yyyy-MM-dd') }
    });
  }

  const updateUser = (req, res) => {
    const id = req.params.id;
    const user = userRepo.updateUser(id, {...req.body, birthDate: DateTime.fromFormat(req.body.birthDate, 'yyyy-MM-dd') });

    
    if (user) {
      return res.send({
        data: {...user, birthDate: user.birthDate.toFormat('yyyy-MM-dd') }
      });
    }

    res.status(404).send({
      error: `User with id ${id} not found`
    });
  }

  const deleteUser = (req, res) => {
    const id = req.params.id;
    const deletedUser = userRepo.deleteUser(id);

    if (deletedUser) {
      return res.send({
        meta: {
          deleted: {...deletedUser, birthDate: deletedUser.birthDate.toFormat('yyyy-MM-dd') }
        }
      });
    }

    res.status(404).send({
      error: `User with id ${id} not found`
    });
  }

  return {
    listUsers,
    getUser,
    createUser,
    updateUser,
    deleteUser,
  };
}