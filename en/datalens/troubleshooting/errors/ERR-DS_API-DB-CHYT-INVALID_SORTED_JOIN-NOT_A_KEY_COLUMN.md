# Column used in join expression is not a key column

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_A_KEY_COLUMN`

When you use the CHYT connection, key columns of the YT tables are significant.
In multi-table datasets, you can link tables (execute `JOIN`) only by `key columns` of joined tables.
To do this, the following requirements must be met:

* All columns used in table links must be part of the key for the tables involved.
* Keys of both tables must begin with those columns.
* Columns must be listed in the same order in the keys of both tables.


 Use one of the methods below to get around this problem:

* Recreate the original tables and set the keys to meet the criteria.
* Use, as your dataset source, an SQL query with `GLOBAL JOINs` that allow joining tables by non-key columns:

   ```sql
   SELECT * FROM left_table GLOBAL JOIN right_table ON (...) ....
   ```

   For more information about the difference between JOIN types, [see the post on the CHYT's Atushka page](https://clubs.at.yandex-team.ru/yt/3689).