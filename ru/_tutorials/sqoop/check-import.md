Если импорт прошел успешно, вы увидите содержимое таблицы `persons`.

### Проверка импорта в {{ objstorage-full-name }} {#check-object-storage}

[Скачайте из бакета](../../storage/operations/objects/download.md) `my-bucket` файлы с результатами импорта.

### Проверка импорта в директорию HDFS {#correct-hdfs}

1. [Подключитесь](../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
1. Выполните команду:

    ```bash
    hdfs dfs -cat /user/root/import-directory/*
    ```

### Проверка импорта в Apache Hive {#check-hive}

1. [Подключитесь](../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
1. Выполните команду:

    ```bash
    hive -e "SELECT * FROM import-table;"
    ```

### Проверка импорта в Apache HBase {#check-hbase}

1. [Подключитесь](../../data-proc/operations/connect.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
1. Выполните команду:

    ```bash
    echo -e "scan 'import-table'" | hbase shell -n
    ```
