# Работа с YDB SDK

Для знакомства с работой {{ ydb-short-name }} SDK вы можете воспользоваться тестовыми приложениями на [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) или [Java](https://github.com/yandex-cloud/ydb-java-sdk). Настройте подключение к базе данных, после чего установите и запустите соответствующее тестовое приложение.

{% note info %}

Подробный разбор кода тестовых приложений читайте в разделе [{#T}](../../sdk/index.md).

{% endnote %}

## Настройка подключения к базе данных {#connect-to-db}

Чтобы подключиться к базе данных:

1. Подготовьте эндпоинт и полный путь [созданной БД](../create-db.md).

    {% cut "Как узнать эндпоинт и путь базы данных" %}

    1. Перейдите в [консоль управления]({{ link-console-main }}).
    1. Выберите нужный каталог и перейдите в сервис **{{ ydb-full-name }}**.
    1. Выберите базу данных, к которой планируете сделать запрос.
    1. В меню слева перейдите в раздел **Обзор**.
    1. Значение эндпоинта указано в строке **Эндпоинт**.
        * Пример значения параметра для Dedicated базы: `lb.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135`.
        * Пример значения параметра для Serverless базы: `ydb.serverless.yandexcloud.net:2135`.
            Порт для эндпоинта по умолчанию `2135`, так что указывать в запросе `:2135` не обязательно.
    1. Полный путь БД указан в строке **База данных**.  
        Пример значения параметра: `/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj`.

    {% endcut %}
1. Для аутентификации в базе данных [создайте сервисный аккаунт](../../iam/operations/sa/create) и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли `viewer` и `editor`.
1. Перейдите в раздел **Сервисные аккаунты** своего каталога и выберите необходимый сервисный аккаунт в списке. Сохраните идентификатор сервисного аккаунта.

    {% note info %}

    Вы можете запускать тестовое приложение с [виртуальной машины](../../compute/operations/vm-create/create-linux-vm) в {{ yandex-cloud }}.

    {% endnote %}

## Запуск тестового приложения {#run-app}

{% include notitle [run-app](../../_includes/run-app.md) %}