const config = require('./dbConfig');
const sql = require('msnodesqlv8');

function getLoginDetails() {
  return new Promise((resolve, reject) => {
    sql.query(config, "SELECT * FROM Servicios", (err, rows) => {
      if (err) {
        reject(err);
      } else {
        resolve(rows);
      }
    });
  });
}

module.exports = {
  getLoginDetails: getLoginDetails
};
