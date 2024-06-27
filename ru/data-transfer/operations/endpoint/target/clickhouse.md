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
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
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

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/clickhouse/ui/cleanup-policy.md) %}

    * {% include [sharding_settings](../../../../_includes/data-transfer/fields/clickhouse/ui/sharding-settings.md) %}

    * {% include [alt_names](../../../../_includes/data-transfer/fields/clickhouse/ui/alt-names.md) %}

    * {% include [flush_interval](../../../../_includes/data-transfer/fields/clickhouse/ui/flush-interval.md) %}

- CLI {#cli}

    * {% include [cluster-name](../../../../_includes/data-transfer/fields/clickhouse/cli/cluster-name.md) %}

    * {% include [alt-name](../../../../_includes/data-transfer/fields/clickhouse/cli/alt-name.md) %}

    * Настройки [шардирования](../../../../managed-clickhouse/concepts/sharding.md) данных:

        * {% include [shard-by-column-hash](../../../../_includes/data-transfer/fields/clickhouse/cli/shard-by-column-hash.md) %}

        * {% include [custom-sharding-column-name](../../../../_includes/data-transfer/fields/clickhouse/cli/custom-sharding-column-name.md) %}

        * {% include [custom-sharding-mapping-string](../../../../_includes/data-transfer/fields/clickhouse/cli/custom-sharding-mapping-string.md) %}

        * {% include [shard-by-transfer-id](../../../../_includes/data-transfer/fields/clickhouse/cli/shard-by-transfer-id.md) %}

        Вы можете указать только один из вариантов шардирования:

        * `--shard-by-column-hash`;
        * `--custom-sharding-column-name` и `--custom-sharding-mapping-string`;
        * `--shard-by-transfer-id`.

- {{ TF }} {#tf}

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/clickhouse/terraform/cleanup-policy.md) %}

    * {% include [clickhouse_cluster_name](../../../../_includes/data-transfer/fields/clickhouse/terraform/clickhouse-cluster-name.md) %}

    * {% include [alt_names](../../../../_includes/data-transfer/fields/clickhouse/terraform/alt-names.md) %}

    * Настройки [шардирования](../../../../managed-clickhouse/concepts/sharding.md) данных:

        * {% include [column_value_hash](../../../../_includes/data-transfer/fields/clickhouse/terraform/sharding-column-value-hash.md) %}

        * {% include [transfer_id](../../../../_includes/data-transfer/fields/clickhouse/terraform/sharding-transfer-id.md) %}

        * {% include [custom_mapping](../../../../_includes/data-transfer/fields/clickhouse/terraform/custom-mapping.md) %}

        * {% include [round_robin](../../../../_includes/data-transfer/fields/clickhouse/terraform/round-robin.md) %}

        Вы можете указать только один из вариантов шардирования: `sharding.column_value_hash.column_name`, `sharding.transfer_id`, `custom_mapping` или `round_robin`. Если вариант шардирования не указан, то все данные переносятся в один шард.

- API {#api}

    * {% include [altNames](../../../../_includes/data-transfer/fields/clickhouse/api/alt-names.md) %}

    * {% include [cleanupPolicy](../../../../_includes/data-transfer/fields/clickhouse/api/cleanup-policy.md) %}

    * {% include [sharding](../../../../_includes/data-transfer/fields/clickhouse/api/sharding.md) %}

    * {% include [clickhouseClusterName](../../../../_includes/data-transfer/fields/clickhouse/api/clickhouse-cluster-name.md) %}

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Не добавляются новые таблицы](#no-new-tables)
* [Не переносятся данные](#no-transfer)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [table-names](../../../../_includes/data-transfer/troubles/table-names.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}