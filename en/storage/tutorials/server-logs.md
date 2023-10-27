# Number of object queries

Get the query statistics for {{ objstorage-name }} objects using the [S3 Select](../concepts/s3-select-language.md) query language.

{% note info %}

To get information on object queries, [enable logging](../operations/buckets/enable-logging.md#enable).

{% endnote %}

## Getting started {#before-you-begin}

1. Install and configure the [AWS CLI](../tools/aws-cli.md).
1. Download and install the [jq](https://stedolan.github.io/jq/download/) utility.

## Getting query statistics {#request-stat}

{% list tabs %}

- Bash

   1. Run the query against {{ objstorage-name }} and save the output to a file:

      1. For convenience, save:

         * Name of the bucket storing the object with the logs, to a variable named `$bucket`:

            ```bash
            bucket=<bucket_name>
            ```

         * [Key](../concepts/object.md#key) of the object containing the logs, to a variable named `$key`:

            ```bash
            key=<object_key>
            ```

         * S3 Select expression to select object data, to a variable named `$query`:

            ```bash
            query='<query_expression>'
            ```

            Sample expressions:

            * Retrieving queries by response code:

               ```sql
               SELECT "timestamp", request_id, handler, object_key, status, request_time
               FROM S3Object
               WHERE status >= 400
               ```

            * Searching for long-running queries:

               ```sql
               SELECT "timestamp", request_id, handler, object_key, status, request_time
               FROM S3Object
               WHERE request_time >= 1000
               ```

            * Average time for processing queries (using [aggregate functions](../concepts/s3-select-language.md#aggregate-functions) `AVG`):

               ```sql
               SELECT AVG(request_time) AS "avg" FROM S3Object
               ```

      1. Run this command:

         ```bash
         aws --endpoint https://{{ s3-storage-host }} s3api select-object-content \
           --bucket $bucket \
           --key $key \
           --expression "$query" \
           --expression-type 'SQL' \
           --input-serialization 'JSON={Type=LINES}' \
           --output-serialization 'JSON={}' \
           "output.json"
         ```

   1. If a query uses no aggregate functions, output the number of queries for each object key. To do this, run an aggregation query using the `jq` utility:

      ```bash
      jq .object_key output.json | uniq -c | sort -nr
      ```

      Result:

      ```bash
      9 "path/logs/2021-02-10-22-02-25-199f57b5-5601-3210-5d9a-1apl1e5z6b4f"
      7 "path/logs/2021-01-28-11-40-11-580g57b5-9903-1108-6a7a-1ghj1e0e8b0f"
      3 "path/logs/2020-12-09-10-05-31-123f57b5-1853-4120-8d7a-5bcc1e9e9b4f"
      1 "path/logs/2020-12-09-08-11-10-123f57b5-1773-9310-1d2a-5bcc1e9e9b4f"
      1 "path/logs/2020-12-01-14-42-11-493f57b5-1093-4120-8d7a-5bcc1e9e9b4f"
      ```

{% endlist %}
