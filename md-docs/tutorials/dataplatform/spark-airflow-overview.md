[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Managed Service for Apache Spark™ > Интеграция Managed Service for Apache Spark™ и Managed Service for Apache Airflow™ > Обзор

# Интеграция Yandex Managed Service for Apache Spark™ и Yandex Managed Service for Apache Airflow™

С помощью Yandex Managed Service for Apache Airflow™ можно управлять кластерами Yandex Managed Service for Apache Spark™ и запускать PySpark-задания из DAG. В приведенных примерах DAG создает временный кластер Managed Service for Apache Spark™, запускает задание и удаляет кластер после выполнения задания.

Выберите подходящий сценарий:

* [Запуск простого PySpark-задания в Yandex Managed Service for Apache Spark™ с помощью Yandex Managed Service for Apache Airflow™](airflow-spark-min.md) — простой пример для знакомства с интеграцией сервисов. Задание создает данные в памяти и выводит результат в лог. Бакет Object Storage хранит DAG-файл и скрипт задания.
* [Автоматизация работы с таблицами в Yandex Managed Service for Apache Spark™ с помощью Yandex Managed Service for Apache Airflow™](airflow-and-spark.md) — пример работы с таблицами, данные которых хранятся в Object Storage, а метаданные — в Apache Hive™ Metastore. В руководстве приведены варианты настройки инфраструктуры с разделением прав доступа и с упрощенной конфигурацией.