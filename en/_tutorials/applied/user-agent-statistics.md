# Getting website traffic statistics using S3 Select


Get the query statistics for objects within a bucket configured to [host a static website](../../storage/concepts/hosting.md). The data will be retrieved using the [S3 Select](../../storage/concepts/s3-select-language.md) query language.

{% note info %}

To get information about requests, [enable logging](../../storage/operations/buckets/enable-logging.md#enable) for the bucket with the website content.

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

  1. To display the number of hits for each page, run an aggregation query using the `sort` and `uniq` commands:

     ```bash
     sort -nr output.csv | uniq -c
     ```

     Result:

     ```bash
     418 docker/19.03.9 go/go1.13.10 git-commit/1d238398e7 kernel/4.4.0-142-generic os/linux arch/amd64 UpstreamClient(Go-http-client/1.1)
     255 docker/19.03.13 go/go1.13.15 git-commit/4484c46d9d kernel/3.10.0-1127.19.1.el7 os/linux arch/amd64 UpstreamClient(Go-http-client/1.1)
     101 aws-sdk-java/1.11.424 Linux/4.14.74-28+yc7 OpenJDK_64-Bit_Server_VM/11.0.5-shenandoah+10-adhoc.heretic.src java/11.0.5-shenandoah
     17 aws-cli/1.18.27 Python/2.7.6 Linux/4.19.62-13 botocore/1.17.50
     ```

{% endlist %}
