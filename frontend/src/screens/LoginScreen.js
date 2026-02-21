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
