const db = require("../models/db");

exports.listRestaurants = async (req, res) => {
  try {
    const result = await db.query("SELECT id, name, cuisine FROM restaurants LIMIT 50");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: "db error", details: err.message });
  }
};

exports.getRestaurant = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query("SELECT id, name, cuisine FROM restaurants WHERE id = $1", [id]);
    if (result.rows.length === 0) return res.status(404).json({ error: "not found" });
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "db error", details: err.message });
  }
};
