---
title: Working with data distribution policies in {{ mgp-name }}
description: Learn how to define a distribution policy for a new table, modify the distribution policy and key for an existing table, and manually redistribute data across segments.
---


# Working with data distribution policies in {{ mgp-name }}

In {{ mgp-name }}, all database tables are distributed row by row across the cluster's [segment hosts](../concepts/index.md#architecture-segment). Each table is assigned a data distribution policy that defines the specific rule used to allocate rows to segments. For more on distribution policies, see [{#T}](../concepts/sharding.md).

When working with data distribution policies, you can:

* [Define a distribution policy](#set-distribution-policy) for a new table.
* [Modify the distribution policy and key](#change-distribution-policy) for an existing table.
* [Manually redistribute data](#redistribute-data) across segments.


## Defining a distribution policy {#set-distribution-policy}

{% list tabs group=instructions %}

- SQL {#sql}

  To define a distribution policy, run this command:

  * For hash distribution:

    ```sql
    CREATE TABLE <table_name> (
      <column_descriptions>
    ) DISTRIBUTED BY (<distribution_key>);
    ```

    Where `<distribution_key>` is a single column or a comma-separated list of columns.

  * For random distribution:

    ```sql
    CREATE TABLE <table_name> (
      <column_descriptions>
    ) DISTRIBUTED RANDOMLY;
    ```

  * For replicated distribution:

    ```sql
    CREATE TABLE <table_name> (
      <column_descriptions>
    ) DISTRIBUTED REPLICATED;
    ```

{% endlist %}


## Modifying a distribution policy {#change-distribution-policy}

{% note warning %}

If a table has a primary key or a unique constraint, you cannot change its distribution policy from hash distribution to random distribution.

{% endnote %}

{% list tabs group=instructions %}

- SQL {#sql}

  To modify a distribution policy or key, run this command:

  * Changing to hash distribution or selecting a new distribution key:

    ```sql
    ALTER TABLE <table_name>
    SET DISTRIBUTED BY (<distribution_key>);
    ```

    Where `<distribution_key>` is a single column or a comma-separated list of columns.

  * Changing to random distribution:

    ```sql
    ALTER TABLE <table_name>
    SET DISTRIBUTED RANDOMLY;
    ```

  * Changing to replicated distribution:

    ```sql
    ALTER TABLE <table_name>
    SET DISTRIBUTED REPLICATED;
    ```

  When you modify a policy, data is automatically redistributed across segments, except in the following cases:

  * When changing the policy from hash distribution to random distribution.
  * When the `DISTRIBUTED` clause specifies the current distribution policy settings.

  If needed, you can [manually redistribute data](#redistribute-data).

{% endlist %}


## Redistributing data manually {#redistribute-data}

{% list tabs group=instructions %}

- SQL {#sql}

  To redistribute data, e.g., when changing the policy from hash distribution to random distribution, run this command:

  ```sql
  ALTER TABLE <table_name>
  SET WITH (REORGANIZE=TRUE);
  ```

  When [expanding a {{ mgp-name }} cluster](../concepts/expand.md), data is redistributed automatically, so you do not need to run this command manually.

{% endlist %}