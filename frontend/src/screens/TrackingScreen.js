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
