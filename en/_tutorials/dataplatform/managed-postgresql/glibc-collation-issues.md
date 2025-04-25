# Fixing string sorting issues in {{ PG }} after upgrading glibc

The Ubuntu 18.04 version of the glibc (GNU C) library contains significant changes in the string sorting rules. This change affects the way the data is displayed and the structure of indexes in {{ PG }}, which may violate the uniqueness of the primary key. 

For example:

```sql
CREATE TABLE t (id int, str text PRIMARY KEY);
INSERT INTO t VALUES (1, 'yndkpx'), (2, 'ynd_kpx'), (3, 'ynd-kpx'), (4, 'kpx');
```

Sort result in `SELECT * FROM t ORDER BY str;` output:

* On Ubuntu 14.04:

   ```text
    id |   str
   ----+---------
     1 | yndkpx
     2 | ynd_kpx
     3 | ynd-kpx
     4 | kpx
   ```

* On Ubuntu 18.04:

   ```text
    id |   str
   ----+---------
     3 | ynd-kpx
     2 | ynd_kpx
     1 | yndkpx
     4 | kpx
   ```

## Issue criticality {#critical}

Changing the sorting order has the following consequences:

* Violation of `PRIMARY KEY` uniqueness. {{ PG }} allows insertion of duplicates:

   ```sql
   INSERT INTO t VALUES (5, 'ynd_kpx');
   INSERT 0 1  -- The operation is successful, which is a violation
   ```

* Incorrect operation of indexes:

   Checking via `amcheck`:

   ```sql
   CREATE EXTENSION IF NOT EXISTS amcheck;
   SELECT bt_index_check('t_pkey');
   ```

   Result:

   ```text
   ERROR:  item order invariant violated for index "t_pkey"
   DETAIL:  Lower index tid=(1,1) (points to heap tid=(0,1)) higher index tid=(1,2) 
   (points to heap tid=(0,5)) page lsn=0/1665F88.
   ```

* Changing string comparison results:

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

## Technical solution {#technical-solution}

The solution is implemented as an [mdb-locales](https://github.com/postgredients/mdb-locales) package, which includes:

* `libmdblocales` library for uploading locales.
* Patch for {{ PG }}.
* Fixed locales from the previous `glibc` version.

### How it works {#how-it-works}

`mdb-locales` provides interception of locale system calls followed by their redirection to the library, which stabilizes the sorting behavior:

```sql
-- After installing mdb-locales:
SELECT * FROM pg_collation WHERE collprovider='c';
```

Result:

```text
  oid  |  collname  | collnamespace | collowner | collversion
-------+------------+---------------+-----------+-------------
 12547 | en_US.utf8 |            11 |        10 | 2.27
 12548 | en_US      |            11 |        10 | 2.27
```

### Verification {#verification}

Checking for correct operation after installing `mdb-locales`:

```sql
-- Checking uniqueness of PRIMARY KEY
INSERT INTO t VALUES (5, 'ynd_kpx');

ERROR:  duplicate key value violates unique constraint "t_pkey"

-- Checking index integrity
SELECT bt_index_check('t_pkey');

 bt_index_check 
---------------
               
(1 row)
```

## Recommendations when upgrading Ubuntu to 18.04 {#update-recommendations}

1. Before the upgrade:

    * Create a full backup of your data.
    * Audit the indexes.
    * Install and configure `mdb-locales`.

1. After the upgrade:

    * Perform index checks via `amcheck`.
    * Test critical queries with sorting.
    * Verify unique restrictions.

{% note warning %}

Upgrading `glibc` may violate fundamental guarantees of the database. You need to perform a full test after upgrading the system.

{% endnote %}
