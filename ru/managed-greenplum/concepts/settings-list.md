# Настройки {{ GP }}

Для кластера {{ mgp-name }} можно задать настройки, которые относятся к {{ GP }}. Часть настроек задается [на уровне кластера](#dbms-cluster-settings), часть — на уровне внешних источников данных: [S3](#s3-settings), [JDBC](#jdbc-settings), [HDFS](#hdfs-settings), [Hive](#hive-settings).

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, [API](../../glossary/rest-api.md), SQL или Terraform. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса, одна и та же настройка будет представлена по-разному. Например, **Max connections** в консоли управления соответствует:

* `max_connections` в gRPC API;
* `maxConnections` в REST API.

## Зависимость настроек от размера хранилища {#settings-instance-dependent}

Значения некоторых настроек {{ GP }} могут быть автоматически скорректированы при изменении размера хранилища:

* Если значения не были заданы или не подходят новому размеру, будут применены настройки по умолчанию для этого размера.
* Если заданные вручную настройки подходят для нового размера, они не будут изменены.

Список настроек, зависящих от размера хранилища:

* [Gp workfile limit per segment](#setting-gp-workfile-limit-per-segment);
* [Max slot wal keep size](#setting-max-slot-wal-keep-size).

## Настройки СУБД уровня кластера {#dbms-cluster-settings}

Доступны следующие настройки:

{% include [mgp-dbms-settings](../../_includes/mdb/mgp/dbms-settings.md) %}

## Настройки внешнего источника данных S3 {#s3-settings}

Доступны следующие настройки:

* **Access Key**{#setting-access-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Публичный ключ доступа к S3-хранилищу.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

* **Secret Key**{#setting-secret-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Секретный ключ доступа к S3-хранилищу.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

* **Fast Upload**{#setting-fast-upload} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Управляет быстрой загрузкой больших файлов в S3-хранилище. Если настройка выключена, PXF формирует файлы на диске перед отправкой в S3-хранилище. Если настройка включена, PXF формирует файлы в оперативной памяти (если ее не хватает, то записывает на диск).

    По умолчанию быстрая загрузка включена.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

* **Endpoint**{#setting-endpoint} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Адрес S3-хранилища. Значение для {{ objstorage-full-name }} — `{{ s3-storage-host }}`. Это значение используется по умолчанию.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/s3_objstore_cfg.html#minio-server-configuration-1).

## Настройки внешнего источника данных JDBC {#jdbc-settings}

Доступны следующие настройки:

* **Driver**{#setting-driver} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Класс JDBC-драйвера в Java. Возможные значения:

    {% include [JBDC driver](../../_includes/mdb/mgp/jdbc-driver.md) %}

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **Url**{#setting-url} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    URL базы данных. Примеры:

    {% include [URL examples](../../_includes/mdb/mgp/url-examples.md) %}

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **User**{#setting-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Имя пользователя, владельца БД.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **Password**{#setting-password} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Пароль пользователя БД.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#jdbc-server-configuration-2).

* **Statement Batch Size**{#setting-statement-batch-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Количество строк в пакете для чтения из внешней таблицы.

    Значение по умолчанию — `100`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#statementlevel-properties-5).

* **Statement Fetch Size**{#setting-statement-fetch-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Количество строк, которые нужно поместить в буфер при чтении из внешней таблицы.

    Значение по умолчанию — `1000`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#statementlevel-properties-5).

* **Statement Query Timeout**{#setting-statement-query-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в секундах), в течение которого драйвер JDBC ожидает выполнения операции чтения или записи.

    Значение по умолчанию — `60`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#statementlevel-properties-5).

* **Pool Enabled**{#setting-pool-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, используется ли пул подключений JDBC. По умолчанию используется.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Maximum Size**{#setting-pool-maximum-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Максимальное количество подключений к серверу базы данных.

    Значение по умолчанию — `5`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Connection Timeout**{#setting-pool-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Максимальное время (в миллисекундах) для ожидания подключения из пула.

    Значение по умолчанию — `30000`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Idle Timeout**{#setting-pool-idle-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Максимальное время (в миллисекундах), по истечении которого неактивное соединение считается простаивающим.

    Значение по умолчанию — `30000`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

* **Pool Minimum Idle**{#setting-pool-minimum-idle} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Минимальное количество простаивающих подключений в пуле.

    Значение по умолчанию — `0`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/jdbc_cfg.html#about-jdbc-connection-pooling-9).

## Настройки внешнего источника данных HDFS {#hdfs-settings}

Доступны следующие настройки:

{% include [HDFS and Hive settings](../../_includes/mdb/mgp/external-sources-additional-settings.md) %}

* **Dfs**{#setting-dfs} {{ tag-con }} {{ tag-api }}

    Настройки распределенной файловой системы.

    Подробнее см. в [документации Apache Hadoop](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml).

    * **Ha Automatic Failover Enabled**{#setting-ha-automatic-failover-enabled}

        Определяет, включена ли автоматическая отказоустойчивость для высокой доступности файловой системы. По умолчанию включена.

    * **Block Access Token Enabled**{#setting-block-access-token-enabled}

        Определяет, используются ли токены доступа. По умолчанию токены проверяются во время подключений к узлам для хранения данных (datanodes).

    * **Use Datanode Hostname**{#setting-use-datanode-hostname}

        Определяет, используются ли имена узлов для хранения данных (datanodes) при подключении к этим узлам. По умолчанию используются.

    * **Nameservices**

        Список логических имен HDFS-служб. Имена могут быть произвольными, разделяются запятыми.

* **Yarn**{#setting-yarn} {{ tag-con }} {{ tag-api }}

    Настройки службы ResourceManager, которая отслеживает ресурсы в кластере и планирует запуск приложений (например, заданий MapReduce).

    Подробнее см. в [документации Apache Hadoop](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/ResourceManagerHA.html).

    * **Resourcemanager Ha Enabled**{#setting-resourcemanager-ha-enabled}

        Определяет, включена ли высокая доступность для ResourceManager. По умолчанию включена.

    * **Resourcemanager Ha Auto Failover Enabled**{#setting-resourcemanager-ha-auto-failover-enabled}

        Определяет, включен ли автоматический переход на другой ресурс, если активная служба вышла из строя или не отвечает. По умолчанию автоматический переход включен, только если включена настройка **Resourcemanager Ha Enabled**.

    * **Resourcemanager Ha Auto Failover Embedded**{#setting-resourcemanager-ha-auto-failover-embedded}

        Определяет, использовать ли встроенный метод ActiveStandbyElector для выбора активной службы. Если текущая активная служба вышла из строя или не отвечает, ActiveStandbyElector делает активной другую службу ResourceManager, которая берет управление на себя.

        По умолчанию настройка включена, только если включены настройки **Resourcemanager Ha Enabled** и **Resourcemanager Ha Auto Failover Enabled**.

    * **Resourcemanager Cluster Id**{#setting-resourcemanager-cluster-id}

        Идентификатор кластера. Используется, чтобы служба ResourceManager не стала активной для другого кластера.

## Настройки внешнего источника данных Hive {#hive-settings}

Доступны следующие настройки:

{% include [HDFS and Hive settings](../../_includes/mdb/mgp/external-sources-additional-settings.md) %}

* **Ppd**{#setting-ppd} {{ tag-con }} {{ tag-api }}

    Определяет, включено ли выталкивание предикатов (predicate pushdown) для запросов к внешним таблицам. По умолчанию включено.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.10/greenplum-platform-extension-framework/cfg_server.html#about-the-pxfsitexml-configuration-file-3).

* **Metastore Uris**{#setting-metastore-uris} {{ tag-con }} {{ tag-api }}

    Список URI, разделенных запятыми. Чтобы запросить метаданные, внешняя СУБД подключается к Metastore по одному из этих URI.

* **Metastore Kerberos Principal**{#setting-metastore-kerberos-principal} {{ tag-con }} {{ tag-api }}

    Участник службы для сервера Metastore Thrift.

* **Auth Kerberos Principal**{#setting-auth-kerberos-principal} {{ tag-con }} {{ tag-api }}

    Участник сервера Kerberos.
