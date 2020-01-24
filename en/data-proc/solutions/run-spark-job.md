# Launching and managing applications for Spark and PySpark

By following this tutorial, you'll be able to calculate statistics on 2018 US air traffic based on data from [transtats.bts.gov](https://transtats.bts.gov/). The data set is prepared in [Parquet](https://parquet.apache.org/) format in a public {{ objstorage-full-name }} bucket named `yc-mdb-examples`.

To work with {{ objstorage-name }}, we recommend [setting up S3cmd](../../storage/instruments/s3cmd.md).

You can get a list of files using the command:

```bash
$ s3cmd ls s3://yc-mdb-examples/dataproc/example01/set01/

2019-09-13 17:17  19327838   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_1.parquet
2019-09-13 17:17  21120204   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_10.parquet
...
```

{% note info %}

Before you begin setting up access to Yandex.Cloud services and internet resources, make sure that the cluster network is [configured properly](./configure-network.md).

{% endnote %}

To run Spark applications in {{ dataproc-name }} clusters, you can use:

1. Spark Shell (a command shell for Scala and Python programming languages). Learn more in the [Spark documentation](https://spark.apache.org/docs/latest/quick-start).
1. The `spark-submit` script. You can find a detailed description of this method in the [Spark documentation](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications).

## Using Spark Shell {#spark-shell}

1. Run Spark Shell on the master host:

   ```bash
   pyspark
   ```

   The number of cores and executors is only limited by your {{ dataproc-name }} configuration.

1. Enter the following code line by line:

   ```python
   sc._jsc.hadoopConfiguration().set("spark.hadoop.fs.s3a.endpoint", "storage.yandexcloud.net")
   sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider")
   sql = SQLContext(sc)
   df = sql.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
   ```

   The last line reads the data from the public bucket containing the sample data set. After this line is executed, an organized data set `df` (DataFrame) containing the data read becomes available for the current session.

1. To see the schema of the resulting DataFrame, run the command:

   ```
   df.printSchema()
   ```

   The terminal displays a list of columns with their types.

1. Calculate flight statistics by month and find the top ten cities by the number of departures:

   * Number of flights by month:

     ```python
     df.groupBy("Month").count().orderBy("Month").show()
     ```

   * Top ten cities by number of departures:

     ```
     df.groupBy("OriginCityName").count().orderBy("count", ascending=False).show(10)
     ```

## Using Spark Submit {#spark-submit}

Spark Submit lets you run pre-written applications using the `spark-submit` script. As an example, let's take an application for calculating the number of flights by month.

{% list tabs %}

- PySpark Submit

  1. On the master host, create the file `month_stat.py` with the following code:

    ```python
    import sys
    
    from pyspark import SparkContext, SparkConf
    from pyspark.sql import SQLContext
    
    def main():
          conf = SparkConf().setAppName("Month Stat - Python")
          conf.set("spark.hadoop.fs.s3a.endpoint", "storage.yandexcloud.net")
          conf.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider")
          sc = SparkContext(conf=conf)
    
          sql = SQLContext(sc)
          df = sql.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
          defaultFS = sc._jsc.hadoopConfiguration().get("fs.defaultFS")
          month_stat = df.groupBy("Month").count()
          month_stat.repartition(1).write.format("csv").save(defaultFS+"/tmp/month_stat")
    
    if __name__ == "__main__":
          main()
    ```

  1. Run the application:

      ```bash
      $ spark-submit month_stat.py
      ```

  1. The result of running the application are exported to HDFS. You can list the resulting files using the command:

      ```bash
      $ hdfs dfs -ls /tmp/month_stat
      ```

- Spark Submit

  This example describes how to build and run an application using the [Scala](https://scala-lang.org) programming language. To build our applications, we use the standard Scala build utility [sbt](https://scala-lang.org/download/).

  To create and launch a Spark application:

  1. Run the `scala-version` command on the host in the MASTERNODE subcluster to learn your Scala version.

     Make sure that the Scala version matches the versions of the libraries deployed in the {{ dataproc-name }} cluster and the libraries used in the application. The default set of libraries can be found in the `/usr/lib/spark/jars` directory on the {{ dataproc-name }} master host.

  1. Create a directory, for example, `spark-app`.

  1. Add a file to the created folder with the path `./src/main/scala/app.scala`.

  1. Copy the following code to the `app.scala` file:

      ```scala
      package com.yandex.cloud.mdb.dataproc.scala
      
      import org.apache.spark.{SparkConf, SparkContext}
      import org.apache.spark.sql.SQLContext
      
        object Main {
          def main(args: Array[String]) {
            val conf = new SparkConf().setAppName("Month Stat - Scala App")
            val sc = new SparkContext(conf)
            sc.hadoopConfiguration.set("spark.hadoop.fs.s3a.endpoint", "storage.yandexcloud.net")
            sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider")
            val sqlContext = new org.apache.spark.sql.SQLContext(sc)
            val df = sqlContext.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
            val month_stat = df.groupBy("Month").count()
            val defaultFS = sc.hadoopConfiguration.get("fs.defaultFS")
            month_stat.repartition(1).write.format("csv").save(defaultFS+"/tmp/month_stat")
      
            sc.stop()
          }
        }
      ```

  1. In the `spark-app` folder, create the file `build.sbt` with the following configuration:

      ```scala
      scalaVersion  := "2.11.6"
      
      libraryDependencies ++= Seq(
          "org.apache.spark" %% "spark-core" % "2.2.3" % "provided",
          "org.apache.spark" %% "spark-sql" % "2.2.3" % "provided"
      )
      ```

     {% note info %}

     The Scala and library versions may change as {{ dataproc-name }} components are updated.

     {% endnote %}

  1. Compile and build your jar file:

      ```bash
      $ sbt complie
      $ sbt pacakge
      ```

  1. Launch the resulting application:

      ```bash
      $ spark-submit --class com.yandex.cloud.mdb.dataproc.scala.Main ./target/scala-2.11/scala-app_2.11-0.1-SNAPSHOT.jar
      ```

  1. The result of running the application are exported to HDFS. You can list the resulting files using the command:

      ```bash
      $ hdfs dfs -ls /tmp/month_stat
      ```

{% endlist%}

## Terminating the application {#yarn-kill}

By default, the resources of the running application are managed by the YARN component. If you need to terminate or remove the application from the queue, use the `yarn` utility:

1. List the applications:

   ```bash
   $ yarn application -list
   ```

1. Terminate the application you no longer need:

   ```bash
   $ yarn application -kill <application_id>
   ```

You can learn more about YARN commands on the [YARN Commands](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YarnCommands.html) page.

