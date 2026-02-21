import React from "react";
import { View, Text } from "react-native";

export default function Header({ title }) {
  return (
    <View style={{ padding: 16, backgroundColor: "#fff", borderBottomWidth: 1, borderColor: "#eee" }}>
      <Text style={{ fontSize: 20, fontWeight: "600" }}>{title}</Text>
    </View>
  );
}
