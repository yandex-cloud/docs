# Пошаговые инструкции для Managed Service for Apache Airflow™

## Кластеры {#clusters}

* [Информация об имеющихся кластерах](cluster-list.md)
* [Создание кластера](cluster-create.md)
* [Изменение кластера](cluster-update.md)
* [Обновление версии Apache Airflow™ и Python](cluster-version-update.md)
* [Остановка и запуск кластера](cluster-stop.md)
* [Управление доступом к кластеру](cluster-access.md)
* [Техническое обслуживание кластера](cluster-maintenance.md)
* [Удаление кластера](cluster-delete.md)

## Подключения {#connections}

* [Подключение к базе данных Yandex Managed Service for Apache Airflow™](update-connections.md)
* [Подключение к Yandex Managed Service for ClickHouse®](clickhouse.md)
* [Подключение к Yandex Managed Service for PostgreSQL](postgres-operator.md)

## Хранение артефактов в Yandex Lockbox {#lockbox}

* [Загрузка переменной из Yandex Lockbox](load-variable-from-lockbox.md)
* [Хранение подключений Apache Airflow™ в Yandex Lockbox](lockbox-secrets-in-maf-cluster.md)

## Работа с DAG-файлами {#dags}

* [Загрузка DAG-файлов в кластер](upload-dags.md)
* [Получение IAM-токена](get-iam-token.md)

## Работа с Yandex Object Storage

* [Загрузка файла в Yandex Object Storage](upload-file-to-s3.md)
* [Подключение к бакету Yandex Object Storage с политикой доступа](s3-policy-connect.md)
* [Чтение файла из Yandex Object Storage](read-file-from-dags-bucket.md)

## Интерфейсы Apache Airflow™ {#interfaces}

* [Работа с интерфейсами Apache Airflow™](af-interfaces.md)

## Логи и мониторинг {#logs}

* [Мониторинг состояния кластера](monitoring.md)
* [Просмотр логов кластера](cluster-logs.md)
* [Передача логов кластера в Yandex Cloud Logging](af-logging.md)
* [Получение логов выполнения DAG](export-dag-logs.md)