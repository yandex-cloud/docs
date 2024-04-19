# Устранение ошибки `SSL is required`


## Описание проблемы {#issue-description}

Подключение из {{ datalens-full-name }} к базе данных {{ mpg-full-name }} завершается ошибкой:

```
ERR.CHARTS.DATA_FETCHING_ERROR
ERR.DS_API.DB
db_message": "odyssey: xxxxxxxxxxx: SSL is required"
```

## Решение {#issue-resolution}

Такая ошибка сообщает, что для подключения необходим протокол SSL. Его [необязательно использовать](../../../managed-postgresql/operations/connect.md) при подключении к базе из того же самого облака или каталога, но если вы подключаетесь к внешней базе данных, то использовать доверенный SSL-сертификат на сервере нужно.

При возникновении проблемы с новым подключением к {{ mpg-full-name }} [включите **Доступ из DataLens**](../../../managed-postgresql/operations/datalens-connect.md#allow-access) в настройках кластера, после чего [настройте подключение в {{ datalens-full-name }}](../../../datalens/operations/connection/create-postgresql.md).

Если проблема воспроизводится с уже существующим подключением к {{ mpg-full-name }}, выключите и включите [доступ из {{ datalens-full-name }}](../../../managed-postgresql/operations/datalens-connect.md#allow-access) в [настройках](../../../managed-postgresql/operations/update.md#change-additional-settings) кластера. Если это не поможет, создайте в {{ datalens-full-name }} новое подключение к базе данных кластера {{ mpg-full-name }}. После этого [замените подключение в датасете](../../../datalens/operations/dataset/replace-connection.md) на рабочее.