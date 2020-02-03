# Подключение

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт подключения.

Подключение создается с помощью коннектора. Коннекторы содержат настройки подключения к популярным источникам данных.
На базе подключения вы можете создавать [_датасеты_](dataset.md).

## Коннектор {#connector}

_Коннектор_ — это драйвер для подключения и загрузки данных из БД, API или файла.
С помощью подключения {{ datalens-short-name }} выполняет запрос данных у источника.

В {{ datalens-short-name }} доступны следующие типы коннекторов:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV-файл**
- **MS SQL Server**
- **Metrica** (в режиме прямого доступа и через API)
- **AppMetrica** (в режиме прямого доступа и через API)

{% include [connection-note](../../_includes/datalens/datalens-connection-note.md) %}

## Управление доступом {#access-management}

Вы можете настроить права доступа к подключению. Подробнее в разделе [{#T}](../security/index.md).

#### См. также {#see-also}
- [{#T}](../operations/connection/create-clickhouse.md)
- [{#T}](../operations/connection/create-csv.md)
- [{#T}](../operations/connection/create-mysql.md)
- [{#T}](../operations/connection/create-postgresql.md)
- [{#T}](../operations/connection/create-mssql-server.md)
- [{#T}](../operations/connection/create-metrica-api.md)
- [{#T}](../operations/connection/create-metrica-logs-api.md)
- [{#T}](../operations/connection/create-appmetrica.md)
