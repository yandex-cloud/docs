---
title: "Instructions for adding data to a {{ datalens-full-name }} dataset via an SQL query"
description: "In this tutorial, you'll learn how to add data to a {{ datalens-full-name }} dataset using an SQL query"
---

# Describing a dataset via a source SQL query

{% note info %}

To use subqueries as a source, in the connection settings, enable **Raw SQL level** → **Allow subselects in datasets**. You can do this when creating or editing the [connection](../../concepts/connection.md).

{% endnote %}

To add data to a dataset using a SQL query:

1. Open the dataset. If you don't have a dataset, [create one](create.md).
1. In the upper left-hand corner, select the **Sources** tab.
1. In the left part of the screen, under **Tables**, click ![image](../../../_assets/plus-sign.svg) **Add**.
1. Enter a **Source name** and enter the SQL code in the **Subquery** field.
1. Click **Create**.

{% cut "Example of SQL query" %}

{% include [datalens-sql-join-example](../../../_includes/datalens/datalens-sql-join-example.md) %}

{% endcut %}
