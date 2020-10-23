# Подключение к базе данных

{% if audience == "internal" %}

Доступ к базам данных в {{ ydb-short-name }} осуществляется по протоколу gRPC. Сетевой адрес для соединения cо своей базой (database endpoint) можно узнать в [веб-интерфейсе](https://ydb.yandex-team.ru/) на вкладке **Info**.

![Database API Endpoint](../_assets/db_ui_info_cluster_api.png)

Для получения доступа следует с помощью [Puncher](https://puncher.yandex-team.ru) создать заявки на правила доступа по TCP к серверам в кластерах {{ ydb-short-name }} и устройствам, балансирующим к ним сетевые соединения.

## Доступ к кластеру ydb-ru {#access-to-ydb-ru}

В отдельных заявках укажите:

* адрес балансировщика: ydb-ru.yandex.net, протокол TCP, порт 2135;

![Puncher_request_form_4slb_sample](../_assets/puncher_request_4slb_form_ydb_ru.png)

* макрос: ```_C_YDB_RU_``` для баз данных в кластере `ydb-ru`, протокол TCP, диапазон портов 31000-32000.

![Puncher_request_form_sample](../_assets/puncher_request_form_ydb_ru.png)

## Доступ к кластеру ydb-ru-prestable {#access-to-ydb-ru-prestable}

В отдельных заявках укажите:

* адрес балансировщика: ydb-ru-prestable.yandex.net, протокол TCP, порт 2135;

![Puncher_request_form_4slb_sample](../_assets/puncher_request_4slb_form_ydb_ru_prestable.png)

* макрос: ```_C_YDB_RU_PRESTABLE_``` для баз данных в кластере ydb-ru, протокол TCP, диапазон портов 31000-32000.

![Puncher_request_form_sample](../_assets/puncher_request_form_ydb_ru_prestable.png)

{% else if audience == "external" %}

Доступ к базам данных {{ ydb-short-name }} осуществляется по протоколу gRPC поверх TLS.

{% endif %}

Для подключения к базе данных {{ ydb-name }} выполните следующие настройки:

1. {% if deploy != "arc" %} [Создайте сервисный аккаунт](../../iam/operations/sa/create.md). {% else %} Создайте сервисный аккаунт. {% endif %}
1. {% if deploy != "arc" %} [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) {% else %} Назначьте {% endif %} созданному сервисному аккаунту роли `viewer` и `editor`.
1. [Получите идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.
1. {% if deploy != "arc" %} [Создайте авторизованные ключи доступа](../../iam/operations/sa/create-access-key.md) {% else %} Создайте авторизованные ключи доступа {% endif %} к сервисному аккаунту и сохраните их.
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
