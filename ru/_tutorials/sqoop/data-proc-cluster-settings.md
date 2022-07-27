Укажите настройки, соответствующие хранилищу, в которое будут импортированы данные:

{% list tabs %}

* Бакет {{ objstorage-name }}

    * **Сервисный аккаунт** — имя созданного ранее сервисного аккаунта.
    * **Имя бакета** — имя созданного ранее бакета.
    * **Сервисы** — `Sqoop`.

* Директория HDFS

    **Сервисы**:

    * `HBase`,
    * `HDFS`,
    * `Sqoop`,
    * `Yarn`,
    * `Zookeeper`.

* Apache Hive

    * **Сервисы**:

        * `HDFS`,
        * `Hive`,
        * `Mapreduce`,
        * `Sqoop`,
        * `Yarn`.

    * **Свойства** — ключ `hive:hive.execution.engine` со значением `mr`.

* Apache HBase

    **Сервисы**:

    * `HBase`,
    * `HDFS`,
    * `Sqoop`,
    * `Yarn`,
    * `Zookeeper`.

{% endlist %}
