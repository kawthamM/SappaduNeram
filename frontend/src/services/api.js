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
