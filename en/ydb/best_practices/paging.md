---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Paginated output

This section provides recommendations for organizing paginated data output.

To organize paginated output, we recommend selecting data sorted by primary key sequentially, limiting the number of rows with the LIMIT keyword.

The query in listing 1 demonstrates the recommended way to organize paginated output.

{% note info %}

`$lastCity, $lastNumber`: Primary key values obtained from the previous query.

{% endnote %}

<small>Listing 1: Query for organizing paginated output</small>

```sql
DECLARE $limit AS Uint64;
DECLARE $lastCity AS Utf8;
DECLARE $lastNumber AS Uint32;

$Data = (
    SELECT * FROM schools
    WHERE city = $lastCity AND number > $lastNumber
    ORDER BY city, number LIMIT $limit

    UNION ALL

    SELECT * FROM schools
    WHERE city > $lastCity
    ORDER BY city, number LIMIT $limit
);
SELECT * FROM $Data ORDER BY city, number LIMIT $limit;
```

{% note warning "Значение NULL в ключевой колонке" %}

In YDB, all columns, including key ones, may have a NULL value. Despite this, using NULL as key column values is highly discouraged, since the SQL standard doesn't allow NULL to be compared. As a result, concise SQL statements with simple comparison operators won't work correctly. Instead, you'll have to use cumbersome statements with IS NULL/IS NOT NULL expressions.

{% endnote %}

