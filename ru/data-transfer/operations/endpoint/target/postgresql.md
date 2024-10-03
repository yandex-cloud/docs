---
title: Как настроить эндпоинт-приемник {{ PG }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ PG }} в {{ data-transfer-full-name }}.
---
# Передача данных в эндпоинт-приемник {{ PG }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ PG }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ PG }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](../../../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ PG }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Миграция кластера {{ PG }}](../../../tutorials/managed-postgresql.md);
    * [Миграция из AWS RDS for {{ PG }}](../../../tutorials/rds-to-mpg.md);
    * [Миграция со сменой хранилища: {{ MY }} в {{ PG }}](../../../tutorials/mmy-to-mpg.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

    * [Поставка данных из {{ KF }} в {{ PG }}](../../../tutorials/mkf-to-mpg.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Загрузка данных из {{ GP }} в {{ PG }}](../../../tutorials/greenplum-to-postgresql.md);
    * [Загрузка данных из {{ objstorage-name }} в {{ PG }}](../../../tutorials/object-storage-to-postgresql.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ GP }}](../source/greenplum.md);
* [{{ KF }}](../source/kafka.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [{{ ydb-name }}](../source/ydb.md);
* [Oracle](../source/oracle.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/pg-prepare.md) %}

## Настройка эндпоинта-приемника {{ PG }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mpg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ mpg-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mpg.viewer }}`](../../../../managed-postgresql/security/index.md#mpg-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/managed-postgresql.md) %}

- CLI {#cli}

    * Тип эндпоинта — `postgres-target`.

    {% include [Managed PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-postgresql.md) %}
    
- {{ TF }} {#tf}

    * Тип эндпоинта — `postgres_target`.

    {% include [Managed PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-postgresql.md) %}

    Пример структуры конфигурационного файла:


    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        postgres_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            mdb_cluster_id = "<идентификатор_кластера>"
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
          }
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-postgresql.md) %}

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-postgresql.md) %}

- CLI {#cli}

    * Тип эндпоинта — `postgres-target`.

    {% include [On premise PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-postgresql.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `postgres_target`.

    {% include [On premise PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-postgresql.md) %}

    Пример структуры конфигурационного файла:


    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        postgres_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            on_premise {
              hosts = ["<список_хостов>"]
              port  = <порт_для_подключения>
            }
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
          }
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-postgresql.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/postgresql/ui/cleanup_policy.md) %}

    * {% include [save_tx_boundaries](../../../../_includes/data-transfer/fields/postgresql/ui/save_tx_boundaries.md) %}

- {{ TF }} {#tf}

    {% include [cleanup_policy](../../../../_includes/data-transfer/fields/postgresql/terraform/cleanup-policy.md) %}

- API {#api}

    {% include [cleanupPolicy](../../../../_includes/data-transfer/fields/postgresql/api/cleanup-policy.md) %}

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Действия с базой данных во время трансфера {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) %}

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ PG }}:

* [Остановка сессии мастер-транзакции трансфера](#master-trans-stop)
* [Превышение квоты на длительность соединения](#conn-duration-quota)
* [Ошибка трансфера при переносе представлений (VIEW)](#view)
* [Ошибка добавления записи в таблицу по constraint](#constraint)
* [Ошибка при переносе всех таблиц схемы](#schema)
* [Невозможно создать объекты с участием функций расширения](#extension-functions)
* [Низкая скорость трансфера](#low-speed)
* [Не переносятся таблицы-наследники](#successor-tables)
* [Не хватает слотов репликации в базе данных источника](#replication-slots)
* [Перестали переноситься данные после изменения эндпоинта-источника](#no-data-transfer)
* [Ошибка трансфера при смене хоста-мастера](#master-change)
* [Ошибка при трансфере вложенных транзакций](#inner-tables)
* [Ошибка трансфера таблиц с отложенными ограничениями](#deferrable-constr)
* [Не удается создать слот репликации на стадии активации](#lock-replication)
* [Чрезмерное увеличение журнала WAL](#excessive-wal)
* [Ошибка при репликации из внешнего источника](#external-replication)
* [Ошибка трансфера при переносе таблиц без первичных ключей](#primary-keys)
* [Ошибка удаления таблицы при политике очистки Drop](#drop-table-error)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [master-trans-stop](../../../../_includes/data-transfer/troubles/postgresql/master-trans-stop.md) %}

{% include [conn-duration-quota](../../../../_includes/data-transfer/troubles/postgresql/conn-duration-quota.md) %}

{% include [view](../../../../_includes/data-transfer/troubles/postgresql/view.md) %}

{% include [constraint](../../../../_includes/data-transfer/troubles/postgresql/constraint.md) %}

{% include [schema](../../../../_includes/data-transfer/troubles/postgresql/schema.md) %}

{% include [extension functions](../../../../_includes/data-transfer/troubles/postgresql/extension-functions.md) %}

{% include [low-speed](../../../../_includes/data-transfer/troubles/postgresql/low-speed.md) %}

{% include [successor-tables](../../../../_includes/data-transfer/troubles/postgresql/successor-tables.md) %}

{% include [replication-slots](../../../../_includes/data-transfer/troubles/postgresql/replication-slots.md) %}

{% include [no-data-transfer](../../../../_includes/data-transfer/troubles/postgresql/no-data-transfer.md) %}

{% include [master-change](../../../../_includes/data-transfer/troubles/postgresql/master-change.md) %}

{% include [inner-tables](../../../../_includes/data-transfer/troubles/postgresql/inner-tables.md) %}

{% include [deferrable-tables](../../../../_includes/data-transfer/troubles/postgresql/deferrable-constraints.md) %}

{% include [lock-replication](../../../../_includes/data-transfer/troubles/postgresql/lock-replication.md) %}

{% include [excessive-wal](../../../../_includes/data-transfer/troubles/postgresql/excessive-wal.md) %}

{% include [external-replication](../../../../_includes/data-transfer/troubles/postgresql/external-replication.md) %}

{% include [primary-keys](../../../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [drop-table-error](../../../../_includes/data-transfer/troubles/drop-table-error.md) %}
