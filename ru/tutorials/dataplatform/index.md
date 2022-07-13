# Построение Data Platform на базе {{ yandex-cloud }}

* [Синхронизация данных из {{ MY }} с помощью {{ data-transfer-full-name }}](sync-mysql.md)
* [Миграция базы данных из {{ mmy-full-name }} в {{ MY }}](mmy-to-mysql-migration.md)
* [Настройка управляемой базы данных в кластере {{ CH }} для Graphite](clickhouse-for-graphite.md)
{% if product == "yandex-cloud" %}
* [Обмен данными между {{ mch-name }} и {{ dataproc-full-name }}](dp-mch-data-exchange.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Импорт базы данных в {{ dataproc-full-name }} с использованием Sqoop](sqoop.md)
{% endif %}
* Использование реестра схем форматов данных с Managed Service for Apache Kafka®:
    * [Управление схемами данных](schema-registry-overview.md)
    * [Использование {{ mkf-msr }} с {{ mkf-full-name }}](managed-schema-registry.md)
    * [Использование Confluent Schema Registry](confluent-schema-registry.md)
* [Настройка Kafka Connect для работы с кластером {{ mkf-name }}](kafka-connect.md)
* [{#T}](kafka-cdc.md)
* [{#T}](./kafka-cdc-data-transfer.md)
* [Миграция данных в {{ mkf-name }}](kafka-connector.md)
{% if product == "yandex-cloud" %}
* [Перенос коллекций из {{ MG }} в {{ mmg-name }}](mongodb-migration.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Миграция базы данных в {{ mms-name }}](mssql-data-migration.md)
{% endif %}
* [Перенос данных из {{ PG }} в {{ CH }} с помощью {{ data-transfer-full-name }}](rdbms-to-clickhouse.md)
* [Настройка {{ dns-full-name }} для доступа к кластерам управляемых баз данных из других облачных сетей](mdb-dns-peering.md)
* [{#T}](redis-data-migration.md)
{% if product == "yandex-cloud" %}
* [{#T}](migration-via-reindex-api.md)
* [Настройка GeeseFS в {{ dataproc-full-name }} с помощью скриптов инициализации](./data-proc-init-actions-geesefs.md).
{% endif %}
* [{#T}](mysql-data-migration.md)
