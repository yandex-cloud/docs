[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Подключение MCP-клиента к кластеру OpenSearch

# Подключение MCP-клиента к кластеру OpenSearch

В этом практическом руководстве вы настроите подключение MCP-клиента к кластеру OpenSearch: включите встроенный MCP-сервер, зарегистрируете инструменты и добавите сервер в конфигурацию клиента.

{% note info %}

MCP-сервер в OpenSearch доступен начиная с версии 3.0.

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

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for OpenSearch](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-create.md#create-cluster) нужной вам конфигурации с публичным доступом к любой группе хостов.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

        1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [Managed Service for OpenSearch](../../managed-opensearch/operations/connect/index.md#configuring-security-groups).

    - С помощью Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [opensearch-mcp.tf](https://github.com/yandex-cloud-examples/yc-opensearch-mcp/blob/main/opensearch-mcp.tf). В файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch;
            * кластер Managed Service for OpenSearch.

        1. Укажите в файле `opensearch-mcp.tf` переменные:

            * `version` — версия OpenSearch.
            * `admin_password` — пароль администратора OpenSearch.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

            В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

    {% endlist %}

1. [Установите SSL-сертификат](../../managed-opensearch/operations/connect/index.md#ssl-certificate).

1. Проверьте подключение к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --request GET 'https://<FQDN_хоста_OpenSearch_с_публичным_доступом>:9200/'
    ```
    
    FQDN хоста можно получить со [списком хостов в кластере](../../managed-opensearch/operations/host-groups.md#list-hosts).
    
    При успешном подключении будет выведено сообщение вида:
    
    ```bash
    {
      "name" : "....mdb.yandexcloud.net",
      "cluster_name" : "...",
      "cluster_uuid" : "...",
      "version" : {
      "distribution" : "opensearch",
      ...
      },
      "tagline" : "The OpenSearch Project: https://opensearch.org/"
    }
    ```

1. Создайте отдельного пользователя для MCP-клиента.

    Внутреннего пользователя можно создать либо через OpenSearch Dashboards, либо через Security REST API.

    {% list tabs group=mcp-user-create %}

    - OpenSearch Dashboards {#dashboards}

        1. [Подключитесь](../../managed-opensearch/operations/connect/clients.md#dashboards) к OpenSearch Dashboards от имени `admin`.
        1. В меню слева выберите **OpenSearch Plugins** → **Security**.
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
          "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_security/api/internalusers/mcp-client" \
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
          "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_security/api/internalusers/mcp-client"
        ```

    {% endlist %}

    {% note info %}

    Если вы планируете регистрировать другие инструменты, создайте роль с нужными правами. Подробнее о настройке прав в [документации OpenSearch по пользователям и ролям](https://opensearch.org/docs/latest/security/access-control/users-roles/) и [списке поддерживаемых инструментов](https://opensearch.org/docs/latest/ml-commons-plugin/agents-tools/tools/index/).

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
  "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_cluster/settings" \
  --data '{
    "persistent": {
      "plugins.ml_commons.mcp_server_enabled": true
    }
  }'
```

## Зарегистрируйте инструменты {#register-tools}

После включения MCP-сервера зарегистрируйте инструменты, которые будут доступны MCP-клиенту.

Полный список встроенных инструментов приведен в [документации OpenSearch](https://opensearch.org/docs/latest/ml-commons-plugin/agents-tools/tools/index/).

Формат запроса на регистрацию описан в [документации OpenSearch](https://opensearch.org/docs/latest/ml-commons-plugin/api/mcp-server-apis/register-mcp-tools/).

Например, можно зарегистрировать базовый набор инструментов для просмотра индексов, схемы и поиска:

```bash
curl \
  --cacert ~/.opensearch/root.crt \
  --user mcp-client:<пароль> \
  --request POST \
  --header "Content-Type: application/json" \
  "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ml/mcp/tools/_register" \
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
  "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ml/mcp/tools/_list"
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
https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ml/mcp
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
        "url": "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ml/mcp",
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
      "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ml/mcp" \
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
            "https://<адрес_хоста_OpenSearch_с_публичным_доступом>:9200/_plugins/_ml/mcp",
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

    [Удалите кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-delete.md).

- С помощью Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}