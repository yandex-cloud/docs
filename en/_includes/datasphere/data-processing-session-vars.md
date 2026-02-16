{{ ml-platform-name }} uses system variables to run {{ dataproc-name }} clusters. Do not override the values of the following variables:
* `sc`
* `spark`
* `HiveContext`
* `StreamingContext`
* `SqlContext`

The parameters required to run Livy jobs override the following global Spark configurations:
* `spark.jars`
* `spark.submit.deployMode`
* `spark.yarn.dist.archives`
* `spark.submit.pyFiles`
* `spark.yarn.maxAppAttempts`
* `spark.yarn.submit.waitAppCompletion`

To specify additional libraries for a Spark session, use the `spark.driver.extraClassPath` and `spark.executor.extraClassPath` parameters and place the libraries on all the nodes when creating a {{ dataproc-name }} cluster with initialization scripts. Make sure the paths to the libraries you use are the same on all cluster nodes.