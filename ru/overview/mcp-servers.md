---
title: MCP-серверы {{ yandex-cloud }} для AI-агентов и IDE
description: 'Подключите MCP-серверы {{ yandex-cloud }} к AI-агентам, ассистентам и IDE: управляйте инфраструктурой, Serverless-ресурсами и данными с помощью Model Context Protocol.'
keywords:
  - MCP Yandex Cloud
  - Yandex Cloud MCP Servers
  - ИИ-агент
  - AI-агент
  - AI-ассистент
  - Model Context Protocol Yandex Cloud
  - MCP-сервер для управления облаком
  - vibe coding
  - VibeDevOps
  - подключить Yandex Cloud к Cursor
  - подключить Yandex Cloud к Claude Code
  - Yandex Cloud CLI для агентов
  - yc mcp
  - npm @yandex-cloud/mcp
  - MCP-сервер Toolkit
  - MCP-сервер Functions
  - MCP-сервер Serverless Containers
  - MCP-сервер API Gateway
  - MCP-сервер Workflows
  - MCP-сервер Data Catalog
  - IAM-токен для MCP
  - Streamable HTTP MCP
---

# MCP-серверы {{ yandex-cloud }} для AI-агентов и IDE


[Model Context Protocol](../glossary/mcp.md) (MCP) — открытый стандарт, который подключает AI-приложения к внешним системам. Внешние системы делятся на три категории:


* источники данных, например, базы данных или файловые хранилища;
* инструменты, например, API или скрипты;
* рабочие процессы, например, сценарии, которые выполняются автоматически.

Без MCP для каждой пары «AI-приложение — внешняя система» пришлось бы писать отдельную интеграцию. MCP предоставляет единый интерфейс, с помощью которого любой MCP-клиент может обращаться к внешним инструментам по общим правилам.
В {{ yandex-cloud }} есть набор специализированных MCP-серверов для управления облачной инфраструктурой, Serverless-ресурсами и данными. С их помощью AI-агент может:

* создавать виртуальные машины;
* разворачивать функции и контейнеры;
* настраивать триггеры и рабочие процессы;
* искать метаданные в каталоге данных;
* обращаться к {{ yandex-cloud }} и веб-поиску.

## Доступные MCP-серверы {#available-servers}

#|
||
**Категория** | **MCP-сервер** | **Описание**
||
||
Инфраструктура
|
[Toolkit MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/toolkit-mcp-server/README.md)
|
Развертывает простые приложения с помощью сервисов [{{ compute-full-name }}](../compute/index.yaml), [{{ vpc-full-name }}](../vpc/index.yaml), [{{ iam-full-name }}](../iam/index.yaml), [{{ objstorage-full-name }}](../storage/index.yaml) и [{{ ydb-full-name }}](../ydb/index.yaml)
||
||
Поиск и знания
|
[Documentation MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/documentation-mcp-server/README.md)
|
Предоставляет доступ в реальном времени к официальной документации {{ yandex-cloud }} с помощью [генеративного поиска](mcp-doc-server.md)
||
||
Поиск и знания
|
[Search MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/search-mcp-server/README.md)
|
Выполняет классический и генеративный веб-поиск с помощью [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/concepts/)
||
||
Serverless
|
[Functions MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/functions-mcp-server/README.md)
|
Создает и развертывает функции [{{ sf-full-name }}](../functions/index.yaml), управляет их версиями, тегами и политиками масштабирования
||
||
Serverless
|
[Serverless Containers MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/containers-mcp-server/README.md)
|
Управляет контейнерами [{{ serverless-containers-full-name }}](../serverless-containers/index.yaml): развертывает ревизии, настраивает масштабирование и работает с реестром образов
||
||
Serverless
|
[Triggers MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/triggers-mcp-server/README.md)
|
Создает триггеры для функций и контейнеров, которые запускаются по таймеру или событиям других сервисов
||
||
Serverless
|
[Workflows MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/workflows-mcp-server/README.md)
|
Создает и запускает рабочие процессы [{{ sw-full-name }}]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow), описанные в YAML-спецификации, и управляет расписанием их запуска
||
||
Serverless
|
[API Gateway MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/apigateway-mcp-server/README.md)
|
Управляет шлюзами [{{ api-gw-full-name }}](../api-gateway/index.yaml): [OpenAPI](../glossary/openapi.md)-спецификациями, пользовательскими доменами и WebSocket-соединениями
||
||
Serverless
|
[MCP Gateway MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/mcpgateway-mcp-server/README.md)
|
Создает MCP-шлюзы и настраивает инструменты для вызова функций, контейнеров, HTTP-эндпоинтов и рабочих процессов
||
||
Данные
|
[Data Catalog Consumer MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/datacatalog-consumer-mcp-server/README.md)
|
Позволяет искать таблицы, представления и запросы, а также получать граф зависимостей в [{{ data-catalog-full-name }}](../metadata-hub/index.yaml)
||
|#

