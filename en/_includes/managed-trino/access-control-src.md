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

## Queries-privileges-REST {#queries-privileges-rest}

If you do not specify the `privileges` parameter, the rule will prohibit any actions with the queries.

{% note warning %}

You cannot specify the `EXECUTE` privilege if the rule already contains the `queryOwners` parameter.

{% endnote %}

## Tables-privileges {#table-ownership}

If you do not specify the `privileges` parameter, the rule will prohibit any actions on tables and views.

{% note info %}

To use the `OWNERSHIP` privilege for a table or view, you need the `ALL` access level for the catalog containing that object.

{% endnote %}

## View-creation {#view-creation}

{% note info "Creating and reading a view" %}

To create a view (`CREATE VIEW`), the user needs:

* The `OWNERSHIP` privilege for the view. In the table access rule, specify the name of the new view in the table name field, as well as relevant catalog and schema.
* The `ALL` access level for the catalog you are creating the view in.
* The `SELECT` privilege for all the source tables the view is reading data from and access to their catalogs.

For other users to be able to read a view with `SECURITY DEFINER`, its owner also needs the `GRANT_SELECT` privilege for all the source tables and the `ALL` access level for their catalogs. The `GRANT_SELECT` privilege for the sources alone is not enough to create a view.

For more details on permission check modes and group rule restrictions, see [Access to views](../../managed-trino/concepts/access-control.md#views).

{% endnote %}
