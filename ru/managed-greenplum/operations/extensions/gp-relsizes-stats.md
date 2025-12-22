---
title: Как использовать расширение gp_relsizes_stats в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете использовать расширение gp_relsizes_stats в {{ mgp-name }}.
---

# Использование gp_relsizes_stats в {{ mgp-name }}

Расширение `gp_relsizes_stats` предназначено для сбора статистики о физических размерах файлов и таблиц на всех сегментах кластера {{ GP }}.

Ключевые возможности:

* Автоматический сбор статистики через фоновый воркер (background worker).
* Мониторинг всех сегментов кластера одновременно.
* Гибкие настройки производительности для контроля нагрузки на систему.
* Отслеживание истории изменения размеров таблиц.
* Ручной запуск сбора статистики при необходимости.

Компоненты расширения:

* Главный фоновый воркер. Если включен, периодически инициирует сбор статистики. Запускается в базе данных `postgres`.
* Воркеры для конкретных баз данных.
* Функция сбора статистики. Сканирует файловую систему для подсчета размеров файлов. Выполняется на каждом сегменте.

## Схема данных {#data-schema}

При [установке расширения](#extension-install) создается схема `relsizes_stats_schema` со следующими таблицами.

Основные таблицы:

| Таблица | Описание | Структура |
|---------|----------|-----------|
| `segment_file_map` | Маппинг идентификаторов таблиц (reloid) и имен файлов таблиц на диске (relfilenode) для каждого сегмента. | `segment`, `reloid`, `relfilenode` |
| `segment_file_sizes` | Размеры файлов по сегментам. | `segment`, `relfilenode`, `filepath`, `size`, `mtime` |
| `table_sizes_history` | История размеров таблиц. | `insert_date`, `nspname`, `relname`, `size`, `mtime` |

Представления для анализа:

| Таблица | Описание |
|---------|----------|
| `table_files` | Детальная информация о файлах таблиц с типами (main, toast, ao и т. д.). |
| `table_sizes` | Агрегированные размеры таблиц по всем сегментам. |
| `namespace_sizes` | Размеры схем базы данных. |

## Настройки расширения {#extension-settings}

| Настройка | Значение по умолчанию | Описание |
|-----------|-----------------------|----------|
| `relsizes_stats.on` | True | Если настройка включена, расширение доступно для установки в базу данных. |
| `relsizes_stats.enable` | False | Если настройка включена, создается главный фоновый воркер, который периодически запускает сбор статистики по всему кластеру.<br>Если вы хотите использовать ручной сбор статистики, эту настройку рекомендуется отключить, чтобы не создавать фоновую нагрузку. |
| `relsizes_stats.restart_naptime` | 21 600 000 мс | Определяет периодичность сбора статистики по всему кластеру. |
| `relsizes_stats.database_naptime` | 0 мс | Определяет время ожидания между сбором статистики для разных баз данных. |
| `relsizes_stats.file_naptime` | 1 мс | Определяет время ожидания между обработкой разных файлов. Это позволяет лимитировать фоновую нагрузку, которую создает сбор статистики, распределяя ее во времени. |

Чтобы изменить настройки, обратитесь в [службу технической поддержки]({{ link-console-support }}).

## Установка расширения gp_relsizes_stats в кластер {{ GP }} {#extension-install}

1. [Подключитесь](../connect.md) к базе данных от имени владельца или пользователя, имеющего в базе данных разрешение `CREATE`, и выполните команду:

    ```sql
    CREATE EXTENSION gp_relsizes_stats;
    ```

1. Проверьте, что расширение было установлено:

    ```sql
    SELECT extname FROM pg_extension;
    ```

    Будет выведен список расширений, установленных в БД:

    ```text
          extname
    -------------------
     ...
     gp_relsizes_stats
    ```

## Примеры использования {#examples}

В качестве примера рассмотрим сбор статистики по базе данных колл-центра. Для этого подготовьте исходные данные:

1. Создайте схему `call_center`:

    ```sql
    CREATE SCHEMA call_center;
    ```

1. Создайте таблицу `operators` в схеме `call_center`:

    ```sql
    CREATE TABLE call_center.operators (
        id INTEGER PRIMARY KEY,
        operator_name varchar (20),
        operator_id INTEGER
    );
    ```

1. Вставьте в таблицу `operators` сгенерированные данные:

    ```sql
    INSERT INTO call_center.operators (id, operator_name, operator_id)
    SELECT 
        generate_series(1, 1000) AS id,
        'Operator ' || generate_series(1, 1000) AS operator_name,
        10000 + generate_series(1, 1000) AS operator_id;
    ```

1. Запустите вручную сбор статистики:

    ```sql
    SELECT relsizes_stats_schema.relsizes_collect_stats_once();
    ```

### Размеры таблиц

Чтобы вывести из всей базы данных 20 таблиц с наибольшим размером, выполните команду:

```sql
SELECT nspname, relname,
       pg_size_pretty(size) as size_pretty,
       mtime
FROM relsizes_stats_schema.table_sizes
ORDER BY size DESC
LIMIT 20;
```

Чтобы вывести размер таблицы `operators`, выполните команду:

```sql
SELECT relname, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.table_sizes
WHERE nspname='call_center' AND relname='operators';
```

### Размеры схем

Чтобы вывести размеры всех схем в базе данных, выполните команду:

```sql
SELECT nspname, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.namespace_sizes
ORDER BY size DESC;
```

Чтобы вывести размер схемы `call_center`, выполните команду:

```sql
SELECT nspname, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.namespace_sizes
WHERE nspname='call_center';
```

### История роста таблицы

Чтобы вывести историю изменения размера таблицы `operators`, выполните команду:

```sql
SELECT insert_date, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.table_sizes_history
WHERE nspname='call_center' AND relname='operators'
ORDER BY insert_date;
```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
