const Users = require("../models/user.model.js");

// Create and Save a new Customer
exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  // Create new user
  const user = new Users({
    username: req.body.username,
    email_address: req.body.email_address,
    name: req.body.name,
    phone_number: req.body.phone_number,
    password: req.body.password,
    salt: req.body.salt,
    is_admin: req.body.is_admin,
  });

  Users.create(user, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while creating the User",
      });
    else {
      res.status(200).json(data);
    }
  });
};

// Retrieve all users from the database.
exports.findAll = (req, res) => {
  Users.getAll((err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while retrieving users",
      });
    else {
      res.json(data);
    }
  });
};

// Find a single user with a user name
exports.findOne = (req, res) => {
  Users.findById(req.params.username, (err, data) => {
    if (!req.params) {
      res.status(404).send({
        message: `Not found user`,
      });
    }
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found user ${req.params.username}`,
        });
      }
    } else res.json(data);
  });
};

// Remove User based on ID
exports.delete = (req, res) => {
  Users.remove(req.params.username, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found username with username ${req.params.username}.`,
        });
      } else {
        res.status(500).send({
          message: "Could not delete username " + req.params.username,
        });
      }
    } else res.send({ message: `Users was deleted successfully!` });
  });
};

exports.updateOne = (req, res) => {
  // Validate Request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  console.log(req.body);

  Users.update(req.params.name, new Users(req.body), (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found User ${req.params.name}.`,
        });
      } else {
        res.status(500).send({
          message: "Error updating User " + req.params.name,
        });
      }
    } else res.send(data);
  });
};