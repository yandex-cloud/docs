### Секреты, используемые MCP Gateway и Tools, рекомендуется хранить в сервисе Yandex Lockbox {#tool-secrets}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.tool-secrets ||
|#

#### Описание

**Как работает правило**: если в окружении есть ресурсы AI Studio, проверяется, что токены для подключения к Tools хранятся в сервисе [Yandex Lockbox](https://yandex.cloud/ru/services/lockbox).

Секреты, используемые MCP Gateway и Tools, должны храниться в [Yandex Lockbox](https://yandex.cloud/ru/services/lockbox).

Доступ к конфиденциальным данным секрета должен иметь только тот сервисный аккаунт, который действительно выполняет запросы к Tool, и его доступ должен быть ограничен конкретным секретом.

Для [Cloud Functions](https://yandex.cloud/ru/docs/functions/concepts/) и [Serverless Containers](https://yandex.cloud/ru/docs/serverless-containers/) следует использовать штатную передачу секретов в runtime-конфигурацию, чтобы в версии функции или ревизии контейнера хранилась ссылка на секрет, а не значение.

Для Workflows секреты не должны передаваться через входные параметры; workflow должен получать содержимое секрета runtime-доступом к Lockbox или через поддерживаемую безопасную интеграцию.

Для внешних HTTP Tools заголовок не должен храниться в незашифрованном виде в конфигурации MCP Gateway.

Контроль соответствует риску [OWASP MCP01:2025 Token Mismanagement and Secret Exposure](https://owasp.org/www-project-mcp-top-10/2025/MCP01-2025-Token-Mismanagement-and-Secret-Exposure).

#### Инструкции и решения по выполнению

1. Получите список MCP Gateway и прикрепленных Tools:

   ```bash
   yc serverless mcp-gateway list --format json; 
   ```

1. Для каждого Gateway выполните:

   ```bash
   yc serverless mcp-gateway get --name <gateway-name> --format json 
   ```
