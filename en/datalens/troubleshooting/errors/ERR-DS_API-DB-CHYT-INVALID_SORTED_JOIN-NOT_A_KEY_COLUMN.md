---
title: ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_A_KEY_COLUMN error
description: This page describes the ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_A_KEY_COLUMN error.
---

# Column used in join expression is not a key column

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_A_KEY_COLUMN`

If you use a CHYT connection, the key columns of {{ ytsaurus-name }} tables are significant.
In multi-table datasets, you can join tables (`JOIN`) only based on these tables' `key columns`.
Make sure the following requirements are met:

* All columns used to join tables must form a part of the key for those tables.
* The keys of both tables must begin with exactly those columns.
* Columns must be listed in the same order in the keys of both tables.


Use one of the methods below to get around this problem:

* Recreate the original tables and set the keys to meet the criteria.
* As a dataset source, use an SQL query with `GLOBAL JOIN`, which allows joining tables based on non-key columns:

  ```sql
  SELECT * FROM left_table GLOBAL JOIN right_table ON (...) ....
  ```

