
// Simple Node.js HTTP server
const http = require('http');

// Use PORT from environment or default to 3000
const port = process.env.PORT || 3000;

// Create HTTP server
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  // Respond with the value of the WEBTEXT environment variable
  const msg = process.env.WEBTEXT;
  res.end(msg);
});

// Start server and log the URL
server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}/`);
});
