const { createPool } = require("mysql2");
const dbConfig = require("../config/db.config.js");

// create connection
const pool = createPool({
  host: dbConfig.HOST,
  user: dbConfig.USER,
  password: dbConfig.PASSWORD,
  database: dbConfig.DB,
  connectionLimit: 100,
  ssl: false
});

// connect to database
pool.getConnection((error, connection) => {
    if (error) {
        console.error(error);
        // check for connection errors
        if (error.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('Database connection was closed.');
        } else if (error.code === 'ER_CON_COUNT_ERROR') {
            console.error('Database has too many connections.');
        } else if (error.code === 'ECONNREFUSED') {
            console.error('Database connection was refused.');
        }
    } else {
        console.log("Connected to MySQL database...");
    }

    // release connection
    if (connection) connection.release();

    // return statement
    return;
});

// export connection
module.exports = pool;