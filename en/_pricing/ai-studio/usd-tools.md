| **Service** | **Price per 1,000 requests,<br/>without VAT** |
|---------|-------------------------------------|
| Web Search tool | {{ sku|USD|yandexaistudio.requests.agent|string }} |
| File Search tool | {% calc [currency=USD] {{ sku|USD|aistudio.tool.filesearch|number }} × 1000 %} |
| {{ code-interpreter }} tool | Free of charge |
| MCP tool | {{ sku|USD|aistudio.tool.mcp|string }} |