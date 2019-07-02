# Подключение к базе данных

{% if audience == "internal" %}

Доступ к базам данных в {{ ydb-short-name }} осуществляется по протоколу gRPC. Сетевой адрес для соединения cо своей базой (database endpoint) можно узнать в [веб-интерфейсе](https://ydb.yandex-team.ru/) на вкладке **Info**.

![Database API Endpoint](../_assets/db_ui_info_cluster_api.png)

Для получения доступа следует с помощью [Puncher](https://puncher.yandex-team.ru) создать заявки на правила доступа по TCP к серверам в кластерах {{ ydb-short-name }} и устройствам, балансирующим к ним сетевые соединения.

## Доступ к кластеру ydb-ru {#access-to-ydb-ru}

В отдельных заявках укажите:

* адрес балансировщика: ydb-ru.yandex.net, протокол TCP, порт 2135;

![Pucnher_request_form_4slb_sample](../_assets/puncher_request_4slb_form_ydb_ru.png)

* макрос: ```_C_YDB_RU_``` для баз данных в кластере `ydb-ru`, протокол TCP, диапазон портов 31000-32000.

![Pucnher_request_form_sample](../_assets/puncher_request_form_ydb_ru.png)

## Доступ к кластеру ydb-ru-prestable {#access-to-ydb-ru-prestable}

В отдельных заявках укажите:

* адрес балансировщика: ydb-ru-prestable.yandex.net, протокол TCP, порт 2135;

![Pucnher_request_form_4slb_sample](../_assets/puncher_request_4slb_form_ydb_ru_prestable.png)

* макрос: ```_C_YDB_RU_PRESTABLE_``` для баз данных в кластере ydb-ru, протокол TCP, диапазон портов 31000-32000.

![Pucnher_request_form_sample](../_assets/puncher_request_form_ydb_ru_prestable.png)

{% else if audience == "external" %}

Доступ к базам данных в {{ ydb-short-name }} осуществляется по протоколу gRPC. Чтобы узнать эндпоинт для соединения с базой данных:

1. Перейдите на страницу **Базы данных** в консоли управления.

1. Кликните на имя базы данных, для которой необходимо получить эндпоинт. Откроется страница **Навигация**.

1. Перейдите на страницу **Обзор**. Эндпоинт базы данных указан в поле **Эндпоинты**.

{% endif %}