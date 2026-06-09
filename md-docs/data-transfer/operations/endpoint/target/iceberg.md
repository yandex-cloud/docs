# Передача данных в эндпоинт-приемник {{ IBRG }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в таблицы {{ IBRG }} в кластере {{ metastore-full-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с таблицами и [контролируйте трансфер](../../monitoring.md).

## Сценарии передачи данных в {{ IBRG }} {#scenarios}

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ CH }}](../source/clickhouse.md);
* [{{ GP }}](../source/greenplum.md);
* [{{ MG }}](../source/mongodb.md);
* [{{ MY }}](../source/mysql.md);
* [{{ PG }}](../source/postgresql.md);
* [{{ ES }}](../source/elasticsearch.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [Oracle](../source/oracle.md);
* [{{ ydb-name }}](../source/ydb.md);
* [{{ ytsaurus-name }}](../source/yt.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника {{ IBRG }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения к кластеру {{ metastore-name }}](#managed-service).
* [Настройки конфигурации](#bucket-config) для бакета {{ objstorage-full-name }} или пользовательского S3-совместимого хранилища.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ metastore-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.metastore.viewer }}`](../../../../metadata-hub/security/metastore-roles.md#managed-metastore-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.mdb_cluster_id.title }}** — идентификатор кластера, каталог которого используется для таблиц {{ IBRG }}.

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.security_group_ids.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика. Это позволит применить указанные правила групп безопасности к ВМ и кластерам в выбранной сети без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

      Убедитесь, что выбранные группы безопасности [настроены](../../../../metadata-hub/operations/metastore/configure-security-group.md).


{% endlist %}

### Настройки конфигурации бакета {#bucket-config}

{% list tabs group=instructions %}

- Бакет {{ objstorage-full-name }} {#obj-storage}

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergObjectStorageConnectionSettings.bucket.title }}** — имя [бакета](../../../../storage/concepts/bucket.md), в который будут загружаться данные из источника.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergObjectStorageConnectionSettings.service_account_id.title }}** — выберите или создайте [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `storage.uploader`, от имени которого сервис {{ data-transfer-name }} будет подключаться к бакету.


- Пользовательское S3-совместимое хранилище {#s3-storage}

    * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.endpoint.title }}** — эндпоинт для службы, совместимой с Amazon S3. Оставьте поле пустым для использования Amazon.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.region.title }}** — регион для отправки запросов.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.bucket.title }}** — имя бакета.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.access_key_id.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.secret_access_key.title }}** — [идентификатор и содержимое ключа AWS](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) для доступа к частному бакету.

{% endlist %}

* (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.prefix.title }}** — префикс путей для записи объектов в бакет.

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:

     * `{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergCleanupPolicy.ICEBERG_CLEANUP_POLICY_DISABLED.title }}` — существующие таблицы с данными будут использоваться для дальнейшей записи данных.

     * `{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergCleanupPolicy.ICEBERG_CLEANUP_POLICY_DROP.title }}` — полное удаление таблиц, участвующих в трансфере.

       Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).