const express = require("express");
const path = require("path");
const app = express();

const PORT = process.env.PORT || 8080;

// Serve the landing page and any static assets from /public
app.use(express.static(path.join(__dirname, "public")));

// Health check route — kept separate from static serving so monitoring/deploy
// checks don't depend on the page itself rendering correctly.
app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok" });
});

app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
});
