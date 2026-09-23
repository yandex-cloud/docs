---
title: Использование {{ datalens-full-name }} с AI-агентами
description: Из этой статьи вы узнаете, как начать работать с AI-агентами в {{ datalens-name }}.
---

# Использование {{ datalens-full-name }} с AI-агентами

Вы можете использовать AI-агенты для работы с {{ datalens-name }}. Например, [Claude Code](https://claude.com/claude-code), [Codex](https://developers.openai.com/codex), [OpenCode](https://opencode.ai) и другие. Для этого нужно подключить {{ datalens-name }} к AI-агенту с помощью [MCP-сервера](../concepts/ai-agents.md#mcp) или [Python SDK](../concepts/ai-agents.md#sdk) и установить [навыки](../concepts/ai-agents.md#skills).


## Перед началом работы {#before-you-begin}

* Убедитесь, что у вас есть доступ к [{{ yandex-cloud }}]({{ link-console-main }}) и [{{ datalens-name }}]({{ link-datalens-main }}).
* Подготовьте объект в {{ datalens-name }}, с которым будет работать AI-агент: создайте новый [воркбук](../workbooks-collections/index.md) или выберите существующий. Для проверки сценария создания [чарта](../concepts/chart/index.md) в воркбуке должен быть доступный [датасет](../dataset/index.md).
* Убедитесь, что у вас есть права на редактирование выбранного воркбука и объектов, с которыми будет работать AI-агент.



{% note info %}

Не рекомендуется смешивать MCP и SDK в рамках одной задачи.

{% endnote %}


## Подключите {{ datalens-name }} к AI-агенту {#connect-agent}

Чтобы подключить {{ datalens-name }} к AI-агенту, добавьте MCP-сервер в AI-агент или установите [datalens-sdk](https://pypi.org/project/datalens-sdk/) — типизированный Python SDK для API {{ datalens-name }}.

{% list tabs group="instructions" %}

- Claude Code {#claude-code}

  Добавьте сервер командой:

  ```bash
  claude mcp add datalens \
    --env DATALENS_ORG_ID=<идентификатор_организации> \
    -- npx -y @datalens-tech/mcp@latest
  ```

  Или опишите сервер в корневой папке проекта в файле `.mcp.json`, чтобы конфигурация была общей для команды:

  ```json
  {
    "mcpServers": {
      "datalens": {
        "command": "npx",
        "args": ["-y", "@datalens-tech/mcp@latest"],
        "env": {
          "DATALENS_ORG_ID": "<идентификатор_организации>"
        }
      }
    }
  }
  ```

  Такой же формат конфигурации используется в Claude Desktop в файле `claude_desktop_config.json`

- Codex {#codex}

  Добавьте секцию в файл `~/.codex/config.toml`:

  ```toml
  [mcp_servers.datalens]
  command = "npx"
  args = ["-y", "@datalens-tech/mcp@latest"]

  [mcp_servers.datalens.env]
  DATALENS_ORG_ID = "<идентификатор_организации>"
  ```

- OpenCode {#opencode}

  Добавьте секцию `mcp` в файл `opencode.json`:

  ```json
  {
    "$schema": "https://opencode.ai/config.json",
    "mcp": {
      "datalens": {
        "type": "local",
        "command": ["npx", "-y", "@datalens-tech/mcp@latest"],
        "environment": {
          "DATALENS_ORG_ID": "<идентификатор_организации>"
        }
      }
    }
  }
  ```

  {% note tip %}

  Рекомендуется запуск через `npx` — пакет загружается по запросу и не требует установки. Альтернативные способы: локальная сборка из [репозитория](https://github.com/datalens-tech/datalens-mcp) или глобальная установка с помощью `npm install -g @datalens-tech/mcp` и команды `datalens-mcp`.

  {% endnote %}

- Python SDK {#sdk}

  Выполните команду:

  ```bash
  pip install datalens-sdk
  ```

  **Пример**

  В этом примере предполагается, что клиент по умолчанию использует активный профиль {{ yandex-cloud }} CLI и сам обновляет IAM-токены:

  ```python
  from datalens_sdk import {{ datalens-name }}ClientYC

  with {{ datalens-name }}ClientYC() as client:
      dataset = client.get.dataset(by_id="<идентификатор_датасета>")
      print(dataset.name)
  ```

  Основные возможности:

  * `client.get` — загрузка объектов: датасетов, чартов, дашбордов, воркбуков, коллекций.
  * `client.create` — типизированные fluent-билдеры для создания объектов.
  * Операции над объектами — `.rename()`, `.update()`, `.delete()`.
  * Экспорт JSON-снимков объектов в файлы и создание объектов из снимков (`client.raw`).
  * Экспорт дашборда вместе с зависимостями — чартами и датасетами.

  Способы авторизации:

  * Профиль {{ yandex-cloud }} CLI (по умолчанию).
  * Ключ сервисного аккаунта, статический IAM-токен.


  {% note warning %}

  SDK находится в альфа-версии (0.x): до релиза 1.0 минорные версии могут содержать несовместимые изменения. Поэтому при работе через AI-агентов следует использовать SDK в паре с навыком `datalens-sdk`.

  {% endnote %}

{% endlist %}

{% note info %}

MCP-сервер и SDK поддерживают статическую авторизацию готовым IAM-токеном. Это позволяет использовать AI-агенты, когда {{ yandex-cloud }} CLI недоступен, например в изолированном окружении. Срок жизни IAM-токена — 12 часов, и обновлять его в этом режиме нужно самостоятельно.

{% endnote %}


## Установите навыки {#install-skills}

Чтобы AI-агент учитывал модель объектов {{ datalens-name }} и выбирал подходящие инструменты для задачи, установите навыки `datalens-skills`.

{% list tabs group="instructions" %}

- Универсальный способ {#npx}

  CLI `skills` автоматически определяет установленные AI-агенты.

  Выполните команды:

  ```bash
  npx skills add datalens-tech/datalens-skills --skill datalens
  npx skills add datalens-tech/datalens-skills --skill datalens-sdk
  ```

  {% note tip %}

  Используйте флаги:

  * `--agent '*'` — установить во все обнаруженные AI-агенты.
  * `-g` — глобально для всех проектов.
  * `--list` — показать список доступных навыков.

  {% endnote %}

- Claude Code {#claude-code}

  Репозиторий работает как plugin marketplace.

  Выполните команды:

  ```text
  /plugin marketplace add datalens-tech/datalens-skills
  /plugin install datalens-skills@datalens
  ```

- Codex {#codex}

  1. Установите CLI версии 0.142.0 и выше.
  1. Выполните команды установки:

      ```bash
      codex plugin marketplace add datalens-tech/datalens-skills
      codex plugin add datalens-skills@datalens
      ```

      При установке через плагин навыки получают префикс, например `datalens-skills:datalens-sdk`. 

- Вручную {#manual}

  Скопируйте нужные папки из `skills/` в папку, которую сканирует AI-агент:

  | AI-агент | В проекте | Глобально |
  | --- | --- | --- |
  | Claude Code | `.claude/skills/`   | `~/.claude/skills/` |
  | Codex       | `.agents/skills/`   | `~/.agents/skills/` |
  | OpenCode    | `.opencode/skills/` | `~/.config/opencode/skills/` |

  {% note tip %}

  Папка `.agents/skills/` вендор-нейтральна: ее читают и Codex, и OpenCode. OpenCode также читает `.claude/skills/`, поэтому одной установки часто достаточно для нескольких AI-агентов.

  {% endnote %}

{% endlist %}


## Отправьте запрос {#send-request}

После подключения {{ datalens-name }} к AI-агенту и установки навыков сформулируйте задачу на естественном языке и укажите идентификаторы объектов, с которыми нужно работать.

1. Запустите новую сессию AI-агента.
1. Отправьте запрос через AI-агент.


### Типовые сценарии {#examples}

Ниже приведены примеры запросов к AI-агенту с установленными навыками и MCP-сервером.

* **Аудит зависимостей**

    Запрос:

    ```text
    Найди все чарты и дашборды, которые используют датасет <идентификатор_датасета>.
    ```

    Результат: AI-агент вызовет команды навигации и Relations API через MCP.

* **Клонирование контента**

    Запрос:

    ```text
    Склонируй дашборд <идентификатор_дашборда> со всеми чартами и датасетами
    в воркбук <идентификатор_воркбука>.
    ```

    Результат: AI-агент напишет скрипт на SDK с экспортом зависимостей.

* **Создание с нуля**

    Запрос:

    ```text
    Подключись к базе, создай датасет с вычисляемым полем маржи
    и собери дашборд с продажами по регионам.
    ```

    Результат: AI-агент построит цепочку: подключение → датасет → чарты → дашборд.

* **Массовые изменения**

    Задача для SDK: цикл по объектам с типизированными обновлениями.

    Запрос:

    ```text
    Во всех датасетах воркбука переименуй поле «revenue» в «Выручка».
    ```

    Результат: AI-агент переименует указанные поля.

* **AI-отчет**

    Запрос:

    ```text
    Собери HTML-отчет по итогам квартала и опубликуй его в {{ datalens-name }}.
    ```

    Результат: навык `datalens-html-pages` проведет через создание, валидацию и публикацию страницы.


## Полезные ссылки {#see-also}

* [{#T}](../concepts/ai-agents.md)
* [{#T}](../operations/api-start.md)
* [MCP-сервер @datalens-tech/mcp](https://github.com/datalens-tech/datalens-mcp)
* [npm](https://www.npmjs.com/package/@datalens-tech/mcp)
* [Коллекция навыков datalens-skills](https://github.com/datalens-tech/datalens-skills)
* [Python SDK datalens-sdk](https://pypi.org/project/datalens-sdk/)
* [Стандарт Agent Skills](https://agentskills.io)
* [Model Context Protocol](https://modelcontextprotocol.io)