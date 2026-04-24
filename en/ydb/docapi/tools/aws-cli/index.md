---
title: Working with the AWS CLI. Overview
description: This section describes how to create, add, read, and update table data using the AWS CLI. We also provide examples of how to run simple queries.
---

# Working with the AWS CLI in {{ ydb-name }}. Overview

This section describes how to perform the following operations in {{ ydb-short-name }} using the AWS CLI:
* [Creating](create-table.md) a table.
* [Adding](put-item.md), [reading](get-item.md), and [updating](update-item.md) table data.
* [Running](query.md) simple queries.

## Getting started {#before-you-begin}

1. [Configure the AWS environment](../aws-setup.md).
1. Prepare the Document API endpoint of [your database](../../../operations/manage-databases.md).

   {% cut "Where to find the Document API endpoint of a database" %}

   1. Navigate to the [management console]({{ link-console-main }}).
   1. Select the folder and go to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database you want to query.
   1. In the menu on the left, go to the **{{ ui-key.yacloud.common.overview }}** section.
   1. The **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}** line shows the endpoint value.

      >Here is an example of an endpoint value:
      >
      >```text
      >{{ ydb.aws-ep }}
      >```

   {% endcut %}

   {% note info %}

   For the Amazon DynamoDB compatibility mode, use a serverless database configuration.

   {% endnote %}