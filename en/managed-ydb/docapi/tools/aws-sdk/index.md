---
sourcePath: overlay/quickstart/document-api/aws-sdk/index.md
---

# Overview

This section describes how to use the AWS SDK for several programming languages to write simple programs that perform the following operations in YDB:

* [Creating](create-table.md) tables and [loading](load-data.md) JSON data in the table.
* Managing records in a table: [adding](create-item.md), [reading](read-item.md), [updating](update-item.md), and [deleting](delete-item.md) data.
* [Searching and extracting](query-and-scan.md) data.
* [Deleting](delete-table.md) a table.

## Before you begin {#before-you-begin}

1. [Configure the AWS environment](../aws-setup.md).
1. Prepare the Document API endpoint of the [created database](../../../operations/manage-database.md#create-db).

   {% cut "How do I find out the Document API endpoint of a database?" %}

   1. Go to the [management console]({{ link-console-main }}).
   1. Select the desired folder and go to **{{ ydb-full-name }}**.
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

## Environment setup {#environment-set}

Configure the environment for your programming language:

{% list tabs %}

- Java

   The examples in the section on building Java applications are based on [Apache Maven](https://maven.apache.org/).

  For more information about the AWS SDK for Java, see the [AWS documentation]{% if lang == "en" %}(https://aws.amazon.com/sdk-for-java/){% endif %}{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-java/){% endif %}.

- Python

   1. [Install](https://www.python.org/downloads/) Python 3.6 or higher.
   1. Install the Boto3 library:

      ```bash
      pip install boto3
      ```

      For more information about the AWS SDK for Python (Boto), see the [AWS documentation](https://aws.amazon.com/sdk-for-python/).

- PHP

   1. Install [PHP](https://www.php.net/).
   1. Configure the [AWS SDK for PHP](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html).

   For more information about the AWS SDK for PHP, see the [AWS documentation]{% if lang == "en" %}(https://aws.amazon.com/sdk-for-php/){% endif %}{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-php/){% endif %}.

- Node.js

   1. Install [Node.js](https://nodejs.org/ru/).
   1. Install [AWS SDK for Node.js](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/installing-jssdk.html).

   For more information about the AWS SDK for Node.js, see the [documentation]{% if lang == "en" %}(https://aws.amazon.com/sdk-for-node-js/){% endif %}{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-node-js/){% endif %}..

- Ruby

   1. Install [Ruby](https://www.ruby-lang.org/ru/documentation/installation/).
   1. Install [AWS SDK for Ruby](https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/setup-install.html).

   For more information about the AWS SDK for Ruby, see the [documentation]{% if lang == "en" %}(https://aws.amazon.com/sdk-for-ruby/){% endif %}{% if lang == "ru" %}(https://aws.amazon.com/ru/sdk-for-ruby/){% endif %}.

{% endlist %}
