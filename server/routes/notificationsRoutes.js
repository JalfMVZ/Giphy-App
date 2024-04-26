const express = require("express");
const { sendNotification } = require("../controllers/Notifications/notificationController");
const { registerDevice } = require("../controllers/Notifications/registroDispositivo");
const { deleteDevice } = require("../controllers/Notifications/deleteDevices");
const { enviarNotificacion } = require("../controllers/Notifications/enviarNotificaciones");

const router = express.Router();

router.post("/notifications", sendNotification);
router.post("/registerDevice", registerDevice);
router.post("/enviarNotificacion", enviarNotificacion);

router.delete("/deleteDevice", deleteDevice)


module.exports = router;
