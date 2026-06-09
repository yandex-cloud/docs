# Запуск заданий

Задание можно запустить несколькими способами:

* [Создайте задания в {{ dataproc-name }}](jobs.md). После этого они запустятся автоматически.
* [Запустите задания Apache Hive](../tutorials/how-to-use-hive.md) с помощью {{ yandex-cloud }} CLI или Hive CLI.
* [Запустите приложения Spark или PySpark](../tutorials/run-spark-job.md) с помощью Spark Shell, утилиты `spark-submit` или {{ yandex-cloud }} CLI.
* [Запустите задания с удаленных хостов](../tutorials/remote-run-job.md), не входящих в кластер {{ dataproc-name }}, с помощью утилиты `spark-submit`.
* Настройте интеграцию с сервисом [{{ maf-full-name }}](../tutorials/airflow-automation.md) или [{{ ml-platform-full-name }}](../tutorials/datasphere-integration.md). Тогда запуск заданий будет автоматизирован.