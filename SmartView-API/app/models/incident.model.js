const sql = require("./db.js")
const priorityValue = { high: 3, medium: 2, low: 1 }
const sortByColums = {
  time: "incident_time",
  priority: `CASE
WHEN priority_level = 'high' THEN ${priorityValue.high}
WHEN priority_level = 'medium' THEN ${priorityValue.medium}
ELSE ${priorityValue.low} end`,
};


// constructor
const Incidents = function (incidents) {
  this.incident_id = incidents.incident_id;
  this.incident_description = incidents.incident_description;
  this.incident_type = incidents.incident_type;
  this.cam_id = incidents.cam_id;
  this.incident_time = incidents.incident_time;
  this.incident_media = incidents.incident_assignee;
  this.assignee = incidents.assignee;
  this.priority_level = incidents.priority_level;
  this.incident_status = incidents.incident_status;
  this.officer_notes = incidents.officer_notes;
};

Incidents.create = (newIncident, result) => {
  sql.query("INSERT INTO Team24_smartview.incidents SET ?", newIncident, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created customer: ", {
      id: res.incident_id,
      ...newIncident,
    });
    result(null, { id: res.incident_id, ...newIncident });
  });
};

Incidents.findById = (incidentId, result) => {
  sql.query(
    `SELECT * FROM Team24_smartview.incidents WHERE incident_id = ${incidentId}`,
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
        return;
      }

      if (res.length) {
        console.log("found incident: ", res[0]);
        result(null, res[0]);
        return;
      }

      // not found Customer with the id
      result({ kind: "not_found" }, null);
    }
  );
};

Incidents.getAll = (result) => {
  sql.query("SELECT * FROM Team24_smartview.incidents", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("incidents: ", res);
    result(null, res);
  });
};

Incidents.getDataForCameraId = (cameraId, pageOffset, pageSize,  sortBy, sortOrder, priorityLevel, result) => {
  priorityLevel = priorityLevel ? new Set(priorityLevel) : null
  let priorityLevelInString = ''
  const resultData = {}
  let countQuery = `SELECT count(*) as count FROM Team24_smartview.incidents where cam_id = '${cameraId}'`
  let dataQuery = `SELECT * FROM Team24_smartview.incidents where cam_id = '${cameraId}' order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`

  if(priorityLevel){
    for(let priority of priorityLevel){
      priorityLevelInString += `'${priority}',`
    }

    priorityLevelInString = priorityLevelInString.substring(0, priorityLevelInString.length - 1)
  }

  if(priorityLevel){
    countQuery = `SELECT count(*) as count FROM Team24_smartview.incidents where cam_id = '${cameraId}' and priority_level in(${priorityLevelInString})`
    dataQuery = `SELECT * FROM Team24_smartview.incidents where cam_id = '${cameraId}' and priority_level in(${priorityLevelInString}) order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`
  }

  if(!cameraId){
    countQuery = `SELECT count(*) as count FROM Team24_smartview.incidents`
    dataQuery = `SELECT * FROM Team24_smartview.incidents order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`
    
    if(priorityLevel){
      countQuery = `SELECT count(*) as count FROM Team24_smartview.incidents where priority_level in(${priorityLevelInString})`
      dataQuery = `SELECT * FROM Team24_smartview.incidents where priority_level in(${priorityLevelInString}) order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`
    }
  }

  sql.query(countQuery, (err, rowCount) => {
    if (err) {
      return result(null, err);
    }

    resultData.rowCount = rowCount[0].count

    sql.query(dataQuery, (err, data) => {
      if (err) {
        return result(null, err);
      }
      
      resultData.data = data
      
      result(null, resultData);
    });
  });
};

