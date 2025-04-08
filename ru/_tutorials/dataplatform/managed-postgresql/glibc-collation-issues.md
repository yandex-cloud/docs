# Решение проблем с сортировкой строк в {{ PG }} после обновления glibc

Версия библиотеки glibc (GNU C) в Ubuntu 18.04 содержит существенные изменения в правилах сортировки строк. Это изменение влияет на отображение данных и структуру индексов в {{ PG }}, что может привести к нарушению уникальности первичного ключа. 

Пример:

```sql
CREATE TABLE t (id int, str text PRIMARY KEY);
INSERT INTO t VALUES (1, 'yndkpx'), (2, 'ynd_kpx'), (3, 'ynd-kpx'), (4, 'kpx');
```

Результат сортировки в выводе `SELECT * FROM t ORDER BY str;`:

* На Ubuntu 14.04:

   ```text
    id |   str
   ----+---------
     1 | yndkpx
     2 | ynd_kpx
     3 | ynd-kpx
     4 | kpx
   ```

* На Ubuntu 18.04:

   ```text
    id |   str
   ----+---------
     3 | ynd-kpx
     2 | ynd_kpx
     1 | yndkpx
     4 | kpx
   ```

## Критичность проблемы {#critical}

Изменение порядка сортировки приводит к следующим последствиям:

* Нарушение уникальности `PRIMARY KEY`. {{ PG }} допускает вставку дубликатов:

   ```sql
   INSERT INTO t VALUES (5, 'ynd_kpx');
   INSERT 0 1  -- Операция успешна, что является нарушением
   ```

* Некорректная работа индексов:

   Проверка через `amcheck`:

   ```sql
   CREATE EXTENSION IF NOT EXISTS amcheck;
   SELECT bt_index_check('t_pkey');
   ```

   Результат:

   ```text
   ERROR:  item order invariant violated for index "t_pkey"
   DETAIL:  Lower index tid=(1,1) (points to heap tid=(0,1)) higher index tid=(1,2) 
   (points to heap tid=(0,5)) page lsn=0/1665F88.
   ```

* Изменение результатов сравнения строк:

   ```sql
   -- Ubuntu 14.04:
   SELECT '1-1' < '11';

    ?column? 
   ----------
    f

   -- Ubuntu 18.04:
   SELECT '1-1' < '11';

    ?column? 
   ----------
    t
   ```

## Техническое решение {#technical-solution}

Решение реализовано в виде пакета [mdb-locales](https://github.com/postgredients/mdb-locales), включающего:

* Библиотеку `libmdblocales` для загрузки локалей.
* Патч для {{ PG }}.
* Фиксированные локали из предыдущей версии `glibc`.

### Принцип работы {#how-it-works}

`mdb-locales` обеспечивает перехват системных вызовов локалей с их переадресацией в библиотеку, что стабилизирует поведение сортировки:

```sql
-- После установки mdb-locales:
SELECT * FROM pg_collation WHERE collprovider='c';
```

Результат:

```text
  oid  |  collname  | collnamespace | collowner | collversion
-------+------------+---------------+-----------+-------------
 12547 | en_US.utf8 |            11 |        10 | 2.27
 12548 | en_US      |            11 |        10 | 2.27
```

### Верификация {#verification}

Проверка корректности работы после установки `mdb-locales`:

```sql
-- Проверка уникальности PRIMARY KEY
INSERT INTO t VALUES (5, 'ynd_kpx');

ERROR:  duplicate key value violates unique constraint "t_pkey"

-- Проверка целостности индекса
SELECT bt_index_check('t_pkey');

 bt_index_check 
---------------
               
(1 row)
```

## Рекомендации при обновлении Ubuntu до 18.04 {#update-recommendations}

1. Перед обновлением:

    * Создайте полную резервную копию данных.
    * Проведите аудит индексов.
    * Установите и настройте `mdb-locales`.

1. После обновления:

    * Выполните проверки индексов через `amcheck`.
    * Протестируйте критичные запросы с сортировкой.
    * Верифицируйте уникальные ограничения.

{% note warning %}

Обновление `glibc` может нарушить фундаментальные гарантии базы данных. Необходимо провести полное тестирование после обновления системы.

{% endnote %}
