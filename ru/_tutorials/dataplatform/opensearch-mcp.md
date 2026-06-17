

В этом практическом руководстве вы настроите подключение MCP-клиента к кластеру {{ OS }}: включите встроенный MCP-сервер, зарегистрируете инструменты и добавите сервер в конфигурацию клиента.

{% note info %}

MCP-сервер в {{ OS }} доступен начиная с версии 3.0.

{% endnote %}

Чтобы настроить подключение:

1. [Включите MCP-сервер](#enable-mcp).
1. [Зарегистрируйте инструменты](#register-tools).
1. [Подготовьте Basic-токен](#basic-token).
1. [Добавьте MCP-сервер в конфигурацию клиента](#client-config).
1. [Проверьте подключение](#check-connection).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Кластер {{ mos-name }}: использование вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mos-name }}](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации с публичным доступом к любой группе хостов.

            {% include [public-access](../../_includes/mdb/note-public-access.md) %}

        1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [{{ mos-name }}](../../managed-opensearch/operations/connect/index.md#configuring-security-groups).

    - С помощью {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-mcp.tf](https://github.com/yandex-cloud-examples/yc-opensearch-mcp/blob/main/opensearch-mcp.tf). В файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mos-name }};
            * кластер {{ mos-name }}.

        1. Укажите в файле `opensearch-mcp.tf` переменные:

            * `version` — версия {{ OS }}.
            * `admin_password` — пароль администратора {{ OS }}.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. [Установите SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate).

1. Проверьте подключение к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

    {% include [default-connstring](../../_tutorials/_tutorials_includes/opensearch/check-connection.md) %}

1. Создайте отдельного пользователя для MCP-клиента.

    Внутреннего пользователя можно создать либо через {{ OS }} Dashboards, либо через Security REST API.

    {% list tabs group=mcp-user-create %}

    - OpenSearch Dashboards {#dashboards}

        1. [Подключитесь](../../managed-opensearch/operations/connect/clients.md#dashboards) к {{ OS }} Dashboards от имени `admin`.
        1. В меню слева выберите **{{ OS }} Plugins** → **Security**.
        1. На панели слева выберите **Internal users** и нажмите **Create internal user**.
        1. Укажите имя пользователя и пароль, например `mcp-client`.
        1. Нажмите **Submit**.
        1. Назначьте пользователю роль `ml_full_access`:

            1. На панели слева выберите **Roles**.
            1. Откройте роль `ml_full_access` и перейдите на вкладку **Mapped users**.
            1. Нажмите **Manage mapping**, добавьте пользователя `mcp-client` и нажмите **Map**.

    - REST API {#rest-api}

        Создайте внутреннего пользователя и назначьте ему роль `ml_full_access`, в данном примере создается пользователь `mcp-client`:

        ```bash
        curl \
          --cacert ~/.opensearch/root.crt \
          --user admin:<пароль> \
          --request PUT \
          --header "Content-Type: application/json" \
          "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_security/api/internalusers/mcp-client" \
          --data '{
            "password": "<пароль_пользователя>",
            "opendistro_security_roles": [
              "ml_full_access"
            ]
          }'
        ```

        При необходимости проверьте, что пользователь создан:

        ```bash
        curl \
          --cacert ~/.opensearch/root.crt \
          --user admin:<пароль> \
          --request GET \
          "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_security/api/internalusers/mcp-client"
        ```

    {% endlist %}

    {% note info %}

    Если вы планируете регистрировать другие инструменты, создайте роль с нужными правами. Подробнее о настройке прав в [документации OpenSearch по пользователям и ролям]({{ os.docs }}/security/access-control/users-roles/) и [списке поддерживаемых инструментов]({{ os.docs }}/ml-commons-plugin/agents-tools/tools/index/).

    {% endnote %}

1. Для шагов, где изменяются настройки кластера, создаются роли и пользователи или регистрируются инструменты, используйте учетную запись `admin` или другого пользователя с достаточными административными правами. Для подключения MCP-клиента и формирования Basic-токена используйте учетные данные пользователя `mcp-client`.


{% note warning %}

MCP-клиент получает те же права, что и пользователь, чьи учетные данные передаются в заголовке `Authorization`. Не используйте в конфигурации клиента учетную запись `admin`, если достаточно отдельного пользователя с ограниченным набором прав.

{% endnote %}

## Включите MCP-сервер {#enable-mcp}

Выполните запрос к API кластера:

```bash
curl \
  --cacert ~/.opensearch/root.crt \
  --user admin:<пароль> \
  --request PUT \
  --header "Content-Type: application/json" \
  "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_cluster/settings" \
  --data '{
    "persistent": {
      "plugins.ml_commons.mcp_server_enabled": true
    }
  }'
```

## Зарегистрируйте инструменты {#register-tools}

После включения MCP-сервера зарегистрируйте инструменты, которые будут доступны MCP-клиенту.

Полный список встроенных инструментов приведен в [документации OpenSearch]({{ os.docs }}/ml-commons-plugin/agents-tools/tools/index/).

Формат запроса на регистрацию описан в [документации OpenSearch]({{ os.docs }}/ml-commons-plugin/api/mcp-server-apis/register-mcp-tools/).

Например, можно зарегистрировать базовый набор инструментов для просмотра индексов, схемы и поиска:

```bash
curl \
  --cacert ~/.opensearch/root.crt \
  --user mcp-client:<пароль> \
  --request POST \
  --header "Content-Type: application/json" \
  "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_ml/mcp/tools/_register" \
  --data '{
    "tools": [
      {
        "name": "ListIndexTool",
        "type": "ListIndexTool",
        "description": "Возвращает список индексов кластера",
        "attributes": {
          "input_schema": {
            "type": "object",
            "properties": {
              "indices": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "description": "Список индексов. Укажите [] для всех индексов кластера"
              }
            },
            "additionalProperties": false
          }
        }
      },
      {
        "name": "IndexMappingTool",
        "type": "IndexMappingTool",
        "description": "Возвращает mappings и settings для указанного индекса",
        "attributes": {
          "input_schema": {
            "type": "object",
            "properties": {
              "index": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "description": "Список индексов"
              }
            },
            "required": [
              "index"
            ],
            "additionalProperties": false
          }
        }
      },
      {
        "name": "SearchIndexTool",
        "type": "SearchIndexTool",
        "description": "Выполняет поиск по индексу с помощью OpenSearch DSL",
        "attributes": {
          "input_schema": {
            "type": "object",
            "properties": {
              "index": {
                "type": "string"
              },
              "query": {
                "type": "string"
              }
            },
            "required": [
              "index",
              "query"
            ],
            "additionalProperties": false
          }
        }
      }
    ]
  }'
```

Чтобы проверить, что инструменты зарегистрированы, выполните запрос:

```bash
curl \
  --cacert ~/.opensearch/root.crt \
  --user mcp-client:<пароль> \
  --request GET \
  "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_ml/mcp/tools/_list"
```

Если регистрация прошла успешно, в ответе вернется массив `tools`.

## Сформируйте Basic-токен {#basic-token}

Если MCP-клиент передает Basic-аутентификацию в заголовке, сформируйте токен из имени и пароля созданного пользователя:

```bash
echo -n 'mcp-client:<пароль>' | base64
```

Используйте полученное значение как `<base64-basic-token>`.

## Добавьте MCP-сервер в конфигурацию клиента {#client-config}

Во всех примерах ниже используется адрес:

```text
https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_ml/mcp
```

Если клиент не позволяет отдельно указать путь к CA-сертификату, заранее установите [SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate) в системное хранилище сертификатов.

{% list tabs group=mcp_client %}

- OpenCode {#opencode}

    Добавьте сервер в конфигурацию OpenCode:

    ```json
    {
      "opensearch": {
        "enabled": true,
        "type": "remote",
        "url": "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_ml/mcp",
        "headers": {
          "Authorization": "Basic <base64-basic-token>"
        }
      }
    }
    ```

- Claude Code {#claude-code}

    Добавьте MCP-сервер командой:

    ```bash
    claude mcp add --transport http opensearch \
      "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_ml/mcp" \
      --header "Authorization: Basic <base64-basic-token>"
    ```

- FastMCP {#fastmcp}

    Установите пакет:

    ```bash
    pip3 install fastmcp
    ```

    Пример подключения:

    ```python
    import asyncio

    import httpx
    from fastmcp import Client

    auth = httpx.BasicAuth(
        username="mcp-client",
        password="<пароль>",
    )


    async def main():
        async with Client(
            "https://<адрес_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/_plugins/_ml/mcp",
            auth=auth,
            verify="/path/to/root.crt",
        ) as client:
            for tool in await client.list_tools():
                print(tool.name)

            result = await client.call_tool("ListIndexTool", {})
            print(result)


    asyncio.run(main())
    ```

- VS Code {#vscode}

    На данный момент (до версии OpenSearch 3.7) наблюдаются проблемы с подключением к MCP-серверу напрямую из VS Code. Вы можете самостоятельно настроить MCP Proxy для подключения к MCP-серверу из VS Code.

{% endlist %}

После сохранения конфигурации перезапустите MCP-клиент или обновите его настройки, если это требуется в вашем приложении.

## Проверьте подключение {#check-connection}

1. Убедитесь, что клиент подключился к MCP-серверу без ошибок авторизации и TLS.
1. Проверьте, что клиент распознает зарегистрированные инструменты, например `ListIndexTool`, `IndexMappingTool` и `SearchIndexTool`.
1. Выполните тестовый вызов `ListIndexTool` и убедитесь, что в ответе возвращается список индексов кластера.

Например, для `FastMCP` достаточно запустить скрипт из предыдущего шага. Если подключение настроено правильно, скрипт:

* выведет список доступных инструментов;
* выполнит вызов `ListIndexTool`;
* вернет информацию об индексах кластера.

Если вы используете IDE или локальный агент, откройте список MCP-серверов или инструментов в интерфейсе клиента и убедитесь, что сервер `opensearch` активен.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

- С помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
