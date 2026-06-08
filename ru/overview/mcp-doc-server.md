---
title: MCP-сервер документации для AI-ассистентов, агентов и IDE
description: 'Настройте MCP-сервер для подключения документации {{ yandex-cloud }} к AI-ассистентам, агентам и IDE: Cursor, Claude Code, OpenAI Codex, Zoo Code и другим MCP-клиентам.'
keywords:
  - ИИ-агент
  - AI-агент
  - AI-ассистент
  - LLM
  - нейросеть
  - vibe coding
  - документация в IDE
  - актуальная документация для ИИ
  - Markdown документация Yandex Cloud
  - md-doc
  - MCP-сервер документации Yandex Cloud
  - Yandex Cloud Documentation MCP Server
  - MCP документация Yandex Cloud
  - документация Yandex Cloud в AI-инструментах
  - документация Yandex Cloud для нейросетей
  - как подключить документацию Yandex Cloud к Cursor
  - как подключить документацию Yandex Cloud к Claude Code
  - как подключить документацию Yandex Cloud к Codex
  - настройка MCP-сервера Yandex Cloud
  - mcpServers конфигурация Yandex Cloud
  - подключить документацию Yandex Cloud к AI-ассистент
  - Yandex Cloud docs MCP Cursor
  - Yandex Cloud documentation MCP Claude Code
  - Yandex Cloud MCP OpenAI Codex
  - MCP сервер Yandex Cloud SourceCraft Code Assistant
  - Zoo Code Yandex Cloud MCP
  - documentation_generative_search
  - docs.mcp.cloud.yandex.net
  - Streamable HTTP MCP
  - генеративный поиск по документации
  - Model Context Protocol Yandex Cloud
  - MCP сервер без авторизации
---

# Документация {{ yandex-cloud }} в AI‑инструментах

## Документация в Markdown {#doc-markdown}

{{ yandex-cloud }} предоставляет всю документацию в формате Markdown для использования в качестве контекста AI‑инструментов в IDE, таких как [Cursor](https://cursor.com), Visual Studio Code с [GitHub Copilot](https://docs.github.com/ru/copilot), [Continue](https://www.continue.dev/), [Cline](https://cline.bot/) и других ассистентов. Это помогает модели отвечать с учетом актуальной информации, использовать правильные названия сервисов, параметры CLI и API, а также примеры конфигурации.

Документация в формате Markdown доступна по адресу:
[https://md-docs.website.yandexcloud.net/](https://md-docs.website.yandexcloud.net/)

## MCP-сервер поиска по документации {{ yandex-cloud }} {#yc-docs-search-mcp}

[{{ yandex-cloud }} Documentation MCP-сервер](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/documentation-mcp-server/README.md) обеспечивает доступ в реальном времени к официальной документации {{ yandex-cloud }} с помощью генеративного поиска. Сервер предоставляет AI‑ассистентам инструмент `documentation_generative_search`.

Вы можете добавить MCP-сервер в любую IDE, поддерживающую протокол MCP. Для работы сервера не требуется авторизация или токены.

### Подключение {#connect}

{{ yandex-cloud }} Documentation MCP-сервер доступен через транспорт Streamable HTTP по адресу:

```text
https://docs.mcp.cloud.yandex.net/mcp
```

### Конфигурация {#config}

Пример конфигурации MCP-сервера:

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "type": "streamableHttp",
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

Где:

* `type` — транспорт Streamable HTTP. Возможные значения:
  * `streamableHttp` — в формате CamelCase;
  * `streamable-http` — в формате kebab-case;
  * `http` — упрощенный вариант для клиентов, поддерживающих потоковую передачу по умолчанию.

## Примеры подключения для популярных IDE {#ide-examples}

{% list tabs %}

- {{ ca-full-name }}

  {{ ca-full-name }} поддерживает два уровня конфигурации: глобальный и проектный. Для удаленных серверов {{ ca-name }} использует транспорт Streamable HTTP, где поле `type` должно быть задано как `streamable-http`. Подробнее в [документации {{ ca-name }}]({{ link-src-docs }}/code-assistant/operations/agent/mcp/overview).

  Вы можете редактировать как глобальные, так и проектные файлы конфигурации MCP прямо из меню настроек MCP в {{ ca-name }}:
  
  1. Нажмите ![image](../_assets/console-icons/ellipsis.svg) в верхней панели чата и выберите MCP-серверы.
  1. Выберите соответствующую опцию:
      * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP** — открывает глобальный файл `mcp_settings.json`.
      * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP** — открывает проектный файл `.codeassistant/mcp.json`. Если этот файл отсутствует, {{ ca-name }} создаст его автоматически.

  1. Добавьте конфигурацию в файл:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-documentation": {
           "type": "streamable-http",
           "url": "https://docs.mcp.cloud.yandex.net/mcp"
         }
       }
     }
     ```

  1. Сохраните файл.

- Claude Code

  [Claude Code](https://claude.com) поддерживает два уровня конфигурации: глобальный и проектный. Для удаленных серверов Claude Code использует транспорт HTTP. Подробнее в [документации Claude Code](https://docs.claude.com/en/docs/claude-code/mcp?utm_source=openai).

  {% list tabs %}
  
  - Подключение для проекта

    1. Откройте файл `.mcp.json` в корне проекта.

    1. Добавьте конфигурацию в файл:

       * Через транспорт HTTP:

         ```bash
         claude mcp add --transport http yandex-cloud-documentation \
           --scope project \
           https://docs.mcp.cloud.yandex.net/mcp
         ```

       * Через JSON-конфигурацию:

         ```json
         {
           "mcpServers": {
             "yandex-cloud-documentation": {
               "type": "http",
               "url": "https://docs.mcp.cloud.yandex.net/mcp"
             }
           }
         }
         ```

    1. Сохраните файл.

  - Подключение для пользователя

    1. Откройте файл `~/.mcp.json` в домашней директории.

    1. Добавьте конфигурацию в файл:

       * Через транспорт HTTP:

         ```bash
         claude mcp add --transport http yandex-cloud-documentation \
           --scope user \
           https://docs.mcp.cloud.yandex.net/mcp
         ```

       * Через JSON-конфигурацию:

         ```json
         {
           "mcpServers": {
             "yandex-cloud-documentation": {
               "type": "http",
               "url": "https://docs.mcp.cloud.yandex.net/mcp"
             }
           }
         }
         ```

    1. Сохраните файл.

  {% endlist %}
  
  Проверьте подключение одним из способов:
  
  * В терминале:

    ```bash
    claude mcp get yandex-cloud-documentation
    ```

  * В интерфейсе Claude Code:

    ```text
    /mcp
    ```

- Cursor

  Cursor поддерживает MCP-серверы через файл `mcp.json`. Конфигурацию можно добавить глобально или только для проекта. Подробнее в [документации Cursor](https://cursor.com/docs/mcp).

  1. Создайте файл:

     * Для проектной конфигурации — в корне проекта:

       ```text
       .cursor/mcp.json
       ```

     * Для глобальной конфигурации — в домашней директории:

       ```text
       ~/.cursor/mcp.json
       ```

  1. Добавьте конфигурацию в файл:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-documentation": {
           "type": "streamableHttp",
           "url": "https://docs.mcp.cloud.yandex.net/mcp"
         }
       }
     }
     ```

  1. Сохраните файл и перезапустите Cursor или обновите список MCP-серверов в настройках.

