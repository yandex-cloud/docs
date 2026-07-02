[Документация Yandex Cloud](../../index.md) > [Yandex Data Processing](../index.md) > Практические руководства > Все руководства

# Практические руководства Yandex Data Processing

## Сетевые настройки и обслуживание кластера {#network-settings}

* [Настройка сети для Yandex Data Processing](configure-network.md)
* [Миграция кластера Yandex Data Processing с файловой системой HDFS в другую зону доступности](hdfs-cluster-migration.md)
* [Переключение сетевого соединения при пересоздании кластера Yandex Data Processing](reconnect-network.md)

## Работа с заданиями {#jobs}

### Базовые примеры работы с заданиями {#jobs-basic-tutorials}

* [Работа с заданиями Hive](hive-job-basics.md)
* [Работа с заданиями MapReduce](mapreduce-job-basics.md)
* [Работа с заданиями PySpark](pyspark-job-basics.md)
* [Работа с заданиями Spark](spark-job-basics.md)

### Продвинутые примеры работы с заданиями {#jobs-advanced-tutorials}

* [Запуск заданий Apache Hive](how-to-use-hive.md)
* [Запуск и управление приложениями для Spark и PySpark](run-spark-job.md)
* [Запуск заданий с удаленных хостов, не входящих в кластер Yandex Data Processing](remote-run-job.md)

## Интеграция Yandex Data Processing с другими сервисами {#integration}

* [Использование Yandex Object Storage в Yandex Data Processing](copy-files-from-object-storage.md)
* [Импорт данных из Yandex Object Storage, обработка и экспорт в Yandex Managed Service for ClickHouse®](s3-data-processing-ch.md)
* [Монтирование бакетов Yandex Object Storage к файловой системе хостов Yandex Data Processing](geesefs-init-actions.md)
* [Совместная работа с таблицами с использованием Apache Hive™ Metastore](data-processing-to-data-processing.md)
* [Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore](metastore-import.md)
* [Обмен данными с Yandex Managed Service for ClickHouse®](exchange-data-with-mch.md)
* [Импорт данных из кластера Yandex Managed Service for MySQL® с помощью Sqoop](sqoop-mmy.md)
* [Импорт данных из кластера Yandex Managed Service for PostgreSQL с помощью Sqoop](sqoop-mpg.md)
* [Интеграция с сервисом Yandex DataSphere](datasphere-integration.md)
* [Работа с топиками Apache Kafka® с помощью PySpark-заданий в Yandex Data Processing](kafka.md)
* [Автоматизация работы с помощью Yandex Managed Service for Apache Airflow™](airflow-automation.md)