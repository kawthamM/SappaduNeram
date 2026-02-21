const db = require("../models/db");

exports.createOrder = async (req, res) => {
  const { user_id, items } = req.body;
  if (!user_id || !items) return res.status(400).json({ error: "invalid payload" });
  // Basic stub - in a real app insert into db
  res.status(201).json({ id: Date.now(), user_id, items });
};

exports.getOrder = async (req, res) => {
  const { id } = req.params;
  res.json({ id, status: "preparing", items: [] });
};
