# Подключение к базе данных


Доступ к базам данных {{ ydb-short-name }} осуществляется по протоколу gRPC поверх TLS.


Для подключения к базе данных {{ ydb-name }} выполните следующие настройки:

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) созданному сервисному аккаунту роли `viewer` и `editor`.
1. [Получите идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.
1. [Создайте авторизованные ключи доступа](../../iam/operations/sa/create-access-key.md) к сервисному аккаунту и сохраните их.
1. Перейдите на страницу сервиса {{ ydb-name }}, нажмите на имя нужной базы данных и перейдите в раздел **Обзор**. Сохраните эндпоинт БД.
1. (опционально) Если ваша база данных не имеет публичных IP-адресов, [создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для доступа к БД в {{ yandex-cloud }}.

   {% note info %}

   Дальнейшую настройку выполняйте в созданной виртуальной машине.

   {% endnote %}

1. Подготовьте SSL-сертификат для подключения к базе данных:

   ```bash
   mkdir ~/.ydb
   wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.ydb/CA.pem
   ```

1. {% include [cli-install](../../_includes/cli-install.md) %}

#### Что дальше

* [Запустите тестовое приложение](../quickstart/launch-test-app.md#run-test).
