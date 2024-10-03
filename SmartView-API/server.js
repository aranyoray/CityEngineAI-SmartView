const express = require("express");
const bodyParser = require("body-parser");

const app = express();

// parse requests of content-type: application/json
app.use(bodyParser.json());

// parse requests of content-type: application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

require("./app/routes/incident.routes.js")(app);
// set port, listen for requests
app.listen(3000, () => {
  console.log("Server is running on port 3000.");
});

// const swaggerAutogen = require("swagger-autogen")();

// const outputFile = "./swagger_output.json";
// const endpointsFiles = ["./app/routes/incident.routes.js"];

// swaggerAutogen(outputFile, endpointsFiles);

const swaggerUi = require("swagger-ui-express"),
  swaggerDocument = require("./swagger_output.json");

app.use("/", swaggerUi.serve, swaggerUi.setup(swaggerDocument));
