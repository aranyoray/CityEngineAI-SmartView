const sql = require("./db.js");

// constructor
const Users = function (users) {
  this.username = users.username;
  this.email_address = users.email_address;
  this.name = users.name;
  this.phone_number = users.phone_number;
  this.password = users.password;
  this.salt = users.salt;
  this.is_admin = users.is_admin;
};

Users.create = (newUser, result) => {
  sql.query("INSERT INTO Team24_smartview.users SET ?", newUser, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created customer: ", {
      ...newUser,
    });
    result(null, { ...newUser });
  });
};

Users.findById = (username, result) => {
  sql.query(
    `SELECT * FROM Team24_smartview.users WHERE username = "${username}"`,
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
        return;
      }

      if (res.length) {
        console.log("found user: ", res[0]);
        result(null, res[0]);
        return;
      }

      // not found Customer with the id
      result({ kind: "not_found" }, null);
    }
  );
};

Users.getAll = (result) => {
  sql.query("SELECT * FROM Team24_smartview.users", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("users: ", res);
    result(null, res);
  });
};

Users.getIncidentsBasedOnAssingee = (assignee, result) => {
  sql.query(
    `SELECT * FROM Team24_smartview.incidents WHERE assignee = "${assignee}"`,
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      console.log("incidents: ", res);
      result(null, res);
    }
  );
};

Users.remove = (username, result) => {
  sql.query("set foreign_key_checks = 0;");
  sql.query(
    "DELETE FROM Team24_smartview.users WHERE username = ?",
    username,
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Customer with the id
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("deleted user with username: ", username);
      result(null, res);
    }
  );
};

Users.update = (name, user, result) => {
  sql.query(
    "UPDATE Team24_smartview.users SET username = ?, phone_number = ?, email_address = ? WHERE name = ?;",
    [user.username, user.phone_number, user.email_address, name],
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Tutorial with the id
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("updated user: ", { user: name, ...user });
      result(null, { user: name, ...user });
    }
  );
};

module.exports = Users;
