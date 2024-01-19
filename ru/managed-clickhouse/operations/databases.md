---
title: "Как управлять базами данных кластера {{ CH }} в {{ mch-full-name }}"
description: "Следуя данной инструкции, вы сможете управлять базами данных кластера {{ CH }}." 
---

# Управление базами данных в {{ mch-name }}

{{ mch-name }} позволяет управлять базами данных кластера двумя способами:

* С помощью стандартных интерфейсов {{ yandex-cloud }} (CLI, [API](../../glossary/rest-api.md), консоль управления). Способ подходит, если вы хотите создавать и удалять базы данных кластера, используя возможности сервиса {{ mch-full-name }}.
* С помощью SQL-запросов к кластеру. Способ подходит, если вы хотите использовать уже существующее у вас решение для создания и управления базами данных или если вам требуется поддержка {{ MY }} баз данных в {{ mch-name }}.

## Управление базами данных через SQL {#sql-database-management}

Чтобы включить управление, выберите опции **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** и **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** при [создании](cluster-create.md) или [изменении настроек](./update.md#SQL-management) кластера.

В кластере с включенным управлением базами данных через SQL:

* Управление базами данных и [пользователями](./cluster-users.md#sql-user-management) через стандартные интерфейсы {{ yandex-cloud }} (CLI, API, консоль управления) недоступно.
* Невозможно включить управление пользователями и базами данных с помощью стандартных интерфейсов {{ yandex-cloud }}.
* Существующие пользователи, настройки пользователей и базы данных, созданные с помощью стандартных интерфейсов {{ yandex-cloud }}, будут сохранены.
* Управление осуществляется с помощью учетной записи `admin`. Пароль для нее задается при выборе опций **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** и **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}**.

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} database list \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы получить список баз данных кластера, воспользуйтесь методом REST API [list](../api-ref/Database/list.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/List](../api-ref/grpc/database_service.md#List).

- SQL {#sql}

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-database-management).
  1. Получите список баз данных:

      ```sql
      SHOW DATABASES;
      ```

{% endlist %}

## Создать базу данных {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера.
  1. Выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.databases.button_add }}**.
  1. Введите имя для базы данных и нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.databases.popup-add_button_add }}**.

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду создания БД, задав имя новой базы:

  ```bash
  {{ yc-mdb-ch }} database create <имя_БД> \
     --cluster-name=<имя_кластера>
  ```

  {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  {{ mch-short-name }} запустит операцию создания базы данных.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок описания базы данных `database`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          database {
            name = "<имя_БД>"
          }
        }
        ```

        {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  Чтобы создать новую базу данных в кластере, воспользуйтесь методом REST API [create](../api-ref/Database/create.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Create](../api-ref/grpc/database_service.md#Create).

- SQL {#sql}

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-database-management).
  1. Создайте базу данных:

      ```sql
      CREATE DATABASE <имя_БД>;
      ```

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

  Подробнее о создании баз данных см. [в документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/create/database/).

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_databases }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД и выберите пункт **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```bash
  {{ yc-mdb-ch }} database delete <имя_БД> \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок `database` с описанием базы данных.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  Чтобы удалить базу данных, воспользуйтесь методом REST API [delete](../api-ref/Database/delete.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Delete](../api-ref/grpc/database_service.md#Delete).

- SQL {#sql}

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-database-management).
  1. Удалите базу данных:

      ```sql
      DROP DATABASE <имя_БД>;
      ```

  Подробнее об удалении объектов см. [в документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/drop/).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
