[Документация Yandex Cloud](../index.md) > Yandex Managed Service for Apache Airflow™ > Managed Service for Apache Airflow™

# Yandex Managed Service for Apache Airflow™

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение кластера](operations/cluster-update.md)

 - [Обновление версии Apache Airflow™ и Python](operations/cluster-version-update.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключения

 - [Managed Service for Apache Airflow™: подключение к базе данных](operations/update-connections.md)

 - [Managed Service for ClickHouse®: подключение к базе данных](operations/clickhouse.md)

 - [Managed Service for PostgreSQL: подключение к базе данных](operations/postgres-operator.md)

### Хранение артефактов в Yandex Lockbox

 - [Загрузка переменной из Yandex Lockbox](operations/load-variable-from-lockbox.md)

 - [Хранение подключений Apache Airflow™ в Yandex Lockbox](operations/lockbox-secrets-in-maf-cluster.md)

### Работа с DAG-файлами

 - [Загрузка DAG-файлов в кластер](operations/upload-dags.md)

 - [Получение IAM-токена](operations/get-iam-token.md)

### Работа с Yandex Object Storage

 - [Загрузка файла в Yandex Object Storage](operations/upload-file-to-s3.md)

 - [Подключение к бакету Yandex Object Storage с политикой доступа](operations/s3-policy-connect.md)

 - [Чтение файла из Yandex Object Storage](operations/read-file-from-dags-bucket.md)

 - [Работа с интерфейсами Apache Airflow™](operations/af-interfaces.md)

### Логи и мониторинг

 - [Мониторинг состояния кластера](operations/monitoring.md)

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Передача логов Apache Airflow™ в Cloud Logging](operations/af-logging.md)

 - [Получение логов выполнения DAG](operations/export-dag-logs.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Работа с кластерами

 - [Yandex Data Processing: автоматизация работы](tutorials/data-processing-automation.md)

 - [Yandex Query: автоматизация задач](tutorials/airflow-auto-tasks.md)

 - [Managed Service for Apache Spark™: автоматизация работы](tutorials/spark-automation.md)

 - [Запуск PySpark-задания с помощью Yandex Managed Service for Apache Airflow™](tutorials/airflow-spark-min.md)

### Другие руководства

 - [Настройка SMTP-сервера для отправки уведомлений по электронной почте](tutorials/test-smtp-notification.md)

 - [Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK](tutorials/using-python-sdk.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Сеть в Managed Service for Apache Airflow™](concepts/network.md)

 - [Доступные версии Apache Airflow™](concepts/versions.md)

 - [Политика работы с версиями Apache Airflow™](concepts/update-policy.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Имперсонация](concepts/impersonation.md)

 - [Классы хостов](concepts/instance-types.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

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

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

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

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Метрики Yandex Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)