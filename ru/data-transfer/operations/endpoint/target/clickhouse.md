---
title: "Как настроить эндпоинт-приемник {{ CH }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ CH }} в {{ data-transfer-full-name }}."
---

# Передача данных в эндпоинт-приемник {{ CH }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ CH }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ CH }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ CH }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    * [Миграция кластера {{ CH }}](../../../tutorials/managed-clickhouse.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    * [Поставка данных из {{ KF }} в {{ CH }}](../../../tutorials/mkf-to-mch.md);
    * [Поставка данных из {{ DS }} в {{ CH }}](../../../tutorials/yds-to-clickhouse.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}
    * [Загрузка данных {{ GP }} в {{ CH }}](../../../tutorials/greenplum-to-clickhouse.md);
    * [Загрузка данных {{ MY }} в {{ CH }}](../../../tutorials/mysql-to-clickhouse.md);
    * [Загрузка данных {{ metrika }} в {{ CH }}](../../../tutorials/metrika-to-clickhouse.md);
    * [Загрузка данных {{ yandex-direct }} в {{ CH }}](../../../tutorials/direct-to-mch.md);

    * [Загрузка данных {{ PG }} в {{ CH }}](../../../tutorials/rdbms-to-clickhouse.md);
    * [Загрузка данных из {{ objstorage-name }} в {{ CH }}](../../../tutorials/object-storage-to-clickhouse.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ CH }}](../source/clickhouse.md);
* [{{ GP }}](../source/greenplum.md);
* [{{ KF }}](../source/kafka.md);
* [Aibyte](../../../transfer-matrix.md#airbyte);
* [{{ metrika }}](../source/metrika.md);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [Oracle](../source/oracle.md).
* [{{ ES }}](../source/elasticsearch.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/clickhouse-prepare.md) %}

## Настройка эндпоинта-приемника {{ CH }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mch-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ mch-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mch.viewer }}`](../../../../managed-clickhouse/security.md#managed-clickhouse-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- CLI {#cli}

    * Тип эндпоинта — `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `clickhouse_target`.

    {% include [Managed ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        clickhouse_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              mdb_cluster_id = "<идентификатор_кластера>"
              database       = "<имя_переносимой_базы_данных>"
              user           = "<имя_пользователя_для_подключения>"
              password {
                raw = "<пароль_пользователя>"
              }
            }
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse.md) %}

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI {#cli}

    * Тип эндпоинта — `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `clickhouse_target`.

    {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        clickhouse_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              on_premise {
                http_port   = "<порт_для_подключения_по_HTTP>"
                native_port = "<порт_для_подключения_к_нативному_интерфейсу>"
                shards {
                  name  = "<имя_шарда>"
                  hosts = [ "список IP-адресов или FQDN хостов шарда" ]
                }
                tls_mode {
                  enabled {
                    ca_certificate = "<сертификат_в_формате_PEM>"
                  }
                }
              }
              database = "<имя_переносимой_базы_данных>"
              user     = "<имя_пользователя_для_подключения>"
              password {
                raw = "<пароль_пользователя>"
              }
            }
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.

          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.sharding_settings.title }}** — задайте настройки для [шардирования](../../../../managed-clickhouse/concepts/sharding.md):

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.no_sharding.title }}** — шардирование не используется.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_column.title }}** — имя колонки в таблицах, по которой следует шардировать данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки. Укажите имя колонки для шардирования в соответствующем поле.

            Для шардирования по конкретным значениям колонки укажите их в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.array_item_label }}**. Это поле определяет соответствие значений колонки и индекса шарда (порядковый номер шарда в отсортированном по именам списке шардов) для шардирования по конкретным значениям данных.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}** — данные по шардам будут распределяться на основе значения идентификатора трансфера. При этом трансфер игнорирует настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.title }}** и шардирует данные только по идентификатору трансфера.

           {% note warning %}

           Если не задавать имя колонки для шардирования и не использовать настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}**, то все данные будут перенесены в один шард.

           {% endnote %}

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_round_robin.title }}** — данные по шардам будут распределяться случайным образом (количество данных на каждом шарде будет примерно одинаковым).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}** — при необходимости задайте настройки переименования таблиц при трансфере.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}** — укажите задержку, с которой данные должны поступать в кластер-приемник. Увеличьте значение в этом поле, если {{ CH }} не успевает делать слияние кусков данных.

- {{ TF }} {#tf}

    * `clickhouse_cluster_name` — укажите имя кластера, в который будут передаваться данные.

    * `alt_names` — при необходимости укажите правила переименования таблиц базы-источника при переносе в базу-приемник:

        * `from_name` – имя таблицы в источнике.
        * `to_name` – имя таблицы в приемнике.

    * `sharding.column_value_hash.column_name` — имя колонки в таблицах, по которой следует [шардировать](../../../../managed-clickhouse/concepts/sharding.md) данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки.

    * `sharding.transfer_id` — при значении `true` данные по шардам распределяются на основе значения идентификатора трансфера. При этом трансфер игнорирует настройку `sharding.column_value_hash.column_name` и шардирует данные только по идентификатору трансфера.

       {% note warning %}

       Если не задавать имя колонки для шардирования и не использовать настройку `sharding.transfer_id`, то все данные будут перенесены в один шард.

       {% endnote %}

    * `cleanup_policy` — укажите способ очистки данных в базе-приемнике перед переносом:

        * `CLICKHOUSE_CLEANUP_POLICY_DROP` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

           Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

        * `CLICKHOUSE_CLEANUP_POLICY_DISABLED` — не очищать.

           Выберите эту опцию, если будет производиться только репликация без копирования данных.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Не добавляются новые таблицы](#no-new-tables)
* [Не переносятся данные](#no-transfer)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [table-names](../../../../_includes/data-transfer/troubles/table-names.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}