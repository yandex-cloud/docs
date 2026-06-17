# Работа с интерфейсами Apache Airflow™

Для работы с Managed Service for Apache Airflow™ можно использовать [веб-интерфейс](#web-gui) или [API Apache Airflow™](#rest-api).

Открыть веб-интерфейс или отправить API-запрос могут только пользователи с ролью не ниже [managed-airflow.user](../security/index.md#managed-airflow-user). В API проверка роли происходит через [IAM-токен](../../iam/concepts/authorization/iam-token.md), который используется для аутентификации.

Интерфейсы Apache Airflow™ доступны через интернет, поэтому проверка роли нужна для их дополнительной защиты. Даже если у злоумышленника есть ссылка на веб-интерфейс и пароль пользователя `admin` для аутентификации, злоумышленник не сможет обратиться к интерфейсу, так как у него нет нужной роли.

## Работа с веб-интерфейсом {#web-gui}

1. В [консоли управления](https://console.yandex.cloud) откройте страницу кластера.
1. В поле **Веб-сервер** нажмите **Перейти** ![start](../../_assets/console-icons/arrow-up-right-from-square.svg).
1. В открывшемся веб-интерфейсе [веб-сервера Managed Service for Apache Airflow™](../concepts/index.md#components) введите данные для аутентификации:

   * Логин — `admin`.
   * Пароль — пароль пользователя `admin`, который вы указали при создании кластера.

Подробности о работе в веб-интерфейсе читайте в [документации Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/ui.html).

## Работа с API Apache Airflow™ {#rest-api}

Запросы к [API Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html) можно выполнять с виртуальных машин (ВМ), расположенных в облачной сети кластера Managed Service for Apache Airflow™.

1. В облачной сети, в которой расположен кластер Managed Service for Apache Airflow™, создайте ВМ на основе [Linux](../../compute/quickstart/quick-create-linux.md).
1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подключения к ВМ.
1. Получите IAM-токен для субъекта с ролью не ниже `managed-airflow.user`. Процесс получения токена зависит от типа субъекта:

   * [аккаунт на Яндексе](../../iam/operations/iam-token/create.md);
   * [сервисный аккаунт](../../iam/operations/iam-token/create-for-sa.md);
   * [локальный аккаунт](../../iam/operations/iam-token/create-for-local.md);
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

    Запрос возвращает список DAG-файлов. Пример ответа в [документации API Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html#operation/get_dags).

{% note warning %}

Чтобы использовать базовую аутентификацию в API Apache Airflow™ как в примере выше, при [создании](cluster-create.md) или [изменении](cluster-update.md) кластера задайте значение свойства `api.auth_backends` **:** `airflow.api.auth.backend.basic_auth` в блоке **Конфигурация Airflow**. Подробнее об аутентификации в API в [документации Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/security/api.html).

{% endnote %}