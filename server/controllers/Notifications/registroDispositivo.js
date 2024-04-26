const sql = require("mssql");
const dbConfig = require("../../dbConfig");

const registerDevice = async (req, res) => {
  const response = {
    code: "OK",
    message: "",
    id: 1,
  };

  try {
    // Verificar si se proporciona el cuerpo de la solicitud
    if (!req.body || !req.body.deviceid) {
      response.code = "ERR";
      response.message = "Token Nulo";
      return res.json(response);
    }

    // Obtener el DEVICEID y el ID del cuerpo de la solicitud
    const { deviceid, id } = req.body;

    // Verificar si se proporciona un ID para la actualización
    if (id) {
      await sql.connect(dbConfig);
      const result = await sql.query`UPDATE DISPOSITIVOS SET DEVICEID = ${deviceid} WHERE ID = ${id}`;
      await sql.close();
    } else {
      // Si no se proporciona un ID, insertar un nuevo registro
      await sql.connect(dbConfig);
      const result = await sql.query`INSERT INTO DISPOSITIVOS (DEVICEID) VALUES (${deviceid}); SELECT SCOPE_IDENTITY() AS ID;`;
      response.id = result.recordset[0].ID;
      await sql.close();
    }
  } catch (error) {
    // Manejar errores
    console.error("Error:", error);
    response.code = "ERR";
    response.message = "Error";
  }

  // Enviar respuesta JSON al cliente
  res.json(response);
};

module.exports = {
  registerDevice: registerDevice,
};
