const CCTV = require("../models/cctv.model.js");

// Create and Save a new CCTV RTSP
exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  // Create an CCTV
  const cctv = new CCTV({
    cctv_name: req.body.cctv_name,
    cctv_link_address: req.body.cctv_link_address,
    cctv_physical_address: req.body.cctv_physical_address,
    cctv_latitude: req.body.cctv_latitude,
    cctv_longitude: req.body.cctv_longitude,
  });

  CCTV.create(cctv, (err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while creating the Incident",
      });
    else {
      res.status(200).json(data);
    }
  });
};

// Retrieve all Cases from the database.
exports.findAll = (req, res) => {
  CCTV.getAll((err, data) => {
    if (err)
      res.status(500).send({
        message: err.message || "Error occured while retrieving Cases",
      });
    else {
      res.json(data);
    }
  });
};


// Find a single CCTV with a cctv_id
exports.findOne = (req, res) => {
  CCTV.findById(req.params.cctv_id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found cctv id ${req.params.case_id}`,
        });
      }
    } else res.json(data);
  });
};

// Find CCTV physical address based on incident_id
exports.findCCTVPhysicalAddressByIncidentId = (req, res) => {
  CCTV.findByIncidentId(req.params.incident_id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `CCTV with incident_id ${req.params.incident_id} not found.`,
        });
      } else {
        res.status(500).send({
          message:
            "Error retrieving CCTV with incident_id " + req.params.incident_id,
        });
      }
    } else {
      res.send(data);
    }
  });
};

// Find CCTV coordinates based on incident_id
exports.findCCTVLocationByIncidentId = (req, res) => {
  CCTV.findLocationByIncidentId(req.params.incident_id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `CCTV with incident_id ${req.params.incident_id} not found.`,
        });
      } else {
        res.status(500).send({
          message:
            "Error retrieving CCTV with incident_id " + req.params.incident_id,
        });
      }
    } else {
      res.send(data);
    }
  });
};

// Remove CCTV based on ID
exports.delete = (req, res) => {
  CCTV.remove(req.params.cctv_id, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found CCTV with id ${req.params.id}.`,
        });
      } else {
        res.status(500).send({
          message: "Could not delete CCTV with id " + req.params.id,
        });
      }
    } else res.send({ message: `CCTV was deleted successfully!` });
  });
};

// Update CCTV by ID
exports.updateOne = (req, res) => {
  // Validate Request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  console.log(req.body);

  CCTV.updateById(req.params.cctv_id, new CCTV(req.body), (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found CCTV with id ${req.params.cctv_id}.`,
        });
      } else {
        res.status(500).send({
          message: "Error updating CCTV with id " + req.params.cctv_id,
        });
      }
    } else res.send(data);
  });
};
