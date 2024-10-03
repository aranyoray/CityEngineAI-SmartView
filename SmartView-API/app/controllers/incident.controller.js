const Incidents = require("../models/incident.model.js")

const sortByOptions = ['time', 'priority']
const filterByOptions = 'priority'
const priorityLevels = ['high', 'medium', 'low']
const sortOrderOptions = ['asc', 'desc']

// Create and Save a new Customer
exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  // Create an incident
  const incident = new Incidents({
    incident_id: req.body.incident_id,
    incident_description: req.body.incident_description,
    incident_type: req.body.incident_type,
    cam_id: req.body.cam_id,
    incident_time: req.body.incident_time,
    incident_media: req.body.incident_assignee,
    assignee: req.body.assignee,
    priority_level: req.body.priority_level,
    incident_status: req.body.incident_status,
    officer_notes: req.body.officer_notes,
  });

  Incidents.create(incident, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while creating the Incident",
      });
  });
};

// Retrieve all Incidents from the database.
exports.findAll = (req, res) => {  
  const cameraId = req.params.camera_id
  let pageSize = Number(req.query.pageSize)
  let pageOffset = Number(req.query.pageOffset)
  let sortBy = req.query.sortBy || req.query.sortby
  let sortOrder = req.query.sortOrder || req.query.sortorder
  let filterBy = req.query.filterBy || req.query.filterby
  let priorityLevel = req.query.priorityLevel || req.query.prioritylevel

  if(cameraId === 'ongoing'){
    delete req.params.camera_id
    return this.findOngoingCases(req, res)
  }

  if(!req.query.pageSize || req.query.pageSize === 0){
    pageSize = 10
  }

  if(!sortBy){
    sortBy = 'time'
  }

  if(!sortOrder){
    sortOrder = 'desc'
  }

  if(sortBy && !sortByOptions.includes(sortBy)){
    return res.status(401).send({
      message: `sortBy value should be any of ${sortByOptions}`,
    });
  }

  if(sortOrder && !sortOrderOptions.includes(sortOrder)){
    return res.status(401).send({
      message: `sortOrder value should be any of ${sortOrderOptions}`,
    });
  }

  if(filterBy && !filterByOptions.includes(filterBy)){
    return res.status(401).send({
      message: `filterBy value should be ${filterByOptions}`,
    });
  } else {
    if(!priorityLevel){
      return res.status(401).send({
        message: `No priorityLevel passed, value should be of ${priorityLevels}`,
      });
    }

    if(!Array.isArray(priorityLevel)){
      priorityLevel = [priorityLevel]
    }

    let priorityLevelSet = new Set(priorityLevels);
    let isPriorityLevelCorrect = priorityLevel.every(num => priorityLevelSet.has(num));
    
    if(!isPriorityLevelCorrect){
      return res.status(401).send({
        message: `priorityValue value should be of ${priorityLevels}`,
      });
    }
  }

  if(!Number.isInteger(pageSize) || Number.isInteger(pageSize) < 0){
    return res.status(401).send({
      message: 'Page size should be numeric',
    });
  }

  if(!req.query.pageOffset){
    pageOffset = 0
  }

  if(!Number.isInteger(pageOffset) || Number.isInteger(pageOffset) < 0){
    return res.status(401).send({
      message: 'Page offset should be numeric',
    });
  }

  Incidents.getDataForCameraId(cameraId, pageOffset, pageSize, sortBy, sortOrder, priorityLevel, (err, data) => {
    if (err)
      return res.status(500).send({
        message: err.message || "Error occured while retrieving Incidents",
      });
    else {
      return res.json(data);
    }
  });
};

// Retrieve all Incidents from the database.
exports.findLow = (req, res) => {
  Incidents.getAll((err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while retrieving Incidents",
      });
    else {
      const filtered = data.filter(
        (incident) => incident.priority_level == "low"
      );
      res.json(filtered);
    }
  });
};

exports.findMedium = (req, res) => {
  Incidents.getAll((err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while retrieving Incidents",
      });
    else {
      const filtered = data.filter(
        (incident) => incident.priority_level == "medium"
      );
      res.json(filtered);
    }
  });
};