## Подключение {#connection}

MCP-серверы {{ yandex-cloud }} поддерживают два способа подключения: локально через [`npm-клиент`](https://www.npmjs.com/) (транспорт stdio) с автоматической аутентификацией и удаленно через [Streamable HTTP](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports#streamable-http).

### Предварительные требования {#prerequisites}

Чтобы подключить MCP-сервер {{ yandex-cloud }}, потребуется:

* Роль {{ yandex-cloud }} для работы с конкретным сервисом, например `editor` или `functions.admin`. Полный список ролей — в таблице [Конфигурация серверов](#server-configs).
* Node.js версии 18.0.0 или выше — при подключении через `npm`-клиент.
* [{{ yandex-cloud }} CLI](../cli/quickstart.md) — опционально, требуется только для аутентификации через CLI-профиль.

### NPM-клиент (stdio) {#npm-client}

`npm`-клиент [@yandex-cloud/mcp](https://www.npmjs.com/package/@yandex-cloud/mcp) запускает MCP-сервер локально и обеспечивает аутентификацию в {{ yandex-cloud }} одним из способов:

* OAuth — аутентификация через браузер без дополнительных флагов. Используется по умолчанию.
* OAuth с явным выбором аккаунта — параметр `-S <идентификатор_пользователя_или_сервисного_аккаунта>` или параметр `-u <email>`.
* Аутентификация через {{ yandex-cloud }} CLI — параметр `-p <профиль>` использует уже настроенный [профиль CLI](../cli/quickstart.md#initialize). Требует установленного {{ yandex-cloud }} CLI.
* Без аутентификации — параметр `--no-auth`. Подходит только для серверов, которым не требуется авторизация (например, для Documentation MCP-сервера).

Пример конфигурации:

```json
{
  "mcpServers": {
    "yandex-cloud-toolkit": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y", "@yandex-cloud/mcp",
        "-s", "toolkit"
      ]
    }
  }
}
```

Где:

* `-s, --server` — имя MCP-сервера, например `toolkit`, `search` или `functions`. Полный список имен серверов — в разделе [Конфигурация серверов](#server-configs).
* `-r, --region <REGION>` — регион {{ yandex-cloud }} для OAuth-аутентификации. Параметр принимает значения `ru` или `kz`. Значение по умолчанию — `ru`;
* `-H, --header <Key:Value>` — дополнительный заголовок для каждого вызова инструмента MCP-сервера. Параметр можно указать несколько раз, например, чтобы передать `Folder-Id`.

### Streamable HTTP {#streamable-http}

Для подключения через Streamable HTTP используйте [IAM-токен](../iam/concepts/authorization/iam-token.md), который можно получить с помощью {{ yandex-cloud }} CLI:

```bash
yc iam create-token
```

Для аутентификации от имени [сервисного аккаунта](../iam/concepts/users/service-accounts.md):

```bash
yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>
```

{% note info %}

IAM-токен действует не более {{ iam-token-lifetime }}. После истечения срока действия его нужно перевыпустить.

{% endnote %}

Пример конфигурации:

```json
{
  "mcpServers": {
    "yandex-cloud-toolkit": {
      "type": "streamableHttp",
      "url": "https://toolkit.mcp.cloud.yandex.net/mcp",
      "headers": {
        "Authorization": "Bearer <IAM-токен>"
      }
    }
  }
}
```

## Конфигурация серверов {#server-configs}

Параметры для подключения MCP-серверов:

#|
||
**MCP-сервер** | **Имя сервера для `npm`-клиента (`-s`)** | **URL для Streamable HTTP** | **Необходимая роль**
||
||
Toolkit
|
`toolkit`
|
`https://toolkit.mcp.cloud.yandex.net/mcp`
|
`editor` или `compute.admin`
||
||
Documentation
|
`docs`
|
`https://docs.mcp.cloud.yandex.net/mcp`
|
не требуется
||
||
Search
|
`search`
|
`https://search.mcp.cloud.yandex.net/mcp`
|
[`search-api.webSearch.user`](../iam/roles-reference.md#search-api-webSearch-user)
||
||
Functions
|
`functions`
|
`https://functions.mcp.cloud.yandex.net/mcp`
|
`editor` или [`functions.admin`](../functions/security/index.md#functions-admin)
||
||
Serverless Containers
|
`containers`
|
`https://containers.mcp.cloud.yandex.net/mcp`
|
`editor` или [`serverless-containers.admin`](../serverless-containers/security/index.md#serverless-containers-admin)
||
||
Triggers
|
`triggers`
|
`https://triggers.mcp.cloud.yandex.net/mcp`
|
`editor` или [`functions.admin`](../functions/security/index.md#functions-admin)
||
||
Workflows
|
`workflows`
|
`https://workflows.mcp.cloud.yandex.net/mcp`
|
`editor` или `serverless.workflows.admin`
||
||
API Gateway
|
`apigateway`
|
`https://apigateway.mcp.cloud.yandex.net/mcp`
|
`editor` или [`api-gateway.admin`](../api-gateway/security/index.md#api-gateway-admin)
||
||
MCP Gateway
|
`mcpgateway`
|
`https://mcpgateway.mcp.cloud.yandex.net/mcp`
|
`editor` или `serverless.mcpGateways.admin`
||
||
Data Catalog Consumer
|
`datacatalog-consumer`
|
`https://datacatalog-consumer.mcp.cloud.yandex.net/mcp`
|
[`data-catalog.viewer`](../metadata-hub/security/data-catalog-roles.md#data-catalog-viewer)
||
|#

Для серверов, которые обращаются к ресурсам каталога (Toolkit, Search, Functions, Serverless Containers, Triggers, Workflows, API Gateway, MCP Gateway), можно передать значения по умолчанию через заголовки:

* `Cloud-Id` — идентификатор облака для поля `cloud_id` в инструментах MCP-сервера;
* `Folder-Id` — идентификатор каталога для поля `folder_id` в инструментах MCP-сервера.

Пример для `npm`-клиента:

```bash
npx @yandex-cloud/mcp -s toolkit -H "Folder-Id:<идентификатор_каталога>"
```

## Примеры подключения {#examples}

Подключите MCP-сервер [вручную](#ide-examples) или [с помощью AI-агента](#connect-via-agent).

### Подключение через AI-агента {#connect-via-agent}

Чтобы настроить и подключить MCP-сервер, отправьте вашему AI-агенту следующую инструкцию:

```text
Подключи MCP-сервер {{ yandex-cloud }} через `npx @yandex-cloud/mcp -s <имя_сервера>`.
```

Где `<имя_сервера>` — значение из столбца **Имя сервера для `npm`-клиента (`-s`)** в [таблице](#server-configs).

AI-агент сам найдет файл конфигурации и добавит в него настройки MCP-сервера. Для этого ему нужен доступ к файловой системе и терминалу.

### Подключение для популярных IDE {#ide-examples}

Ниже пример подключения Toolkit MCP-сервера через `npm`-клиент. Чтобы подключить другой сервер, замените имя сервера `toolkit` в параметре `-s` на значение из [таблицы](#server-configs). Если вы используете Streamable HTTP, замените также [URL](#server-configs) сервера.

{% list tabs %}

- {{ ca-full-name }}

  {{ ca-full-name }} поддерживает два уровня конфигурации: глобальный и проектный. Подробнее в [документации {{ ca-name }}]({{ link-src-docs }}/code-assistant/operations/agent/mcp/overview).

  1. Нажмите ![image](../_assets/console-icons/ellipsis.svg) в верхней панели чата и выберите MCP-серверы.
  1. Выберите соответствующую опцию:
      * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP** — открывает глобальный файл `mcp_settings.json`.
      * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP** — открывает проектный файл `.codeassistant/mcp.json`. Если этот файл отсутствует, {{ ca-name }} создаст его автоматически.
  1. Добавьте конфигурацию в файл:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Сохраните файл.

- Claude Code

  [Claude Code](https://claude.com) поддерживает два уровня конфигурации: глобальный и проектный. Подробнее в [документации Claude Code](https://docs.claude.com/en/docs/claude-code/mcp?utm_source=openai).

  1. Откройте файл `.mcp.json` в корне проекта (для проектной конфигурации) или `~/.mcp.json` в домашней директории (для глобальной).
  1. Добавьте конфигурацию в файл:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Сохраните файл.

  Проверьте подключение:

  ```bash
  claude mcp get yandex-cloud-toolkit
  ```

- Cursor

  Cursor поддерживает MCP-серверы через файл `mcp.json`. Подробнее в [документации Cursor](https://cursor.com/docs/mcp).

  1. Создайте файл `.cursor/mcp.json` в корне проекта (для проектной конфигурации) или `~/.cursor/mcp.json` в домашней директории (для глобальной).
  1. Добавьте конфигурацию в файл:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Сохраните файл и перезапустите Cursor или обновите список MCP-серверов в настройках.

- OpenAI Codex

  [Codex](https://github.com/openai/codex) настраивает MCP-серверы в файле `~/.codex/config.toml`. Подробнее в [документации Codex](https://mintlify.wiki/openai/codex/configuration/mcp-servers).

  1. Откройте файл `~/.codex/config.toml`.
  1. Добавьте конфигурацию в файл:

     ```toml
     [mcp_servers.yandex-cloud-toolkit]
     command = "npx"
     args = ["-y", "@yandex-cloud/mcp", "-s", "toolkit"]
     ```

  1. Сохраните файл и перезапустите Codex.

- Zoo Code

  Zoo Code поддерживает два уровня конфигурации: глобальный и проектный. Подробнее в [документации Zoo Code](https://docs.zoocode.dev/features/mcp/overview).

  1. Нажмите ![image](../_assets/console-icons/gear.svg) в верхней панели чата.
  1. На панели слева выберите ![image](../_assets/layout-split-rows-dots.svg) **MCP Servers**.
  1. Выберите соответствующую опцию:
     * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP** — открывает глобальный файл `mcp_settings.json`.
     * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP** — открывает проектный файл `.roo/mcp.json`. Если этот файл отсутствует, Zoo Code создаст его автоматически.
  1. Добавьте конфигурацию в файл:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Сохраните файл.

{% endlist %}

## {{ yandex-cloud }} CLI как альтернатива для агентов {#cli-for-agents}

Если AI-агент имеет доступ к терминалу, он может управлять ресурсами {{ yandex-cloud }} напрямую через [{{ yandex-cloud }} CLI](../cli/quickstart.md) — без подключения MCP-сервера. Такой способ полезен, когда агенту нужны команды, которых еще нет среди инструментов MCP-серверов, либо когда терминал уже доступен агенту как основной инструмент.

Чтобы агент мог использовать CLI:

1. [Установите](../cli/quickstart.md#install) {{ yandex-cloud }} CLI в окружении, где работает агент.
1. [Создайте профиль](../cli/quickstart.md#initialize). Для этого войдите от имени пользователя или [сервисного аккаунта](../cli/operations/authentication/service-account.md).
1. Добавьте параметр `--format json` к командам CLI, чтобы агент мог структурированно обрабатывать вывод, например:

   ```bash
   yc compute instance list --format json
   ```

Роли, необходимые для конкретных операций CLI, совпадают с ролями для соответствующего MCP-сервера. Полный список ролей — в таблице [Конфигурация серверов](#server-configs).

## Проверка работы {#testing}

После подключения попросите AI-агента вызвать один из инструментов MCP-сервера.

Примеры запросов:

> Разверни виртуальную машину в {{ yandex-cloud }} с публичным IP-адресом.

> Найди в документации {{ yandex-cloud }}, как настроить {{ TF }} provider.

> Создай бакет {{ objstorage-name }} для статического сайта.

Если подключение работает, AI-агент вызовет соответствующий инструмент MCP-сервера и вернет результат выполнения операции.

#### Полезные ссылки {#see-also}

* [Репозиторий Yandex Cloud MCP на GitHub](https://github.com/yandex-cloud/mcp)
* [Пакет @yandex-cloud/mcp в npm](https://www.npmjs.com/package/@yandex-cloud/mcp)
* [{#T}](mcp-doc-server.md)


* [{#T}](../glossary/mcp.md)


* [{#T}](../iam/concepts/authorization/iam-token.md)
* [{#T}](../cli/quickstart.md)
* [Рекомендуемые MCP-серверы {{ ca-name }}]({{ link-src-docs }}/code-assistant/operations/agent/mcp/recommended-mcp-servers)