- OpenAI Codex

  [Codex](https://github.com/openai/codex) поддерживает удаленные MCP-серверы через Streamable HTTP: для такого сервера нужно указать поле `url`. MCP-серверы настраиваются в файле `~/.codex/config.toml`. Подробнее в [документации Codex](https://mintlify.wiki/openai/codex/configuration/mcp-servers).

  {% list tabs %}
  
  - Подключение через config.toml
    
    1. Откройте файл `~/.codex/config.toml`.

    1. Добавьте конфигурацию в файл:

       ```toml
       [mcp_servers.yandex-cloud-documentation]
       url = "https://docs.mcp.cloud.yandex.net/mcp"
       enabled = true
       ```

    1. Сохраните файл и перезапустите Codex.

  - Подключение через CLI

    Если ваша версия Codex поддерживает добавление удаленных HTTP MCP-серверов через CLI, выполните команду:

    ```bash
    codex mcp add yandex-cloud-documentation \
      --url https://docs.mcp.cloud.yandex.net/mcp
    ```

  {% endlist %}

- Zoo Code

  Zoo Code поддерживает два уровня конфигурации: глобальный и проектный. Для удаленных серверов Zoo Code использует транспорт Streamable HTTP, где поле `type` должно быть задано как `streamable-http`. Подробнее в [документации Zoo Code](https://docs.zoocode.dev/features/mcp/overview).

  Вы можете редактировать как глобальные, так и проектные файлы конфигурации MCP прямо из меню настроек MCP в Zoo Code:

  1. Нажмите ![image](../_assets/console-icons/gear.svg) в верхней панели чата.
  1. На панели слева выберите ![image](../_assets/layout-split-rows-dots.svg) **MCP Servers**.
  1. Выберите соответствующую опцию:
     * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP** — открывает глобальный файл `mcp_settings.json`.
     * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP** — открывает проектный файл `.roo/mcp.json`. Если этот файл отсутствует, Zoo Code создаст его автоматически.

  1. Добавьте конфигурацию в файл:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-documentation": {
           "type": "streamable-http",
           "url": "https://docs.mcp.cloud.yandex.net/mcp"
         }
       }
     }
     ```

  1. Сохраните файл.

{% endlist %}

## Универсальная конфигурация {#universal-config}

Если ваш MCP-клиент поддерживает JSON-конфигурацию с `mcpServers`, для подключения используйте один из вариантов ниже.

### Для клиентов с `streamableHttp` {#camel-case}

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "type": "streamableHttp",
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

### Для клиентов с `streamable-http` {#kebab-case}

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "type": "streamable-http",
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

### Для клиентов, которые определяют транспорт по URL {#url-only}

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

## Проверка работы {#testing}

После подключения попросите AI‑ассистента найти информацию в документации {{ yandex-cloud }}. 

Примеры запросов:

> Используй документацию {{ yandex-cloud }} и расскажи, как установить YC CLI.

> Найди в документации {{ yandex-cloud }}, как настроить {{ TF }} provider.

Если подключение работает, AI‑ассистент сможет вызвать инструмент MCP-сервера `documentation_generative_search` и вернуть ответ на основе документации {{ yandex-cloud }}.

## Внешние инструменты {#external-tools}

### Context7 {#context7}

[Context7](https://github.com/upstash/context7) — это MCP-сервер, разработанный компанией Upstash. Он предоставляет AI-ассистентам и редакторам кода актуальную документацию и примеры кода, специфичные для текущей версии библиотек.

Для работы с документацией {{ yandex-cloud }} используйте [репозиторий](https://context7.com/yandex-cloud/docs) Context7. Подробнее о настройке в [инструкции](https://github.com/upstash/context7#installation).
