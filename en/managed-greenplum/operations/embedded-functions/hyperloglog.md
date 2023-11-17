# Estimating the number of unique elements using the HyperLogLog algorithm

You can estimate the number of unique elements in a table column (set _cardinality_) using the built-in {{ mgp-name }} functions that implement the [HyperLogLog algorithm](https://algo.inria.fr/flajolet/Publications/FlFuGaMe07.pdf).

This algorithm converts the original set into a special _HLL_ object. The cardinality of the HLL object corresponds to the cardinality of the original set and can be estimated in constant time. This algorithm can quickly estimate the number of unique elements in a column, with the relative estimation error decreasing as the set size increases.

In {{ mgp-name }}, the HyperLogLog algorithm is implemented by two functions:

* `gp_hyperloglog_accum(<column_name>)`: Applies the HyperLogLog algorithm to the provided column. This function returns an HLL object with the `gp_hyperloglog_estimator` data type.
* `gp_hyperloglog_get_estimate(<HLL>)`: Converts the provided HLL object to a numeric estimation.

In addition, you can use auxiliary functions:

* `gp_hyperloglog_merge(<HLL1>, <HLL2>)`: Returns the HLL resulting from the union (disjunction) of the source HLLs.
* `gp_hyperloglog_add_item_agg_default(<HLL>, <value>)`: Checks if a value belongs to the set whose HLL was provided as a parameter:

   * If the value belongs to the set, or it is a `null` value, the function returns the HLL of the original set.
   * If the value does not belong to the set, the function returns the updated HLL with the specified value added to the set.

## Getting the HLL of a column {#get-hll}

Run the following query:

```sql
SELECT gp_hyperloglog_accum(<column_name>) FROM <table_name>;
```

The output will contain a string.

## Getting an estimate of the number of unique elements in a column {#get-estimation}

Run the following query:

```sql
SELECT gp_hyperloglog_get_estimate(gp_hyperloglog_accum(<column_name>)) FROM <table_name>;
```

The output will contain a real number.

## Getting an estimate of the number of unique elements in a union of two columns {#merge}

Run the following query:

```sql
SELECT gp_hyperloglog_get_estimate(
    gp_hyperloglog_merge(gp_hyperloglog_accum(<column_1>), gp_hyperloglog_accum(<column_2>)))
FROM <table_names>;
```

The output will contain a real number.

## Including a new element in an existing estimate {#add}

Run the following query:

```sql
SELECT gp_hyperloglog_get_estimate(
    gp_hyperloglog_add_item_agg_default(gp_hyperloglog_accum(<column_name>), <new_element_value>))
FROM <table_name>;
```

If the new element is not unique for this column or has a `null` value, the returned estimate will be the same as if you [requested the number of unique elements in the column](#get-estimation). Otherwise, the estimate will be incremented by approximately `1`.

## Creating and using a pre-aggregation table {#aggregation}

Pre-aggregation allows you to estimate the number of unique values in a multidimensional dataset in advance. This way, you can retrieve the estimate for any dimension whenever you need. Furthermore, it eliminates the need to calculate the HLL for each query, providing an estimate in constant time, O(1).

To use this method:

1. Create a pre-aggregation table and populate it with data:

   ```sql
   CREATE TABLE agg_table(column1, column2, ..., estimate gp_hyperloglog_estimator);

   INSERT INTO agg_table(column1, column2, ..., estimate)
   SELECT column1, column2, ..., gp_hyperloglog_accum(estimated_col)
   FROM original_table
   GROUP BY column1, column2, ...;
   ```

   Where:

   * `agg_table`: Name of the pre-aggregation table.
   * `column1, column2, ...,`: Names of the columns in the original table, excluding the column whose cardinality you want to estimate.
   * `estimate`: Name of the column with the estimate in the pre-aggregation table.
   * `estimated_col`: Name of the column in the original table whose cardinality you want to estimate.
   * `original_table`: Name of the original table.

1. Create a new [aggregate function](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-sql_commands-CREATE_AGGREGATE.html) based on `gp_hyperloglog_merge`:

   ```sql
   CREATE AGGREGATE gp_hyperloglog_merge(gp_hyperloglog_estimator) (
   SFUNC=gp_hyperloglog_merge,
   STYPE=gp_hyperloglog_estimator,
   FINALFUNC=gp_hyperloglog_comp,
   COMBINEFUNC=gp_hyperloglog_merge
   );
   ```

1. Get an estimate of the number of unique elements in a specific column, e.g., `column1`:

   ```sql
   SELECT column1, gp_hyperloglog_get_estimate(gp_hyperloglog_merge(estimate))
   FROM agg_table
   GROUP BY column1;
   ```

## Examples {#examples}

The following examples use tables populated with integers using the [generate_series function](https://www.postgresql.org/docs/current/functions-srf.html).

### Estimating the number of unique elements {#common-estimate}

Let's assume we have a table with a list of customers in different cities:

```sql
CREATE TABLE clients(city_id int, client_id int);
INSERT INTO clients (city_id, client_id)
VALUES (generate_series(1, 10), generate_series(1, 10000));
```

To estimate how many unique customers there are in each city, run the following query:

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

### Estimating the number of unique elements in a union of columns {#conj-estimate}

Let's assume we have two tables:

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

In this example, `viewer_id` is the ID of a user who visited a product page on the website, and `purchaser_id` is the ID of a user who made a purchase. Both of these values are customer IDs, i.e., they belong to the same set.

To estimate how many customers bought a product after visiting the website, i.e., the number of non-unique elements in the column union:

1. Estimate the number of unique entries in the union of the `viewer_id` and `purchaser_id` columns:

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

1. Subtract the resulting estimate from the total number of elements in both columns: `2000 - 1498 = 502`.

### Creating a pre-aggregation table {#aggregation-example}

Let's assume we have a table with a list of customers in different cities and stores:

```sql
CREATE TABLE clients(city_id int, shop_id int, client_id int);
INSERT INTO clients (city_id, shop_id, client_id)
VALUES (generate_series(1, 5), generate_series(1, 10), generate_series(1, 10000));
```

To get a quick estimate of the number of unique customers by city or store:

1. Create a pre-aggregation table and populate it with data:

   ```sql
   CREATE TABLE agg_clients(city_id int, shop_id int, unique_clients gp_hyperloglog_estimator);

   INSERT INTO agg_clients(city_id, shop_id, unique_clients)
   SELECT city_id, shop_id, gp_hyperloglog_accum(client_id)
   FROM clients
   GROUP BY city_id, shop_id;
   ```

1. Create an aggregate function based on `gp_hyperloglog_merge`:

   ```sql
   CREATE AGGREGATE gp_hyperloglog_merge(gp_hyperloglog_estimator) (
   SFUNC=gp_hyperloglog_merge,
   STYPE=gp_hyperloglog_estimator,
   FINALFUNC=gp_hyperloglog_comp,
   COMBINEFUNC=gp_hyperloglog_merge
   );
   ```

1. Get an estimate of the number of unique customers:

   * By city:

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

   * By store:

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
