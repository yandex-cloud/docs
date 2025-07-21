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

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте ресурс `yandex_trino_catalog`:

        ```hcl
        resource "yandex_trino_catalog" "<имя_каталога>" {
          name        = "<имя_каталога>"
          cluster_id  = yandex_trino_cluster.mytr.id
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

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

#### Подключение On-premise {#ch-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URL** — URL для подключения к БД {{ CH }} в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД {{ CH }}.
    * **Пароль** — пароль пользователя для подключения к БД {{ CH }}.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/clickhouse.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

### Коннектор Delta Lake {#delta-lake}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/delta-lake.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

### Коннектор Hive {#hive}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/hive.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

### Коннектор Iceberg {#iceberg}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/iceberg.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

### Коннектор Oracle {{ preview-stage }} {#oracle}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Тип подключения** — On-premise.
    * **URL** — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
    * **Имя пользователя** — имя пользователя для подключения к БД Oracle.
    * **Пароль** — пароль пользователя для подключения к БД Oracle.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/oracle.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

#### Подключение On-premise {#pg-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URL** — URL для подключения к БД {{ PG }} в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД {{ PG }}.
    * **Пароль** — пароль пользователя для подключения к БД {{ PG }}.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/postgresql.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

### Коннектор MS SQL Server {{ preview-stage }} {#ms-sql}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Тип подключения** — On-premise.
    * **URL** — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД Microsoft SQL Server.
    * **Пароль** — пароль пользователя для подключения к БД Microsoft SQL Server.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/sqlserver.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
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

{% endlist %}

### Коннектор TPC-DS {#tpc-ds}

Коннектор TPC-DS не требует обязательных настроек. Опционально можно задать дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpcds.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
      ...
      tpcds = {
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpcds.html).

{% endlist %}

### Коннектор TPC-H {#tpc-h}

Коннектор TPC-H не требует обязательных настроек. Опционально можно задать дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpch.html).

- {{ TF }} {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога>" {
      ...
      tpch = {
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации]({{ tr.docs}}/connector/tpch.html).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}