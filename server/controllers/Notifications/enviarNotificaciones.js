const admin = require("firebase-admin");



const enviarNotificacion = async (req, res) => {
  const { id, title, body } = req.body;

  if (!id || !title || !body) {
    return res.status(400).json({ error: "Faltan parámetros" });
  }

  try {
    // Buscar el token de dispositivo en la base de datos utilizando la ID
    const deviceToken = await getDeviceTokenById(id);

    if (!deviceToken) {
      return res.status(404).json({ error: "No se encontró el dispositivo con la ID proporcionada" });
    }

    // Enviar la notificación mediante FCM
    await admin.messaging().send({
      token: deviceToken,
      notification: {
        title: title,
        body: body,
      },
    });

    res.json({ message: "Notificación enviada correctamente" });
  } catch (error) {
    console.error("Error al enviar la notificación:", error);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};

// Función para obtener el token de dispositivo por ID (simulación)
async function getDeviceTokenById(id) {
  // Aquí puedes implementar la lógica para buscar el token en la base de datos
  // Por ahora, simplemente devolvemos un token de ejemplo
  if (id === "2") {
    return "sample_device_token";
  } else {
    return null;
  }
}

module.exports = {
    enviarNotificacion: enviarNotificacion,
};
