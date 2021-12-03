Укажите настройки, соответствующие хранилищу, в которое будут импортированы данные:

{% list tabs %}

- Бакет {{ objstorage-full-name }}

    * **Сервисный аккаунт** — `bucket-sa`.
    * **Имя бакета** — `my-bucket`.
    * **Сервисы** — `Sqoop`.

- Директория HDFS

    **Сервисы**:

    * `HBase`,
    * `HDFS`,
    * `Sqoop`,
    * `Yarn`,
    * `Zookeeper`.

- Apache Hive

    * **Сервисы**:

        * `HDFS`,
        * `Hive`,
        * `Mapreduce`,
        * `Sqoop`,
        * `Yarn`.

    * **Свойства** — ключ `hive:hive.execution.engine` со значением `mr`.

- Apache HBase

    **Сервисы**:

    * `HBase`,
    * `HDFS`,
    * `Sqoop`,
    * `Yarn`,
    * `Zookeeper`.

{% endlist %}
