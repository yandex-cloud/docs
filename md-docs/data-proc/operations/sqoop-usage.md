[Документация Yandex Cloud](../../index.md) > [Yandex Data Processing](../index.md) > [Пошаговые инструкции](index.md) > Сервисы Apache и другие сторонние сервисы > Использование Sqoop

# Использование Sqoop

Импорт баз данных в кластер Yandex Data Processing из внешних источников выполняется с помощью утилиты [Sqoop](https://sqoop.apache.org/). Раздел содержит:

* сведения о [формировании строк подключения](#jdbc-url-getting) и [установке драйверов](#driver-installation) для Sqoop;
* команды для импорта данных с помощью Sqoop в:

    * [Yandex Object Storage](#object-storage);
    * [директорию HDFS](#hdfs);
    * [Apache Hive](#apache-hive);
    * [Apache HBase](#apache-hbase).

{% note info %}

Утилита Sqoop не поддерживается для кластеров Yandex Data Processing версии 2.0 и выше. В качестве альтернативы используйте [функциональные возможности Apache Spark™](https://spark.apache.org/docs/latest/sql-data-sources-jdbc.html).

{% endnote %}

## Формирование строки подключения JDBC {#jdbc-url-getting}

Строка подключения JDBC имеет вид:

{% list tabs group=data_sources %}

- PostgreSQL {#postgresql}

    ```http
    jdbc:postgresql://<адрес_сервера_базы_данных>:5432/<имя_базы_данных>
    ```

    Для Yandex Managed Service for PostgreSQL используйте строку с [особым FQDN](../../managed-postgresql/operations/connect/fqdn.md#fqdn-master), который указывает на хост-мастер:

    ```http
    jdbc:postgresql://c-<идентификатор_кластера>.rw.mdb.yandexcloud.net:6432/<имя_базы_данных>
    ```

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-postgresql/operations/cluster-list.md#list-clusters).

- MySQL® {#mysql}

    ```http
    jdbc:mysql://<адрес_сервера_базы_данных>:3306/<имя_базы_данных>
    ```

    Для Yandex Managed Service for MySQL® используйте строку с [особым FQDN](../../managed-mysql/operations/connect/fqdn.md#fqdn-master), который указывает на хост-мастер:

    ```http
    jdbc:mysql://c-<идентификатор_кластера>.rw.mdb.yandexcloud.net:3306/<имя_базы_данных>
    ```

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-mysql/operations/cluster-list.md#list-clusters).

{% endlist %}

## Установка JDBC-драйвера {#driver-installation}

Чтобы Sqoop мог подключиться к базе данных через строку подключения JDBC, установите JDBC-драйвер:

{% list tabs group=data_sources %}

- PostgreSQL {#postgresql}

    Драйвер для Yandex Managed Service for PostgreSQL предустановлен в Yandex Data Processing, дополнительных действий не требуется.

- MySQL® {#mysql}

    [Подключитесь](connect-ssh.md) по [SSH](../../glossary/ssh-keygen.md) к хосту подкластера Yandex Data Processing для хранения данных и выполните команду:

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

### В Object Storage {#object-storage}

Этот тип импорта доступен, если в кластере Yandex Data Processing активирован компонент `Sqoop`.

Чтобы импортировать данные в бакет Object Storage:

1. При [создании](cluster-create.md) или изменении кластера Yandex Data Processing укажите имя бакета для импорта в Object Storage. Убедитесь, что сервисный аккаунт Yandex Data Processing имеет [права на запись](../../storage/operations/buckets/edit-acl.md) в этот бакет.
1. [Сформируйте строки подключения](#jdbc-url-getting) для JDBC.
1. [Подключитесь](connect-ssh.md) по SSH к хосту подкластера Yandex Data Processing для хранения данных.
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

Этот тип импорта доступен, если в кластере Yandex Data Processing включены сервисы:

* `HBase`;
* `HDFS`;
* `Sqoop`;
* `Yarn`;
* `Zookeeper`.

Чтобы импортировать данные в директорию HDFS:

1. [Сформируйте строки подключения](#jdbc-url-getting) для JDB.
1. [Подключитесь](connect-ssh.md) по SSH к хосту подкластера Yandex Data Processing для хранения данных.
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

Этот тип импорта доступен, если в кластере Yandex Data Processing включены сервисы:

* `HDFS`;
* `Hive`;
* `Mapreduce`;
* `Sqoop`;
* `Yarn`.

Чтобы импортировать данные в таблицу Hive:

1. При [создании](cluster-create.md) или изменении кластера Yandex Data Processing добавьте в свойства кластера ключ `hive:hive.execution.engine` со значением `mr`.
1. [Сформируйте строки подключения](#jdbc-url-getting) для JDBC.
1. [Подключитесь](connect-ssh.md) по SSH к хосту подкластера Yandex Data Processing для хранения данных.
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

Этот тип импорта доступен, если в кластере Yandex Data Processing включены сервисы:

* `HBase`;
* `HDFS`;
* `Sqoop`;
* `Yarn`;
* `Zookeeper`.

Чтобы импортировать данные в Apache HBase:

1. [Сформируйте строки подключения](#jdbc-url-getting) для JDBC.
1. [Подключитесь](connect-ssh.md) по SSH к хосту подкластера Yandex Data Processing для хранения данных.
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