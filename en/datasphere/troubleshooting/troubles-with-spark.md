# Errors when using a Spark connector

When using Spark, a hidden directory named `.spark/` is created in the project storage, and that directory contains service information about all Spark connectors available in the project. To see hidden files and directories, in the panel at the top of the {{ jlab }}Lab interface, click **View** ⟶ **Show Hidden Files**.

A Spark session is created before the start of the first notebook cell and can be accessed via the `spark` variable. If an error occurs during session creation, the `spark` variable will not be available, and an error report will appear in a file named `.spark/connector/<connector_ID>/session_creation_err_<error_time>.txt`. Attach this file when you contact [technical support]({{ link-console-support }}).

## Error writing data to S3 {#s3-load-data}

If a `Could not find any valid local directory for s3ablock-0001` error occurs when writing data to S3, add one of the following parameters in the Spark connector settings under **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}**:

Parameter | Description
---|---
`spark.hadoop.fs.s3a.fast.upload.buffer` = `bytebuffer` | Fast file upload using RAM. The file size must not exceed the available RAM size.
`spark.hadoop.fs.s3a.buffer.dir` = `/tmp` | Standard upload to disk
