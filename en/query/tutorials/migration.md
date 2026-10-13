---
title: Migrating from {{ yq-full-name }}
description: This tutorial describes how to migrate from {{ yq-full-name }} to {{ ydb-full-name }} or how to work directly with {{ objstorage-name }}.
---

# Migrating from {{ yq-full-name }}

{% note warning %}

Starting October 13, 2026, {{ yq-full-name }} will be unavailable to new users.

Current users will be able to create and modify entities until November 10, 2026. Afterwards, {{ yq-full-name }} will go read-only and cease to operate on December 14, 2026. For more information on how it will be handled, see [{#T}](../sunset.md).

{% endnote %}

Once {{ yq-full-name }} is discontinued, you will be able to work with your data in one of the following ways:

* **Direct reading from {{ objstorage-name }}**. Read data from the bucket using S3-compatible utilities, libraries, or your application.
* **{{ ydb-full-name }}**. Run federated queries against files in {{ objstorage-name }} using external data sources and external tables. You can write the results to the output bucket.

{% note warning %}

Connections, data bindings, and {{ yq-full-name }} queries are not automatically migrated. You will need to recreate them by following the steps below. The {{ yq-full-name }} discontinuation does not affect the data in the {{ objstorage-name }} buckets.

This guide describes the migration of analytical queries. There is no direct equivalent in {{ yandex-cloud }} for {{ yq-full-name }} streaming queries.

{% endnote %}

## How to choose your target environment {#choice}

This section provides a brief comparison of methods for handling data once {{ yq-full-name }} is no longer available.

#|
|| **Scenario** | **How you use {{ yq-full-name }}** ||
|| [Direct reading from {{ objstorage-name }}](#direct-read) | You read files, such as usage details in CSV format, and process them within your application. ||
|| [Federated queries in {{ ydb-full-name }}](#ydb-federated) | You regularly run analytical queries against files in a bucket, store query text in your code, or use data bindings. ||
|| [Column-oriented tables in {{ ydb-full-name }}](#ydb-column-tables) | You are building frequently updated dashboards or repeatedly reading the same data. ||
|#

Choose direct reading from {{ objstorage-name }} if:

* Data processing is already implemented in your application.
* Queries are simple and do not require SQL.
* You read files rarely or only once.

Choose federated queries in {{ ydb-full-name }} if:

* Data must remain in the bucket.
* You want to retain SQL queries and the familiar model of working with external data.
* Same files are not read repeatedly.

Choose column-oriented tables in {{ ydb-full-name }} if:

* Same data is used in recurring queries or dashboards.
* Speed of repetitive analytical queries is important.
* You are ready to load data from the bucket into the database.

{% note tip %}

If you used {{ yq-full-name }} for SQL queries against files in {{ objstorage-name }}, start with federated queries in {{ ydb-full-name }}. This option requires fewer changes to queries and does not require moving the source data out of the bucket.

{% endnote %}

The pricing structure is different for {{ yq-full-name }} and {{ ydb-full-name }}. In {{ yq-full-name }}, you pay for the amount of data read by queries. When reading directly from {{ objstorage-name }}, operations and outbound traffic are charged. In {{ ydb-full-name }}, dedicated computing resources and database storage are charged independently of the number of requests. For more details on resource costs, see the [{{ objstorage-name }} pricing policy](../../storage/pricing.md) and [{{ ydb-full-name }} pricing policy](../../ydb/pricing/index.md).

## Direct reading from {{ objstorage-name }} {#direct-read}

This scenario is suitable if you perform all required data processing on your end.

### Getting started {#direct-read-before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) to perform read operations.

1. Assign the [`storage.viewer`](../../storage/security/index.md#storage-viewer) role to the service account for the bucket or the folder containing it.

1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account.

   Save `key_id` and `secret`: you will not see the secret key again.

### Read the data {#direct-read-query}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. [Configure the AWS CLI](../../storage/tools/aws-cli.md) with the service account key.

  1. View the list of files:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 ls s3://<bucket_name>/<prefix>/
     ```

  1. Download the files:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 cp s3://<bucket_name>/<prefix>/ ./data/ --recursive
     ```

- Python {#python}

  This example reads CSV files with a specified prefix and calculates the sum for a column, just as the `SELECT service_name, SUM(cost) ... GROUP BY service_name` query would in {{ yq-full-name }}. Check the column names against the headers of your files.

  ```python
  import boto3
  import pandas as pd

  s3 = boto3.client(
      "s3",
      endpoint_url="https://{{ s3-storage-host }}",
      aws_access_key_id="<key_ID>",
      aws_secret_access_key="<secret_key>",
  )

  frames = []
  paginator = s3.get_paginator("list_objects_v2")
  for page in paginator.paginate(Bucket="<bucket_name>", Prefix="<prefix>/"):
      for obj in page.get("Contents", []):
          if obj["Key"].endswith(".csv"):
              body = s3.get_object(Bucket="<bucket_name>", Key=obj["Key"])["Body"]
              frames.append(pd.read_csv(body))

  df = pd.concat(frames)
  print(df.groupby("service_name")["cost"].sum().sort_values(ascending=False))
  ```

{% endlist %}

## {{ ydb-full-name }} {#ydb}

### Entity mapping {#ydb-mapping}

#|
|| **{{ yq-full-name }}** | **{{ ydb-full-name }}** ||
|| Connections to {{ objstorage-name }} | `CREATE EXTERNAL DATA SOURCE` ([external data source](https://ydb.tech/docs/en/concepts/datamodel/external_data_source)) with `SOURCE_TYPE = "ObjectStorage"` ||
|| Data binding | `CREATE EXTERNAL TABLE` ([external table](../../managed-greenplum/concepts/external-tables.md)) ||
|| Accessing a binding: `bindings.<binding_name>` | Accessing an external table by name: `<table_name>` ||
|| Authentication via service account | Static access key of the service account stored in the database [secrets](https://ydb.tech/docs/en/concepts/datamodel/secrets) ||
|| Reading files by mask, partitioning (`partition projection`) | Supported with the same syntax ||
|| Formats: `csv_with_names`, `tsv_with_names`, `json_each_row`, `json_list`, `json_as_string`, `parquet`, `raw` | Supported ||
|| Writing the result to a bucket: `INSERT INTO <connection>.<path>` | Supported with the same syntax ||
|| Connections with {{ mpg-name }}, {{ mch-name }}, {{ mmy-name }}, and {{ mgp-name }} | [Federated queries](https://ydb.tech/docs/en/concepts/query_execution/federated_query/) to external databases ||
|| Streaming queries to {{ yds-full-name }} | No similar option ||
|| Connections to {{ monitoring-name }} | No similar option ||
|| Saved queries | Store query texts in your repository ||
|#

### Getting started {#ydb-before-you-begin}

1. [Create](../../ydb/operations/manage-databases.md#create-db-dedicated) a {{ ydb-full-name }} database with dedicated resources in the same cloud where the data buckets are located.

   {% note info %}

   External data sources are available only in databases with dedicated resources. In a serverless database, a query to an external source will fail with the `External data sources are disabled` error.

   {% endnote %}

1. Assign the [`ydb.editor`](../../ydb/security/index.md#ydb-editor) role for the database to the user who will be migrating the queries.

1. Create a service account and static access key, as described in [this section](#direct-read-before-you-begin). If your queries write results to a bucket, additionally assign the [`storage.uploader`](../../storage/security/index.md#storage-uploader) role to the service account.

1. Save the query texts, as well as connection and binding settings from {{ yq-full-name }}; this includes names, bucket paths, format, compression, schema, and partitioning settings.

### Federated queries: reading files from {{ objstorage-name }} {#ydb-federated}

This scenario mirrors the operation of {{ yq-full-name }}: the data remains in the bucket, while the database reads it with every query.

#### Create an external data source {#ydb-data-source}

1. Store the static key in the database secrets:

   ```yql
   CREATE SECRET s3_key_id WITH (value = "<key_ID>");
   CREATE SECRET s3_secret_key WITH (value = "<secret_key>");
   ```

1. Create an external data source. To avoid changing the query text, give it the same name as the connection in {{ yq-full-name }}:

   ```yql
   CREATE EXTERNAL DATA SOURCE <connection_name> WITH (
       SOURCE_TYPE = "ObjectStorage",
       LOCATION = "https://{{ s3-storage-host }}/<bucket_name>/",
       AUTH_METHOD = "AWS",
       AWS_ACCESS_KEY_ID_SECRET_PATH = "s3_key_id",
       AWS_SECRET_ACCESS_KEY_SECRET_PATH = "s3_secret_key",
       AWS_REGION = "{{ region-id }}"
   );
   ```

   Secrets are not required for a public bucket: specify `AUTH_METHOD = "NONE"` and do not specify the `AWS_*` parameters.

1. Check whether the database can successfully read the bucket:

   ```yql
   SELECT *
   FROM <connection_name>.`<path>/`
   WITH (
       FORMAT = "csv_with_names",
       WITH_INFER = "true"
   )
   LIMIT 10;
   ```

#### Migrate data bindings {#ydb-bindings}

For each binding, create an external table with the same columns, format, and compression:

```yql
CREATE EXTERNAL TABLE <binding_name> (
    date Date NOT NULL,
    service_name Utf8,
    cost Double
) WITH (
    DATA_SOURCE = "<connection_name>",
    LOCATION = "<path>/",
    FORMAT = "csv_with_names",
    COMPRESSION = "gzip"
);
```

If partitioning or `partition projection` is configured in the binding, copy the `PARTITIONED_BY` and `projection.*` settings without changing them.

#### Migrate queries {#ydb-queries}

Queries to connections are migrated unchanged if the external source name matches the connection name. Remove the `bindings.` prefix from binding requests:

{% list tabs %}

- {{ yq-full-name }}

  ```yql
  SELECT service_name, SUM(cost) AS total
  FROM bindings.`billing`
  WHERE date >= Date("2026-09-01")
  GROUP BY service_name
  ORDER BY total DESC;
  ```

- {{ ydb-full-name }}

  ```yql
  SELECT service_name, SUM(cost) AS total
  FROM billing
  WHERE date >= Date("2026-09-01")
  GROUP BY service_name
  ORDER BY total DESC;
  ```

{% endlist %}

You can run requests in the management console, or using the [YDB CLI](https://ydb.tech/docs/en/reference/ydb-cli/) or [SDK](https://ydb.tech/docs/en/reference/ydb-sdk/). For example, to save the result to a CSV file, run:

```bash
ydb \
  --endpoint <database_endpoint> \
  --database <path_to_database> \
  sql -s 'SELECT service_name, SUM(cost) AS total FROM billing GROUP BY service_name' \
  --format csv > result.csv
```

#### Consider performance {#ydb-performance}

The speed of a federated query is limited by the network throughput of the database nodes during reads from {{ objstorage-name }}. {{ yq-full-name }} distributed reads across a shared pool of nodes; consequently, the same query may take longer to run in a database with a small number of nodes. If speed is important, increase the number of database nodes or move your data to [column-oriented tables](#ydb-column-tables).

### Column-oriented tables: loading data into the database {#ydb-column-tables}

If the same files are read repeatedly, e.g., by an auto-refreshing dashboard, upload them into a column-oriented table. Queries to the column-oriented table do not read the bucket again.

1. Create a column-oriented table:

   ```yql
   CREATE TABLE billing_data (
       date Date NOT NULL,
       resource_id Utf8 NOT NULL,
       service_name Utf8,
       cost Double,
       PRIMARY KEY (date, resource_id)
   )
   PARTITION BY HASH(date, resource_id)
   WITH (STORE = COLUMN);
   ```

1. Load data from the external table:

   ```yql
   INSERT INTO billing_data
   SELECT date, resource_id, service_name, cost
   FROM billing;
   ```

1. To load additional files, run the same query on a schedule with a filter based on date or path, e.g., from a [{{ sf-name }} function with a timer trigger](../../functions/operations/trigger/timer-create.md).

1. Switch queries and dashboards from the external table to `billing_data`.

### Database connections {#ydb-databases}

Connections with {{ yq-full-name }}, {{ mpg-name }}, {{ mch-name }}, {{ mmy-name }}, and {{ mgp-name }} are migrated to external data sources of the appropriate type. The syntax of `SELECT * FROM<source>.<table>` queries does not change. For more information on connection settings, see [Federated queries](https://ydb.tech/docs/en/concepts/query_execution/federated_query/).

## Check the result {#check}

1. Run each migrated query against the same files both in {{ yq-full-name }} and in the environment you migrated to.

1. Compare the number of rows and the checksums by the key columns:

   ```yql
   SELECT COUNT(*) AS rows, SUM(cost) AS total_cost
   FROM billing
   WHERE date BETWEEN Date("2026-09-01") AND Date("2026-09-30");
   ```

1. Switch the dashboards, schedules, and applications that accessed {{ yq-full-name }} to your new environment.

## If something went wrong {#troubleshooting}

#|
|| **Error or symptom** | **What to check** ||
|| `External data sources are disabled` | The database was created in serverless mode. Create a database with dedicated resources. ||
|| `Access Denied` when reading the bucket | The `storage.viewer` role assigned to a service account, the key values ​​in the secrets, and the `LOCATION` value (which must end with `/`). ||
|| Data parsing error | Column types and requirements in the schema. If the file does not contain a column with `NOT NULL`, the request will fail. ||
|| The request is taking longer to complete than in {{ yq-full-name }} | Number of database nodes. Use [column-oriented tables](#ydb-column-tables) for recurring queries. ||
|#

If you were unable to resolve your issue, contact [support](../../support/overview.md) and provide the following:

* Database ID.
* Query text and error text.
* Error time and query ID, if there is one in the output.
