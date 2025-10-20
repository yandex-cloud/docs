|Description|Example|
|---|---|
|`NULL` check|`WHERE column1 IS NULL` or `WHERE column1 IS NOT NULL`|
|`OR`, `NOT`, or `AND` logical conditions or parentheses to prioritize calculations |`WHERE column1 IS NULL OR (column2 IS NOT NULL AND column3 > 10)`.|
|Comparison operators (`=`, `==`, `!=`, `<>`, `>`, `<`, `>=`, or `<=`) to other columns or constants|`WHERE column1 > column2 OR column3 <= 10`, `WHERE column1 + column2 > 10`, `WHERE column1 = (10 + 10)`|

Other filter types do not support source pushdown: the external table rows will be filtered on the federated {{ yq-full-name }} side, i.e., {{ yq-full-name }} will perform a full scan of the external table when processing the query.