---
title: Подключения
description: На странице представлены вопросы и ответы про подключения.
alternate:
  - href: ru/datalens/qa/connections.md
    type: text/markdown
    title: Markdown version
---

# Подключения

{% include [postgre-type.md](../../_qa/datalens/postgre-type.md) %}


{% include [metrica-clickhouse-connection](../../_qa/datalens/metrica-clickhouse-connection.md) %}

{% include [uploading-data-logs-api.md](../../_qa/datalens/uploading-data-logs-api.md) %}

{% include [csv-rows-display](../../_qa/datalens/csv-rows-display.md) %}

{% include [csv-long-loading](../../_qa/datalens/csv-long-loading.md) %}

{% include [csv-network-error](../../_qa/datalens/csv-network-error.md) %}

{% include [google-sheets-display-v2](../../_qa/datalens/google-sheets-v2.md) %}

### Как получить токен для подключения к БД {{ bitrix24-name }}? {#bitrix24-token}

Получите токен в настройках подключения BI-аналитики {{ bitrix24-name }} по [инструкции](https://helpdesk.bitrix24.ru/open/17402692/). В качестве токена используйте значение секретного ключа.

{% note info %}

Если вы используете коробочную версию {{ bitrix24-name }}, BI-аналитика доступна только [на специальном тарифе](https://helpdesk.bitrix24.ru/open/15702822/). Подробнее о решениях для BI-аналитики в {{ bitrix24-name }} читайте в [документации {{ bitrix24-name }}](https://helpdesk.bitrix24.ru/open/14888370/).

{% endnote %}

Если подключение настроить не удалось, [обратитесь в поддержку {{ bitrix24-name }}](https://helpdesk.bitrix24.ru/ticket.php).

### Почему при создании подключения к Google Sheets возникает ошибка «Не удалось загрузить файл»? {#google-sheets-file-load}

После указания ссылки на документ и длительного ожидания может появиться сообщение:

```text
Не удалось загрузить файл
Request ID: ********-****-****-****-************
```

Проверьте таблицу Google Sheets:

* Объем итоговых данных на каждом листе не превышает 200 МБ.
* На одном листе не больше 300 столбцов.
* На каждом листе заполнено не менее двух строк. Первая строка используется для заголовков полей датасета.
* В названии таблицы нет символов `+` и `/`.

Если таблица не соответствует одному или нескольким требованиям, создайте ее копию и приведите данные в соответствие с ограничениями.

### Что делать, если при загрузке CSV-файла возникает ошибка `ERR.FILE.PARSE_FAILED`? {#csv-upload}

Если при загрузке CSV-файла появляется сообщение `Не удалось загрузить файл` или ошибка `ERR.FILE.PARSE_FAILED`:

1. Проверьте кодировку файла. Поддерживаются UTF-8, UTF-16, Windows-1251 и UTF-8-Sig.
1. Проверьте разделители столбцов во всем файле. Поддерживаются запятая (`,`), точка с запятой (`;`) и знак табуляции.
1. Загрузите файл повторно:

   * отключите блокировщики рекламы;
   * откройте страницу датасета в режиме инкогнито;
   * используйте другой браузер.

{% note alert %}

Перед отправкой CSV-файла удалите из него чувствительные данные.

{% endnote %}

### Что делать, если при подключении к {{ mpg-name }} возникает ошибка `SSL is required`? {#postgresql-ssl-required}

Ошибка может выглядеть так:

```text
ERR.CHARTS.DATA_FETCHING_ERROR
ERR.DS_API.DB
db_message": "odyssey: ***********: SSL is required"
```

Она означает, что для подключения требуется SSL. При подключении к внешней базе данных используйте на сервере доверенный SSL-сертификат.

Если ошибка возникла при создании подключения к {{ mpg-name }}, [включите **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}**](../../managed-postgresql/operations/datalens-connect.md#allow-access) в настройках кластера, а затем [настройте подключение](../operations/connection/create-postgresql.md).

Если ошибка возникла в существующем подключении, выключите и снова включите [доступ из {{ datalens-name }}](../../managed-postgresql/operations/datalens-connect.md#allow-access) в [настройках кластера](../../managed-postgresql/operations/update.md#change-additional-settings). Если это не помогло, создайте новое подключение и [замените его в датасете](../dataset/create-dataset.md#replace-connection).

### Как подключиться к коннектору МойСклад? {#moysklad-connector}

Проверьте токен и настройте подключение по [инструкции разработчика](https://www.htmls.ru/learning/course/index.php?COURSE_ID=12&LESSON_ID=384&LESSON_PATH=380.381.384).

Если подключение настроить не удалось, обратитесь в техническую поддержку коннектора по адресу [datalens@htmls.ru](mailto:datalens@htmls.ru).

### Что делать, если при создании подключения возникает ошибка `ERR.DS_API.US.BAD_REQUEST data.key should not start with /`? {#bad-request-data-key}

Ошибка может возникнуть при создании подключения в корне иерархии {{ datalens-name }}, внутри каталога **«{{ ui-key.datalens.component.aside-header.view.switch_root }}»**.

После нажатия кнопки **{{ ui-key.datalens.connection.connections-list.modify.button_create-connection }}** укажите во всплывающем окне другой каталог.

### Что делать, если при подключении к API {{ metrika }} возникает ошибка `direct_client_logins`? {#metrika-direct-client-logins}

Для построения запроса к API {{ metrika }} требуется параметр `direct_client_logins`. Подробнее о нем описано в [документации API {{ metrika }}](https://yandex.ru/dev/metrika/doc/api2/api_v1/direct-clicks.html?lang=ru).

{{ datalens-short-name }} не позволяет передавать этот и подобные параметры, поэтому построить чарт напрямую не получится. Вместо этого [выгрузите данные в {{ CH }}](#uploading-data-logs-api).

### Что делать, если при подключении к БД {{ MY }} возникает ошибка `1043 Bad handshake`? {#mysql-bad-handshake}

Ошибка означает, что клиент и сервер не смогли согласовать параметры подключения, обменяться ключами шифрования или установить безопасное соединение.

Чтобы устранить ошибку:

1. Убедитесь, что используется актуальная версия {{ MY }}.
1. Проверьте, что на стороне БД используется [SSL-сертификат](../../glossary/ssl-certificate.md), подписанный удостоверяющим центром. Подключение с самоподписанным сертификатом создать не получится.
1. Проверьте, что сервер {{ MY }} поддерживает выбранный метод аутентификации. При необходимости обновите {{ MY }} или измените настройки плагина аутентификации.


{% include [google-sheets-error](../../_qa/datalens/google-sheets-error.md) %}

{% include [yadocs-error](../../_qa/datalens/yadocs-link.md) %}

### Учитываются ли таймзоны при работе с датами? {#timezone-date}

Данные о времени с указанием часового пояса {{ datalens-short-name }} запрашивает и возвращает в часовом поясе источника, само указание часового пояса при этом отбрасывается. Например, для {{ PG }} с настройкой `timezone: Europe/Berlin` все данные из колонок с типом `TIMESTAMP WITH TIME ZONE` будут выводиться в таймзоне `Europe/Berlin` независимо от часового пояса пользователя или того, с каким сдвигом они были записаны в базу.

Например:

* значение в источнике: `2025-03-31 10:00:00+01:00`;
* значение в {{ datalens-short-name }}: `2025-03-31 10:00:00`.

[Таймзона](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) учитывается при вычислениях, в т. ч. с использованием функций [преобразования типов](../function-ref/type-conversion-functions.md).

Например, для {{ PG }} с настройкой `timezone: Europe/Berlin`:

* формула `DATEPART(DATETIME(#1970-01-01 01:00:00#, 'UTC'), 'hour')` вернет значение `2`, т. к. таймзона базы (`Europe/Berlin`) сдвинута относительно указанной (`UTC`) на 1 час;
* формула `INT(DATETIME(#1970-01-01 01:00:00#, 'UTC'))` вернет значение `3600`.


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
