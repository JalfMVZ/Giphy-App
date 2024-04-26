const express = require("express");
const bodyParser = require("body-parser");
const admin = require("firebase-admin");
const serviceAccount = require("./firebase-admin.json");

const notificationsRoutes = require("./routes/notificationsRoutes.js");

const app = express();
const port = process.env.PORT || 3000;




admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

app.use(express.urlencoded({ extended: false }));

// CONFIG MIDLEWARE
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Credentials", "true");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  res.header(
    "Access-Control-Allow-Methods",
    "GET, POST, OPTIONS, PUT, DELETE, PATCH"
  );
  next();
});

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(notificationsRoutes);

//? Iniciar el servidor
app.listen(port, () => {
  console.log(`Servidor escuchando en el puerto ${port}`);
});
