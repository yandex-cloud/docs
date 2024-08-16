# Как подключиться к {{ yandex-direct }} из {{ datalens-name }}


## Описание задачи {#case-description}

Необходимо настроить подключение к данным из {{ yandex-direct }} в {{ datalens-name }}.

## Решение {#case-resolution}

Вы можете запрашивать данные из [API {{ yandex-direct }}](https://yandex.ru/dev/direct/#start) с помощью [{{ sf-name }}](../../../functions/quickstart/index.md).

Для этого понадобится создать функцию, которая будет сохранять данные из {{ yandex-direct }} в промежуточной базе данных, например в кластер [{{ mch-full-name }}](../../../managed-clickhouse/quickstart.md). Затем на стороне {{ datalens-name }} потребуется [настроить подключение](../../../datalens/operations/connection/create-clickhouse.md) к этой БД.