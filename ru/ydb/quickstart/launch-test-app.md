# Запуск тестового приложения с помощью YDB SDK

Для знакомства с работой {{ ydb-short-name }} SDK вы можете воспользоваться тестовыми приложениями на [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) или [Java](https://github.com/yandex-cloud/ydb-java-sdk). Для этого необходимо настроить подключение к базе данных, после чего установить и запустить соответствующее тестовое приложение.

{% note info %}

Подробный разбор кода тестовых приложений читайте в разделе [{#T}](../sdk/index.md).

{% endnote %}

## Настройка подключения к базе данных {#connect-to-db}

Чтобы подключиться к базе данных:

1. [Создайте Serverless базу данных](create-db.md) в {{ yandex-cloud }}.
1. Для аутентификации в базе данных {% if deploy != "arc" %}[создайте сервисный аккаунт](../../iam/operations/sa/create){% else %}создайте сервисный аккаунт{% endif %} и {% if deploy != "arc" %}[назначьте](../../iam/operations/sa/assign-role-for-sa.md){% else %}назначьте{% endif %} ему роли `viewer` и `editor`.
1. Перейдите в раздел **Сервисные аккаунты** своего каталога и выберите необходимый сервисный аккаунт в списке. Сохраните идентификатор сервисного аккаунта.

   {% note info %}

   Вы можете запускать тестовое приложение с {% if deploy != "arc" %} [виртуальной машины](../../compute/operations/vm-create/create-linux-vm) {% else %} виртуальной машины {% endif %} в {{ yandex-cloud }}.

   {% endnote %}

1. Перейдите в раздел **Обзор** вашей базы данных и сохраните значения эндпоинта и идентификатора базы, приведенные в блоке **YDB эндпоинт**.

## Запуск тестового приложения {#run-test}

{% include notitle [run-app](../_includes/run-app.md) %}