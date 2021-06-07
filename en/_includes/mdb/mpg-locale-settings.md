{{ PG }} uses locales to support various language standards. The locale you choose affects:

- Sort order in the queries that use the `ORDER BY` operator or standard text data matching operators.
- The functions `upper`, `lower`, `initcap`, and the `to_char` family of functions.
- Pattern matching operators (`LIKE`, `ILIKE`, `SIMILAR TO`, regular expressions).
- Support of indexes with the `LIKE` operator.

By default, the `C` locale is used. if you use the `C` encoding for text data containing non-Latin (for example, Cyrillic) characters, errors might occur in the data sort order and data display in the case of pattern search. If this locale is not suitable for valid processing of tables in your database, select another encoding from the list. However, please keep in mind that a non-standard locale might decrease the database query processing rate.

For more information about locale settings, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/locale.html).

You cannot change locale settings after you create a database. However, you can set the sorting locale for columns when creating and modifying individual tables. Learn more in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-createtable.html).

