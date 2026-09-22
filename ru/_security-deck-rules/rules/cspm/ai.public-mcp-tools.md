### К публичным MCP-серверам не следует подключать непубличные функции, workflows и Tools, требующие авторизации {#public-mcp-tools}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.public-mcp-tools ||
|#

#### Описание

**Как работает правило**: проверяется, что привязанные к MCP-серверу функции, workflows и Tools являются публичными.

Это сценарий, в котором может быть реализована уязвимость Confused Deputy и в котором может произойти злоупотребление прокси (proxy abuse): внешний субъект использует публичный MCP Gateway как посредника для вызова внутреннего Tool.

Риск возникает даже если сам Tool не публичен напрямую: достаточно, что публичный Gateway имеет сервисный аккаунт с доступом  с доступом, который позволяет обращаться к внутреннему Tool.

Контроль связан с [OWASP MCP07:2025 Insufficient Authentication & Authorization](https://owasp.org/www-project-mcp-top-10/2025/MCP07-2025–Insufficient-Authentication&Authorization) и рисками избыточных полномочий.

#### Инструкции и решения по выполнению

1. Найдите публичные MCP Gateway, используя проверку по правилу [Используйте публичные MCP-серверы только при необходимости](#public-mcp). 
1. Получите список Tools публичного Gateway: 

   ```bash
   yc serverless mcp-gateway get --name <gateway-name> --format json 
   ```
