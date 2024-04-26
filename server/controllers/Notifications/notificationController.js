const admin = require("firebase-admin");

const sendNotification = async (req, res) => {
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
};

module.exports = {
  sendNotification: sendNotification,
};