Incidents.getCaseStatus = (incidentId, result) => {
  sql.query(
    `SELECT incident_status FROM Team24_smartview.incidents WHERE incident_id = "${incidentId}"`,
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

Incidents.getOngoingCases = (cameraId, pageOffset, pageSize, sortBy, sortOrder, priorityLevel, result) => {
  priorityLevel = priorityLevel ? new Set(priorityLevel) : null
  let priorityLevelInString = ''
  const resultData = {}
  let countQuery =  `SELECT count(*) as count FROM Team24_smartview.incidents where cam_id = '${cameraId}' and incident_status = 'ongoing'`
  let dataQuery = `SELECT * FROM Team24_smartview.incidents where cam_id = '${cameraId}' and incident_status= 'ongoing' order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`

  if(priorityLevel){
    for(let priority of priorityLevel){
      priorityLevelInString += `'${priority}',`
    }

    priorityLevelInString = priorityLevelInString.substring(0, priorityLevelInString.length - 1)
  }

  if(priorityLevel){
    countQuery = `SELECT count(*) as count FROM Team24_smartview.incidents where cam_id = '${cameraId}' and incident_status= 'ongoing' and priority_level in(${priorityLevelInString})`
    dataQuery = `SELECT * FROM Team24_smartview.incidents where cam_id = '${cameraId}' and incident_status= 'ongoing' and priority_level in(${priorityLevelInString}) order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`
  }

  if(!cameraId){
    countQuery =  `SELECT count(*) as count FROM Team24_smartview.incidents where incident_status = 'ongoing'`
    dataQuery = `SELECT * FROM Team24_smartview.incidents where incident_status= 'ongoing' order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`

    if(priorityLevel){
      countQuery = `SELECT count(*) as count FROM Team24_smartview.incidents where incident_status = 'ongoing' and priority_level in(${priorityLevelInString})`
      dataQuery = `SELECT * FROM Team24_smartview.incidents where incident_status = 'ongoing' and priority_level in(${priorityLevelInString}) order by ${sortByColums[sortBy]} ${sortOrder} limit ${pageOffset}, ${pageSize}`
    }
  }

  sql.query(countQuery, (err, rowCount) => {
    if (err) {
      return result(null, err);
    }

    resultData.rowCount = rowCount[0].count

    sql.query(dataQuery, (err, data) => {
      if (err) {
        return result(null, err);
      }
      
      resultData.data = data
      
      result(null, resultData);
    });
  });
}

Incidents.getCompletedCases = (result) => {
  sql.query(
    "SELECT * FROM Team24_smartview.incidents WHERE incident_status= 'completed'",
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

Incidents.getIncidentsBasedOnAssingee = (assignee, result) => {
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

Incidents.updateById = (id, incident, result) => {
  sql.query(
    "UPDATE incidents SET officer_notes = ? WHERE incident_id = ?",
    [incident.officer_notes, id],
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

      console.log("updated incident: ", { id: id, ...incident });
      result(null, { id: id, ...incident });
    }
  );
};

Incidents.updateStatusById = (id, incident, result) => {
  sql.query(
    "UPDATE incidents SET incident_status = ? WHERE incident_id = ?",
    [incident.incident_status, id],
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

      console.log("updated incident: ", { id: id, ...incident });
      result(null, { id: id, ...incident });
    }
  );
};



//   static updateById(id, customer, result) {
//     query(
//       "UPDATE customers SET email = ?, name = ?, active = ? WHERE id = ?",
//       [customer.email, customer.name, customer.active, id],
//       (err, res) => {
//         if (err) {
//           console.log("error: ", err);
//           result(null, err);
//           return;
//         }

//         if (res.affectedRows == 0) {
//           // not found Customer with the id
//           result({ kind: "not_found" }, null);
//           return;
//         }

//         console.log("updated incident: ", { id: id, ...customer });
//         result(null, { id: id, ...customer });
//       }
//     );
//   }
Incidents.remove = (incidentId, result) => {
  sql.query(
    "DELETE FROM Team24_smartview.incidents WHERE incident_id = ?",
    incidentId,
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

      console.log("deleted incident with id: ", id);
      result(null, res);
    }
  );
};

Incidents.removeAll = (result) => {
  sql.query("DELETE FROM Team24_smartview.incidents", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} incidents`);
    result(null, res);
  });
};

module.exports = Incidents;
