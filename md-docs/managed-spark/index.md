

# Yandex Managed Service for Apache Spark™

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Подключение к кластеру](operations/connect.md)

 - [Изменение кластера](operations/cluster-update.md)

 - [Обновление версии Apache Spark™](operations/cluster-version-update.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Задания (jobs)

 - [Задания Spark](operations/jobs-spark.md)

 - [Задания PySpark](operations/jobs-pyspark.md)

 - [Задания SparkConnect](operations/jobs-sparkconnect.md)

### Логи и мониторинг

 - [Мониторинг состояния кластера](operations/monitoring.md)

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Мониторинг состояния Spark-приложений](operations/spark-monitoring.md)

 - [Диагностика и примеры устранения проблем производительности Spark-приложений](operations/spark-diagnostics.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Работа с Yandex Object Storage с использованием локального каталога Hive](tutorials/spark-objstorage-integration.md)

 - [Работа с Yandex Object Storage с использованием кластера Apache Hive™ Metastore](tutorials/metastore-and-spark.md)

 - [Работа с таблицей формата Apache Iceberg™ из PySpark-задания](tutorials/spark-simple-rw-job.md)

 - [Запуск PySpark-задания с помощью Yandex Managed Service for Apache Airflow™](tutorials/airflow-spark-min.md)

 - [Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL](tutorials/job-pyspark-secret-access.md)

 - [Автоматизация работы с помощью Yandex Managed Service for Apache Airflow™](tutorials/airflow-automation.md)

 - [Интеграция с DataSphere](tutorials/spark-and-datasphere.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Сеть в Yandex Managed Service for Apache Spark™](concepts/network.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Классы хостов](concepts/instance-types.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Автоматическое масштабирование](concepts/autoscaling.md)

 - [Свойства Apache Spark™](concepts/spark-properties.md)

 - [Управление доступом](security.md)

 - [Правила тарификации](pricing.md)

 - [Метрики Yandex Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

### job

 - [Overview](cli-ref/job/index.md)

 - [cancel](cli-ref/job/cancel.md)

 - [create-pyspark](cli-ref/job/create-pyspark.md)

 - [create-spark](cli-ref/job/create-spark.md)

 - [create-spark-connect](cli-ref/job/create-spark-connect.md)

 - [get](cli-ref/job/get.md)

 - [list](cli-ref/job/list.md)

 - [log](cli-ref/job/log.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

#### job

 - [Overview](cli-ref/v0/job/index.md)

 - [cancel](cli-ref/v0/job/cancel.md)

 - [create-pyspark](cli-ref/v0/job/create-pyspark.md)

 - [create-spark](cli-ref/v0/job/create-spark.md)

 - [create-spark-connect](cli-ref/v0/job/create-spark-connect.md)

 - [get](cli-ref/v0/job/get.md)

 - [list](cli-ref/v0/job/list.md)

 - [log](cli-ref/v0/job/log.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Cluster

 - [Overview](api-ref/grpc/Cluster/index.md)

 - [Get](api-ref/grpc/Cluster/get.md)

 - [List](api-ref/grpc/Cluster/list.md)

 - [Create](api-ref/grpc/Cluster/create.md)

 - [Update](api-ref/grpc/Cluster/update.md)

 - [Delete](api-ref/grpc/Cluster/delete.md)

 - [Start](api-ref/grpc/Cluster/start.md)

 - [Stop](api-ref/grpc/Cluster/stop.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Job

 - [Overview](api-ref/grpc/Job/index.md)

 - [List](api-ref/grpc/Job/list.md)

 - [Create](api-ref/grpc/Job/create.md)

 - [Get](api-ref/grpc/Job/get.md)

 - [ListLog](api-ref/grpc/Job/listLog.md)

 - [Cancel](api-ref/grpc/Job/cancel.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

 - [История изменений](release-notes.md)