---
title: "Как использовать Sqoop в {{ dataproc-full-name }}"
description: "Следуя данной инструкции, вы сможете использовать Sqoop." 
---

# Использование Sqoop

Импорт баз данных в кластер {{ dataproc-name }} из внешних источников выполняется с помощью утилиты [Sqoop](https://sqoop.apache.org/). Раздел содержит:

* сведения о [формировании строк подключения](#jdbc-url-getting) и [установке драйверов](#driver-installation) для Sqoop;
* команды для импорта данных с помощью Sqoop в:

    * [{{ objstorage-full-name }}](#object-storage);
    * [директорию HDFS](#hdfs);
    * [Apache Hive](#apache-hive);
    * [Apache HBase](#apache-hbase).

{% include [No Sqoop in DataProc v2.0](../../_includes/data-proc/no-sqoop-in-dataproc2.md) %}

## Формирование строки подключения JDBC {#jdbc-url-getting}

Строка подключения JDBC имеет вид:

{% list tabs %}

- {{ PG }}

    ```http
    jdbc:postgresql://<адрес_сервера_базы_данных>:5432/<имя_базы_данных>
    ```

    Для {{ mpg-full-name }} используйте строку с [особым FQDN](../../managed-postgresql/operations/connect.md#fqdn-master), который указывает на хост-мастер:

    ```http
    jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/<имя_базы_данных>
    ```

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-postgresql/operations/cluster-list.md#list-clusters).

- {{ MY }}

    ```http
    jdbc:mysql://<адрес_сервера_базы_данных>:3306/<имя_базы_данных>
    ```

    Для {{ mmy-full-name }} используйте строку с [особым FQDN](../../managed-mysql/operations/connect.md#fqdn-master), который указывает на хост-мастер:

    ```http
    jdbc:mysql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mmy }}/<имя_базы_данных>
    ```

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-mysql/operations/cluster-list.md#list-clusters).

{% endlist %}

## Установка JDBC-драйвера {#driver-installation}

Чтобы Sqoop мог подключиться к базе данных через строку подключения JDBC, установите JDBC-драйвер:

{% list tabs %}

- {{ PG }}

    Драйвер для {{ mpg-full-name }} предустановлен в {{ dataproc-name }}, дополнительных действий не требуется.

- {{ MY }}

    [Подключитесь](./connect.md) по [SSH](../../glossary/ssh-keygen.md) к хосту подкластера {{ dataproc-name }} для хранения данных и выполните команду:

    ```bash
    MYSQL_VER="8.0.25" && \
    wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_VER}.tar.gz" \
        --output-document 'mysql-connector-java.tar.gz' && \
    sudo tar -xf mysql-connector-java.tar.gz -C /var/lib/sqoop/ && \
    export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/var/lib/sqoop/mysql-connector-java-${MYSQL_VER}.jar
    ```

    {% note info %}

    Чтобы установить другую версию драйвера, измените в команде значение переменной `MYSQL_VER`.

    {% endnote %}

{% endlist %}

## Импорт с помощью Sqoop {#import-with-sqoop}

### В {{ objstorage-name }} {#object-storage}

Этот тип импорта доступен, если в кластере {{ dataproc-name }} активирован компонент `Sqoop`.

Чтобы импортировать данные в бакет {{ objstorage-name }}:

1. При [создании](cluster-create.md) или изменении кластера {{ dataproc-name }} укажите имя бакета для импорта в {{ objstorage-name }}. Убедитесь, что сервисный аккаунт {{ dataproc-name }} имеет [права на запись](../../storage/operations/buckets/edit-acl.md) в этот бакет.
1. [Сформируйте строки подключения](#jdbc-url-getting) для JDBC.
1. [Подключитесь](connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
1. [Установите драйверы](#driver-installation) для работы Sqoop, если они еще не установлены.
1. Выполните команду:

    ```bash
    sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
      --connect <строка_подключения_JDBC> \
      --username <имя_пользователя_базы_данных> \
      --P \
      --table '<имя_таблицы_базы_данных>' \
      --target-dir 's3a://<имя_бакета_для_импорта>/<директория_назначения>' \
      --split-by '<столбец_таблицы>'
    ```

    Где `--split-by` — столбец таблицы, используемый для разделения.

    {% note warning %}

    Не указывайте имя существующей директории бакета.

    {% endnote %}

### В директорию HDFS {#hdfs}

Этот тип импорта доступен, если в кластере {{ dataproc-name }} включены сервисы:

* `HBase`;
* `HDFS`;
* `Sqoop`;
* `Yarn`;
* `Zookeeper`.

Чтобы импортировать данные в директорию HDFS:

1. [Сформируйте строки подключения](#jdbc-url-getting) для JDB.
1. [Подключитесь](connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
1. [Установите драйверы](#driver-installation) для работы Sqoop, если они еще не установлены.
1. Выполните команду:

    ```bash
    sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
      --connect <строка_подключения_JDBC> \
      --username <имя_пользователя_базы_данных> \
      --table '<имя_таблицы_базы_данных>' \
      --target-dir '<директория_HDFS>' \
      --P \
      --split-by '<столбец_таблицы>'
    ```

    Где `--split-by` — столбец таблицы, используемый для разделения.

    {% note warning %}

    Не указывайте имя существующей директории HDFS.

    {% endnote %}

### В Apache Hive {#apache-hive}

Этот тип импорта доступен, если в кластере {{ dataproc-name }} включены сервисы:

* `HDFS`;
* `Hive`;
* `Mapreduce`;
* `Sqoop`;
* `Yarn`.

Чтобы импортировать данные в таблицу Hive:

1. При [создании](cluster-create.md) или изменении кластера {{ dataproc-name }} добавьте в свойства кластера ключ `hive:hive.execution.engine` со значением `mr`.
1. [Сформируйте строки подключения](#jdbc-url-getting) для JDBC.
1. [Подключитесь](connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
1. [Установите драйверы](#driver-installation) для работы Sqoop, если они еще не установлены.
1. Создайте базу данных Hive:

    ```bash
    hive -e "CREATE DATABASE <имя_базы_данных_Hive>;"
    ```

1. Выполните команду:

    ```bash
    sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
      --connect <строка_подключения_JDBC> \
      --username <имя_пользователя_исходной_базы_данных> \
      --P \
      --table '<имя_таблицы_в_исходной_базе_данных>' \
      --hive-import \
      --create-hive-table \
      --hive-database '<имя_базы_данных_Hive>' \
      --hive-table '<имя_таблицы_Hive>' \
      --split-by '<столбец_таблицы>'
    ```

    Где `--split-by` — столбец таблицы, используемый для разделения.

    {% note warning %}

    Не указывайте имя существующей таблицы Hive.

    {% endnote %}

### В Apache HBase {#apache-hbase}

Этот тип импорта доступен, если в кластере {{ dataproc-name }} включены сервисы:

* `HBase`;
* `HDFS`;
* `Sqoop`;
* `Yarn`;
* `Zookeeper`.

Чтобы импортировать данные в Apache HBase:

1. [Сформируйте строки подключения](#jdbc-url-getting) для JDBC.
1. [Подключитесь](connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
1. [Установите драйверы](#driver-installation) для работы Sqoop, если они еще не установлены.
1. Выполните команду:

    ```bash
    sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
      --connect <строка_подключения_JDBC> \
      --username <имя_пользователя_исходной_базы_данных> \
      --P \
      --table '<имя_таблицы_в_исходной_базе_данных>' \
      --hbase-create-table \
      --column-family '<семейство_столбцов_HBase>' \
      --hbase-table '<имя_таблицы_HBase>' \
      --split-by '<столбец_таблицы>'
    ```

    Где `--split-by` — столбец таблицы, используемый для разделения.

    {% note warning %}

    Не указывайте имя существующей таблицы HBase.

    {% endnote %}

