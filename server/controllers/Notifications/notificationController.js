const admin = require("firebase-admin");

const sendNotification = async (req, res) => {
    const rawTokens = req.headers["authorization"];
    let tokens;
    console.log("token:", rawTokens )
    if (rawTokens) {
      tokens = rawTokens.split(",") || [];
    } else {
      tokens = [rawTokens];
    }
  
    if (!tokens.length) {
      return res.status(400).json({ error: "No recipient tokens provided" });
    }
  
    const data = req.body.data;
    try {
      await admin.messaging().sendEachForMulticast({
        tokens,
        data: {
          title: data.title,
          body: data.body,
        },
      });
      res.json("Notification sent");
      console.log("Notification sent");
    } catch (error) {
      console.error("Error sending notification:", error);
      res.status(500).json({ error: "Internal server error" });
    }
  };
  

module.exports = {
  sendNotification: sendNotification
};
