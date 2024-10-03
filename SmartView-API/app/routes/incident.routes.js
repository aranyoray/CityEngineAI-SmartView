module.exports = (app) => {
  const incidents = require("../controllers/incident.controller.js");
  const users = require("../controllers/user.controller.js");
  const cctv = require("../controllers/cctv.controller.js");

  /* Routes related to users */

  app.post("/users", users.create);
  // Get all users
  app.get("/allusers", users.findAll);
  // Get user based on username
  app.get("/users/:username?", users.findOne);
  app.delete("/users/:username", users.delete);
  app.put("/users/:name", users.updateOne);

  /* Routes related to incidents */
  app.get("/incidents/", incidents.findAll);
  app.get("/incidents/:camera_id", incidents.findAll);
  app.get("/incidents/priority/low", incidents.findLow);
  app.get("/incidents/priority/medium", incidents.findMedium);
  app.get("/incidents/priority/high", incidents.findHigh);
  app.get("/incidents/ongoing/", incidents.findOngoingCases);
  app.get("/incidents/ongoing/:camera_id", incidents.findOngoingCases);
  app.get("/incidents/completed", incidents.findCompletedCases);
  // app.put("/incidents/:incident_id", incidents.updateOne);
  app.put("/incidents/status/:incident_id", incidents.updateOneStatus);
  app.put(
    "/incidents/description/:incident_id",
    incidents.updateOneDescription
  );
  app.get("/incidents/getStatus/:incident_id", incidents.findOneStatus);

  // Get all cases based on user logged in
  app.get("/incidents/:assignee", incidents.getIncidentsBasedOnAssingee);

  // Retrieve a single Incident with incident_id
  app.get("/incidents/:incident_id", incidents.findOne);

  /* Routes related to CCTVs */
  app.get("/cctv/:cctv_id", cctv.findOne);
  app.get("/cctv", cctv.findAll);
  app.post("/cctv", cctv.create);
  app.delete("/cctv/:cctv_id", cctv.delete);
  app.put("/cctv/:cctv_id", cctv.updateOne);
  app.get(
    "/cctv/incident/:incident_id",
    cctv.findCCTVPhysicalAddressByIncidentId
  );
  app.get("/cctv/location/:incident_id", cctv.findCCTVLocationByIncidentId);
};
