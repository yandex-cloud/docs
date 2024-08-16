---
title: "Working with the AWS SDK. Overview"
description: "This section describes how to use the AWS SDK to write simple programs that perform the following operations in YDB. Examples are given for several programming languages."
sourcePath: overlay/quickstart/document-api/aws-sdk/index.md
---

# Working with the AWS SDK in {{ ydb-name }}. Overview

This section describes how to use the AWS SDK for several programming languages to write simple programs that perform the following operations in {{ ydb-short-name }}:
* [Creating](create-table.md) tables and [loading](load-data.md) JSON data in the table.
* Managing records in a table: [adding](create-item.md), [reading](read-item.md), [updating](update-item.md), and [deleting](delete-item.md) data.
* [Searching and extracting](query-and-scan.md) data.
* [Deleting](delete-table.md) a table.

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

## Environment setup {#environment-set}

Configure the environment for your programming language:

{% list tabs group=programming_language %}

- Java {#java}

   The examples in the section on building Java applications are based on [Apache Maven](https://maven.apache.org/).

   To learn more about the AWS SDK for Java, see the [AWS documentation](https://aws.amazon.com/sdk-for-java/).

- Python {#python}

   1. [Install](https://www.python.org/downloads/) Python 3.8 or higher.
   1. Install the Boto3 library:

      ```bash
      pip install boto3
      ```

      For more information about the AWS SDK for Python (Boto), see the [AWS documentation](https://aws.amazon.com/sdk-for-python/).

- PHP {#php}

   1. Install [PHP](https://www.php.net/).
   1. Configure the [AWS SDK for PHP](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html).

   To learn more about the AWS SDK for PHP, see the [AWS documentation](https://aws.amazon.com/sdk-for-php/).

- Node.js {#node}

   1. Install [Node.js](https://nodejs.org/).
   1. Install [AWS SDK for Node.js](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html).

   To learn more about the AWS SDK for Node.js, see the [documentation](https://aws.amazon.com/sdk-for-node-js/).

- Ruby {#ruby}

   1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/).
   1. Install [AWS SDK for Ruby](https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/setup-install.html).

   To learn more about the AWS SDK for Ruby, see the [documentation](https://aws.amazon.com/sdk-for-ruby/).

{% endlist %}