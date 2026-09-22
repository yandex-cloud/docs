### Используйте публичные MCP-серверы только при необходимости {#public-mcp}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.public-mcp ||
|#

#### Описание

**Как работает правило**: проверятся, является ли публичным созданный MCP-сервер

MCP Gateway должен быть приватным по умолчанию. Публичный доступ расширяет поверхность атаки и создает риск несанкционированного вызова Tools и агентской логики. Особенно опасна привязка к публичной группе [`allUsers`](https://yandex.cloud/ru/docs/iam/concepts/access-control/public-group#allUsers) с ролью `serverless.mcpGateways.anonymousInvoker`, так как она разрешает анонимный вызов MCP Gateway.

Доступ на группу [`allAuthenticatedUsers`](https://yandex.cloud/ru/docs/iam/concepts/access-control/public-group#allAuthenticatedUsers) с ролью, позволяющей вызывать ресурс или сервис, также считается публичным, хотя и требует аутентификации в Yandex Cloud.

Контроль соответствует [OWASP MCP07:2025 Insufficient Authentication & Authorization](https://owasp.org/www-project-mcp-top-10/2025/MCP07-2025–Insufficient-Authentication&Authorization).

#### Инструкции и решения по выполнению

1. Получите список MCP Gateway: 

   ```bash
   yc serverless mcp-gateway list --format json 
   ``` 

1. Для каждого Gateway проверьте доступ на публичную группу: 

   ```bash 
   yc serverless mcp-gateway list-access-bindings --name <name> --format json 
   ```
