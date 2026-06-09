# Передача данных в эндпоинт-приемник {{ yds-full-name }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в очередь {{ yds-full-name }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ yds-full-name }} {#scenarios}

1. Захват изменений данных — это процесс отслеживания изменений в базе данных и поставка этих изменений потребителям. Применяется для приложений, которые чувствительны к изменению данных в реальном времени.
    * [Захват изменений {{ MY }} и поставка в {{ DS }}](../../../tutorials/mmy-to-yds.md);
    * [Захват изменений {{ PG }} и поставка в {{ DS }}](../../../tutorials/mpg-to-yds.md);
    * [Захват изменений {{ ydb-short-name }} и поставка в {{ DS }}](../../../tutorials/ydb-to-yds.md).

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.
  
    * [Поставка данных из {{ KF }} в {{ DS }}](../../../tutorials/mkf-to-yds.md).

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [{{ ydb-name }}](../source/ydb.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md).
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника {{ yds-full-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#general-settings) к потоку данных в {{ yds-full-name }} и [настройки сериализации](#serializer). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

### Основные настройки {#general-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-full-name }}, зарегистрированную в [{{ yds-full-name }}](../../../../data-streams/index.md) в качестве приемника.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока, ассоциированного с базой данных.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или создайте [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `yds.editor`, от имени которого сервис {{ data-transfer-name }} будет подключаться к приемнику данных.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

{% endlist %}

### Расширенные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTargetAdvancedSettings.save_tx_order.title }}** — не разбивать поток событий на независимые очереди по таблицам.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.supported_codecs.title }}** — укажите требуемый формат сжатия данных: `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.gzip.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.zstd.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.raw.title }}`.

{% endlist %}

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** выберите тип [сериализации](../../../concepts/serializer.md):
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}** — автоматическая сериализация.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}** — сериализация по стандартам Debezium:
      
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_yandex_schema_registry_debezium.title }}**:
    
          * Выберите схему сообщения (формат данных).
          * Выберите из списка [пространство имен](../../../../metadata-hub/operations/list-name-space.md) реестра схем {{ schema-registry-full-name }}.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**:
    
          * Выберите схему ключа сообщения (соответствует Debezium-параметру `key.converter`). Значение по умолчанию соответствует Debezium-параметрам `key.converter.schemas.enable=true` и  `key.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}** Debezium-параметр `key.converter.schemas.enable` принимает значение `false`.
          * Выберите схему значения сообщения (соответствует Debezium-параметру `value.converter`). Значение по умолчанию соответствует Debezium-параметрам `value.converter.schemas.enable=true` и  `value.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}** Debezium-параметр `value.converter.schemas.enable` принимает значение `false`.
          * При выборе значений **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.avro.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.protobuf.title }}** для схем ключа и значения сообщения укажите параметры доступа к внешнему сервису Confluent Schema Registry:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}** — URL сервиса.
            * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}**.
            * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}**.
            * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.ca_cert.title }}** — загрузите SSL-сертификат для подключения. Чтобы пропустить проверку сертификата, не задавайте его.
    
        * При необходимости задайте [**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**](../../../concepts/serializer.md#debezium) в формате `Параметр`-`Значение`.
    
    Если вы хотите использовать JSON-схемы в {{ schema-registry-full-name }}, сохраняя [совместимость схем при добавлении и удалении опциональных полей](../../../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution), укажите следующие настройки:
    
    **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**
    
    * Чтобы использовать {{ schema-registry-name }} для ключей, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.key_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Чтобы использовать {{ schema-registry-name }} для значений, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.value_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Укажите параметры доступа к Schema Registry:
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}** — `https://<идентификатор_пространства_имен>.{{ schema-registry-endpoint }}`.
    
          {% note warning %}
    
          В пространстве имен должна быть [выставлена](../../../../metadata-hub/operations/update-name-space.md) **Политика проверок совместимости для JSON** — `optional friendly`.
    
          {% endnote %}
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}** — `api-key`.
    
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}** — значение [API-ключа](../../../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к {{ schema-registry-name }}. Чтобы получить значение:
          1. Создайте API-ключ с ограниченной областью действия и поместите его в локальную переменную `SECRET`:
    
              ```bash
              yc iam api-key create --folder-id <идентификатор_каталога> \
                --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
                --scopes yc.schema-registry.schemas.manage \
                --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
              SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
              ```
    
          1. Выведите в терминал значение переменной `SECRET`:
    
              ```bash
              echo $SECRET
              ```
    
    
    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**:
        * Чтобы генерировать закрытую схему для ключей, добавьте параметр `key.converter.dt.json.generate.closed.content.schema` со значением `true`.
        * Чтобы генерировать закрытую схему для значений, добавьте параметр `value.converter.dt.json.generate.closed.content.schema` со значением `true`.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#overloaded)
* [Редиректы {{ sf-short-name }}](#redirects)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Прерывание трансфера с ошибкой {#overloaded}

Трансфер типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ прерывается с ошибкой.

Текст ошибки:

```text
/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED
```

Трансфер прерывается из-за ограничения облачной [квоты]({{ link-console-quotas }}) на количество операций с {{ ydb-name }}.

**Решение:**

1. Увеличьте в [квотах {{ ydb-name }}](../../../../ydb/concepts/limits.md) на облако с нужной базой данных значение характеристики **Количество схемных операций в минуту** и [активируйте](../../transfer.md#activate) трансфер повторно.

### Редиректы {{ sf-short-name }} {#redirects}

В трансферах из {{ yds-short-name }} или {{ KF }} в редких случаях может возникнуть ошибка:

```text
redirect to SOME_URL is requested but no redirects are allowed.
```

Возможная причина:

На источнике настроено использование функции {{ sf-short-name }}, которая возвращает не данные, а редирект на другой URL. 

**Решение:**

По соображениям безопасности такие редиректы запрещены. Воздержитесь от использования редиректов в {{ sf-short-name }} в трансферах.