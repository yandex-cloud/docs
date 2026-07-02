[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Airflow™](../index.md) > [Концепции](index.md) > Имперсонация

# Имперсонация в Managed Service for Apache Airflow™

_Имперсонацией_ в Managed Service for Apache Airflow™ называется выполнение кластером Apache Airflow™ действий с пользовательскими ресурсами от имени сервисного аккаунта.

По умолчанию кластер Apache Airflow™ не имеет прав доступа к пользовательским ресурсам. Чтобы обеспечить доступ к ним, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру Apache Airflow™ при [создании](../operations/cluster-create.md#create-cluster) или [изменении](../operations/cluster-update.md) кластера. После этого из кода DAG-файлов можно будет аутентифицироваться от имени сервисного аккаунта.

Благодаря имперсонации кластер Apache Airflow™ поддерживает интеграцию с другими сервисами Yandex Cloud. Среди них [Yandex Cloud Logging](../../logging/index.md), [Yandex Lockbox](../../lockbox/concepts/index.md) и [Yandex Monitoring](../../monitoring/concepts/index.md).

Чтобы кластер мог взаимодействовать с сервисами, назначьте его сервисному аккаунту [роль](../security/index.md#managed-airflow-integrationProvider) `managed-airflow.integrationProvider`. Она позволяет кластеру, например, записывать логи в Cloud Logging, обращаться к секретам Yandex Lockbox или поставлять метрики в Monitoring.

Сервис Managed Service for Apache Airflow™ интегрируется с другими сервисами через [Yandex Cloud Python SDK](https://github.com/yandex-cloud/python-sdk) или [Airflow Yandex Provider](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/index.html).

## Доступные для интеграции сервисы {#services}

### Cloud Logging {#cloud-logging-integration}

Cloud Logging — это сервис для хранения и чтения логов для сервисов Yandex Cloud. Если включено логирование у кластера Managed Service for Apache Airflow™, его логи сохраняются в выбранную лог-группу Cloud Logging.

Подробнее о настройке логирования в разделе [Передача логов кластера](../operations/af-logging.md).

### Monitoring {#monitoring-integration}

Monitoring — это сервис для сбора и хранения метрик для сервисов Yandex Cloud. Метрики отображаются в виде графиков на странице кластера, в разделе **Мониторинг**. Метрики показывают текущее состояние и работоспособность кластера. Они доступны по умолчанию во всех кластерах Managed Service for Apache Airflow™. Список доступных метрик приведен в их [справочнике](../metrics.md).

### Yandex Lockbox {#lockbox-integration}

Yandex Lockbox — это сервис для централизованного хранения секретов. В Yandex Lockbox можно размещать данные для использования в DAG-файлах, например конфигурационные данные, переменные и параметры подключений Apache Airflow™. Пример таких данных приведен в разделе [Автоматизация работы с Yandex Data Processing](../tutorials/data-processing-automation.md#dag).

По умолчанию Apache Airflow™ хранит чувствительные данные в хранилище метаданных. В этом случае управлять секретами для каждого кластера Apache Airflow™ приходится вручную — через UI или API. Чтобы автоматизировать управление секретами, храните их в Yandex Lockbox. Подробнее в [документации Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/security/secrets/secrets-backend/index.html).

Чтобы использовать возможности Yandex Lockbox в кластере Apache Airflow™, [создайте секрет](../../lockbox/operations/secret-create.md) с нужными данными и [выдайте доступ к нему](../../lockbox/operations/secret-access.md) сервисному аккаунту, который привязан к кластеру. После этого данные из секрета можно будет использовать в DAG-файлах кластера.


#### Примеры использования {#examples-lockbox}

* [Настройка SMTP-сервера для отправки уведомлений по электронной почте](../tutorials/test-smtp-notification.md)
* [Хранение подключений Apache Airflow™ в Yandex Lockbox](../operations/lockbox-secrets-in-maf-cluster.md).


## Доступные инструменты для интеграции с Yandex Cloud {#instruments}

### Python SDK {#yc-python-sdk-integration}

[Yandex Cloud Python SDK](https://github.com/yandex-cloud/python-sdk) позволяет управлять ресурсами Yandex Cloud из DAG-файлов кластера Apache Airflow™ от имени [сервисного аккаунта](../../functions/operations/function-sa.md). Для этого создайте в DAG-файле объект `yandexcloud.SDK()` без указания параметров аутентификации. DAG-файл будет аутентифицироваться с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, который привязан к кластеру.


#### Примеры использования {#examples-python}

* [Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK](../tutorials/using-python-sdk.md)


### Airflow Yandex Provider {#yc-airflow-provider-integration}

В кластерах Managed Service for Apache Airflow™ с включенной имперсонацией автоматически настроено соединение `yandexcloud_default`, которое используется всеми операторами в Airflow Yandex Provider по умолчанию. Чтобы использовать его, создайте DAG-файл без указания параметра `yandex_conn_id`. Оператор будет аутентифицироваться с помощью IAM-токена сервисного аккаунта, который привязан к кластеру.

Пример интеграции в разделе [Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™](../tutorials/airflow-auto-tasks.md).