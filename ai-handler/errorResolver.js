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
