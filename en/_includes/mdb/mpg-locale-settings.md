{{ PG }} supports multiple locales. The choice of locale affects the following:

- Sort order in queries using the `ORDER BY` clause or standard text comparison operators.
- `upper`, `lower`, `initcap`, and `to_char` functions.
- Pattern-matching operators, e.g., `LIKE`, `ILIKE`, `SIMILAR TO`, and regular expressions.
- Support of indexes with the `LIKE` operator.

The default locale is `C`. When using the `C` encoding for text data with non-Latin, e.g., Cyrillic, characters, you may encounter errors in data sorting and incorrect pattern-matching results. If this locale causes incorrect data handling in your database, select a different one from the list. However, note that using a non-standard locale may reduce database query performance.

To learn more about locale settings, see the [this {{ PG }} article](https://www.postgresql.org/docs/current/locale.html).

Once you create a database, you cannot change its locale settings. However, you can set a collation for columns when creating or altering individual tables. For more information, see the relevant [{{ PG }} guides](https://www.postgresql.org/docs/current/sql-createtable.html).
