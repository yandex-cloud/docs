### Не используйте сервисные аккаунты с высокими привилегиями для MCP-серверов, функций и рабочих процессов {#mcp-sa-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | ai.mcp-sa-privileges ||
|#

#### Описание

**Как работает правило**: у сервисных аккаунтов проверяется наличие прав выше роли `editor`, назначенных на MCP-серверы, функции и рабочие процессы, реализующие Tools или отдельных шагов таких рабочих процессов.

Через компрометацию сервисного аккаунта, от имени которого выполняется агентский workload, злоумышленник может получить доступ за пределы одного Tool или Gateway.

Для MCP-серверов и агентских workloads особенно опасны роли управления сервисом [Yandex Identity and Access Management](https://yandex.cloud/ru/docs/iam/security/#service-roles), [сервисными аккаунтами](https://yandex.cloud/ru/docs/iam/security/#iam-serviceAccounts-admin), [секретами Lockbox](https://yandex.cloud/ru/docs/lockbox/concepts/secret), [ключами KMS](https://yandex.cloud/ru/docs/kms/concepts/), [контейнерами Serverless](https://yandex.cloud/ru/docs/serverless-containers/concepts/container), объектными хранилищами, и роль [`organization-manager`](https://yandex.cloud/ru/docs/organization/security/#organization-manager-organizations-owner).

Примитивные роли `admin` и `editor` недопустимы для сервисного аккаунта, от имени которого выполняется агентский workload, без исключения. Роли чтения `viewer` и `auditor` не всегда административные, но могут приводить к утечке данных и требуют отдельного обоснования необходимости .

#### Инструкции и решения по выполнению

1. Получите инвентаризацию MCP Gateway, Functions, Containers и Workflows. 
1. Для каждого ресурса определите `serviceAccountId`: 

   ```bash 
   yc serverless function get --name <name> --format json 
   ``` 
   
1. Отзовите доступы с помощью [Модуля диагностики доступов (CIEM)](https://yandex.cloud/ru/docs/security-deck/operations/ciem/revoke-permissions).
