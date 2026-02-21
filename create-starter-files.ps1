# create-starter-files.ps1
# Run from repository root. Creates frontend, backend, db, ai-handler files.

$enc = 'utf8'
function write-file($path, $content) {
  $dir = Split-Path $path -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  $content | Out-File -FilePath $path -Encoding $enc -Force
}

# frontend/package.json
write-file "frontend/package.json" @'
{
  "name": "sappadu-neram-frontend",
  "version": "0.1.0",
  "private": true,
  "main": "node_modules/expo/AppEntry.js",
  "scripts": {
    "start": "expo start",
    "android": "expo start --android",
    "ios": "expo start --ios",
    "web": "expo start --web"
  },
  "dependencies": {
    "expo": "~48.0.0",
    "react": "18.2.0",
    "react-native": "0.71.8",
    "@react-navigation/native": "^6.1.6",
    "@react-navigation/native-stack": "^6.9.12"
  }
}
'@

# frontend/App.js
write-file "frontend/App.js" @'
import React from "react";
import { SafeAreaView, StatusBar } from "react-native";
import AppNavigator from "./src/navigation/AppNavigator";

export default function App() {
  return (
    <SafeAreaView style={{ flex: 1 }}>
      <StatusBar />
      <AppNavigator />
    </SafeAreaView>
  );
}
'@

# frontend/src/components/Header.js
write-file "frontend/src/components/Header.js" @'
import React from "react";
import { View, Text } from "react-native";

export default function Header({ title }) {
  return (
    <View style={{ padding: 16, backgroundColor: "#fff", borderBottomWidth: 1, borderColor: "#eee" }}>
      <Text style={{ fontSize: 20, fontWeight: "600" }}>{title}</Text>
    </View>
  );
}
'@

# frontend/src/screens/LoginScreen.js
write-file "frontend/src/screens/LoginScreen.js" @'
import React, { useState } from "react";
import { View, Text, Button, TextInput } from "react-native";
import { login } from "../services/api";

export default function LoginScreen({ navigation }) {
  const [email, setEmail] = useState("dev@example.com");

  const doLogin = async () => {
    try {
      const res = await login({ email });
      if (res && res.token) {
        navigation.replace("Home");
      } else {
        alert("Login failed");
      }
    } catch (err) {
      alert("Error: " + String(err));
    }
  };

  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center", padding: 16 }}>
      <Text style={{ marginBottom: 8, fontSize: 18 }}>Login</Text>
      <TextInput
        placeholder="email"
        value={email}
        onChangeText={setEmail}
        style={{ width: "100%", padding: 8, borderWidth: 1, borderColor: "#ccc", marginBottom: 12 }}
        autoCapitalize="none"
      />
      <Button title="Login" onPress={doLogin} />
    </View>
  );
}
'@

# frontend/src/screens/HomeScreen.js
write-file "frontend/src/screens/HomeScreen.js" @'
import React, { useEffect, useState } from "react";
import { View, Text, Button, FlatList } from "react-native";
import Header from "../components/Header";
import { getRestaurants } from "../services/api";

export default function HomeScreen({ navigation }) {
  const [restaurants, setRestaurants] = useState([]);

  useEffect(() => {
    (async () => {
      try {
        const data = await getRestaurants();
        setRestaurants(Array.isArray(data) ? data : []);
      } catch (err) {
        console.warn("Failed to fetch restaurants", err);
      }
    })();
  }, []);

  return (
    <View style={{ flex: 1 }}>
      <Header title="SappaduNeram" />
      <View style={{ flex: 1, padding: 16 }}>
        <Button title="Open Cart" onPress={() => navigation.navigate("Cart")} />
        <Button title="Track Order" onPress={() => navigation.navigate("Tracking")} />

        <Text style={{ marginTop: 16, fontSize: 16 }}>Restaurants</Text>
        <FlatList
          data={restaurants}
          keyExtractor={(item) => String(item.id)}
          renderItem={({ item }) => (
            <View style={{ padding: 8, borderBottomWidth: 1, borderColor: "#eee" }}>
              <Text style={{ fontWeight: "600" }}>{item.name}</Text>
              <Text style={{ color: "#666" }}>{item.cuisine}</Text>
            </View>
          )}
        />
      </View>
    </View>
  );
}
'@

# frontend/src/screens/CartScreen.js
write-file "frontend/src/screens/CartScreen.js" @'
import React from "react";
import { View, Text } from "react-native";
import Header from "../components/Header";

export default function CartScreen() {
  return (
    <View style={{ flex: 1 }}>
      <Header title="Cart" />
      <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
        <Text>Your cart is empty.</Text>
      </View>
    </View>
  );
}
'@

# frontend/src/screens/TrackingScreen.js
write-file "frontend/src/screens/TrackingScreen.js" @'
import React from "react";
import { View, Text } from "react-native";
import Header from "../components/Header";

export default function TrackingScreen() {
  return (
    <View style={{ flex: 1 }}>
      <Header title="Tracking" />
      <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
        <Text>Order is being prepared.</Text>
      </View>
    </View>
  );
}
'@

# frontend/src/navigation/AppNavigator.js
write-file "frontend/src/navigation/AppNavigator.js" @'
import React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import LoginScreen from "../screens/LoginScreen";
import HomeScreen from "../screens/HomeScreen";
import CartScreen from "../screens/CartScreen";
import TrackingScreen from "../screens/TrackingScreen";

const Stack = createNativeStackNavigator();

export default function AppNavigator() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Login" screenOptions={{ headerShown: false }}>
        <Stack.Screen name="Login" component={LoginScreen} />
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Cart" component={CartScreen} />
        <Stack.Screen name="Tracking" component={TrackingScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
'@

# frontend/src/services/api.js
write-file "frontend/src/services/api.js" @'
const API_BASE = "http://localhost:3000/api";

async function request(path, options = {}) {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: { "Content-Type": "application/json" },
    ...options,
  });
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`API error ${res.status}: ${text}`);
  }
  return res.json();
}

