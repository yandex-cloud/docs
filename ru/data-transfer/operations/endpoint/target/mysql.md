---
title: Как настроить эндпоинт-приемник {{ MY }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ MY }} в {{ data-transfer-full-name }}.
---

# Передача данных в эндпоинт-приемник {{ MY }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ MY }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ MY }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ MY }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
  
   * [Миграция кластера {{ MY }}](../../../tutorials/managed-mysql-to-mysql.md);
   * [Миграция со сменой хранилища: {{ PG }} в {{ MY }}](../../../tutorials/mpg-to-mmy.md).
   * [Миграция со сменой хранилища: {{ objstorage-name }} в {{ MY }}](../../../tutorials/objs-mmy-migration.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
  
   * [Поставка данных из {{ KF }} в {{ MY }}](../../../tutorials/mkf-to-mmy.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [{{ ydb-name }}](../source/ydb.md).

## Подготовка базы данных приемника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/mysql-prepare.md) %}

## Настройка эндпоинта-приемника {{ MY }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmy-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ mmy-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mmy.viewer }}`](../../../../managed-mysql/security/index.md#mmy-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql.md) %}

- CLI {#cli}

    * Тип эндпоинта — `mysql-target`.

    {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-target.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_target`.

    {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-target.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            mdb_cluster_id = "<идентификатор_кластера>"
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-target.md) %}

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql.md) %}

- CLI {#cli}

    * Тип эндпоинта — `mysql-target`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-target.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_target`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-target.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_target {
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
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-target.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% note warning %}

Настройки **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}** можно задать только через Консоль управления.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.

          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.advanced_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.timezone.title }}** — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется локальная таймзона сервера.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.sql_mode.title }}** — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.skip_constraint_checks.title }}** — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

            {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}** — укажите имя схемы, в которой будут созданы служебные таблицы, необходимые для обеспечения работы трансфера.

    * {% include [alter-schema-change](../../../../_includes/data-transfer/fields/alter-schema-change.md) %}

- CLI {#cli}

    * `--sql-mode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html)

    * `--skip-constraint-checks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `--timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

- {{ TF }} {#tf}

    * `sql_mode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html). По умолчанию используется список `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`.

    * `skip_constraint_checks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

    * {% include [alter-schema-change-tf](../../../../_includes/data-transfer/fields/alter-schema-change-tf.md) %}

- API {#api}

    * `sqlMode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html)

    * `skipConstraintChecks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Действия с базой данных во время трансфера {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mysql-work-with-db.md) %}

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ MY }}:

* [Размер лога одной транзакции превышает 4 ГБ](#binlog-size)
* [Не добавляются новые таблицы](#no-new-tables)
* [Ошибка при трансфере из AWS RDS for {{ MY }}](#aws-binlog-time)
* [Ошибка трансфера при переносе таблиц без первичных ключей](#primary-keys)
* [Ошибка обращения к бинарному логу](#binlog-bytes)
* [Не удается получить позицию в бинарном логе](#binlog-position)
* [Ошибка удаления таблицы при политике очистки Drop](#drop-table-error)
* [Сдвиг времени в типе данных DATETIME при трансфере в {{ CH }}](#timeshift)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [binlog-size](../../../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [aws-binlog-time](../../../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

{% include [primary-keys](../../../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [binlog-bytes](../../../../_includes/data-transfer/troubles/mysql/binlog-bytes.md) %}

{% include [binlog-position](../../../../_includes/data-transfer/troubles/mysql/binlog-position.md) %}

{% include [drop-table-error](../../../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [timezone-shift](../../../../_includes/data-transfer/troubles/mysql/timezone-shift.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