exports.findHigh = (req, res) => {
  Incidents.getAll((err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while retrieving Incidents",
      });
    else {
      const filtered = data.filter(
        (incident) => incident.priority_level == "high"
      );
      res.json(filtered);
    }
  });
};

// Retrieve all ongoing Incidents from the database.
exports.findOngoingCases = (req, res) => {
  const cameraId = req.params.camera_id
  let pageSize = Number(req.query.pageSize)
  let pageOffset = Number(req.query.pageOffset)
  let sortBy = req.query.sortBy || req.query.sortby
  let sortOrder = req.query.sortOrder || req.query.sortorder
  let filterBy = req.query.filterBy || req.query.filterby
  let priorityLevel = req.query.priorityLevel || req.query.prioritylevel

  if(!req.query.pageSize || req.query.pageSize === 0){
    pageSize = 10
  }

  if(!Number.isInteger(pageSize) || Number.isInteger(pageSize) < 0){
    return res.status(401).send({
      message: 'Page size should be numeric',
    });
  }

  if(!req.query.pageOffset){
    pageOffset = 0
  }

  if(!Number.isInteger(pageOffset) || Number.isInteger(pageOffset) < 0){
    return res.status(401).send({
      message: 'Page offset should be numeric',
    });
  }

  if(!sortBy){
    sortBy = 'time'
  }

  if(!sortOrder){
    sortOrder = 'desc'
  }

  if(sortBy && !sortByOptions.includes(sortBy)){
    return res.status(401).send({
      message: `sortBy value should be any of ${sortByOptions}`,
    });
  }

  if(sortOrder && !sortOrderOptions.includes(sortOrder)){
    return res.status(401).send({
      message: `sortOrder value should be any of ${sortOrderOptions}`,
    });
  }

  if(filterBy && !filterByOptions.includes(filterBy)){
    return res.status(401).send({
      message: `filterBy value should be ${filterByOptions}`,
    });
  } else {
    if(!priorityLevel){
      return res.status(401).send({
        message: `No priorityLevel passed, value should be of ${priorityLevels}`,
      });
    }

    if(!Array.isArray(priorityLevel)){
      priorityValue = [priorityLevel]
    }

    let priorityLevelSet = new Set(priorityLevels);
    let isPriorityLevelCorrect = priorityLevel.every(num => priorityLevelSet.has(num));
    
    if(!isPriorityLevelCorrect){
      return res.status(401).send({
        message: `priorityValue value should be of ${priorityLevels}`,
      });
    }
  }

  Incidents.getOngoingCases(cameraId, pageOffset, pageSize, sortBy, sortOrder, priorityLevel, (err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Error occured while retrieving ongoing Incidents",
      });
    else {
      res.json(data);
    }
  }); 
};

// Retrieve all completed Incidents from the database.
exports.findCompletedCases = (req, res) => {
  Incidents.getCompletedCases((err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Error occured while retrieving completed Incidents",
      });
    else {
      res.json(data);
    }
  });
};

// Retrieve incident based on Assignee
exports.getIncidentsBasedOnAssingee = (req, res) => {
  Incidents.getIncidentsBasedOnAssingee(req.params.assignee, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while retrieving Incidents",
      });
    else {
      res.json(data);
    }
  });
};

// Find a single Customer with a customerId
exports.findOne = (req, res) => {
  Incidents.findById(req.params.incident_id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found incident id ${req.params.incident_id}`,
        });
      }
    } else res.json(data);
  });
};

// Get status of an incident
exports.findOneStatus = (req, res) => {
  Incidents.getCaseStatus(req.params.incident_id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found incident id ${req.params.incident_id}`,
        });
      }
    } else res.json(data);
  });
};

// Update one incident status
exports.updateOneStatus = (req, res) => {
  Incidents.updateStatusById(
    req.params.incident_id,
    new Incidents(req.body),
    (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found incident id ${req.params.incident_id}`,
          });
        }
      } else res.json(data);
    }
  );
};

// Update description of incident 
exports.updateOneDescription = (req, res) => {
  Incidents.updateById(
    req.params.incident_id,
    new Incidents(req.body),
    (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found incident id ${req.params.incident_id}`,
          });
        }
      } else res.json(data);
    }
  );
};


