---
title: "How to create a {{ ydb-name }} connection"
description: "Follow this guide to create a {{ ydb-name }} connection."
---

# Creating a {{ ydb-name }} connection

{% note info %}


To create a connection, you will need a [service account](../../../iam/concepts/users/service-accounts.md) with the **ydb.viewer** or **viewer** [role](../../../iam/operations/sa/assign-role-for-sa.md).


To write subqueries in datasets and queries in QL charts, use [YQL syntax](https://ydb.tech/en/docs/yql/reference/syntax/).

{% endnote %}

To create a {{ ydb-name }} connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **{{ ydb-short-name }}** connection.

1. Specify the connection parameters:

   
   * **Cloud and folder**: Select the folder where your service account will be located.
   * **Service account**: Select an existing service account or create a new one.
   * **Database**: Select the database to connect or create a new one.


   {% note warning %}

   Capital letters are not allowed in {{ ydb-short-name }} database column names.

   {% endnote %}

   * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
   * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. (Optional) Make sure the connection works properly. To do this, click **Check connection**.
1. Click **Create connection**.


1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.