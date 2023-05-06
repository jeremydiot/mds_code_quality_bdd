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

    const birthDate = DateTime.fromFormat(req.body.birthDate, 'yyyy-MM-dd'); 
    if (!birthDate.isValid) return res.status(400).send({error: 'BirthDate format incorrect (yyyy-mm-dd)'})

    if(!/^(0|\+33|0033)[1-9][0-9]{8}$/.test(req.body.phone)) return res.status(400).send({error: 'Phone format incorrect (+33 or 0 or 0033 follewed by 9 digits)'})
    
    const user = userRepo.createUser({...req.body, birthDate });

    res.status(201).send({
      data: {...user, birthDate: user.birthDate.toFormat('yyyy-MM-dd') }
    });
  }

  const updateUser = (req, res) => {
    const id = req.params.id;

    const birthDate = DateTime.fromFormat(req.body.birthDate, 'yyyy-MM-dd'); 
    if (!birthDate.isValid) return res.status(400).send({error: 'BirthDate format incorrect (yyyy-mm-dd)'})

    if(!/^(0|\+33|0033)[1-9][0-9]{8}$/.test(req.body.phone)) return res.status(400).send({error: 'Phone format incorrect (+33 or 0 or 0033 follewed by 9 digits)'})
    
    const user = userRepo.updateUser(id, {...req.body, birthDate });

    
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