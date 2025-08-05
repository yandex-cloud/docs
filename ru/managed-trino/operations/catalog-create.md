---
title: Создание каталога {{ TR }}
description: Следуя этой инструкции, вы создадите каталог в кластере {{ mtr-name }}.
---

# Создание каталога {{ TR }}

## Роли для создания каталога {{ TR }} {#roles}

Для создания [каталога {{ TR }}](../concepts/index.md#catalog) с типом подключения [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) вашему аккаунту в {{ yandex-cloud }} нужна дополнительная роль [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user), чтобы использовать подключения из {{ connection-manager-name }}.

[Сервисному аккаунту](../../iam/concepts/users/service-accounts.md) кластера должны быть назначены роли [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) и [{{ roles-lockbox-payloadviewer }}](../../lockbox/security/index.md#lockbox-payloadViewer). Это даст кластеру нужные права для работы с подключениями из {{ connection-manager-name }}. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Создать каталог {{ TR }} {#create-catalog}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.trino.catalogs.create_action }}**.
  1. В поле **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** задайте имя каталога {{ TR }}.
  1. В поле **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** выберите тип [коннектора](../concepts/index.md#connector).
  1. Задайте [настройки каталога {{ TR }}](#catalog-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для создания каталога {{ TR }}:

        ```bash
        {{ yc-mdb-tr }} catalog create --help
        ```

    1. Посмотрите описание команды CLI для создания каталога {{ TR }} c конкретным коннектором:

        ```bash
        {{ yc-mdb-tr }} catalog create <тип_коннектора> --help
        ```

    1. Чтобы создать каталог {{ TR }}, выполните команду:

        ```bash
        {{ yc-mdb-tr }} catalog create <тип_коннектора> <имя_каталога_{{ TR }}>
        ```

        В команде также нужно передать настройки каталога {{ TR }}, которые зависят от типа коннектора. [Подробнее о настройках для разных типов коннекторов](#catalog-settings).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте ресурс `yandex_trino_catalog`:

        ```hcl
        resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
          name        = "<имя_каталога_{{ TR }}>"
          cluster_id  = yandex_trino_cluster.<имя_кластера>.id
          <тип_коннектора> = {
            <настройки_каталога_{{ TR }}>
          }
        }
        ```

        [Подробнее о настройках каталога {{ TR }}](#catalog-settings) для разных типов коннекторов.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Catalog.Create](../api-ref/Catalog/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
            --data '{
                      "catalog": {
                        "name": "<имя_каталога_{{ TR }}>",
                        "connector": {
                          "<тип_коннектора>": {
                            <настройки_каталога_{{ TR }}>
                          }
                        }
                      }
                    }'
        ```

        [Подробнее о настройках каталога {{ TR }}](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Catalog/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [CatalogService.Create](../api-ref/grpc/Catalog/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "<тип_коннектора>": {
                            <настройки_каталога_{{ TR }}>
                      }
                    }
                  }
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.Create
        ```

        [Подробнее о настройках каталога {{ TR }}](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Catalog/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настройки каталога {{ TR }} {#catalog-settings}

Настройки каталога {{ TR }} отличаются в зависимости от выбранного коннектора.

{% note info %}

Коннекторы с пометкой {{ preview-stage }} находятся на стадии предварительного тестирования. Стабильность работы не гарантируется.

{% endnote %}

### Коннектор {{ CH }} {#ch}

Задайте настройки для нужного типа подключения — [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) или On-premise (пользовательская инсталляция).

#### Подключение {{ connection-manager-name }} {#ch-connection-manager}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Идентификатор подключения** — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ CH }}.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

    * **База данных** — имя БД в кластере {{ CH }}.
    * **Параметры клиента** — параметры клиента {{ CH }} в формате `ключ: значение`.

        {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create clickhouse <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --connection-manager-connection-id <идентификатор_подключения> \
      --connection-manager-database <имя_БД> \
      --connection-manager-connection-properties <список_параметров_клиента_{{ CH }}> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--connection-manager-connection-id` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ CH }}.

      Чтобы узнать идентификатор подключения:
        1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.   

    * `--connection-manager-database` — имя БД в кластере {{ CH }}.
    * `--connection-manager-connection-properties` — параметры клиента {{ CH }} в формате `ключ=значение`.

        {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      clickhouse = {
        connection_manager = {
          connection_id = "<идентификатор_подключения>"
          database      = "<имя_БД>"
          connection_properties = {
            <список_настроек_клиента_{{ CH }}>
          }
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `connection_manager` — настройки {{ connection-manager-name }}:

        * `connection_id` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ CH }}.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

        * `database` — имя БД в кластере {{ CH }}.
        * `connection_properties` — список настроек клиента {{ CH }} в формате `"ключ" = "значение"`.

            {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "clickhouse": {
                        "connection": {
                          "connectionManager": {
                            "connectionId": "<идентификатор_подключения>",
                            "database": "<имя_БД>",
                            "connectionProperties": {
                              <список_настроек_клиента_{{ CH }}>
                            }
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `connectionManager` — настройки {{ connection-manager-name }}:

        * `connectionId` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ CH }}.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

        * `database` — имя БД в кластере {{ CH }}.
        * `connectionProperties` — список настроек клиента {{ CH }} в формате `"ключ": "значение"`.

            {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "clickhouse": {
                    "connection": {
                      "connection_manager": {
                        "connection_id": "<идентификатор_подключения>",
                        "database": "<имя_БД>",
                        "connection_properties": {
                          <список_настроек_клиента_{{ CH }}>
                        }
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `connection_manager` — настройки {{ connection-manager-name }}:

        * `connection_id` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ CH }}.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

        * `database` — имя БД в кластере {{ CH }}.
        * `connection_properties` — список настроек клиента {{ CH }} в формате `"ключ": "значение"`.

            {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

#### Подключение On-premise {#ch-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URL** — URL для подключения к БД {{ CH }} в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД {{ CH }}.
    * **Пароль** — пароль пользователя для подключения к БД {{ CH }}.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create clickhouse <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД {{ CH }} в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`
    * `--on-premise-user-name` — имя пользователя для подключения к БД {{ CH }}.
    * `--on-premise-password` — пароль пользователя для подключения к БД {{ CH }}.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      clickhouse = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД {{ CH }} в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД {{ CH }}.
        * `password` — пароль пользователя для подключения к БД {{ CH }}.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "clickhouse": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД {{ CH }} в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
        * `userName` — имя пользователя для подключения к БД {{ CH }}.
        * `password` — пароль пользователя для подключения к БД {{ CH }}.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "clickhouse": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД {{ CH }} в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД {{ CH }}.
        * `password` — пароль пользователя для подключения к БД {{ CH }}.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Delta Lake {#delta-lake}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/delta-lake.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create delta-lake <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --metastore-hive-uri <URI_для_подключения> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <идентификатор_ключа_доступа> \
      --filesystem-external-s3-aws-secret-key <секретный_ключ> \
      --filesystem-external-s3-aws-endpoint <эндпоинт> \
      --filesystem-external-s3-aws-region <регион> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    {% include [cli-connector-settings](../../_includes/managed-trino/cli-connector-settings.md) %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/delta-lake.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      delta_lake = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_для_подключения>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    {% include [connector-settings-terraform](../../_includes/managed-trino/terraform/connector-settings.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/delta-lake.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "deltaLake": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_для_подключения>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    {% include [connector-settings-rest-api](../../_includes/managed-trino/api/connector-settings-rest.md) %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/delta-lake.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "delta_lake": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_для_подключения>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    {% include [connector-settings-grpc-api](../../_includes/managed-trino/api/connector-settings-grpc.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/delta-lake.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Hive {#hive}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/hive.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create hive <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --metastore-hive-uri <URI_для_подключения> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <идентификатор_ключа_доступа> \
      --filesystem-external-s3-aws-secret-key <секретный_ключ> \
      --filesystem-external-s3-aws-endpoint <эндпоинт> \
      --filesystem-external-s3-aws-region <регион> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    {% include [cli-connector-settings](../../_includes/managed-trino/cli-connector-settings.md) %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/hive.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      hive = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_для_подключения>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    {% include [connector-settings-terraform](../../_includes/managed-trino/terraform/connector-settings.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/hive.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "hive": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_для_подключения>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    {% include [connector-settings-rest-api](../../_includes/managed-trino/api/connector-settings-rest.md) %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/hive.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "hive": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_для_подключения>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    {% include [connector-settings-grpc-api](../../_includes/managed-trino/api/connector-settings-grpc.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/hive.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Iceberg {#iceberg}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/iceberg.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create iceberg <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --metastore-hive-uri <URI_для_подключения> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <идентификатор_ключа_доступа> \
      --filesystem-external-s3-aws-secret-key <секретный_ключ> \
      --filesystem-external-s3-aws-endpoint <эндпоинт> \
      --filesystem-external-s3-aws-region <регион> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    {% include [cli-connector-settings](../../_includes/managed-trino/cli-connector-settings.md) %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/iceberg.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      iceberg = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_для_подключения>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    {% include [connector-settings-terraform](../../_includes/managed-trino/terraform/connector-settings.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/iceberg.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "iceberg": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_для_подключения>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    {% include [connector-settings-rest-api](../../_includes/managed-trino/api/connector-settings-rest.md) %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/iceberg.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "iceberg": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_для_подключения>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    {% include [connector-settings-grpc-api](../../_includes/managed-trino/api/connector-settings-grpc.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/iceberg.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Oracle {{ preview-stage }} {#oracle}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Тип подключения** — On-premise.
    * **URL** — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
    * **Имя пользователя** — имя пользователя для подключения к БД Oracle.
    * **Пароль** — пароль пользователя для подключения к БД Oracle.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/oracle.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create oracle <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
    * `--on-premise-user-name` — имя пользователя для подключения к БД Oracle.
    * `--on-premise-password` — пароль пользователя для подключения к БД Oracle.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/oracle.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      oracle = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
        * `user_name` — имя пользователя для подключения к БД Oracle.
        * `password` — пароль пользователя для подключения к БД Oracle.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/oracle.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "oracle": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
        * `userName` — имя пользователя для подключения к БД Oracle.
        * `password` — пароль пользователя для подключения к БД Oracle.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/oracle.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "oracle": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
        * `user_name` — имя пользователя для подключения к БД Oracle.
        * `password` — пароль пользователя для подключения к БД Oracle.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/oracle.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор {{ PG }} {#pg}

Задайте настройки для нужного типа подключения — [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) или On-premise (пользовательская инсталляция).

#### Подключение {{ connection-manager-name }} {#pg-connection-manager}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Идентификатор подключения** — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ PG }}.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

    * **База данных** — имя БД в кластере {{ PG }}.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create postgresql <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --connection-manager-connection-id <идентификатор_подключения> \
      --connection-manager-database <имя_БД> \
      --connection-manager-connection-properties <список_параметров_клиента_{{ PG }}> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--connection-manager-connection-id` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ PG }}.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

    * `--connection-manager-database` — имя БД в кластере {{ PG }}.
    * `--connection-manager-connection-properties` — список настроек клиента {{ PG }} в формате `ключ=значение`.

        {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      postgresql = {
        connection_manager = {
          connection_id = "<идентификатор_подключения>"
          database      = "<имя_БД>"
          connection_properties = {
            <список_настроек_клиента_{{ PG }}>
          }
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `connection_manager` — настройки {{ connection-manager-name }}:

        * `connection_id` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ PG }}.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

        * `database` — имя БД в кластере {{ PG }}.
        * `connection_properties` — список настроек клиента {{ PG }} в формате `"ключ" = "значение"`.

            {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "postgresql": {
                        "connection": {
                          "connectionManager": {
                            "connectionId": "<идентификатор_подключения>",
                            "database": "<имя_БД>",
                            "connectionProperties": {
                              <список_настроек_клиента_{{ PG }}>
                            }
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `connectionManager` — настройки {{ connection-manager-name }}:

        * `connectionId` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ PG }}.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

        * `database` — имя БД в кластере {{ PG }}.
        * `connectionProperties` — список настроек клиента {{ PG }} в формате `"ключ": "значение"`.

            {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "postgesql": {
                    "connection": {
                      "connection_manager": {
                        "connection_id": "<идентификатор_подключения>",
                        "database": "<имя_БД>",
                        "connection_properties": {
                          <список_настроек_клиента_{{ PG }}>
                        }
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `connection_manager` — настройки {{ connection-manager-name }}:

        * `connection_id` — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ PG }}.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

        * `database` — имя БД в кластере {{ PG }}.
        * `connection_properties` — список настроек клиента {{ PG }} в формате `"ключ": "значение"`.

            {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

#### Подключение On-premise {#pg-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URL** — URL для подключения к БД {{ PG }} в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД {{ PG }}.
    * **Пароль** — пароль пользователя для подключения к БД {{ PG }}.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create postgresql <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД {{ PG }} в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
    * `--on-premise-user-name` — имя пользователя для подключения к БД {{ PG }}.
    * `--on-premise-password` — пароль пользователя для подключения к БД {{ PG }}.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      postgresql = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД {{ PG }} в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД {{ PG }}.
        * `password` — пароль пользователя для подключения к БД {{ PG }}.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "postgesql": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД {{ PG }} в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
        * `userName` — имя пользователя для подключения к БД {{ PG }}.
        * `password` — пароль пользователя для подключения к БД {{ PG }}.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "postgresql": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД {{ PG }} в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД {{ PG }}.
        * `password` — пароль пользователя для подключения к БД {{ PG }}.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор MS SQL Server {{ preview-stage }} {#ms-sql}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Тип подключения** — On-premise.
    * **URL** — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД Microsoft SQL Server.
    * **Пароль** — пароль пользователя для подключения к БД Microsoft SQL Server.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/sqlserver.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create sqlserver <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
    * `--on-premise-user-name` — имя пользователя для подключения к БД Microsoft SQL Server.
    * `--on-premise-password` — пароль пользователя для подключения к БД Microsoft SQL Server.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/sqlserver.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      sqlserver = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД Microsoft SQL Server.
        * `password` — пароль пользователя для подключения к БД Microsoft SQL Server.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/sqlserver.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "sqlserver": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
        * `userName` — имя пользователя для подключения к БД Microsoft SQL Server.
        * `password` — пароль пользователя для подключения к БД Microsoft SQL Server.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/sqlserver.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "sqlserver": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД Microsoft SQL Server.
        * `password` — пароль пользователя для подключения к БД Microsoft SQL Server.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/sqlserver.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор TPC-DS {#tpc-ds}

Коннектор TPC-DS не требует обязательных настроек. Опционально можно задать дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpcds.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create tpcds <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --additional-properties <список_дополнительных_настроек>
    ```  

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpcds.html).  

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      tpcds = {
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpcds.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "tpcds": {
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpcds.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "tpcds": {
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpcds.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор TPC-H {#tpc-h}

Коннектор TPC-H не требует обязательных настроек. Опционально можно задать дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpch.html).

- CLI {#cli}

    Пример команды:

    ```bash
    {{ yc-mdb-tr }} catalog create tpch <имя_каталога_{{ TR }}> \
      --cluster-id <идентификатор_кластера> \
      --additional-properties <список_дополнительных_настроек>
    ```  

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpch.html).      

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
      ...
      tpch = {
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpch.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_{{ TR }}>",
                    "connector": {
                      "tpch": {
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpch.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_{{ TR }}>",
                "connector": {
                  "tpch": {
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpch.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}