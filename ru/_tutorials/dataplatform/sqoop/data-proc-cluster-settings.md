Укажите настройки, соответствующие хранилищу, в которое будут импортированы данные:

{% list tabs %}

* Бакет {{ objstorage-name }}

    * **{{ ui-key.yacloud.mdb.cluster.overview.label_service-account }}** — имя созданного ранее сервисного аккаунта.
    * **{{ ui-key.yacloud.mdb.cluster.overview.label_bucket }}** — имя созданного ранее бакета.
    * **{{ ui-key.yacloud.mdb.cluster.overview.label_services }}** — `Sqoop`.

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
