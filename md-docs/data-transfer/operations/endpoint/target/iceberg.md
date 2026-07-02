[Документация Yandex Cloud](../../../../index.md) > [Yandex Data Transfer](../../../index.md) > [Пошаговые инструкции](../../index.md) > [Настройка эндпоинтов](../index.md) > Apache Iceberg® > Приемник

# Передача данных в эндпоинт-приемник Apache Iceberg™


С помощью сервиса Yandex Data Transfer вы можете переносить данные в таблицы Apache Iceberg™ в кластере Apache Hive™ Metastore и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в Yandex Data Transfer.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с таблицами и [контролируйте трансфер](../../monitoring.md).

## Сценарии передачи данных в Apache Iceberg™ {#scenarios}

Подробное описание возможных сценариев передачи данных в Yandex Data Transfer читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [ClickHouse®](../source/clickhouse.md);
* [Greenplum®](../source/greenplum.md);
* [MongoDB](../source/mongodb.md);
* [MySQL®](../source/mysql.md);
* [PostgreSQL](../source/postgresql.md);
* [Elasticsearch](../source/elasticsearch.md);
* [Yandex Object Storage](../source/object-storage.md);
* [Oracle](../source/oracle.md);
* [Managed Service for YDB](../source/ydb.md);
* [YTsaurus](../source/yt.md).

Полный список поддерживаемых источников и приемников в Yandex Data Transfer читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника Apache Iceberg™ {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения к кластеру Apache Hive™ Metastore](#managed-service).
* [Настройки конфигурации](#bucket-config) для бакета Yandex Object Storage или пользовательского S3-совместимого хранилища.
* [Дополнительные параметры](#additional-settings).

### Кластер Apache Hive™ Metastore {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `managed-metastore.viewer`](../../../../metadata-hub/security/metastore-roles.md#managed-metastore-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение с указанием кластера в Yandex Cloud.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Кластер Apache Hive™ Metastore** — идентификатор кластера, каталог которого используется для таблиц Apache Iceberg™.

    
    * **Группы безопасности** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика. Это позволит применить указанные правила групп безопасности к ВМ и кластерам в выбранной сети без изменения их настроек. Подробнее читайте в разделе [Сеть в Yandex Data Transfer](../../../concepts/network.md).

      Убедитесь, что выбранные группы безопасности [настроены](../../../../metadata-hub/operations/metastore/configure-security-group.md).


{% endlist %}

### Настройки конфигурации бакета {#bucket-config}

{% list tabs group=instructions %}

- Бакет Yandex Object Storage {#obj-storage}

    
    * **Бакет** — имя [бакета](../../../../storage/concepts/bucket.md), в который будут загружаться данные из источника.
    * **Сервисный аккаунт** — выберите или создайте [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `storage.uploader`, от имени которого сервис Data Transfer будет подключаться к бакету.


- Пользовательское S3-совместимое хранилище {#s3-storage}

    * (Опционально) **Эндпоинт** — эндпоинт для службы, совместимой с Amazon S3. Оставьте поле пустым для использования Amazon.
    * **Регион** — регион для отправки запросов.
    * **Бакет** — имя бакета.
    * **Идентификатор статического ключа** и **Содержимое статического ключа** — [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) для доступа к частному бакету.

{% endlist %}

* (Опционально) **Префикс пути** — префикс путей для записи объектов в бакет.

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

   * **Политика очистки** — выберите способ очистки данных в базе-приемнике перед переносом:

     * `Не очищать` — существующие таблицы с данными будут использоваться для дальнейшей записи данных.

     * `DROP` — полное удаление таблиц, участвующих в трансфере.

       Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).