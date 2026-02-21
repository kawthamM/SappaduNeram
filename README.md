# SappaduNeram 🍴

A Chennai-based food ordering app with Tamil-first experience.

---

## 📂 Project Structure

SappaduNeram/
│
├── frontend/                # React Native app
│   ├── src/
│   │   ├── components/      # Reusable UI components
│   │   │   └── Header.js
│   │   ├── screens/
│   │   │   ├── LoginScreen.js
│   │   │   ├── HomeScreen.js
│   │   │   ├── CartScreen.js
│   │   │   └── TrackingScreen.js
│   │   ├── navigation/
│   │   │   └── AppNavigator.js
│   │   ├── services/
│   │   │   └── api.js
│   │   └── assets/
│   ├── App.js
│   └── package.json
│
├── backend/                 # Node.js + Express server
│   ├── src/
│   │   ├── routes/
│   │   │   ├── userRoutes.js
│   │   │   ├── orderRoutes.js
│   │   │   └── restaurantRoutes.js
│   │   ├── controllers/
│   │   │   ├── userController.js
│   │   │   ├── orderController.js
│   │   │   └── restaurantController.js
│   │   ├── models/
│   │   │   └── db.js
│   │   ├── middleware/
│   │   │   └── authMiddleware.js
│   │   └── utils/
│   ├── server.js
│   └── package.json
│
├── db/
│   ├── schema.sql
│   ├── migrations/
│   └── seed.sql
│
├── ai-handler/
│   ├── upgradeMonitor.js
│   ├── errorResolver.js
│   └── tests/
│
├── docs/
│   ├── SappaduNeram_Documentation.docx
│   └── README.md
│
├── .gitignore
└── LICENSE (optional)


# SappaduNeram 🍴

A Chennai-based food ordering app with Tamil-first experience.

## Features
- Tamil/English bilingual interface
- Smart search (dish, cuisine, dietary preference)
- Festival specials (Pongal, Deepavali menus)
- Subscription meals (daily/weekly “sappadu” plans)
- AI food recommender (weather-based suggestions)
- Loyalty rewards & referral system
- Real-time order tracking

## Tech Stack
- Frontend: React Native (auto-upgrade enabled)
- Backend: Node.js + Express
- Database: PostgreSQL + Redis
- Cloud Hosting: AWS/Azure
- Authentication: Firebase Auth/Auth0
- Payments: Razorpay / Paytm / UPI
- Maps: Google Maps API
- AI Integration: Automated version upgrade handler with error resolution

## Workflow
1. User registers/logs in
2. Browse restaurants and dishes
3. Place order and pay
4. Restaurant confirms
5. Delivery partner assigned
6. Real-time tracking
7. Order completion

## Database Schema
See `SappaduNeram_Documentation.docx` for full schema.
