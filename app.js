const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files from public directory
app.use(express.static('public'));

// Routes
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/api/health', (req, res) => {
    res.json({ 
        status: 'healthy', 
        timestamp: new Date().toISOString(),
        server: 'Afriture Terraform Lab',
        version: '1.0.0'
    });
});

app.listen(PORT, () => {
    console.log(`🚀 Afriture Lab Server running on port ${PORT}`);
    console.log(`🌍 Visit: http://localhost:${PORT}`);
});