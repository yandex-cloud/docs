# Устранение ошибки Bad Request for url MetrikaHttpApiException direct_client_logins


## Описание проблемы {#issue-description}

При подключении по API Метрики в соответствующем URL не указан параметр `direct_client_logins`

## Решение {#issue-resolution}

Для построения запроса необходимо передать параметр `direct_client_logins`. Подробнее пишем [здесь](https://yandex.ru/dev/metrika/doc/api2/api_v1/direct-clicks.html?lang=ru).

Пока что у DataLens нет возможности передать этот и подобные параметры, поэтому построить чарт таким образом не получится, но можно [выгрузить данные в ClickHouse](https://cloud.yandex.ru/docs/datalens/qa/#uploading-data-logs-api).

