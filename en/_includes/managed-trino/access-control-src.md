## Function-ownership {#function-ownership}

If you do not specify the `privileges` parameter, the rule will prohibit any actions with the functions.

{% note info %}

To use the `OWNERSHIP` privilege for the function, you need the `ALL` access level for the catalog containing that function.

{% endnote %}

## Procedures-privileges {#procedures-privileges}

If you do not specify the `privileges` parameter, the rule will prohibit any actions with the procedures.

## Queries-privileges {#queries-privileges}

If you do not specify the `privileges` parameter, the rule will prohibit any actions with the queries.

{% note warning %}

You cannot specify the `EXECUTE` privilege if the rule already contains the `query_owners` parameter.

{% endnote %}

## Tables-privileges {#table-ownership}

If you do not specify the `privileges` parameter, the rule will prohibit any actions with the tables.

{% note info %}

To use the `OWNERSHIP` privilege for the table, you need the `ALL` access level for the catalog containing that table.

{% endnote %}