export const getRestaurants = () => request("/restaurants");
export const login = (payload) => request("/users/login", { method: "POST", body: JSON.stringify(payload) });
'@

# backend/package.json
write-file "backend/package.json" @'
{
  "name": "sappadu-neram-backend",
  "version": "0.1.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "cors": "^2.8.5",
    "dotenv": "^16.0.0",
    "express": "^4.18.2",
    "pg": "^8.8.0"
  },
  "devDependencies": {
    "nodemon": "^2.0.22"
  }
}
'@

# backend/.env.example
write-file "backend/.env.example" @'
# Copy to .env and update
PORT=3000
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/sappadu
'@

# backend/server.js
write-file "backend/server.js" @'
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
'@

# backend/src/models/db.js
write-file "backend/src/models/db.js" @'
const { Pool } = require("pg");

const connectionString = process.env.DATABASE_URL || "postgresql://postgres:postgres@localhost:5432/sappadu";

const pool = new Pool({ connectionString });

module.exports = {
  query: (text, params) => pool.query(text, params),
  pool,
};
'@

# backend/src/routes/userRoutes.js
write-file "backend/src/routes/userRoutes.js" @'
const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

router.post("/login", userController.login);
router.get("/", userController.listUsers);

module.exports = router;
'@

# backend/src/routes/orderRoutes.js
write-file "backend/src/routes/orderRoutes.js" @'
const express = require("express");
const router = express.Router();
const orderController = require("../controllers/orderController");
const auth = require("../middleware/authMiddleware");

router.use(auth.requireAuth);
router.post("/", orderController.createOrder);
router.get("/:id", orderController.getOrder);

module.exports = router;
'@

# backend/src/routes/restaurantRoutes.js
write-file "backend/src/routes/restaurantRoutes.js" @'
const express = require("express");
const router = express.Router();
const restaurantController = require("../controllers/restaurantController");

router.get("/", restaurantController.listRestaurants);
router.get("/:id", restaurantController.getRestaurant);

module.exports = router;
'@

# backend/src/controllers/userController.js
write-file "backend/src/controllers/userController.js" @'
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
'@

# backend/src/controllers/orderController.js
write-file "backend/src/controllers/orderController.js" @'
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
'@

# backend/src/controllers/restaurantController.js
write-file "backend/src/controllers/restaurantController.js" @'
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
'@

# backend/src/middleware/authMiddleware.js
write-file "backend/src/middleware/authMiddleware.js" @'
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
'@

# db/schema.sql
write-file "db/schema.sql" @'
-- Schema for SappaduNeram (PostgreSQL)

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  password_hash TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS restaurants (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  cuisine TEXT,
  address TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  restaurant_id INTEGER REFERENCES restaurants(id),
  status TEXT DEFAULT ''placed'',
  total_cents INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  quantity INTEGER DEFAULT 1,
  price_cents INTEGER DEFAULT 0
);
'@

# db/migrations/001_initial.sql
write-file "db/migrations/001_initial.sql" @'
-- 001_initial.sql - initial schema

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  password_hash TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS restaurants (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  cuisine TEXT,
  address TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  restaurant_id INTEGER REFERENCES restaurants(id),
  status TEXT DEFAULT ''placed'',
  total_cents INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  quantity INTEGER DEFAULT 1,
  price_cents INTEGER DEFAULT 0
);
'@

# db/seed.sql
write-file "db/seed.sql" @'
-- seed.sql - minimal seed data

INSERT INTO users (email, name) VALUES
(''dev@example.com'', ''Developer'')
ON CONFLICT DO NOTHING;

INSERT INTO restaurants (name, cuisine, address) VALUES
(''Madras Mess'', ''South Indian'', ''Chennai''),
(''Annas Biryani'', ''Biryani'', ''Chennai'')
ON CONFLICT DO NOTHING;
'@

# ai-handler/upgradeMonitor.js
write-file "ai-handler/upgradeMonitor.js" @'
const fs = require("fs");

function checkForUpgrades() {
  console.log("[upgradeMonitor] Checking for package upgrades...");
  // In a real system this would check registries and safety policies
  const msg = `Checked at ${new Date().toISOString()}\n`;
  try {
    fs.appendFileSync("ai-handler/upgrade.log", msg);
  } catch (err) {
    console.warn("Failed to write log", err);
  }
}

if (require.main === module) {
  checkForUpgrades();
  console.log("Upgrade monitor finished.");
}

module.exports = { checkForUpgrades };
'@

# ai-handler/errorResolver.js
write-file "ai-handler/errorResolver.js" @'
function analyzeError(error) {
  if (!error) return { severity: "info", recommendation: "no error provided" };
  const message = error.message || String(error);
  if (message.match(/timeout|ETIMEDOUT/i)) {
    return { severity: "warning", recommendation: "check network/timeouts" };
  }
  if (message.match(/ECONNREFUSED|ENOTFOUND/i)) {
    return { severity: "critical", recommendation: "check endpoints and services" };
  }
  return { severity: "info", recommendation: "investigate logs" };
}

if (require.main === module) {
  const sample = analyzeError(new Error("ECONNREFUSED"));
  console.log("Sample analysis:", sample);
}

module.exports = { analyzeError };
'@

# ai-handler/tests/README.md
write-file "ai-handler/tests/README.md" @'
# Tests for AI handler

This directory is reserved for unit tests for upgradeMonitor.js and errorResolver.js.
'@

Write-Complete:
Write-Host "All files created. Install dependencies in frontend and backend and run services as needed."