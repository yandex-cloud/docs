# Оценка количества уникальных элементов с помощью алгоритма HyperLogLog

Чтобы оценить количество уникальных элементов в столбце таблицы (_мощность_ множества), вы можете воспользоваться встроенными в {{ mgp-name }} функциями, реализующими [алгоритм HyperLogLog](https://algo.inria.fr/flajolet/Publications/FlFuGaMe07.pdf).

Этот алгоритм преобразует исходное множество в особый объект — _HLL_. Мощность HLL соответствует мощности исходного множества, а ее оценка может быть произведена за константное время. Алгоритм позволяет быстро оценить количество уникальных элементов в столбце, а относительная погрешность оценки снижается с увеличением размера множества.

В {{ mgp-name }} алгоритм HyperLogLog реализуется двумя функциями:

* `gp_hyperloglog_accum(<имя_столбца>)` — применяет алгоритм HyperLogLog к переданному столбцу. Возвращает HLL с типом данных `gp_hyperloglog_estimator`.
* `gp_hyperloglog_get_estimate(<HLL>)` — конвертирует переданный HLL в численную оценку.

Также доступны вспомогательные функции:

* `gp_hyperloglog_merge(<HLL1>, <HLL2>)` — возвращает HLL, который является результатом объединения (дизъюнкции) исходных HLL.
* `gp_hyperloglog_add_item_agg_default(<HLL>, <значение>)` — проверяет, принадлежит ли значение ко множеству, HLL которого передан в параметрах:

    * Если принадлежит или является пустым (`null`), то функция возвращает HLL исходного множества.
    * Если не принадлежит, то функция возвращает HLL множества, включающего указанное значение.

## Получить HLL столбца {#get-hll}

Выполните запрос:

```sql
SELECT gp_hyperloglog_accum(<имя_столбца>) FROM <имя_таблицы>;
```

Ответ будет содержать строку.

## Получить оценку количества уникальных элементов в столбце {#get-estimation}

Выполните запрос:

```sql
SELECT gp_hyperloglog_get_estimate(gp_hyperloglog_accum(<имя_столбца>)) FROM <имя_таблицы>;
```

Ответ будет содержать вещественное число.

## Получить оценку количества уникальных элементов в объединении двух столбцов {#merge}

Выполните запрос:

```sql
SELECT gp_hyperloglog_get_estimate(
    gp_hyperloglog_merge(gp_hyperloglog_accum(<столбец_1>), gp_hyperloglog_accum(<столбец_2>)))
FROM <имена_таблиц>;
```

Ответ будет содержать вещественное число.

## Учесть новый элемент в имеющейся оценке {#add}

Выполните запрос:

```sql
SELECT gp_hyperloglog_get_estimate(
    gp_hyperloglog_add_item_agg_default(gp_hyperloglog_accum(<имя_столбца>), <значение_нового_элемента>))
FROM <имя_таблицы>;
```

Если новый элемент не уникален для данного столбца или имеет значение `null`, то в ответе вернется такая же оценка, как при [запросе количества уникальных элементов в столбце](#get-estimation). Иначе оценка увеличится примерно на `1`.

## Создать и использовать таблицу с предварительной агрегацией {#aggregation}

Предварительная агрегация позволяет заранее рассчитать оценку уникальных значений столбца в многомерном наборе данных, чтобы затем по необходимости извлекать оценку для нужного измерения. При этом не придется вычислять HLL при каждом запросе, а получение оценки происходит за константное время — O(1).

Чтобы воспользоваться этим методом:

1. Создайте таблицу с предварительной агрегацией и наполните ее данными:

    ```sql
    CREATE TABLE agg_table(column1, column2, ..., estimate gp_hyperloglog_estimator);

    INSERT INTO agg_table(column1, column2, ..., estimate)
    SELECT column1, column2, ..., gp_hyperloglog_accum(estimated_col)
    FROM original_table
    GROUP BY column1, column2, ...;
    ```

    Где:

    * `agg_table` — имя таблицы с предварительной агрегацией.
    * `column1, column2, ...,` — имена столбцов исходной таблицы, кроме столбца, для которого проводится оценка.
    * `estimate` — имя столбца с оценкой в таблице с предварительной агрегацией.
    * `estimated_col` — имя столбца в исходной таблице, для которого вычисляется оценка.
    * `original_table` — имя исходной таблицы.

1. Создайте новую [агрегатную функцию](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-sql_commands-CREATE_AGGREGATE.html) на основе `gp_hyperloglog_merge`:

    ```sql
    CREATE AGGREGATE gp_hyperloglog_merge(gp_hyperloglog_estimator) (
    SFUNC=gp_hyperloglog_merge, 
    STYPE=gp_hyperloglog_estimator, 
    FINALFUNC=gp_hyperloglog_comp,
    COMBINEFUNC=gp_hyperloglog_merge
    );
    ```

1. Получите оценку количества уникальных элементов в разрезе нужного столбца, например `column1`:

    ```sql
    SELECT column1, gp_hyperloglog_get_estimate(gp_hyperloglog_merge(estimate))
    FROM agg_table
    GROUP BY column1;
    ```

## Примеры {#examples}

В примерах использованы таблицы, заполненные целыми числами с помощью [функции generate_series](https://www.postgresql.org/docs/current/functions-srf.html).

### Оценка количества уникальных элементов {#common-estimate}

Пусть дана таблица со списком клиентов в разных городах:

```sql
CREATE TABLE clients(city_id int, client_id int);
INSERT INTO clients (city_id, client_id) 
VALUES (generate_series(1, 10), generate_series(1, 10000));
```

Чтобы оценить, сколько уникальных клиентов в каждом городе, выполните запрос:

```sql
SELECT city_id, gp_hyperloglog_get_estimate(gp_hyperloglog_accum(client_id))
FROM clients
GROUP BY city_id
ORDER BY city_id;
```

```sql
 city_id | gp_hyperloglog_get_estimate 
---------+-----------------------------
       1 |            988.212360350532
       2 |             1002.0269799313
       3 |            1006.27966975993
       4 |            998.837197408661
       5 |             1004.1525443185
       6 |            995.648631718888
       7 |            1003.08887802751
       8 |            997.775023703087
       9 |            1005.21614155965
      10 |             1002.0269799313
(10 rows)
```

### Оценка количества уникальных элементов в объединении столбцов {#conj-estimate}

Пусть даны две таблицы:

```sql
CREATE TABLE viewers(index_id int, viewer_id int);
INSERT INTO viewers (index_id, viewer_id) 
VALUES (generate_series(1, 1000), generate_series(1, 1000));
```

```sql
CREATE TABLE purchasers(index_id int, purchaser_id int);
INSERT INTO purchasers (index_id, purchaser_id) 
VALUES (generate_series(1, 1000), generate_series(501, 1500));
```

В этом примере `viewer_id` — идентификатор посетителя страницы товара на сайте, `purchaser_id` — идентификатор покупателя товара. Оба идентификатора являются идентификатором клиента, т. е. принадлежат некоторому единому множеству.

Чтобы оценить, сколько клиентов купило товар после посещения сайта, т. е. количество неуникальных элементов в объединении столбцов:

1. Оцените количество уникальных вхождений в объединении столбцов `viewer_id` и `purchaser_id`:

    ```sql
    SELECT gp_hyperloglog_get_estimate(
        gp_hyperloglog_merge(gp_hyperloglog_accum(viewer_id), gp_hyperloglog_accum(purchaser_id)))
    FROM viewers, purchasers;
    ```

    ```sql
    gp_hyperloglog_get_estimate 
    -----------------------------
                1498.48297183718
    (1 row)
    ```

1. Вычтите полученную оценку из общего количества элементов в обоих столбцах: `2000 − 1498 = 502`.

### Создание таблицы с предварительной агрегацией {#aggregation-example}

Пусть дана таблица со списком клиентов в разных городах и магазинах:

```sql
CREATE TABLE clients(city_id int, shop_id int, client_id int);
INSERT INTO clients (city_id, shop_id, client_id) 
VALUES (generate_series(1, 5), generate_series(1, 10), generate_series(1, 10000));
```

Чтобы быстро получать оценку количества уникальных клиентов в разрезе по городам или магазинам:

1. Создайте таблицу с предварительной агрегацией и наполните ее данными:

    ```sql
    CREATE TABLE agg_clients(city_id int, shop_id int, unique_clients gp_hyperloglog_estimator);

    INSERT INTO agg_clients(city_id, shop_id, unique_clients)
    SELECT city_id, shop_id, gp_hyperloglog_accum(client_id)
    FROM clients
    GROUP BY city_id, shop_id;
    ```

1. Создайте агрегатную функцию на основе `gp_hyperloglog_merge`:

    ```sql
    CREATE AGGREGATE gp_hyperloglog_merge(gp_hyperloglog_estimator) (
    SFUNC=gp_hyperloglog_merge, 
    STYPE=gp_hyperloglog_estimator, 
    FINALFUNC=gp_hyperloglog_comp,
    COMBINEFUNC=gp_hyperloglog_merge
    );
    ```

1. Получите оценку количества уникальных клиентов:

    * В разрезе по городам:

        ```sql
        SELECT city_id, gp_hyperloglog_get_estimate(gp_hyperloglog_merge(unique_clients))
        FROM agg_clients
        GROUP BY city_id
        ORDER BY city_id;
        ```

        ```sql
        city_id | gp_hyperloglog_get_estimate 
        --------+-----------------------------
              1 |            1984.47308188562
              2 |            2002.54325709491
              3 |            1993.50633730345
              4 |            2009.32588394612
              5 |            2012.71700838494
        (5 rows)
        ```

    * В разрезе по магазинам:

        ```sql
        SELECT shop_id, gp_hyperloglog_get_estimate(gp_hyperloglog_merge(unique_clients))
        FROM agg_clients
        GROUP BY shop_id
        ORDER BY shop_id;
        ```

        ```sql
        shop_id | gp_hyperloglog_get_estimate 
        --------+-----------------------------
              1 |            988.212360350532
              2 |             1002.0269799313
              3 |            1006.27966975993
              4 |            998.837197408661
              5 |             1004.1525443185
              6 |            995.648631718888
              7 |            1003.08887802751
              8 |            997.775023703087
              9 |            1005.21614155965
             10 |             1002.0269799313
        (10 rows)
        ```
