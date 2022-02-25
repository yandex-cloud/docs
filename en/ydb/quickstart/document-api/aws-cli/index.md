---
title: Work with AWS CLI. Overview
description: "This section describes how to perform the creating, adding and executing operations using the AWS CLI."
sourcePath: en/ydb/overlay/quickstart/document-api/aws-cli/index.md
---


# Overview

This section describes how to perform the following operations in {{ ydb-short-name }} using the AWS CLI:

* [Creating](create-table.md) a table.
* [Adding](put-item.md), [reading](get-item.md), and [updating](update-item.md) table data.
* [Executing](query.md) simple queries.

## Before you start {#before-you-begin}

1. [Configure the AWS environment](../aws-setup.md).
1. Prepare the Document API endpoint of the [created database](../../create-db.md).

    {% cut "How to find out the Document API database endpoint" %}

    1. Go to the [management console]({{ link-console-main }}).
    1. Select the folder and go to **{{ ydb-full-name }}**.
    1. Select the database you want to query.
    1. In the menu on the left, go to the **Overview** section.
    1. The endpoint value is in the **Document API endpoint** line.

        Example of an endpoint value:

        ```text
        https://docapi.serverless.yandexcloud.net/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj
        ```

    {% endcut %}

    {% note info %}

    For the Amazon DynamoDB-compatible mode, use a serverless database configuration.

    {% endnote %}
