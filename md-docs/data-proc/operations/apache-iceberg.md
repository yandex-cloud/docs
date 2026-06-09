# Настройка {{ IBRG }} в кластере {{ dataproc-name }}

{{ dataproc-name }} версии 2.0 и выше поддерживает использование таблиц {{ IBRG }} совместно с движком {{ SPRK }}.

Подробную информацию об {{ IBRG }} читайте в разделе [{#T}](../concepts/apache-iceberg.md) и в [официальной документации](https://iceberg.apache.org/docs/latest/).


{% note info %}

{{ IBRG }} не является частью сервиса {{ dataproc-name }} и не сопровождается командой разработки и службой поддержки {{ yandex-cloud }}, а его использование не входит в [условия использования {{ dataproc-full-name }}]({{ link-cloud-terms-of-use }}).

{% endnote %}


## Настройте свойства компонентов для работы с {{ IBRG }} {#settings}

1. [Установите свойство](../concepts/settings-list.md#change-properties) `spark:spark.sql.extensions` в значение `org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions`. Это можно сделать как на уровне кластера, так и на уровне отдельного задания.

1. Добавьте библиотеки {{ IBRG }} в зависимости кластера или отдельного задания. Версии библиотек должны быть [совместимы с версией {{ dataproc-name }}](../concepts/apache-iceberg.md#compatibility).

    {% list tabs %}

    - Образ 2.0.x

        Чтобы добавить библиотеки требуемых версий, воспользуйтесь одним из способов:

        * Настройте доступ к репозиторию [Maven](https://maven.apache.org/index.html) и [установите свойство](../concepts/settings-list.md#change-properties) `spark:spark.jars.packages` в значение `{{ dp-libs.iceberg.dp20.pkg }}`.

            Настроить доступ к Maven можно двумя способами:
            
            * В [группе безопасности](../../vpc/concepts/security-groups.md) кластера разрешите сетевой доступ к репозиторию [Maven Central](https://repo.maven.apache.org/maven2/).
            * Настройте [альтернативный репозиторий Maven](https://maven.apache.org/guides/mini/guide-mirror-settings.html) и разрешите трафик к нему в [группе безопасности](../../vpc/concepts/security-groups.md) кластера.

        * Скачайте файл библиотеки [{{ dp-libs.iceberg.dp20.jar }}]({{ dp-libs.iceberg.dp20.repo }}) и предоставьте доступ к нему одним из способов:

            * Сохраните файл в бакет {{ objstorage-full-name }} и передайте URL файла в свойстве `spark:spark.jars`.
            
                URL файла имеет формат `s3a://<имя_бакета>/<путь_к_файлу>`.
            
                Этот бакет должен быть указан в настройках кластера. Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.
            
            * Скопируйте файл на все узлы кластера вручную или с помощью [скриптов инициализации](../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark:spark.driver.extraClassPath` и `spark:spark.executor.extraClassPath`.

    - Образы 2.1.0–2.1.3

        Чтобы добавить библиотеки требуемых версий, воспользуйтесь одним из способов:

        * Настройте доступ к репозиторию [Maven](https://maven.apache.org/index.html) и [установите свойство](../concepts/settings-list.md#change-properties) `spark:spark.jars.packages` в значение `{{ dp-libs.iceberg.dp21.spark32.pkg }}`.

            Настроить доступ к Maven можно двумя способами:
            
            * В [группе безопасности](../../vpc/concepts/security-groups.md) кластера разрешите сетевой доступ к репозиторию [Maven Central](https://repo.maven.apache.org/maven2/).
            * Настройте [альтернативный репозиторий Maven](https://maven.apache.org/guides/mini/guide-mirror-settings.html) и разрешите трафик к нему в [группе безопасности](../../vpc/concepts/security-groups.md) кластера.

        * Скачайте файл библиотеки [{{ dp-libs.iceberg.dp21.spark32.jar }}]({{ dp-libs.iceberg.dp21.spark32.repo }}) и предоставьте доступ к нему одним из способов:

            * Сохраните файл в бакет {{ objstorage-full-name }} и передайте URL файла в свойстве `spark:spark.jars`.
            
                URL файла имеет формат `s3a://<имя_бакета>/<путь_к_файлу>`.
            
                Этот бакет должен быть указан в настройках кластера. Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.
            
            * Скопируйте файл на все узлы кластера вручную или с помощью [скриптов инициализации](../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark:spark.driver.extraClassPath` и `spark:spark.executor.extraClassPath`.

    - Образы 2.1.4–2.1.x

        Чтобы добавить библиотеки требуемых версий, воспользуйтесь одним из способов:

        * Настройте доступ к репозиторию [Maven](https://maven.apache.org/index.html) и [установите свойство](../concepts/settings-list.md#change-properties) `spark:spark.jars.packages` в значение `{{ dp-libs.iceberg.dp21.spark33.pkg }}`.

            Настроить доступ к Maven можно двумя способами:
            
            * В [группе безопасности](../../vpc/concepts/security-groups.md) кластера разрешите сетевой доступ к репозиторию [Maven Central](https://repo.maven.apache.org/maven2/).
            * Настройте [альтернативный репозиторий Maven](https://maven.apache.org/guides/mini/guide-mirror-settings.html) и разрешите трафик к нему в [группе безопасности](../../vpc/concepts/security-groups.md) кластера.

        * Скачайте файл библиотеки [{{ dp-libs.iceberg.dp21.spark33.jar }}]({{ dp-libs.iceberg.dp21.spark33.repo }}) и предоставьте доступ к нему одним из способов:

            * Сохраните файл в бакет {{ objstorage-full-name }} и передайте URL файла в свойстве `spark:spark.jars`.
            
                URL файла имеет формат `s3a://<имя_бакета>/<путь_к_файлу>`.
            
                Этот бакет должен быть указан в настройках кластера. Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.
            
            * Скопируйте файл на все узлы кластера вручную или с помощью [скриптов инициализации](../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark:spark.driver.extraClassPath` и `spark:spark.executor.extraClassPath`.

    - Образ 2.2.x

        Чтобы добавить библиотеки требуемых версий, воспользуйтесь одним из способов:

        * Настройте доступ к репозиторию [Maven](https://maven.apache.org/index.html) и [установите свойство](../concepts/settings-list.md#change-properties) `spark:spark.jars.packages` в значение `{{ dp-libs.iceberg.dp22.pkg }}`.

            Настроить доступ к Maven можно двумя способами:
            
            * В [группе безопасности](../../vpc/concepts/security-groups.md) кластера разрешите сетевой доступ к репозиторию [Maven Central](https://repo.maven.apache.org/maven2/).
            * Настройте [альтернативный репозиторий Maven](https://maven.apache.org/guides/mini/guide-mirror-settings.html) и разрешите трафик к нему в [группе безопасности](../../vpc/concepts/security-groups.md) кластера.

        * Скачайте файл библиотеки [{{ dp-libs.iceberg.dp22.jar }}]({{ dp-libs.iceberg.dp22.repo }}) и предоставьте доступ к нему одним из способов:

            * Сохраните файл в бакет {{ objstorage-full-name }} и передайте URL файла в свойстве `spark:spark.jars`.
            
                URL файла имеет формат `s3a://<имя_бакета>/<путь_к_файлу>`.
            
                Этот бакет должен быть указан в настройках кластера. Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.
            
            * Скопируйте файл на все узлы кластера вручную или с помощью [скриптов инициализации](../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark:spark.driver.extraClassPath` и `spark:spark.executor.extraClassPath`.

    {% endlist %}

Теперь вы можете использовать {{ IBRG }} в кластере {{ dataproc-name }}.

## Пример использования {{ IBRG }} {#example}

Пример проверялся в кластере {{ dataproc-name }} версии 2.0, в котором:

* Установлены компоненты Spark и Hadoop.
* Подключен бакет {{ objstorage-name }}, и сервисный аккаунт кластера имеет права на чтение и запись в этом бакете.
* Настроен доступ к репозиторию Maven Central.
* Необходимые свойства компонентов [настроены](#settings) так, чтобы библиотеки {{ IBRG }} загружались из Maven Central.

Чтобы создать таблицу в формате {{ IBRG }} и начать работать с ней:

1. Укажите [настройки каталога](https://iceberg.apache.org/docs/latest/spark-configuration/#catalogs), в котором будет находиться таблица.

    {{ IBRG }} оперирует таблицами на уровне отдельных каталогов. Настройки каталога указываются на уровне отдельного каталога, нельзя указать настройки для всех каталогов сразу.

    Чтобы настроить каталог `sample` [типа Hadoop](https://iceberg.apache.org/docs/latest/spark-configuration/#catalog-configuration), [установите следующие свойства](../concepts/settings-list.md#change-properties) на уровне кластера или на уровне отдельного задания:

    * Свойство `spark:spark.sql.catalog.sample` со значением `org.apache.iceberg.spark.SparkCatalog`.
    * Свойство `spark:spark.sql.catalog.sample.type` со значением `hadoop`.
    * Свойство `spark:spark.sql.catalog.sample.warehouse` со значением `s3a://<имя_бакета>/warehouse/`.

        Данные таблиц будут храниться в бакете по пути `warehouse/`.

    Подробнее о свойствах, влияющих на настройки каталога, в [документации {{ IBRG }}](https://iceberg.apache.org/docs/latest/spark-configuration/#catalog-configuration).

1. [Подключитесь по SSH](connect-ssh.md) к хосту-мастеру кластера {{ dataproc-name }}.

1. Запустите сессию Spark SQL:

    ```bash
    spark-sql
    ```

    Все дальнейшие действия будут выполняться в рамках этой сессии.

1. Создайте базу данных `db` в каталоге `sample`:

    ```sql
    CREATE DATABASE sample.db;
    ```

1. Переключитесь на базу данных `db` в каталоге `sample`:

    ```sql
    USE sample.db;
    ```

1. Создайте таблицу `mytable`, состоящую из двух колонок:

    ```sql
    CREATE TABLE mytable (id bigint, data string) USING iceberg;
    ```

1. Посмотрите сведения о таблице:

    ```sql
    DESC FORMATTED mytable;
    ```

    Пример результата:

    ```sql
    id      bigint
    data    string

    # Partitioning
    Not partitioned

    # Detailed Table Information
    Name    sample.db.mytable
    Location        s3a://<имя_бакета>/warehouse/db/mytable
    Provider        iceberg
    Owner   ubuntu
    Table Properties        [current-snapshot-id=none,format=iceberg/parquet]
    ```

1. Вставьте несколько записей в таблицу:

    ```sql
    INSERT INTO mytable VALUES (1, 'a'), (2, 'b'), (3, 'c');
    ```

1. Выполните тестовый запрос к таблице:

    ```sql
    SELECT count(1), data FROM mytable GROUP BY data;
    ```

    Пример результата:

    ```sql
    1       a
    1       b
    1       c
    ```