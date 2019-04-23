# Подключение

_Подключение_ содержит информацию о параметрах доступа к источнику данных. Например, IP-адрес хоста БД, порт подключения. 
Подключение создается с помощью коннектора. Коннекторы содержат настройки подключения к популярным источникам данных.

## Коннектор

_Коннектор_ — это компонент сервиса [!KEYREF datalens-short-name], с помощью которого вы создаете соединение с
 определенным типом БД, API или файлом. С помощью подключения [!KEYREF datalens-short-name] выполняет запрос данных у источника.
 
В [!KEYREF datalens-short-name] доступны следующие типы коннекторов:

- **ClickHouse**
- **PostgreSQL**
- **MySQL**
- **CSV-файл**
- **MS SQL Server**
- **Metrica**
- **Metrica Logs API**

> [!IMPORTANT]
>
> При подключении к внешнему источнику данных (который не является ресурсом Яндекс.Облака), необходимо предоставить доступ 
к источнику для следующих IP-адресов сервиса [!KEYREF datalens-short-name]: 
> - `77.88.39.88` порт `29`
> - `93.158.158.96` порт `29`
> - `93.158.156.80` порт `29`
> - `77.88.39.224` порт `28`
> - `37.9.126.112` порт `28`
> - `37.9.65.32` порт `28`

## Управление доступом

Вы можете настроить права доступа к подключению. Подробнее в разделе [[!TITLE]](../security/index.md).

#### См. также
- [[!TITLE]](../operations/connection/create-clickhouse.md)
- [[!TITLE]](../operations/connection/create-csv.md)
- [[!TITLE]](../operations/connection/create-mysql.md)
- [[!TITLE]](../operations/connection/create-postgresql.md)
- [[!TITLE]](../operations/connection/create-mssql-server.md)
- [[!TITLE]](../operations/connection/create-metrika-api.md)
- [[!TITLE]](../operations/connection/create-metrika-logs-api.md)

