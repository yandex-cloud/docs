* Save the file to a {{ objstorage-full-name }} bucket and provide the file's URL in the `spark:spark.jars` property.

   The file's URL has the following format: `s3a://<bucket_name>/<file_path>`.

   This bucket must be specified in the cluster settings. Make sure the cluster service account has read access to the bucket.

* Copy the file to all the cluster nodes manually or using [initialization scripts](../../data-proc/concepts/init-action.md) and provide the full file path in the `spark:spark.driver.extraClassPath` and `spark:spark.executor.extraClassPath` properties.
