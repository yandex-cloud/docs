# Устранение ошибки `SSL is required`


## Описание проблемы {#issue-description}

Подключение из {{ datalens-name }} к базе данных {{ mpg-name }} завершается ошибкой:

```
ERR.CHARTS.DATA_FETCHING_ERROR
ERR.DS_API.DB
db_message": "odyssey: xxxxxxxxxxx: SSL is required"
```

## Решение {#issue-resolution}

Такая ошибка сообщает, что для подключения необходим протокол SSL. Его [необязательно использовать](../../../managed-postgresql/operations/connect.md) при подключении к базе из того же самого облака или каталога, но если вы подключаетесь к внешней базе данных, то использовать доверенный SSL-сертификат на сервере нужно.

При возникновении проблемы с новым подключением к {{ mpg-name }} [включите **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}**](../../../managed-postgresql/operations/datalens-connect.md#allow-access) в настройках кластера, после чего [настройте подключение в {{ datalens-name }}](../../../datalens/operations/connection/create-postgresql.md).

Если проблема воспроизводится с уже существующим подключением к {{ mpg-name }}, выключите и включите [доступ из {{ datalens-name }}](../../../managed-postgresql/operations/datalens-connect.md#allow-access) в [настройках](../../../managed-postgresql/operations/update.md#change-additional-settings) кластера. Если это не поможет, создайте в {{ datalens-name }} новое подключение к базе данных кластера {{ mpg-name }}. После этого [замените подключение в датасете](../../../datalens/dataset/create-dataset.md#replace-connection) на рабочее.
