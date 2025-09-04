# Настройка Delta Lake в однокластерном режиме

{{ dataproc-name }} версии 2.0 и выше поддерживает использование Delta Lake в однокластерном режиме.

Подробную информацию о Delta Lake см. в разделе [Delta Lake в {{ dataproc-name }}](../../concepts/deltalake.md) и в [документации Delta Lake](https://docs.delta.io/latest/index.html).


{% include [deltalake-disclaimer](../../../_includes/data-processing/deltalake-disclaimer.md) %}


{% note warning %}

Если разные Spark-задания в однокластерном режиме одновременно изменяют данные в таблице, информация может быть потеряна.

Настройте Spark-задания так, чтобы исключить одновременную модификацию данных или используйте [мультикластерный режим](./multi-cluster-mode.md). Подробнее в [документации Delta Lake](https://docs.delta.io/latest/delta-storage.html#single-cluster-setup-default).

{% endnote %}

## Подготовьте инфраструктуру {#prereq}

1. Если у вас нет кластера {{ dataproc-name }}, [создайте его](../cluster-create.md).
1. Если для хранения данных вы подключили к кластеру [бакет {{ objstorage-full-name }}](../../../storage/concepts/bucket.md):

    1. Создайте в бакете каталог c именем `warehouse`.
    1. [Установите свойство](../../concepts/settings-list.md#change-properties) `spark.sql.warehouse.dir` в значение `s3a://<имя_бакета>/warehouse/`.

1. [Создайте кластер](../../../metadata-hub/operations/metastore/cluster-create.md) {{ metastore-full-name }} и [подключите](../../../metadata-hub/operations/metastore/data-processing-connect.md) его к кластеру {{ dataproc-name }}.

## Настройте свойства компонентов для работы с Delta Lake {#settings}

1. Установите следующие [свойства](../../concepts/settings-list.md) на уровне кластера или на уровне отдельного задания:

    * `spark.sql.extensions` в значение `io.delta.sql.DeltaSparkSessionExtension`;
    * `spark.sql.catalog.spark_catalog` в значение `org.apache.spark.sql.delta.catalog.DeltaCatalog`.

1. Добавьте библиотеки Delta Lake в зависимости кластера или отдельного задания (нужные версии библиотек [зависят от версии {{ dataproc-name }}](../../concepts/deltalake.md#compatibility)):

    {% list tabs %}

    - {{ dataproc-name }} 2.0.x

        Воспользуйтесь одним из способов:

        * Скачайте файл библиотеки [delta-core_2.12-0.8.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar), сохраните его в бакет {{ objstorage-name }} и передайте URL файла в свойстве `spark.jars`:

            `spark.jars=s3a://<имя_бакета>/<путь_к_файлу>`

            Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.

        * Настройте доступ кластера к репозиторию [Maven](https://maven.apache.org/index.html) и установите свойство `spark.jars.packages` в значение `io.delta:delta-core_2.12:0.8.0`.

            {% include [maven-setup](../../../_includes/data-processing/maven-setup.md) %}

        * Скачайте файл библиотеки [delta-core_2.12-0.8.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar), скопируйте его на все узлы кластера вручную или с помощью [скриптов инициализации](../../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark.driver.extraClassPath` и `spark.executor.extraClassPath`.

    - {{ dataproc-name }} 2.1.0 или 2.1.3

        Воспользуйтесь одним из способов:

        * Скачайте файлы библиотек [delta-core_2.12-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.0.2/delta-core_2.12-2.0.2.jar) и [delta-storage-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.0.2/delta-storage-2.0.2.jar), сохраните их в бакет {{ objstorage-name }} и передайте URL файлов через запятую в свойстве `spark.jars`:

            `spark.jars=s3a://<имя_бакета>/<путь_к_файлу_core>,s3a://<имя_бакета>/<путь_к_файлу_storage>`

            Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.

        * Настройте доступ кластера к репозиторию [Maven](https://maven.apache.org/index.html) и установите свойство `spark.jars.packages` в значение `io.delta:delta-core_2.12:2.0.2,io.delta:delta-storage:2.0.2`.

            {% include [maven-setup](../../../_includes/data-processing/maven-setup.md) %}

        * Скачайте файлы библиотек [delta-core_2.12-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.0.2/delta-core_2.12-2.0.2.jar) и [delta-storage-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.0.2/delta-storage-2.0.2.jar), скопируйте их на все узлы кластера вручную или с помощью [скриптов инициализации](../../concepts/init-action.md) и передайте полный путь к файлам в свойствах `spark.driver.extraClassPath` и `spark.executor.extraClassPath`.

    - {{ dataproc-name }} 2.1.4 и выше

        Воспользуйтесь одним из способов:

        * Скачайте файлы библиотек [delta-core_2.12-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.3.0/delta-core_2.12-2.3.0.jar) и [delta-storage-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.3.0/delta-storage-2.3.0.jar), сохраните их в бакет {{ objstorage-name }} и передайте URL файлов через запятую в свойстве `spark.jars`:

            `spark.jars=s3a://<имя_бакета>/<путь_к_файлу core>,s3a://<имя_бакета>/<путь_к_файлу_storage>`

            Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.

        * Настройте доступ кластера к репозиторию [Maven](https://maven.apache.org/index.html) и установите свойство `spark.jars.packages` в значение `io.delta:delta-core_2.12:2.3.0,io.delta:delta-storage:2.3.0`.

            {% include [maven-setup](../../../_includes/data-processing/maven-setup.md) %}

        * Скачайте файлы библиотек [delta-core_2.12-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.3.0/delta-core_2.12-2.3.0.jar) и [delta-storage-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.3.0/delta-storage-2.3.0.jar), скопируйте их на все узлы кластера вручную или с помощью [скриптов инициализации](../../concepts/init-action.md) и передайте полный путь к файлам в свойствах `spark.driver.extraClassPath` и `spark.executor.extraClassPath`.

    {% endlist %}

Теперь вы можете использовать Delta Lake в кластере {{ dataproc-name }}.

Если перечисленные свойства Spark переданы на уровне кластера, то для работы с таблицами Delta Lake можно использовать [Spark Thrift Server](../../concepts/settings-list.md#spark-thrift-server).

## Пример использования Delta Lake {#example}

Пример проверялся в кластере {{ dataproc-name }} версии 2.0 с доступом к репозиторию Maven Central.

1. [Подключитесь по SSH](../connect-ssh.md) к хосту-мастеру кластера {{ dataproc-name }}.

1. Запустите в кластере сессию Spark, передав необходимые параметры:

    ```bash
    spark-sql \
        --conf spark.jars.packages=io.delta:delta-core_2.12:0.8.0 \
        --conf spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension \
        --conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog
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
