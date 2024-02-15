Если импорт прошел успешно, вы увидите содержимое таблицы `persons`.

{% list tabs %}

* {{ objstorage-name }}

    [Скачайте из бакета](../../../storage/operations/objects/download.md) файлы с результатами импорта.

* Директория HDFS

    1. [Подключитесь](../../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        hdfs dfs -cat /user/root/import-directory/*
        ```

* Apache Hive

    1. [Подключитесь](../../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        hive -e "SELECT * FROM import-table;"
        ```

* Apache HBase

    1. [Подключитесь](../../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        echo -e "scan 'import-table'" | hbase shell -n
        ```

{% endlist %}
