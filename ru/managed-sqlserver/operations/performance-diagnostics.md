# Диагностика производительности

{{ mms-name }} использует встроенные [инструменты диагностики производительности]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/query-store-usage-scenarios){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/performance/query-store-usage-scenarios){% endif %} {{ MS }}.

## Активировать сбор статистики {#activate-stats-collector}

Чтобы активировать сбор статистики, включите [хранилище запросов]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store){% endif %} (query store):
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

## Получить информацию о сессиях и запросах {#get-sessions-queries}

Чтобы посмотреть эти данные:
* [Выполните SQL-запрос]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store?view=sql-server-ver15#performance-auditing-and-troubleshooting){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store?view=sql-server-ver15#performance-auditing-and-troubleshooting){% endif %} напрямую к хранилищу запросов.
* Используйте [SQL Server Management Studio]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/performance/performance-dashboard?view=sql-server-ver15){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/performance/performance-dashboard?view=sql-server-ver15){% endif %}.
