---
title: "Working with the AWS CLI. Overview"
description: "This section describes how to create, add, read, and update table data using the AWS CLI: Examples of how to execute simple queries are given."
---

# Working with the AWS CLI in {{ ydb-name }}. Overview

This section describes how to perform the following operations in {{ ydb-short-name }} using the AWS CLI:
* [Creating](create-table.md) a table.
* [Adding](put-item.md), [reading](get-item.md), and [updating](update-item.md) table data.
* [Executing](query.md) simple queries.

## Getting started {#before-you-begin}

1. [Configure the AWS environment](../aws-setup.md).
1. Prepare the Document API endpoint of the [created database](../../../operations/manage-databases.md).

   {% cut "How do I find out the Document API endpoint of a database?" %}

   1. Go to the [management console]({{ link-console-main }}).
   1. Select the folder and go to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the DB you want to query.
   1. In the menu on the left, go to the **{{ ui-key.yacloud.ydb.database.switch_overview }}** section.
   1. The endpoint value is in the **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}** line.

      > Example of an endpoint value:
      >
      > ```text
      > {{ ydb.aws-ep }}
      > ```

   {% endcut %}

   {% note info %}

   For the Amazon DynamoDB-compatible mode, use a serverless database configuration.

   {% endnote %}