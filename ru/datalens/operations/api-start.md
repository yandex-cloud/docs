# Работа с Public API в {{ datalens-full-name }}


{{ datalens-name }} предоставляет публичное API [https://api.datalens.tech](https://api.datalens.tech) для автоматизации операций с дашбордами, чартами, датасетами и подключениями.

{{ datalens-name }} Public API — это набор методов, аналогичный тем, что используются в веб-интерфейсе {{ datalens-name }}. API описывается OpenAPI-спецификацией и аутентифицируется через IAM-токены {{ yandex-cloud }}.

При работе с API учитывайте действующие [лимиты](../concepts/limits.md#datalens-api-limits).

Для работы с API требуется [IAM-токен](../../iam/operations/iam-token/create) и [идентификатор организации](../settings/index.md#service-settings).

Например, подставьте свои значения `<IAM_TOKEN>`, `<ORG_ID>` и `<ENTRY_ID>` в следующий запрос, чтобы получить список всех связанных с сущностью объектов:

```bash
curl -X 'POST' \
  'https://api.datalens.tech/rpc/getEntriesRelations' \
  -H 'accept: application/json' \
  -H 'x-dl-api-version: 1' \
  -H 'Authorization: Bearer <IAM_TOKEN>' \
  -H 'x-dl-org-id: <ORG_ID>' \
  -H 'Content-Type: application/json' \
  -d '{
  "entryIds": [
    "<ENTRY_ID>"
  ]
}'
```




## MCP-сервер {#mcp-server}

[MCP-сервер](https://www.npmjs.com/package/@datalens-tech/mcp) {{ datalens-name }} предоставляет доступ агентам LLM к публичному API.


Сервер использует протокол MCP через stdio. Добавьте его в конфигурацию клиента MCP одним из способов:

* **Через npx (рекомендуется)**. Без установки или сборки — npx загружает опубликованный пакет по запросу:

  ```bash
  {
    "mcpServers": {
      "datalens": {
        "command": "npx",
        "args": ["-y", "@datalens-tech/mcp@latest"],
        "env": {
          "DATALENS_ORG_ID": "<org-id>"
        }
      }
    }
  }
  ```

* **Через глобальную установку**. Установите пакет один раз, а затем используйте команду `datalens-mcp`:

  ```bash
  npm install -g @datalens-tech/mcp
  ```

  ```bash
  {
    "mcpServers": {
      "datalens": {
        "command": "datalens-mcp",
        "env": {
          "DATALENS_ORG_ID": "<org-id>"
        }
      }
    }
  }
  ```

* **Из локальной сборки**. Используйте этот вариант, если вы клонировали репозиторий. Сначала соберите его:

  ```bash
  npm ci
  npm run build
  ```

  Затем укажите клиенту на собранный файл:

  ```bash
  {
    "mcpServers": {
      "datalens": {
        "command": "node",
        "args": ["/absolute/path/to/datalens-mcp/dist/index.js"],
        "env": {
          "DATALENS_ORG_ID": "<org-id>"
        }
      }
    }
  }
  ```

Где `DATALENS_ORG_ID` — идентификатор вашей организации.

По умолчанию сервер запускает `yc iam create-token` для получения IAM-токена.

{% include [cli-install](../../_includes/cli-install.md) %}

Дополнительные настройки `yc`:

* `DATALENS_YC_PROFILE` — использовать определенный `yc` профиль вместо активного.
* `DATALENS_YC_BIN` — полный путь к бинарному файлу `yc`, если он находится не в `PATH`.


Если вы не можете запустить `yc` (например, в изолированной среде), вы можете самостоятельно управлять токеном IAM: установите `DATALENS_YC_STATIC_AUTH=1` и поместите токен в `DATALENS_API_AUTH_HEADER="Bearer <iam-token>"`. Значение отправляется без изменений при каждом запросе, и `yc` никогда не вызывается.

{% note info %}

Срок действия IAM-токенов истекает через 12 часов. При таком подходе вы сами отвечаете за обновление `DATALENS_API_AUTH_HEADER` и перезапуск сервера до истечения срока действия токена.

{% endnote %}


### Требования к окружению {#requirements}

Чтобы запустить MCP-сервер в окружении с агентом или MCP-клиентом, необходимы:


* [Node.js](https://nodejs.org/) версии 18 или выше;
* `npm` и `npx`, доступные через `PATH` (как правило, они идут в комплекте с Node.js);
* [`yc` CLI](../../cli/quickstart.md) — при использовании рекомендуемого способа авторизации через {{ yandex-cloud }}. При авторизации с помощью статического токена `yc` CLI не требуется.


### Примеры использования {#example}

* Примеры использования на [GitHub](https://github.com/datalens-tech/datalens-mcp/blob/HEAD/.env.example).


