---
title: Как настроить эндпоинт-источник {{ KF }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ KF }} в {{ data-transfer-full-name }}.
---

# Передача данных из эндпоинта-источника {{ KF }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из очереди {{ KF }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ KF }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из {{ KF }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

   Отдельной задачей миграции является зеркалирование данных между очередями:

    * [Зеркалирование {{ KF }}](../../../tutorials/mkf-to-mkf.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

    * [{{ KF }} в {{ CH }}](../../../tutorials/mkf-to-mch.md);
    * [{{ KF }} в {{ PG }}](../../../tutorials/mkf-to-mpg.md);
    * [{{ KF }} в {{ GP }}](../../../tutorials/managed-kafka-to-greenplum.md);
    * [{{ KF }} в {{ MG }}](../../../tutorials/mkf-to-mmg.md);
    * [{{ KF }} в {{ MY }}](../../../tutorials/mkf-to-mmy.md);
    * [{{ KF }} в {{ OS }}](../../../tutorials/mkf-to-mos.md);
    * [{{ KF }} в {{ ydb-short-name }}](../../../tutorials/mkf-to-ydb.md);
    * [{{ KF }} в {{ DS }}](../../../tutorials/mkf-to-yds.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/kafka.md) %}

## Настройка эндпоинта-источника {{ KF }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mkf-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Расширенные настройки](#additional-settings).

### Кластер {{ mkf-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mkf.viewer }}`](../../../../managed-kafka/security/index.md#mkf-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `kafka_source`.

    {% include [Managed Kafka Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-kafka-source.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        kafka_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            cluster_id = "<идентификатор_кластера>"
          }
          auth {
            <метод_аутентификации>
          }
          topic_names = ["<список_имен_топиков>"]
          <расширенные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed Kafka API](../../../../_includes/data-transfer/necessary-settings/api/managed-kafka-source.md) %}

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Подключение к кластеру {{ KF }} с явным указанием сетевых адресов и портов хостов-брокеров.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `kafka_source`.

    {% include [On-premise Kafka Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-kafka-source.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        kafka_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            on_premise {
              broker_urls = ["<список_IP-адресов_или_FQDN_хостов-брокеров>"]
              subnet_id  = "<идентификатор_подсети_c_хостами-брокерами>"
            }
          }
          auth = {
            <метод_аутентификации>
          }
          topic_names = ["<список_имен_топиков>"]
          <расширенные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On-premise Kafka API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-kafka-source.md) %}

{% endlist %}

### Расширенные настройки {#additional-settings}


{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.transformer.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}** — выберите одну из функций, созданных в сервисе {{ sf-name }}.

        
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.service_account_id.title }}** — выберите или [создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будет запускаться функция обработки.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}** — укажите количество попыток вызова функции обработки.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}** — укажите размер буфера (в байтах), при заполнении которого данные будут переданы функции обработки.

            Максимальный размер буфера — 3,5 МБ. Подробнее об ограничениях, действующих при работе с функциями в сервисе {{ sf-name }}, читайте в [соответствующем разделе](../../../../functions/concepts/limits.md).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** — укажите длительность интервала (в секундах), по истечении которого данные из потока должны быть переданы функции обработки.

            {% note info %}

            Если буфер заполнится или истечет интервал отправки, данные будут переданы функции обработки.

            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** — укажите допустимое время ожидания ответа от функции обработки (в секундах).

        {% note warning %}

        Значения в полях **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** указываются с постфиксом `s`, например, `10s`.

        {% endnote %}

    
    * {% include [conversion-rules](../../../../_includes/data-transfer/fields/yds/ui/conversion-rules.md) %}

- {{ TF }} {#tf}

    * {% include [transformers](../../../../_includes/data-transfer/fields/transformers-and-parsers/terraform/transformers.md) %}

    * {% include [parsers](../../../../_includes/data-transfer/fields/transformers-and-parsers/terraform/parsers.md) %}

- API {#api}

    * {% include [transformers](../../../../_includes/data-transfer/fields/transformers-and-parsers/api/transformers.md) %}

    * {% include [parsers](../../../../_includes/data-transfer/fields/transformers-and-parsers/api/parsers.md) %}

{% endlist %}

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ MY }}](../target/mysql.md);
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ ES }}](../target/elasticsearch.md);
* [{{ OS }}](../target/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).
