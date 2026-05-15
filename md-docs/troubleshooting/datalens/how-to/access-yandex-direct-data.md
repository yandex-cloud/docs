# Как подключиться к Яндекс Директ из DataLens


## Описание задачи {#case-description}

Необходимо настроить подключение к данным из Яндекс Директ в DataLens.

## Решение {#case-resolution}

Вы можете запрашивать данные из [API Яндекс Директ](https://yandex.ru/dev/direct/#start) с помощью [Cloud Functions](../../../functions/quickstart/index.md).

Для этого понадобится создать функцию, которая будет сохранять данные из Яндекс Директ в промежуточной базе данных, например в кластере [Yandex Managed Service for ClickHouse®](../../../managed-clickhouse/quickstart.md). Затем на стороне DataLens потребуется [настроить подключение](../../../datalens/operations/connection/create-clickhouse.md) к этой БД.

Для создания функции рекомендуем воспользоваться [примером получения JSON из API Яндекс Директ](https://yandex.ru/dev/direct/doc/ru/python3-requests-campaigns) и [документацией по импорту данных в ClickHouse®](https://clickhouse.com/docs/ru/integrations/data-formats).