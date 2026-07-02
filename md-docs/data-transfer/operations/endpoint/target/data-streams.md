[Документация Yandex Cloud](../../../../index.md) > [Yandex Data Transfer](../../../index.md) > [Пошаговые инструкции](../../index.md) > [Настройка эндпоинтов](../index.md) > Yandex Data Streams > Приемник

# Передача данных в эндпоинт-приемник Yandex Data Streams


С помощью сервиса Yandex Data Transfer вы можете переносить данные в очередь Yandex Data Streams и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в Yandex Data Transfer.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в Yandex Data Streams {#scenarios}

1. Захват изменений данных — это процесс отслеживания изменений в базе данных и поставка этих изменений потребителям. Применяется для приложений, которые чувствительны к изменению данных в реальном времени.
    * [Захват изменений MySQL® и поставка в YDS](../../../tutorials/mmy-to-yds.md);
    * [Захват изменений PostgreSQL и поставка в YDS](../../../tutorials/mpg-to-yds.md);
    * [Захват изменений YDB и поставка в YDS](../../../tutorials/ydb-to-yds.md).

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.
  
    * [Поставка данных из Apache Kafka® в YDS](../../../tutorials/mkf-to-yds.md).

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

Подробное описание возможных сценариев передачи данных в Yandex Data Transfer читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [PostgreSQL](../source/postgresql.md);
* [MySQL®](../source/mysql.md);
* [Apache Kafka®](../source/kafka.md);
* [Managed Service for YDB](../source/ydb.md);
* [Airbyte®](../../../transfer-matrix.md#airbyte);
* [YDS](../source/data-streams.md);
* [Yandex Object Storage](../source/object-storage.md).
* [OpenSearch](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в Yandex Data Transfer читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника Yandex Data Streams {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#general-settings) к потоку данных в Yandex Data Streams и [настройки сериализации](#serializer). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

### Основные настройки {#general-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **База данных** — выберите базу данных Yandex Managed Service for YDB, зарегистрированную в [Yandex Data Streams](../../../../data-streams/index.md) в качестве приемника.
    
    * **Поток** — укажите имя потока, ассоциированного с базой данных.
    
    * **Сервисный аккаунт** — выберите или создайте [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `yds.editor`, от имени которого сервис Data Transfer будет подключаться к приемнику данных.
    
    * **Группы безопасности** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [Сеть в Yandex Data Transfer](../../../concepts/network.md).

{% endlist %}

### Расширенные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Сохранять порядок транзакций** — не разбивать поток событий на независимые очереди по таблицам.

    * **Кодеки сжатия** — укажите требуемый формат сжатия данных: `GZIP`, `ZSTD` или `Без сжатия`.

{% endlist %}

### Настройки сериализации {#serializer}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * В блоке **Настройки сериализации** выберите тип [сериализации](../../../concepts/serializer.md):
    
      * **Auto** — автоматическая сериализация.
      * **Debezium** — сериализация по стандартам Debezium:
      
        * **Yandex Schema Registry**:
    
          * Выберите схему сообщения (формат данных).
          * Выберите из списка [пространство имен](../../../../metadata-hub/operations/list-name-space.md) реестра схем Yandex Schema Registry.
    
        * **On Premise**:
    
          * Выберите схему ключа сообщения (соответствует Debezium-параметру `key.converter`). Значение по умолчанию соответствует Debezium-параметрам `key.converter.schemas.enable=true` и  `key.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **Отключена** Debezium-параметр `key.converter.schemas.enable` принимает значение `false`.
          * Выберите схему значения сообщения (соответствует Debezium-параметру `value.converter`). Значение по умолчанию соответствует Debezium-параметрам `value.converter.schemas.enable=true` и  `value.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **Отключена** Debezium-параметр `value.converter.schemas.enable` принимает значение `false`.
          * При выборе значений **Avro (посредством Schema Registry)**, **JSON (посредством Schema Registry)**, **Protobuf (посредством Schema Registry)** для схем ключа и значения сообщения укажите параметры доступа к внешнему сервису Confluent Schema Registry:
    
            * **URL** — URL сервиса.
            * (Опционально) **Имя пользователя**.
            * (Опционально) **Пароль**.
            * (Опционально) **CA сертификат** — загрузите SSL-сертификат для подключения. Чтобы пропустить проверку сертификата, не задавайте его.
    
        * При необходимости задайте [**Настройки сериализации Debezium**](../../../concepts/serializer.md#debezium) в формате `Параметр`-`Значение`.
    
    Если вы хотите использовать JSON-схемы в Yandex Schema Registry, сохраняя [совместимость схем при добавлении и удалении опциональных полей](../../../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution), укажите следующие настройки:
    
    **Настройки сериализации** — **Debezium** — **On Premise**
    
    * Чтобы использовать Schema Registry для ключей, выберите **Схема ключа сообщения** — **JSON (посредством Schema Registry)**. Чтобы использовать Schema Registry для значений, выберите **Схема значения сообщения** — **JSON (посредством Schema Registry)**. Укажите параметры доступа к Schema Registry:
      * **URL** — `https://<идентификатор_пространства_имен>.schema-registry.yandexcloud.net:443`.
    
          {% note warning %}
    
          В пространстве имен должна быть [выставлена](../../../../metadata-hub/operations/update-name-space.md) **Политика проверок совместимости для JSON** — `optional friendly`.
    
          {% endnote %}
    
      * **Имя пользователя** — `api-key`.
    
      
      * **Пароль** — значение [API-ключа](../../../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к Schema Registry. Чтобы получить значение:
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
    
    
    * В блоке **Настройки сериализации Debezium**:
        * Чтобы генерировать закрытую схему для ключей, добавьте параметр `key.converter.dt.json.generate.closed.content.schema` со значением `true`.
        * Чтобы генерировать закрытую схему для значений, добавьте параметр `value.converter.dt.json.generate.closed.content.schema` со значением `true`.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#overloaded)
* [Редиректы Cloud Functions](#redirects)

Смотрите полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Прерывание трансфера с ошибкой {#overloaded}

Трансфер типа _**Репликация**_ или _**Копирование и репликация**_ прерывается с ошибкой.

Текст ошибки:

```text
/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED
```

Трансфер прерывается из-за ограничения облачной [квоты](https://console.yandex.cloud/cloud?section=quotas) на количество операций с Managed Service for YDB.

**Решение:**

1. Увеличьте в [квотах Managed Service for YDB](../../../../ydb/concepts/limits.md) на облако с нужной базой данных значение характеристики **Количество схемных операций в минуту** и [активируйте](../../transfer.md#activate) трансфер повторно.

### Редиректы Cloud Functions {#redirects}

В трансферах из Data Streams или Apache Kafka® в редких случаях может возникнуть ошибка:

```text
redirect to SOME_URL is requested but no redirects are allowed.
```

Возможная причина:

На источнике настроено использование функции Cloud Functions, которая возвращает не данные, а редирект на другой URL. 

**Решение:**

По соображениям безопасности такие редиректы запрещены. Воздержитесь от использования редиректов в Cloud Functions в трансферах.