// Update timestamp on page load
document.addEventListener('DOMContentLoaded', function() {
    updateTimestamp();
    loadServerInfo();
});

function updateTimestamp() {
    const timestampElement = document.getElementById('timestamp');
    const now = new Date();
    timestampElement.textContent = now.toLocaleString();
}

async function loadServerInfo() {
    const serverInfoElement = document.getElementById('server-info');
    
    try {
        serverInfoElement.innerHTML = '<p>🔄 Loading server information...</p>';
        
        const response = await fetch('/api/health');
        const data = await response.json();
        
        serverInfoElement.innerHTML = `
            <p><strong>Status:</strong> ${data.status}</p>
            <p><strong>Server:</strong> ${data.server}</p>
            <p><strong>Version:</strong> ${data.version}</p>
            <p><strong>Timestamp:</strong> ${new Date(data.timestamp).toLocaleString()}</p>
            <p><strong>Response Time:</strong> ${response.status === 200 ? 'Fast' : 'Slow'}</p>
        `;
    } catch (error) {
        serverInfoElement.innerHTML = `
            <p><strong>Status:</strong> ❌ Error loading server info</p>
            <p><strong>Error:</strong> ${error.message}</p>
            <p><strong>Note:</strong> Server might be starting up or unavailable</p>
        `;
    }
}