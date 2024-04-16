const express = require("express");

const admin = require("firebase-admin");
const serviceAccount = require("./firebase-admin.json");

const app = express();
const port = process.env.PORT || 3000;

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

app.use(express.json());

app.post("/", async (req, res) => {
  const token = req.body.token;
  const data = req.body.data;
  if (token != "" || token != null) {
    try {
      await admin.messaging().sendEachForMulticast({
        tokens: token,
        data: {
          title: data.title,
          body: data.body,
        },
      });
    } catch (error) {
      console.log(error);
    }

    res.json("send");
  } else {
    res.json("ERROR");
  }
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}!`);
});
