# Устранение ошибки `SSL is required`


## Описание проблемы {#issue-description}

Подключение из DataLens к базе данных Managed Service for PostgreSQL завершается ошибкой:

```
ERR.CHARTS.DATA_FETCHING_ERROR
ERR.DS_API.DB
db_message": "odyssey: ***********: SSL is required"
```

## Решение {#issue-resolution}

Такая ошибка сообщает, что для подключения необходим протокол SSL. Его [необязательно использовать](../../../managed-postgresql/operations/connect/index.md) при подключении к базе из того же самого облака или каталога, но если вы подключаетесь к внешней базе данных, то использовать доверенный SSL-сертификат на сервере нужно.

При возникновении проблемы с новым подключением к Managed Service for PostgreSQL [включите **Доступ из DataLens**](../../../managed-postgresql/operations/datalens-connect.md#allow-access) в настройках кластера, после чего [настройте подключение в DataLens](../../../datalens/operations/connection/create-postgresql.md).

Если проблема воспроизводится с уже существующим подключением к Managed Service for PostgreSQL, выключите и включите [доступ из DataLens](../../../managed-postgresql/operations/datalens-connect.md#allow-access) в [настройках](../../../managed-postgresql/operations/update.md#change-additional-settings) кластера. Если это не поможет, создайте в DataLens новое подключение к базе данных кластера Managed Service for PostgreSQL. После этого [замените подключение в датасете](../../../datalens/dataset/create-dataset.md#replace-connection) на рабочее.