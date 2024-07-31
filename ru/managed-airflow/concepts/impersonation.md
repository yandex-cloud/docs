# Имперсонация в {{ maf-full-name }}

_Имперсонацией_ в {{ maf-short-name }} называется выполнение кластером {{ AF }} действий с пользовательскими ресурсами от имени сервисного аккаунта пользователя.

По умолчанию кластер {{ AF }} не имеет прав доступа к пользовательским ресурсам. Чтобы обеспечить доступ к таким ресурсам, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру {{ AF }} при [создании](../operations/cluster-create.md#create-cluster) или [изменении](../operations/cluster-update.md) кластера. После этого из кода DAG-файлов можно будет аутентифицироваться от имени сервисного аккаунта.

Благодаря имперсонации кластер {{ AF }} поддерживает интеграцию с другими сервисами {{ yandex-cloud }} через [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) и [Airflow Yandex Provider](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/index.html).

Сервис {{ maf-short-name }} также поддерживает интеграцию с [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) как с хранилищем секретов {{ AF }}.

## Интеграция с {{ yandex-cloud }} через Python SDK {#yc-python-sdk-integration}

[{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) позволяет управлять ресурсами {{ yandex-cloud }} из DAG-файлов кластера {{ AF }} от имени [сервисного аккаунта](../../functions/operations/function-sa.md). Для этого создайте в DAG-файле объект `yandexcloud.SDK()` без указания параметров аутентификации. DAG-файл будет аутентифицироваться с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, который привязан к кластеру.

Пример интеграции см. в разделе [{#T}](../tutorials/using-python-sdk.md).

## Интеграция с {{ yandex-cloud }} через Airflow Provider {#yc-airflow-provider-integration}

В кластерах {{ maf-short-name }} с включенной имперсонацией автоматически настроено соединение `yandexcloud_default`, которое используется всеми операторами в Airflow Yandex Provider по умолчанию. Чтобы использовать его, создайте DAG-файл без указания параметра `yandex_conn_id`. Оператор будет аутентифицироваться с помощью IAM-токена сервисного аккаунта, который привязан к кластеру.

Пример интеграции см. в разделе [{#T}](../tutorials/airflow-auto-tasks.md).

## Интеграция с {{ lockbox-name }} {#lockbox-integration}

{{ lockbox-name }} — это сервис для централизованного хранения секретов. В {{ lockbox-name }} можно размещать данные для использования в DAG-файлах, например конфигурационные данные, переменные и [параметры подключений](../tutorials/data-proc-automation.md#connections) {{ AF }}.

По умолчанию {{ AF }} хранит чувствительные данные в хранилище метаданных. В этом случае управлять секретами для каждого кластера {{ AF }} приходится вручную, через UI или API. Чтобы автоматизировать управление секретами, храните их в {{ lockbox-name }}. Подробнее см. в [документации {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/security/secrets/secrets-backend/index.html).

Чтобы использовать возможности {{ lockbox-name }} в кластере {{ AF }}, [создайте секрет](../../lockbox/operations/secret-create.md) с нужными данными и [выдайте доступ к нему](../../lockbox/operations/secret-access.md) сервисному аккаунту, который привязан к кластеру. После этого данные из секрета можно будет использовать в DAG-файлах кластера.

Пример интеграции см. в разделе [{#T}](../tutorials/lockbox-secrets-in-maf-cluster.md).
