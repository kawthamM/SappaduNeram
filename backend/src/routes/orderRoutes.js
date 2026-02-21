const express = require("express");
const router = express.Router();
const orderController = require("../controllers/orderController");
const auth = require("../middleware/authMiddleware");

router.use(auth.requireAuth);
router.post("/", orderController.createOrder);
router.get("/:id", orderController.getOrder);

module.exports = router;
