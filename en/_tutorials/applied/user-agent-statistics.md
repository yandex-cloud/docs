# Getting website traffic statistics with S3 Select


Get statistics on queries to objects within a bucket configured to [host a static website](../../storage/concepts/hosting.md). Use the [S3 Select](../../storage/concepts/s3-select-language.md) query language to get data.

{% note info %}

To get information about queries, [enable logging](../../storage/operations/buckets/enable-logging.md#enable) for the bucket with the website content.

{% endnote %}

## Getting started {#before-you-begin}

Install and configure the [AWS CLI](../../storage/tools/aws-cli.md).

## Getting visit statistics {#session-stat}

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Run the query against {{ objstorage-name }} and save the output to a file:

     1. For convenience, save:

        * Name of the bucket storing the object with the logs, to a variable named `$bucket`:

          ```bash
          bucket=<bucket_name>
          ```

        * [Key](../../storage/concepts/object.md#key) of the object containing the logs, to a variable named `$key`:

          ```bash
          key=<object_key>
          ```

        * S3 Select expression to request the data, to a variable named `$query`:

          ```bash
          query="select user_agent from s3object"
          ```

     1. Run this command:

        ```bash
        aws --endpoint https://{{ s3-storage-host }} s3api select-object-content \
          --bucket $bucket \
          --key $key \
          --expression "$query" \
          --expression-type 'SQL' \
          --input-serialization 'JSON={Type=LINES}' \
          --output-serialization 'CSV={}' \
          "output.csv"
        ```

  1. To display the number of requests to the website grouped by browsers and other request clients (by the `user_agent` field), run an aggregation query using the `sort` and `uniq` commands:

     ```bash
     sort output.csv | uniq -c | sort -nr
     ```

     Result:

     ```bash
     418 docker/19.03.9 go/go1.13.10 git-commit/1d238398e7 kernel/4.4.0-142-generic os/linux arch/amd64 UpstreamClient(Go-http-client/1.1)
     255 docker/19.03.13 go/go1.13.15 git-commit/4484c46d9d kernel/3.10.0-1127.19.1.el7 os/linux arch/amd64 UpstreamClient(Go-http-client/1.1)
     101 aws-sdk-java/1.11.424 Linux/4.14.74-28+yc7 OpenJDK_64-Bit_Server_VM/11.0.5-shenandoah+10-adhoc.heretic.src java/11.0.5-shenandoah
     17 aws-cli/1.18.27 Python/2.7.6 Linux/4.19.62-13 botocore/1.17.50
     ```

  1. To display the number of hits for each page:

     1. Update the expression in the `$query` variable:

        ```bash
        query="select object_key from s3object"
        ```

     1. Run this command:

        ```bash
        aws --endpoint https://{{ s3-storage-host }} s3api select-object-content \
          --bucket $bucket \
          --key $key \
          --expression "$query" \
          --expression-type 'SQL' \
          --input-serialization 'JSON={Type=LINES}' \
          --output-serialization 'CSV={}' \
          "output.csv"
        ```

     1. Run the aggregation query:

        ```bash
        sort output.csv | uniq -c | sort -nr
        ```

        Result:

        ```bash
        418 index.html
        255 about.html
        101 images/logo.png
        17 css/style.css
        ```

{% endlist %}
