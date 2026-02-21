const db = require("../models/db");

exports.login = async (req, res) => {
  const { email } = req.body;
  if (!email) return res.status(400).json({ error: "email required" });
  // Return a fake token for local development
  res.json({ token: "fake-token", user: { id: 1, email } });
};

exports.listUsers = async (req, res) => {
  try {
    const result = await db.query("SELECT id, email FROM users LIMIT 10");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: "db error", details: err.message });
  }
};
