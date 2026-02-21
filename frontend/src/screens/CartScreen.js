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
