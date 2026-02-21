require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Routes
app.use("/api/users", require("./src/routes/userRoutes"));
app.use("/api/orders", require("./src/routes/orderRoutes"));
app.use("/api/restaurants", require("./src/routes/restaurantRoutes"));

app.get("/api/health", (req, res) => res.json({ status: "ok" }));

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
