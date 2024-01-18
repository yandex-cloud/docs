---
title: "How to add data to a {{ datalens-full-name }} dataset via an SQL query"
description: "In this tutorial, you will learn how to add data to a {{ datalens-full-name }} dataset using an SQL query."
---

# Describing a dataset via a source SQL query

{% note info %}

To use subqueries as a source, in the connection settings, enable **Raw SQL level** → **Allow subqueries in datasets** when creating or editing a [connection](../../concepts/connection.md).

{% endnote %}

To add data to a dataset using a SQL query:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/circles-intersection.svg) **Datasets** and select the dataset you need. If you do not have a dataset, [create one](create.md).
1. In the top-left corner, select the **Sources** tab.
1. In the left part of the screen, under **Connection**, click ![image](../../../_assets/console-icons/plus.svg) **Add**.

   {% note info %}

   The ![image](../../../_assets/console-icons/plus.svg)**Add** button is only available if the source is a database.

   {% endnote %}

1. Enter a **Source name** and enter the SQL code in the **Subquery** field.
1. Click **Create**.

{% cut "Example of SQL query" %}

{% include [datalens-sql-join-example](../../../_includes/datalens/datalens-sql-join-example.md) %}

{% endcut %}
