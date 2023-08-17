# Подключение к Яндекс Директ из DataLens

## Описание задачи {#case-description}
Возникла необходимость настроить подключение к данным из Яндекс Директа в DataLens.

## Решение {#case-resolution}

Вы можете запрашивать данные из [API Яндекс Директа](https://yandex.ru/dev/direct/#start) с помощью [Cloud Functions](../../../functions/quickstart/index.md).
Для этого понадобится создать функцию, которая будет сохранять данные из Яндекс Директа в промежуточной БД, например в кластер [Managed Service for Clickhouse](../../../managed-clickhouse/quickstart.md). Затем на стороне DataLens потребуется [настроить подключение](../../../datalens/operations/connection/create-clickhouse.md) к этой базе данных.
