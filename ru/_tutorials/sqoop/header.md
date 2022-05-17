Утилита [Sqoop](../../data-proc/operations/sqoop-usage.md) позволяет импортировать базы данных в кластер {{ dataproc-full-name }}. В зависимости от конфигурации кластера {{ dataproc-full-name }} вы можете выполнить импорт в:

* бакет {{ objstorage-full-name }};
* директорию HDFS;
* Apache Hive;
* Apache HBase.

Чтобы импортировать базы данных кластера-источника с помощью Sqoop в кластер-приемник {{ dataproc-full-name }}:

1. [Подготовьте кластер-источник](#prepare).
1. [Выполните импорт](#import).
1. [Проверьте корректность импорта](#check).
