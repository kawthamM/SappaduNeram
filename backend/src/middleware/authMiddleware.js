exports.requireAuth = (req, res, next) => {
  const auth = req.headers.authorization;
  if (!auth) return res.status(401).json({ error: "missing authorization" });
  const parts = auth.split(" ");
  if (parts.length !== 2 || parts[0] !== "Bearer") return res.status(401).json({ error: "invalid authorization" });
  const token = parts[1];
  if (token !== "fake-token") return res.status(403).json({ error: "forbidden" });
  req.user = { id: 1, email: "dev@example.com" };
  next();
};
