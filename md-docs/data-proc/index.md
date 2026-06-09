

# Yandex Data Processing

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры Yandex Data Processing

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Создание кластера с автомасштабированием в сети другого каталога](operations/cluster-create-autoscale.md)

#### Подключение

 - [Подключение к кластеру](operations/connect.md)

 - [Настройка групп безопасности](operations/security-groups.md)

 - [Получение FQDN хоста](operations/fqdn.md)

 - [Подключение к хосту по SSH](operations/connect-ssh.md)

 - [Подключение к хосту через OS Login](operations/connect-oslogin.md)

 - [Подключение к хосту из графических IDE](operations/connect-ide.md)

 - [Изменение кластера](operations/cluster-update.md)

 - [Миграция легковесного кластера в другую зону доступности](operations/migration-to-an-availability-zone.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подкластеры Yandex Data Processing

 - [Управление подкластерами](operations/subclusters.md)

 - [Изменение подкластера](operations/subcluster-update.md)

### Сервисы Apache и другие сторонние сервисы

 - [Подключение к интерфейсам компонентов](operations/connect-interfaces.md)

 - [Использование Sqoop](operations/sqoop-usage.md)

 - [Настройка Apache Iceberg™](operations/apache-iceberg.md)

#### Delta Lake

 - [Настройка Delta Lake в однокластерном режиме](operations/deltalake/one-cluster-mode.md)

 - [Настройка Delta Lake в мультикластерном режиме](operations/deltalake/multi-cluster-mode.md)

 - [Советы по настройке и применению Delta Lake](operations/deltalake/tips.md)

### Задания (jobs)

 - [Все задания](operations/jobs.md)

 - [Запуск заданий](operations/running-jobs.md)

 - [Задания Spark](operations/jobs-spark.md)

 - [Задания PySpark](operations/jobs-pyspark.md)

 - [Задания Hive](operations/jobs-hive.md)

 - [Задания MapReduce](operations/jobs-mapreduce.md)

### Логи и мониторинг

 - [Работа с логами](operations/logging.md)

 - [Мониторинг состояния кластера и хостов](operations/monitoring.md)

 - [Мониторинг состояния Spark-приложений](operations/spark-monitoring.md)

 - [Диагностика и устранение проблем производительности Spark-приложений](operations/spark-diagnostics.md)

 - [Подготовка и использование виртуальных окружений Python](operations/python-env.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Сетевые настройки и обслуживание кластера

 - [Настройка сети для Yandex Data Processing](tutorials/configure-network.md)

 - [Миграция кластера с HDFS в другую зону доступности](tutorials/hdfs-cluster-migration.md)

 - [Переключение сетевого соединения при пересоздании кластера Yandex Data Processing](tutorials/reconnect-network.md)

### Работа с заданиями

 - [Обзор](tutorials/job-overview.md)

 - [Работа с заданиями Hive](tutorials/hive-job-basics.md)

 - [Работа с заданиями MapReduce](tutorials/mapreduce-job-basics.md)

 - [Работа с заданиями PySpark](tutorials/pyspark-job-basics.md)

 - [Работа с заданиями Spark](tutorials/spark-job-basics.md)

 - [Запуск заданий Apache Hive](tutorials/how-to-use-hive.md)

 - [Запуск Spark-приложений](tutorials/run-spark-job.md)

 - [Запуск заданий с удаленного хоста](tutorials/remote-run-job.md)

### Интеграция Yandex Data Processing с другими сервисами

#### Object Storage

 - [Использование Object Storage в Yandex Data Processing](tutorials/copy-files-from-object-storage.md)

 - [Импорт данных из Object Storage, обработка и экспорт в Managed Service for ClickHouse®](tutorials/s3-data-processing-ch.md)

 - [Монтирование бакетов к файловой системе хостов Yandex Data Processing](tutorials/geesefs-init-actions.md)

#### Apache Hive™ Metastore

 - [Совместная работа с таблицами с использованием Apache Hive™ Metastore](tutorials/data-processing-to-data-processing.md)

 - [Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore](tutorials/metastore-import.md)

 - [Обмен данными с Managed Service for ClickHouse®](tutorials/exchange-data-with-mch.md)

 - [Импорт данных из кластера Managed Service for MySQL® с помощью Sqoop](tutorials/sqoop-mmy.md)

 - [Импорт данных из кластера Managed Service for PostgreSQL с помощью Sqoop](tutorials/sqoop-mpg.md)

 - [Интеграция с сервисом DataSphere](tutorials/datasphere-integration.md)

 - [Работа с топиками Apache Kafka® с помощью PySpark-заданий](tutorials/kafka.md)

 - [Автоматизация работы с помощью Managed Service for Apache Airflow™](tutorials/airflow-automation.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

### Классы хостов

 - [Действующие классы хостов](concepts/instance-types.md)

#### Архив

 - [До 20 июня 2023 года](concepts/instance-types-archive/instance-types-20062023.md)

 - [Среда исполнения](concepts/environment.md)

 - [Интерфейсы и порты компонентов Yandex Data Processing](concepts/interfaces.md)

 - [Задания в Yandex Data Processing](concepts/jobs.md)

 - [Задания Spark](concepts/spark-sql.md)

 - [Автоматическое масштабирование](concepts/autoscaling.md)

 - [Декомиссия подкластеров и хостов](concepts/decommission.md)

 - [Сеть в Yandex Data Processing](concepts/network.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Разграничение зон контроля в Yandex Data Processing](concepts/responsibilities.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Хранилище в Yandex Data Processing](concepts/storage.md)

 - [Свойства компонентов](concepts/settings-list.md)

 - [Apache Iceberg™ в Yandex Data Processing](concepts/apache-iceberg.md)

 - [Delta Lake в Yandex Data Processing](concepts/deltalake.md)

 - [Логи в Yandex Data Processing](concepts/logs.md)

 - [Скрипты инициализации](concepts/init-action.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [add-labels](cli-ref/cluster/add-labels.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-hosts](cli-ref/cluster/list-hosts.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [list-ui-links](cli-ref/cluster/list-ui-links.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/cluster/remove-labels.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

### job

 - [Overview](cli-ref/job/index.md)

 - [cancel](cli-ref/job/cancel.md)

 - [create-hive](cli-ref/job/create-hive.md)

 - [create-mapreduce](cli-ref/job/create-mapreduce.md)

 - [create-pyspark](cli-ref/job/create-pyspark.md)

 - [create-spark](cli-ref/job/create-spark.md)

 - [get](cli-ref/job/get.md)

 - [list](cli-ref/job/list.md)

 - [log](cli-ref/job/log.md)

### resource-preset

 - [Overview](cli-ref/resource-preset/index.md)

 - [get](cli-ref/resource-preset/get.md)

 - [list](cli-ref/resource-preset/list.md)

### subcluster

 - [Overview](cli-ref/subcluster/index.md)

 - [create](cli-ref/subcluster/create.md)

 - [delete](cli-ref/subcluster/delete.md)

 - [get](cli-ref/subcluster/get.md)

 - [list](cli-ref/subcluster/list.md)

 - [update](cli-ref/subcluster/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [add-labels](cli-ref/v0/cluster/add-labels.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-hosts](cli-ref/v0/cluster/list-hosts.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [list-ui-links](cli-ref/v0/cluster/list-ui-links.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/cluster/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

#### job

 - [Overview](cli-ref/v0/job/index.md)

 - [cancel](cli-ref/v0/job/cancel.md)

 - [create-hive](cli-ref/v0/job/create-hive.md)

 - [create-mapreduce](cli-ref/v0/job/create-mapreduce.md)

 - [create-pyspark](cli-ref/v0/job/create-pyspark.md)

 - [create-spark](cli-ref/v0/job/create-spark.md)

 - [get](cli-ref/v0/job/get.md)

 - [list](cli-ref/v0/job/list.md)

 - [log](cli-ref/v0/job/log.md)

#### resource-preset

 - [Overview](cli-ref/v0/resource-preset/index.md)

 - [get](cli-ref/v0/resource-preset/get.md)

 - [list](cli-ref/v0/resource-preset/list.md)

#### subcluster

 - [Overview](cli-ref/v0/subcluster/index.md)

 - [create](cli-ref/v0/subcluster/create.md)

 - [delete](cli-ref/v0/subcluster/delete.md)

 - [get](cli-ref/v0/subcluster/get.md)

 - [list](cli-ref/v0/subcluster/list.md)

 - [update](cli-ref/v0/subcluster/update.md)

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

 - [ListHosts](api-ref/grpc/Cluster/listHosts.md)

 - [ListUILinks](api-ref/grpc/Cluster/listUILinks.md)

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

#### ResourcePreset

 - [Overview](api-ref/grpc/ResourcePreset/index.md)

 - [Get](api-ref/grpc/ResourcePreset/get.md)

 - [List](api-ref/grpc/ResourcePreset/list.md)

#### Subcluster

 - [Overview](api-ref/grpc/Subcluster/index.md)

 - [Get](api-ref/grpc/Subcluster/get.md)

 - [List](api-ref/grpc/Subcluster/list.md)

 - [Create](api-ref/grpc/Subcluster/create.md)

 - [Update](api-ref/grpc/Subcluster/update.md)

 - [Delete](api-ref/grpc/Subcluster/delete.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Cluster

 - [Overview](api-ref/Cluster/index.md)

 - [Get](api-ref/Cluster/get.md)

 - [List](api-ref/Cluster/list.md)

 - [Create](api-ref/Cluster/create.md)

 - [Update](api-ref/Cluster/update.md)

 - [Delete](api-ref/Cluster/delete.md)

 - [Start](api-ref/Cluster/start.md)

 - [Stop](api-ref/Cluster/stop.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListHosts](api-ref/Cluster/listHosts.md)

 - [ListUILinks](api-ref/Cluster/listUILinks.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Job

 - [Overview](api-ref/Job/index.md)

 - [List](api-ref/Job/list.md)

 - [Create](api-ref/Job/create.md)

 - [Get](api-ref/Job/get.md)

 - [ListLog](api-ref/Job/listLog.md)

 - [Cancel](api-ref/Job/cancel.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### ResourcePreset

 - [Overview](api-ref/ResourcePreset/index.md)

 - [Get](api-ref/ResourcePreset/get.md)

 - [List](api-ref/ResourcePreset/list.md)

#### Subcluster

 - [Overview](api-ref/Subcluster/index.md)

 - [Get](api-ref/Subcluster/get.md)

 - [List](api-ref/Subcluster/list.md)

 - [Create](api-ref/Subcluster/create.md)

 - [Update](api-ref/Subcluster/update.md)

 - [Delete](api-ref/Subcluster/delete.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

## История изменений

 - [Изменения сервиса](release-notes/index.md)

 - [Образы](release-notes/images.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)