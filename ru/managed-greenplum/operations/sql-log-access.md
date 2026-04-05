---
title: Чтение логов кластера {{ mgp-full-name }} через SQL
description: Как получить доступ к логам Greenplum через SQL с помощью представления mdb_toolkit.gp_log
keywords:
  - greenplum logs sql
  - Greenplum external table logs
  - mdb_toolkit gp_log
  - просмотр логов Greenplum SQL
---

# Чтение логов кластера через SQL

{{ mgp-name }} предоставляет доступ к логам кластера непосредственно через SQL-запросы. Это позволяет анализировать логи с помощью стандартных SQL-инструментов: фильтровать, агрегировать и соединять данные с другими таблицами.

{% note info %}

Функция доступна для кластеров на базе {{ GP }} версии 6.29 и выше, а также Apache Cloudberry™.

{% endnote %}

## Как это работает {#how-it-works}

В базе данных `postgres` в схеме `mdb_toolkit` автоматически создается представление `gp_log`, которое объединяет логи мастер-узла и всех первичных сегментов кластера. Представление обновляется автоматически при изменении топологии кластера (расширение, восстановление из резервной копии, переключение мастера).

## Перед началом работы {#before-you-begin}

Для чтения логов через SQL пользователю необходимо иметь роль `mdb_log_reader`. Выдать ее может администратор кластера (`gpadmin` или пользователь с правами `SUPERUSER`):

```sql
GRANT mdb_log_reader TO <имя_пользователя>;
```

## Чтение логов {#read-logs}

Подключитесь к базе данных `postgres` и выполните запрос к представлению `mdb_toolkit.gp_log`:

```sql
SELECT * FROM mdb_toolkit.gp_log
ORDER BY logtime DESC
LIMIT 100;
```

### Фильтрация по времени {#filter-by-time}

```sql
SELECT logtime, logseverity, logmessage, logdatabase, loguser
FROM mdb_toolkit.gp_log
WHERE logtime >= NOW() - INTERVAL '1 hour'
ORDER BY logtime DESC;
```

### Поиск ошибок {#filter-errors}

```sql
SELECT logtime, logseverity, logmessage, logdatabase, loguser, loghost
FROM mdb_toolkit.gp_log
WHERE logseverity IN ('ERROR', 'FATAL', 'PANIC')
  AND logtime >= NOW() - INTERVAL '24 hours'
ORDER BY logtime DESC;
```

### Поиск медленных запросов {#slow-queries}

```sql
SELECT logtime, logdatabase, loguser, logmessage
FROM mdb_toolkit.gp_log
WHERE logmessage LIKE '%duration:%'
  AND logtime >= NOW() - INTERVAL '1 hour'
ORDER BY logtime DESC;
```

### Фильтрация по базе данных {#filter-by-database}

```sql
SELECT logtime, logseverity, logmessage
FROM mdb_toolkit.gp_log
WHERE logdatabase = '<имя_базы_данных>'
  AND logtime >= NOW() - INTERVAL '6 hours'
ORDER BY logtime DESC;
```

## Структура представления {#schema}

Представление `mdb_toolkit.gp_log` содержит следующие столбцы:

| Столбец | Тип | Описание |
|---|---|---|
| `logtime` | `timestamp with time zone` | Время события |
| `loguser` | `text` | Имя пользователя |
| `logdatabase` | `text` | Имя базы данных |
| `logpid` | `text` | Идентификатор процесса |
| `logthread` | `text` | Идентификатор потока |
| `loghost` | `text` | Имя хоста (мастер или сегмент) |
| `logport` | `text` | Порт |
| `logsessiontime` | `timestamp with time zone` | Время начала сессии |
| `logtransaction` | `int` | Идентификатор транзакции |
| `logsession` | `text` | Идентификатор сессии |
| `logcmdcount` | `text` | Счетчик команд в сессии |
| `logsegment` | `text` | Идентификатор сегмента |
| `logslice` | `text` | Идентификатор среза |
| `logdistxact` | `text` | Идентификатор распределенной транзакции |
| `loglocalxact` | `text` | Идентификатор локальной транзакции |
| `logsubxact` | `text` | Идентификатор вложенной транзакции |
| `logseverity` | `text` | Уровень серьезности (`DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`) |
| `logstate` | `text` | Код состояния SQLSTATE |
| `logmessage` | `text` | Текст сообщения |
| `logdetail` | `text` | Детальное описание ошибки |
| `loghint` | `text` | Подсказка по устранению ошибки |
| `logquery` | `text` | Текст SQL-запроса |
| `logquerypos` | `int` | Позиция в запросе |
| `logcontext` | `text` | Контекст выполнения |
| `logdebug` | `text` | Отладочная информация |
| `logcursorpos` | `int` | Позиция курсора |
| `logfunction` | `text` | Имя функции |
| `logfile` | `text` | Имя исходного файла |
| `logline` | `int` | Номер строки в исходном файле |
| `logstack` | `text` | Трассировка стека |

## Особенности и ограничения {#limitations}

- **Глубина хранения логов**: CSV-логи на узлах кластера ротируются ежедневно. По умолчанию хранятся последние 10 ротаций, то есть не более 10 последних дней. Запросы к более старым данным вернут пустой результат.

- **Маскирование чувствительных данных**: в столбцах `logmessage`, `logdetail`, `logquery` и `logdebug` автоматически скрываются пароли из команд `CREATE/ALTER ROLE ... PASSWORD` и URL-адреса внешних таблиц (PXF, S3, gpfdist). Это сделано для защиты учетных данных.

- **Только база данных `postgres`**: представление `mdb_toolkit.gp_log` доступно только в базе данных `postgres`. Для работы с ним подключитесь именно к этой базе.

- **Нагрузка на кластер**: запросы без фильтра по `logtime` читают все доступные логи со всех узлов кластера, что может создавать значительную нагрузку. Рекомендуется всегда указывать временной диапазон в условии `WHERE`.

- **Параллельное чтение**: данные читаются параллельно со всех первичных сегментов и мастера, поэтому порядок строк без `ORDER BY` не гарантирован.

- **Актуальность топологии**: при изменении топологии кластера (расширение, восстановление из резервной копии) представление автоматически обновляется в течение нескольких минут.

## Примеры аналитических запросов {#analytics}

### Количество ошибок по базам данных за последние сутки {#errors-by-database}

```sql
SELECT logdatabase, logseverity, COUNT(*) AS cnt
FROM mdb_toolkit.gp_log
WHERE logseverity IN ('ERROR', 'FATAL', 'PANIC')
  AND logtime >= NOW() - INTERVAL '24 hours'
GROUP BY logdatabase, logseverity
ORDER BY cnt DESC;
```

### Активность пользователей по часам {#user-activity}

```sql
SELECT DATE_TRUNC('hour', logtime) AS hour,
       loguser,
       COUNT(*) AS events
FROM mdb_toolkit.gp_log
WHERE logtime >= NOW() - INTERVAL '7 days'
  AND logdatabase = '<имя_базы_данных>'
GROUP BY 1, 2
ORDER BY 1 DESC, 3 DESC;
```

### Топ-10 самых частых сообщений об ошибках {#top-errors}

```sql
SELECT logmessage, COUNT(*) AS cnt
FROM mdb_toolkit.gp_log
WHERE logseverity = 'ERROR'
  AND logtime >= NOW() - INTERVAL '7 days'
GROUP BY logmessage
ORDER BY cnt DESC
LIMIT 10;
```

## См. также {#see-also}

- [{#T}](cluster-logs.md)
- [{#T}](mgp-to-cloud-logging.md)

