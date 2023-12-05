# Настройка Delta Lake в мультикластерном режиме

При работе в мультикластерном режиме {{ dataproc-name }} использует базу данных [{{ ydb-full-name }}](../../../ydb/index.yaml) для координации доступа к таблицам Delta Lake из разных кластеров и заданий {{ SPRK }}.

Подробную информацию о Delta Lake см. в разделе [Delta Lake в {{ dataproc-name }}](../../concepts/deltalake.md) и в [документации Delta Lake](https://docs.delta.io/latest/index.html).


{% include [deltalake-disclaimer](../../../_includes/data-proc/deltalake-disclaimer.md) %}


## Подготовьте инфраструктуру {#prereq}

1. [Создайте Serverless-базу данных {{ ydb-name }}](../../../ydb/operations/manage-databases.md#create-db-serverless).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролью `ydb.editor` для доступа к {{ ydb-short-name }}.
1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта.
1. [Создайте секрет в {{ lockbox-full-name }}](../../../lockbox/operations/secret-create.md) и поместите в него данные статического ключа в формате двух пар `ключ-значение`:

    * ключ: `key-id`, значение: `<идентификатор_статического_ключа>`;
    * ключ: `key-secret`, значение: `<секретная_часть_статического_ключа>`.

1. Настройте один или несколько кластеров {{ dataproc-name }} для работы с Delta Lake:

    1. Если у вас нет кластера {{ dataproc-name }}, [создайте его](../cluster-create.md).
    1. Если для хранения данных вы подключили к кластеру [бакет {{ objstorage-full-name }}](../../../storage/concepts/bucket.md):

        1. Создайте в бакете каталог c именем `warehouse`.
        1. [Установите свойство](../../concepts/settings-list.md#change-properties) `spark.sql.warehouse.dir` в значение `s3a://<имя_бакета>/warehouse/`.

    1. [Создайте кластер](../metastore/cluster-create.md) {{ metastore-full-name }} и [подключите](../metastore/dataproc-connect.md) его к кластеру {{ dataproc-name }}.

1. Выдайте роль `lockbox.payloadViewer` сервисному аккаунту, который использовался при создании кластеров {{ dataproc-name }}. Это можно сделать:

    * [только для ранее созданного секрета](../../../lockbox/operations/secret-access.md);
    * [на уровне всего каталога](../../../iam/operations/sa/assign-role-for-sa.md).

## Настройте свойства компонентов для работы с Delta Lake {#settings}

1. Скачайте архив с необходимыми библиотеками Delta Lake и надстройками для подключения к {{ ydb-name }}:

    * [Delta Lake 2.0.2](https://github.com/yandex-cloud/yc-delta/releases/download/v1.1/yc-delta20-multi-dp21-1.1-fatjar.jar) для {{ dataproc-name }} версии 2.1.0 или 2.1.3;
    * [Delta Lake 2.3.0](https://github.com/yandex-cloud/yc-delta/releases/download/v1.1/yc-delta23-multi-dp21-1.1-fatjar.jar) для {{ dataproc-name }} версии 2.1.4 и выше.

    Ознакомиться с исходным кодом надстроек для подключения к {{ ydb-short-name }} можно в репозитории:

    * [надстройки для Delta Lake 2.0.2](https://github.com/yandex-cloud/yc-delta/blob/develop/yc-delta20);
    * [надстройки для Delta Lake 2.3.0](https://github.com/yandex-cloud/yc-delta/blob/develop/yc-delta23).

1. Добавьте скачанный архив в зависимости всех кластеров или отдельных заданий, которые должны иметь доступ к таблицам Delta Lake. Это можно сделать двумя способами:

    * Сохраните архив в бакет {{ objstorage-name }} и передайте URL файла в свойстве `spark.jars`:

        `spark.jars=s3a://<имя_бакета>/<путь_к_файлу>`

        Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.

    * Скопируйте архив на все узлы кластера вручную или с помощью [скриптов инициализации](../../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark.driver.extraClassPath` и `spark.executor.extraClassPath`

1. Установите следующие [свойства](../../concepts/settings-list.md) на уровне кластеров или на уровне отдельных заданий {{ SPRK }}, которые должны иметь доступ к таблицам Delta Lake:

    * `spark.sql.extensions` в значение `io.delta.sql.DeltaSparkSessionExtension`;
    * `spark.sql.catalog.spark_catalog` в значение `org.apache.spark.sql.delta.catalog.DeltaCatalog`;
    * `spark.delta.logStore.s3a.impl` в значение `ru.yandex.cloud.custom.delta.YcS3YdbLogStore`;
    * `spark.io.delta.storage.S3DynamoDBLogStore.ddb.endpoint` в значение Document API эндпоинта, доступное на вкладке **{{ ui-key.yacloud.ydb.database.switch_overview}}** вашей базы данных в [консоли управления]({{ link-console-cloud }});
    * `spark.io.delta.storage.S3DynamoDBLogStore.ddb.lockbox` в значение идентификатора секрета {{ lockbox-short-name }}, который доступен на вкладке **{{ ui-key.yacloud.lockbox.label_section-overview}}** вашего {{ lockbox-short-name }} в [консоли управления]({{ link-console-cloud }}).

Теперь вы можете использовать Delta Lake в мультикластерном режиме.

## Пример использования Delta Lake {#example}

Пример проверялся в кластере {{ dataproc-name }} версии 2.1.7.

1. [Подключитесь по SSH](../connect.md#data-proc-ssh) к хосту-мастеру кластера {{ dataproc-name }}.

1. Запустите в кластере сессию {{ SPRK }}, передав необходимые параметры:

    ```bash
    spark-sql  \
        --conf spark.jars=s3a://<имя_бакета>/yc-delta23-multi-dp21-1.1-fatjar.jar \
        --conf spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension \
        --conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.YcDeltaCatalog \
        --conf spark.delta.logStore.s3a.impl=ru.yandex.cloud.custom.delta.YcS3YdbLogStore \
        --conf spark.io.delta.storage.S3DynamoDBLogStore.ddb.endpoint=<Document_API_эндпоинт> \
        --conf spark.io.delta.storage.S3DynamoDBLogStore.ddb.lockbox=<идентификатор_секрета>
    ```

1. В рамках запущенной сессии создайте базу данных и переключитесь на нее:

    ```sql
    CREATE DATABASE testdelta;
    USE testdelta;
    ```

1. Создайте тестовую таблицу и наполните ее данными:

    ```sql
    CREATE TABLE tab1(a INTEGER NOT NULL, b VARCHAR(100)) USING DELTA;
    INSERT INTO tab1 VALUES (1,'One'), (2,'Two'), (3,'Three');
    ```

1. Замените значения в столбце `b`, добавив к ним значения из столбца `a`, преобразованные в строку:

    ```sql
    UPDATE tab1 SET b=b || ' ** ' || CAST(a AS VARCHAR(10));
    ```

1. Проверьте результат:

    ```sql
    SELECT * FROM tab1;
    ```

    ```sql
    3	Three ** 3
    2	Two ** 2
    1	One ** 1
    ```

## Дополнительные настройки мультикластерного режима для производственных кластеров {{ dataproc-name }} {#prod-configs}

Для повышения производительности работы Delta Lake и оптимизации хранения данных при работе в мультикластерном режиме рекомендуется выполнить дополнительные настройки {{ ydb-short-name }}.

### Настройка пропускной способности {{ ydb-name }} {#throughput}

По умолчанию {{ ydb-short-name }} в Serverless-режиме создается с [пропускной способностью](../../../ydb/concepts/serverless-and-dedicated.md#capacity) 10 Request Units в секунду. При интенсивной работе с таблицами Delta Lake этого может оказаться недостаточно.

Чтобы не допустить снижения производительности Delta Lake из-за недостаточной пропускной способности {{ ydb-short-name }}, отслеживайте поведение параметра **Document API units overflow** по графику при [мониторинге {{ ydb-short-name }}](../../../ydb/operations/monitoring.md). При необходимости увеличьте предел пропускной способности.

На все базы данных {{ ydb-short-name }} в облаке действует общий предел пропускной способности, который определяется квотой. При необходимости обратитесь в [техническую поддержку]({{ link-console-support }}) для увеличения квоты.

### Настройка автоматической очистки мусора {#auto-vacuum}

При работе с Delta Lake неиспользуемые версии метаданных могут накапливаться в таблице {{ ydb-short-name }} и в бакетах {{ objstorage-name }}. Оптимизировать использование хранилища и увеличить эффективность работы Delta Lake можно с помощью [подготовленного скрипта](https://github.com/yandex-cloud/yc-delta/blob/develop/cf-cleanup/cfunc.py), который выполняет регулярную автоматическую очистку устаревших метаданных из таблицы {{ ydb-short-name }} и из бакета.

Скрипт устанавливается в облако в виде двух [Serverless-функций](../../../functions/concepts/index.md):

* Функция очистки данных в таблице {{ ydb-short-name }}. Запускается автоматически один раз в час.
* Функция очистки данных в бакетах. Запускается автоматически один раз в сутки.

Чтобы установить функции очистки в облако:

1. {% include [cli-install](../../../_includes/cli-install.md) %}
1. Скачайте файлы из каталога [cf-cleanup](https://github.com/yandex-cloud/yc-delta/tree/develop/cf-cleanup):

    * `cfunc.py` — исходный код скрипта очистки;
    * `delta-prefixes.txt` — файл с префиксами путей к временным файлам Delta Lake в бакетах;
    * `pack.sh` — скрипт создания ZIP-архива;
    * `requirements.txt` — файл с требованиями к окружению, необходим для установки функций.

    Поместите эти файлы в каталог с именем `cf-cleanup` в рабочей директории.

1. Сделайте файл `pack.sh` исполняемым:

    ```bash
    chmod +x ./cf-cleanup/pack.sh
    ```

1. В файле `delta-prefixes.txt` укажите пути к каталогам в бакетах {{ objstorage-name }}, содержащим временные файлы Delta Lake. Каждый путь должен быть указан в новой строке в следующем формате:

    ```txt
    ИмяБакета Режим ПрефиксПути
    ```

    Поле `Режим` может принимать значения:

    * `W` — Warehouse, путь хранения нескольких баз данных.
    * `D` — Database, путь хранения одной базы данных.
    * `T` — Table, путь хранения одной конкретной таблицы.

    Пример:

    ```txt
    mybucket1 W warehouse/
    mybucket2 D warehouse/testdelta2.db/
    mybucket3 T warehouse/testdelta3.db/tab1/
    ```

1. Поместите файл `delta-prefixes.txt` в бакет {{ objstorage-name }}.
1. Скачайте и поместите в рабочую директорию файлы для управления функциями очистки:

    * [ddb-maint-config.sh](https://github.com/yandex-cloud/yc-delta/blob/develop/ddb-maint-config.sh) — параметры установки.
    * [ddb-maint-setup.sh](https://github.com/yandex-cloud/yc-delta/blob/develop/ddb-maint-setup.sh) — сценарий установки.
    * [ddb-maint-remove.sh](https://github.com/yandex-cloud/yc-delta/blob/develop/ddb-maint-remove.sh) — сценарий удаления.

1. В файле `ddb-maint-config.sh` укажите значения для следующих параметров:

    * `sa_name` — имя сервисного аккаунта, который будет создан для работы функций.
    * `cf_ddb_name` — имя Serverless-функции для очистки базы данных, должно быть уникальным в каталоге.
    * `cf_s3_name` — имя Serverless-функции для очистки бакетов, должно быть уникальным в каталоге.
    * `docapi_endpoint` — Document API эндпоинт. Доступен на вкладке **{{ ui-key.yacloud.ydb.database.switch_overview}}** вашей базы данных {{ ydb-short-name }} в [консоли управления]({{ link-console-cloud }}).
    * `docapi_table` — имя таблицы Delta Lake для которой будет выполняться очистка.
    * `s3_prefix_file` — путь к файлу `delta-prefixes.txt` в бакете {{ objstorage-name }}, например `s3://<имя_бакета>/delta-prefixes.txt`.

1. Запустите в локальной директории сценарий установки:

    ```bash
    bash ./ddb-maint-setup.sh
    ```

Функции очистки временных файлов из таблиц {{ ydb-short-name }} и бакетов {{ objstorage-name }} будут установлены в облако. Проверить их наличие можно в [консоли управления]({{ link-console-cloud }}).

Если функции очистки вам больше не нужны, запустите сценарий их удаления:

```bash
bash ./ddb-maint-remove.sh
```

Время жизни записей метаданных задается свойством Spark `spark.io.delta.storage.S3DynamoDBLogStore.ddb.ttl` и по умолчанию составляет `86400` секунд (одни сутки). Фактическое время жизни для конкретной записи может оказаться больше, поскольку зависит от момента запуска функции очистки.
