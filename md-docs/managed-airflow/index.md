

# Yandex Managed Service for Apache Airflow™

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение кластера](operations/cluster-update.md)

 - [Обновление версии {{ AF }} и Python](operations/cluster-version-update.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключения

 - [{{ maf-name }}: подключение к базе данных](operations/update-connections.md)

 - [{{ mch-name }}: подключение к базе данных](operations/clickhouse.md)

 - [{{ mpg-name }}: подключение к базе данных](operations/postgres-operator.md)

### Хранение артефактов в {{ lockbox-full-name }}

 - [Загрузка переменной из {{ lockbox-name }}](operations/load-variable-from-lockbox.md)

 - [Хранение подключений {{ AF }} в {{ lockbox-full-name }}](operations/lockbox-secrets-in-maf-cluster.md)

### Работа с DAG-файлами

 - [Загрузка DAG-файлов в кластер](operations/upload-dags.md)

 - [Получение IAM-токена](operations/get-iam-token.md)

### Работа с {{ objstorage-full-name }}

 - [Загрузка файла в {{ objstorage-full-name }}](operations/upload-file-to-s3.md)

 - [Подключение к бакету {{ objstorage-full-name }} с политикой доступа](operations/s3-policy-connect.md)

 - [Чтение файла из {{ objstorage-full-name }}](operations/read-file-from-dags-bucket.md)

 - [Работа с интерфейсами {{ AF }}](operations/af-interfaces.md)

### Логи и мониторинг

 - [Мониторинг состояния кластера](operations/monitoring.md)

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Передача логов {{ AF }} в {{ cloud-logging-name }}](operations/af-logging.md)

 - [Получение логов выполнения DAG](operations/export-dag-logs.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Работа с кластерами

 - [{{ dataproc-name }}: автоматизация работы](tutorials/data-processing-automation.md)

 - [{{ yq-full-name }}: автоматизация задач](tutorials/airflow-auto-tasks.md)

 - [{{ msp-name }}: автоматизация работы](tutorials/spark-automation.md)

 - [Запуск PySpark-задания с помощью {{ maf-full-name }}](tutorials/airflow-spark-min.md)

### Другие руководства

 - [Настройка SMTP-сервера для отправки уведомлений по электронной почте](tutorials/test-smtp-notification.md)

 - [Отправка запросов к API {{ yandex-cloud }} через {{ yandex-cloud }} Python SDK](tutorials/using-python-sdk.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Сеть в {{ maf-name }}](concepts/network.md)

 - [Доступные версии {{ AF }}](concepts/versions.md)

 - [Политика работы с версиями {{ AF }}](concepts/update-policy.md)

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

 - [Справочник {{ TF }}](tf-ref.md)

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

 - [Метрики {{ monitoring-full-name }}](metrics.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)