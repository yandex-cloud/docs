# Имперсонация в {{ maf-name }}

_Имперсонацией_ в {{ maf-short-name }} называется выполнение кластером {{ AF }} действий с пользовательскими ресурсами от имени сервисного аккаунта.

По умолчанию кластер {{ AF }} не имеет прав доступа к пользовательским ресурсам. Чтобы обеспечить доступ к ним, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру {{ AF }} при [создании](../operations/cluster-create.md#create-cluster) или [изменении](../operations/cluster-update.md) кластера. После этого из кода DAG-файлов можно будет аутентифицироваться от имени сервисного аккаунта.

Благодаря имперсонации кластер {{ AF }} поддерживает интеграцию с другими сервисами {{ yandex-cloud }}. Среди них [{{ cloud-logging-full-name }}](../../logging/index.yaml), [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) и [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

Чтобы кластер мог взаимодействовать с сервисами, назначьте его сервисному аккаунту [роль](../security/index.md#managed-airflow-integrationProvider) `managed-airflow.integrationProvider`. Она позволяет кластеру, например, записывать логи в {{ cloud-logging-name }}, обращаться к секретам {{ lockbox-name }} или поставлять метрики в {{ monitoring-name }}.

Сервис {{ maf-name }} интегрируется с другими сервисами через [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) или [Airflow Yandex Provider](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/index.html).

## Доступные для интеграции сервисы {#services}

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} — это сервис для хранения и чтения логов для сервисов {{ yandex-cloud }}. Если включено логирование у кластера {{ maf-name }}, его логи сохраняются в выбранную лог-группу {{ cloud-logging-name }}.

Подробнее о настройке логирования см. в разделе [Передача логов кластера](../operations/af-logging.md).

### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} — это сервис для сбора и хранения метрик для сервисов {{ yandex-cloud }}. Метрики отображаются в виде графиков на странице кластера, в разделе **{{ ui-key.yacloud.common.monitoring }}**. Метрики показывают текущее состояние и работоспособность кластера. Они доступны по умолчанию во всех кластерах {{ maf-name }}. Список доступных метрик приведен в их [справочнике](../metrics.md).

### {{ lockbox-name }} {#lockbox-integration}

{{ lockbox-name }} — это сервис для централизованного хранения секретов. В {{ lockbox-name }} можно размещать данные для использования в DAG-файлах, например конфигурационные данные, переменные и параметры подключений {{ AF }}. Пример таких данных приведен в разделе [Автоматизация работы с {{ dataproc-name }}](../tutorials/data-processing-automation.md#dag).

По умолчанию {{ AF }} хранит чувствительные данные в хранилище метаданных. В этом случае управлять секретами для каждого кластера {{ AF }} приходится вручную, через UI или API. Чтобы автоматизировать управление секретами, храните их в {{ lockbox-name }}. Подробнее см. в [документации {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/security/secrets/secrets-backend/index.html).

Чтобы использовать возможности {{ lockbox-name }} в кластере {{ AF }}, [создайте секрет](../../lockbox/operations/secret-create.md) с нужными данными и [выдайте доступ к нему](../../lockbox/operations/secret-access.md) сервисному аккаунту, который привязан к кластеру. После этого данные из секрета можно будет использовать в DAG-файлах кластера.

Пример интеграции см. в разделе [{#T}](../operations/lockbox-secrets-in-maf-cluster.md).

## Доступные инструменты для интеграции с {{ yandex-cloud }} {#instruments}

### Python SDK {#yc-python-sdk-integration}

[{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) позволяет управлять ресурсами {{ yandex-cloud }} из DAG-файлов кластера {{ AF }} от имени [сервисного аккаунта](../../functions/operations/function-sa.md). Для этого создайте в DAG-файле объект `yandexcloud.SDK()` без указания параметров аутентификации. DAG-файл будет аутентифицироваться с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, который привязан к кластеру.

Пример интеграции см. в разделе [{#T}](../tutorials/using-python-sdk.md).

### Airflow Yandex Provider {#yc-airflow-provider-integration}

В кластерах {{ maf-short-name }} с включенной имперсонацией автоматически настроено соединение `yandexcloud_default`, которое используется всеми операторами в Airflow Yandex Provider по умолчанию. Чтобы использовать его, создайте DAG-файл без указания параметра `yandex_conn_id`. Оператор будет аутентифицироваться с помощью IAM-токена сервисного аккаунта, который привязан к кластеру.

Пример интеграции см. в разделе [{#T}](../tutorials/airflow-auto-tasks.md).
