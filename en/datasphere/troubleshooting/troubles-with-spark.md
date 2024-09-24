# Errors when using a Spark connector

When using Spark, a hidden directory named `.spark/` is created in the project storage, and that directory contains service information about all Spark connectors available in the project. To see hidden files and directories, in the panel at the top of the {{ jlab }}Lab interface, click **View** ⟶ **Show Hidden Files**.

A Spark session is created before the start of the first notebook cell and can be accessed via the `spark` variable. If an error occurs during session creation, the `spark` variable will not be available, and an error report will appear in a file named `.spark/connector/<connector_ID>/session_creation_err_<error_time>.txt`. Attach this file when you contact [technical support]({{ link-console-support }}).
