---
title: Access management in {{ mtr-full-name }}
description: In {{ mtr-name }}, you can flexibly control access to cluster objects for individual users or user groups. You can manage access by setting access rules.
---

# Access management in {{ mtr-name }}

{{ mtr-name }} provides unified access to data from multiple sources, such as storage systems, databases, and external services. A single {{ mtr-name }} cluster can serve multiple users and workloads. Access management in {{ mtr-name }} enables you to:

* Segregate access to cluster objects for users and groups with different roles and tasks.
* Prevent unauthorized data operations.
* Prevent users from abusing system resources.

In {{ mtr-name }}, you can manage access using _access rules_, which declaratively describe the allowed and prohibited operations on cluster objects for users and groups.

## Rule structure {#structure}

User access to {{ mtr-name }} cluster objects results from a combination of these two types of rules:

* Top-level rules which control access to all objects in the catalog.
* Granular rules which control access to individual schemas, tables and views, functions, procedures, queries, session’s system properties, or catalog’s session properties.

An access rule describes:

* Users the rule applies to.
* {{ mtr-name }} cluster objects the rule applies to.
* User privileges: Actions users can perform on objects.

In the `users` parameter, specify the IDs of {{ iam-name }} users, and in the `groups` parameter, specify group IDs, not user logins or group names. You can get these values using [SQL queries](#check-identity).

You can specify objects as a list or as a regular expression that matches the object name.

{% note info %}

Rules apply to objects created both before and after the rule was set.

{% endnote %}

As soon as a user accesses an object, all rules for objects of that type get checked for matches. Rules are checked in the order of their declaration. The first rule matching the user-object pair applies.

For more information, see [{#T}](../operations/access-control.md).

## Access to views {#views}

A _view_ (`VIEW`) is a virtual table defined by a saved SQL query. You can query view data in the same way as from a regular table.

[Table access rules](../operations/access-control-tables.md) also apply to views. For a rule to apply to a view, specify the view name in the table name field, as well as the appropriate catalog and schema.

To create a view, a user needs the `OWNERSHIP` privilege for the target view and the `ALL` access tier for its destination catalog. To read the data the view is based on, a user needs the `SELECT` privilege for the source tables and access to their catalogs.

The mode for checking source table permissions is specified in the [`CREATE VIEW`]({{ tr.docs }}/sql/create-view.html#security) command:

* `SECURITY DEFINER`: Used by default. When reading the view, access to source tables is checked against the view owner. If another user runs the query, the system also checks whether the owner holds `SELECT` and `GRANT_SELECT` privileges for the source tables and the `ALL` access tier for their catalogs. The user running the query requires the `SELECT` privilege for the view itself and access to its catalog.
* `SECURITY INVOKER`: Access to source tables is checked against the user running the query. Each user requires read permissions for both the view and source tables.

{% note warning %}

In {{ mtr-name }}, the view owner's groups are ignored when verifying source table access in `SECURITY DEFINER` mode. If access is granted to the owner only via groups, attempts to read the view may fail with an `Access Denied` error, even if the query is run by the owner.

To use `SECURITY DEFINER`, configure source access rules explicitly for the owner: specify the owner ID under `users` and omit `groups` in these rules. Mind the order: the system applies the first matching rule for each object type.

If users must read data with their own access permissions, create or recreate the view with `SECURITY INVOKER`.

{% endnote %}

To find out the mode of an existing view, run this command:

```sql
SHOW CREATE VIEW <catalog_name>.<schema_name>.<view_name>;
```

The `SHOW CREATE VIEW` command is available to the view owner only.

Here is an example of creating a view that verifies permissions against the user running the query:

```sql
CREATE VIEW <catalog_name>.<schema_name>.<view_name>
SECURITY INVOKER
AS SELECT * FROM <source_catalog_name>.<source_schema_name>.<source_table_name>;
```

Views created in Hive are subject to additional Hive connector configurations. For details on the `hive.hive-views.run-as-invoker` parameter, see [Creating a Hive catalog](../operations/catalog-create.md#hive).

## Checking users and groups {#check-identity}

To learn what IDs {{ TR }} uses when checking access rules, run the following queries within the session where the error occurred:

```sql
SELECT current_user;
SELECT current_groups();
```

`current_user` returns the ID of the user running the query, while `current_groups()`, the IDs of their groups. Use these values in the `users` and `groups` parameters of your access rules.

Check the [cluster access rules](../operations/access-control-get.md) to make sure the user is allowed to perform the required actions with the object. To find out whether a rule applies to a user, check the `users` and `groups` conditions against the obtained IDs.

For example, to read the `hive.sales.orders` table, you need the either `READ_ONLY` or `ALL` access to the `hive` catalog and the `SELECT` privilege for the `orders` table within that catalog’s `sales` schema.

The system applies the first matching rule for each object type: privileges from multiple applicable rules of the same type do not accumulate. When reading a view with `SECURITY DEFINER`, also check the rules configured for its owner.

## Managing rules {#management}

In {{ mtr-name }}, access rules are managed resources within a cluster. Therefore, you can manage rules using the {{ yandex-cloud }} CLI, {{ TF }}, and gRPC API. You can set access rules when creating a new cluster or updating an existing one.

To update access rules, you do not have to restart {{ mtr-name }} cluster nodes.

## Auto-updating of rules {#catalog-tracking}

{{ mtr-name }} automatically updates access rules when you rename or delete catalogs:

* Catalog names and IDs get validated. If a catalog with the specified name or ID does not exist, the rule will not be created.
* If you rename a catalog, its name will be automatically updated in all the rules that contain it.
* If you delete a catalog, its name and ID will be automatically deleted from all the rules that contain them. If you delete the only catalog specified in the rule, the rule itself will be automatically deleted.
