const sql = require("mssql");
const dbConfig = require("../../dbConfig");

const deleteDevice = async (req, res) => {
  const { id } = req.body;

  if (!id) {
    return res.status(400).json({ code: "ERR", message: "ID de dispositivo ausente para eliminar", id: 0 });
  }

  try {
    await sql.connect(dbConfig);

    const query = `
      DELETE FROM DISPOSITIVOS
      WHERE ID = @ID;
    `;

    const result = await new sql.Request()
      .input('ID', sql.Int, id)
      .query(query);

    const rowsAffected = result.rowsAffected[0];

    const code = rowsAffected > 0 ? "OK" : "ERR";
    const message = rowsAffected > 0 ? "Eliminación exitosa" : "No se encontró el dispositivo para eliminar";

    res.json({ code, message, id }); 
  } catch (error) {
    console.error("Error deleting device:", error);
    res.status(500).json({ code: "ERR", message: "Error interno del servidor", id: 0 });
  } finally {
    sql.close();
  }
};

module.exports = {
  deleteDevice: deleteDevice,
};
