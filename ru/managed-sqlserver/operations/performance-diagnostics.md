# Диагностика производительности

{{ mms-name }} использует встроенные [инструменты диагностики производительности](https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/query-store-usage-scenarios) {{ MS }}.

## Активировать сбор статистики {#activate-stats-collector}

Чтобы активировать сбор статистики, включите [хранилище запросов](https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) (query store):
1. [Подключитесь к кластеру {{ MS }}](../operations/connect.md#connection-ide).
1. Включите хранилище запросов одним из способов:

    {% list tabs %}

    - SQL

      Выполните запрос к базе данных:

      ```sql
      ALTER DATABASE <имя БД>
      SET QUERY_STORE = ON (OPERATION_MODE = READ_WRITE);
      ```

    - SQL Server Management Studio

      1. Выберите базу данных в окне **Обозреватель объектов**.
      1. Нажмите правой кнопкой мыши и выберите пункт **Свойства**.
      1. Выберите раздел **Хранилище запросов**.
      1. В поле **Режим работы (запрошенный)** выберите значение `Чтение и запись`.
      1. Нажмите кнопку **ОК**.

    {% endlist %}

## Получить информацию о сеансах и запросах {#get-sessions-queries}

Чтобы посмотреть эти данные:
* [Выполните SQL-запрос](https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store?view=sql-server-ver15#performance-auditing-and-troubleshooting) напрямую к хранилищу запросов.
* Используйте [SQL Server Management Studio](https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/performance-dashboard?view=sql-server-ver15).
* Используйте [встроенные хранимые процедуры](sessions.md).
