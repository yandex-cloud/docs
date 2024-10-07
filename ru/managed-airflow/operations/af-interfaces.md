---
title: Работа с интерфейсами {{ AF }}
description: Для работы с {{ AF }} можно использовать веб-интерфейс или {{ AF }} REST API
keywords:
  - работа с интерфейсами {{ AF }}
  - '{{ AF }}'
  - Airflow
---

# Работа с интерфейсами {{ AF }}

Для работы с {{ maf-name }} можно использовать [веб-интерфейс](#web-gui) или [API {{ AF }}](#rest-api).

Открыть веб-интерфейс или отправить API-запрос могут только пользователи с ролью не ниже [{{ roles.maf.user }}](../security/index.md#managed-airflow-user). В API проверка роли происходит через [IAM-токен](../../iam/concepts/authorization/iam-token.md), который используется для аутентификации.

Интерфейсы {{ AF }} доступны через интернет, поэтому проверка роли нужна для их дополнительной защиты. Даже если у злоумышленника есть ссылка на веб-интерфейс и пароль пользователя `admin` для авторизации, злоумышленник не сможет обратиться к интерфейсу, так как у него нет нужной роли.

## Работа с веб-интерфейсом {#web-gui}

{% include [web interface](../../_includes/mdb/maf/web-interface.md) %}

## Работа с API {{ AF }} {#rest-api}

Запросы к [API {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html) можно выполнять с виртуальных машин (ВМ), расположенных в облачной сети кластера {{ maf-name }}.

1. В облачной сети, в которой расположен кластер {{ maf-name }}, создайте ВМ на основе [Linux](../../compute/quickstart/quick-create-linux.md).
1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подключения к ВМ.
1. Получите IAM-токен для субъекта с ролью не ниже `{{ roles.maf.user }}`. Процесс получения токена зависит от типа субъекта:

   * [аккаунт на Яндексе](../../iam/operations/iam-token/create.md);
   * [сервисный аккаунт](../../iam/operations/iam-token/create-for-sa.md);
   * [федеративный аккаунт](../../iam/operations/iam-token/create-for-federation.md).

1. Выполните запрос к API, например, с помощью cURL. В параметрах авторизации укажите имя пользователя и пароль.

    Пример запроса:

    ```bash
    curl \
        --request GET \
        'https://c-<идентификатор_кластера>.airflow.yandexcloud.net/api/v1/dags' \
        --user 'admin:<пароль_пользователя_admin>' \
        --header 'Content-Type: application/json' \
        --header 'X-Cloud-Authorization: Bearer <IAM-токен>'
    ```

    Запрос возвращает список DAG-файлов. Пример ответа см. в [документации API {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html#operation/get_dags).

{% note warning %}

Чтобы использовать базовую аутентификацию в API {{ AF }} как в примере выше, при [создании](cluster-create.md) или [изменении](cluster-update.md) кластера задайте значение свойства `api.auth_backends` **:** `airflow.api.auth.backend.basic_auth` в блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**. Подробнее об аутентификации в API см. в [документации {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/security/api.html).

{% endnote %}
