---
title: Connecting to a {{ SPRK }} cluster
description: Follow this guide to connect to a {{ SPRK }} cluster.
keywords:
  - Connecting to a {{ SPRK }} cluster
---

# Connecting to a cluster {{ SPRK }}

This section presents settings for connection to a {{ msp-full-name }} cluster via [Spark Connect](https://spark.apache.org/docs/3.5.6/spark-connect-overview.html).

## Connecting via Spark Connect {#connection-spark-connect}

1. Create an [IAM token](../../iam/concepts/authorization/iam-token.md) and save it to the environment variable:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

1. [Create a SparkConnect job](jobs-sparkconnect.md#create) without specifying any parameters in your cluster.
1. Copy the Spark Connect Server endpoint of the new connection job.

   You can get the endpoint with the [job information](jobs-sparkconnect.md#get-info). Its value is specified in the **{{ ui-key.yacloud.spark.label_connect-url }}** field in the management console or in the `connect_url` field in the CLI and API.

1. Install the `pyspark` package and [relevant dependencies](https://spark.apache.org/docs/3.5.6/api/python/getting_started/install.html#dependencies) in your environment using the [pip](https://pip.pypa.io/en/stable/) package manager.

   {% note info %}

   Currently, only connection with PySpark `3.5.6` is supported.

   {% endnote %}

1. Run the code for connection to the cluster:

   ```python
   import os
   from pyspark.sql import SparkSession

   url_spark = "<cluster_connecton_endpoint>"
   TOKEN = os.environ.get("TOKEN")

   spark = SparkSession.builder.remote(f"{url_spark}/;use_ssl=true;token={TOKEN}").getOrCreate()
   df = spark.createDataFrame([(1, "Sarah"), (2, "Maria")]).toDF(*["id", "name"])
   df.show()
   ```

   Result:

   ```text
   +---+-----+
   | id| name|
   +---+-----+
   |  1|Sarah|
   |  2|Maria|
   +---+-----+
   ```
