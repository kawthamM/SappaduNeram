const express = require("express");
const router = express.Router();
const restaurantController = require("../controllers/restaurantController");

router.get("/", restaurantController.listRestaurants);
router.get("/:id", restaurantController.getRestaurant);

module.exports = router;
