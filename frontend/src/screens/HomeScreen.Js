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
