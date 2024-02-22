Если импорт прошел успешно, вы увидите содержимое таблицы `persons`.

{% list tabs group=storage_system %}

- {{ objstorage-name }} {#storage}

    [Скачайте из бакета](../../../storage/operations/objects/download.md) файлы с результатами импорта.

- Директория HDFS {#hdfs}

    1. [Подключитесь](../../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        hdfs dfs -cat /user/root/import-directory/*
        ```

- Apache Hive {#hive}

    1. [Подключитесь](../../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        hive -e "SELECT * FROM import-table;"
        ```

- Apache HBase {#hbase}

    1. [Подключитесь](../../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        echo -e "scan 'import-table'" | hbase shell -n
        ```

{% endlist %}
