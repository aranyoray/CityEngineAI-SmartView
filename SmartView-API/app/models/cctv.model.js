const sql = require("./db.js");

// Constructor
const CCTV = function (cctv) {
  this.cctv_id = cctv.cctv_id;
  this.cctv_name = cctv.cctv_name;
  this.cctv_link_address = cctv.cctv_link_address;
  this.cctv_physical_address = cctv.cctv_physical_address;
  this.cctv_latitude = cctv.cctv_latitude;
  this.cctv_longitude = cctv.cctv_longitude;
};

// Find CCTV based on CCTV ID
CCTV.findById = (cctv_id, result) => {
  sql.query(
    `SELECT * FROM Team24_smartview.cctv WHERE cctv_id = ${cctv_id}`,
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
        return;
      }

      if (res.length) {
        console.log("found cctv: ", res[0]);
        result(null, res[0]);
        return;
      }

      // not found cctv with the id
      result({ kind: "not_found" }, null);
    }
  );
};

// Find all CCTVs
CCTV.getAll = (result) => {
  sql.query("SELECT * FROM Team24_smartview.cctv", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("cctv: ", res);
    result(null, res);
  });
};

// Create New CCTV
CCTV.create = (newCCTV, result) => {
  sql.query("INSERT INTO Team24_smartview.cctv SET ?", newCCTV, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created cctv: ", {
      ...newCCTV,
    });
    result(null, { ...newCCTV });
  });
};

CCTV.updateById = (id, cctv, result) => {
  sql.query(
    "UPDATE Team24_smartview.cctv SET cctv_name = ?, cctv_link_address = ?, cctv_physical_address = ? WHERE cctv_id = ?;",
    [cctv.cctv_name, cctv.cctv_link_address, cctv.cctv_physical_address, id],
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

      console.log("updated cctv: ", { id: id, ...cctv });
      result(null, { id: id, ...cctv });
    }
  );
};

// Remove CCTV based on ID
CCTV.remove = (id, result) => {
  sql.query("DELETE FROM Team24_smartview.cctv WHERE cctv_id = ?;", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      // not found Tutorial with the id
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted cctv with id: ", id);
    result(null, res);
  });
};

// Find CCTV physical address based on incident_id
CCTV.findByIncidentId = (incident_id, result) => {
  sql.query(
    `SELECT cctv_physical_address FROM Team24_smartview.cctv INNER JOIN Team24_smartview.incidents ON cctv.cctv_id = incidents.cam_id WHERE incidents.incident_id = ${incident_id}`,
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
        return;
      }

      if (res.length) {
        console.log("found cctv: ", res[0]);
        result(null, res[0]);
        return;
      }

      // not found cctv with the incident_id
      result({ kind: "not_found" }, null);
    }
  );
};

// Find longitude and latitude of CCTV location based on incident_id
CCTV.findLocationByIncidentId = (incident_id, result) => {
  sql.query(
    `SELECT cctv_latitude, cctv_longitude FROM Team24_smartview.cctv INNER JOIN Team24_smartview.incidents ON cctv.cctv_id = incidents.cam_id WHERE incidents.incident_id = ${incident_id}`,
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
        return;
      }

      if (res.length) {
        console.log("found cctv: ", res[0]);
        result(null, res[0]);
        return;
      }

      // not found cctv with the incident_id
      result({ kind: "not_found" }, null);
    }
  );
};

module.exports = CCTV;
