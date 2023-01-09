---
title: "Apache Spark and PySpark. Starting and managing applications"
keywords:
  - apache spark
  - spark
  - PySpark
---

# Launching and managing applications for Spark and PySpark

To run Spark applications in {{ dataproc-name }} clusters, [prepare data](#prepare-data) to process and then select the desired launch option:

* [Spark Shell](#spark-shell) (a command shell for Scala and Python programming languages). Read more about it in the [Spark documentation](https://spark.apache.org/docs/latest/quick-start).
* [The spark-submit script](#spark-submit). For more information, see the [Spark documentation](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications).
* [{{ yandex-cloud }} CLI commands](#run-cli-jobs).

## Preparing data {#prepare-data}

By following this tutorial, you'll calculate statistics on 2018 US air traffic based on data from [transtats.bts.gov](https://transtats.bts.gov/). The data set is prepared in [Parquet](https://parquet.apache.org/) format in a public {{ objstorage-full-name }} bucket named `yc-mdb-examples`.

To work with {{ objstorage-name }}, we recommend [setting up S3cmd](../../storage/tools/s3cmd.md).

You can get a list of files using the command:

```bash
s3cmd ls s3://yc-mdb-examples/dataproc/example01/set01/
```

Result:

```text
2019-09-13 17:17  19327838   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_1.parquet
2019-09-13 17:17  21120204   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_10.parquet
...
```

{% note info %}

Before you begin setting up access to {{ yandex-cloud }} services and internet resources, make sure that the cluster network is [configured properly](./configure-network.md).

{% endnote %}

## Using Spark Shell {#spark-shell}

1. Run Spark Shell on the master host:

   ```bash
   /usr/bin/pyspark
   ```

   The number of cores and executors is only limited by your {{ dataproc-name }} configuration.

1. Enter the following code line by line:

   ```python
   sql = SQLContext(sc)
   df = sql.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
   ```

   The last line reads the data from the public bucket containing the sample data set. After this line is executed, an organized data set `df` (DataFrame) containing the data read becomes available for the current session.

1. To see the schema of the resulting DataFrame, run the command:

   ```python
   df.printSchema()
   ```

   The terminal displays a list of columns with their types.

1. Calculate flight statistics by month and find the top ten cities by the number of departures:

   * Number of flights by month:

      ```python
      df.groupBy("Month").count().orderBy("Month").show()
      ```

   * Top ten cities by number of departures:

      ```python
      df.groupBy("OriginCityName").count().orderBy("count", ascending=False).show(10)
      ```

## Using Spark Submit {#spark-submit}

Spark Submit lets you run pre-written applications using the `spark-submit` script. As an example, let's take an application for calculating the number of flights by month.

{% list tabs %}

- PySpark Submit

   1. On the master host, create a file named `month_stat.py` with the following code:

      ```python
      import sys

      from pyspark import SparkContext, SparkConf
      from pyspark.sql import SQLContext

      def main():
          conf = SparkConf().setAppName("Month Stat - Python")
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
      /usr/bin/spark-submit month_stat.py
      ```
   1. The result of running the application is exported to HDFS. You can list the resulting files using the command:

      ```bash
      hdfs dfs -ls /tmp/month_stat
      ```

- Spark Submit

   This example describes how to build and run an application using the [Scala](https://scala-lang.org) programming language. To build our applications, we use the standard Scala build utility [sbt](https://scala-lang.org/download/).

   To create and launch a Spark application:
   1. Run the `scala-version` command on the master host to find out your Scala version.

      Make sure that the Scala version matches the versions of the libraries deployed in the {{ dataproc-name }} cluster and the libraries used in the application. The default set of libraries can be found in the `/usr/lib/spark/jars` folder on the {{ dataproc-name }} master host.
   1. Create a folder, such as `spark-app`.
   1. Add a file to the created folder with the path `./src/main/scala/app.scala`.
   1. Copy the following code to the `app.scala` file:

      ```scala
      package com.yandex.cloud.dataproc.scala

      import org.apache.spark.{SparkConf, SparkContext}
      import org.apache.spark.sql.SQLContext

        object Main {
          def main(args: Array[String]) {
            val conf = new SparkConf().setAppName("Month Stat - Scala App")
            val sc = new SparkContext(conf)
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

   1. In the `spark-app` folder, create a file named `build.sbt` with the following configuration:

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
      sbt compile && sbt package
      ```

   1. Launch the resulting application:

      ```bash
      /usr/bin/spark-submit \
          --class com.yandex.cloud.dataproc.scala.Main \
              ./target/scala-2.11/scala-app_2.11-0.1-SNAPSHOT.jar
      ```

   1. The result of running the application is exported to HDFS. You can list the resulting files using the command:

      ```bash
      hdfs dfs -ls /tmp/month_stat
      ```

{% endlist %}


## Terminating the application {#yarn-kill}

By default, the resources of the running application are managed by the YARN component. If you need to terminate or remove the application from the queue, use the `yarn` utility:

1. List the applications:

   ```bash
   yarn application -list
   ```
1. Terminate the application you no longer need:

   ```bash
   yarn application -kill <application_id>
   ```

For more information about YARN commands, see [YARN Commands](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YarnCommands.html).

## Running jobs using the {{ yandex-cloud }} CLI {#run-cli-jobs}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../_includes/data-proc/cli-job-intro.md) %}

The application saves the calculation result either using the HDFS component in the {{ dataproc-name }} cluster or to the {{ objstorage-name }} bucket you specified.

The service and debugging information is saved to the {{ objstorage-name }} bucket that you specified when creating the {{ dataproc-name }} cluster. For each job, the {{ dataproc-name }} agent creates a separate folder with a path in the format `dataproc/clusters/<cluster ID>/jobs/<job ID>`. Before the initial run, assign bucket `WRITE` rights to the service account that jobs will be run under.

Below are two application versions, one for Scala and one for Python.

### Running a Spark Job {#cli-scala}

Basic steps:

1. Build a Scala application to a single JAR file using [SBT](https://www.scala-sbt.org/index.html).
2. Upload the JAR file to the {{ objstorage-name }} bucket that the cluster service account has access to.
3. Run the job in the {{ dataproc-name }} cluster.

#### Build a Scala application {#scala-build}

To simplify dependency management, build the application to a single JAR file (fat JAR) using the [sbt-assembly](https://github.com/sbt/sbt-assembly) plugin.

You can get the required Scala version by running the `scala-version` command on the master host. In this example, we use version `2.11.12`. For Spark applications, we recommend making sure that the Scala version matches the versions of the libraries deployed in the {{ dataproc-name }} cluster. You can find the default set of libraries in the `/usr/lib/spark/jars` folder.

Application structure:

```text
spark-app
|-project
|  |-plugins.sbt
|-src
|  |-main
|    |-scala
|      |-app.scala
|-build.sbt
```

To build an app:

1. Create a folder named `spark-app` with the `project` and `src/main/scala` subdirectories.
1. Create a file named `project/plugins.sbt` that describes the connection of the `sbt-assembly` plugin to assemble a single JAR file:

   ```scala
   addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.6")
   ```

1. Create a file named `build.sbt` with a description of the Scala version, dependencies, and their merging strategy in a single JAR file:

   ```scala
   scalaVersion  := "2.11.12"

   libraryDependencies ++= Seq(
       "org.apache.spark" %% "spark-core" % "2.4.4",
       "org.apache.spark" %% "spark-sql" % "2.4.4",

   )

   assemblyMergeStrategy in assembly := {
     case PathList("org","aopalliance", xs @ _*) => MergeStrategy.last
     case PathList("javax", "inject", xs @ _*) => MergeStrategy.last
     case PathList("javax", "servlet", xs @ _*) => MergeStrategy.last
     case PathList("javax", "activation", xs @ _*) => MergeStrategy.last
     case PathList("org", "apache", xs @ _*) => MergeStrategy.last
     case PathList("com", "google", xs @ _*) => MergeStrategy.last
     case PathList("com", "esotericsoftware", xs @ _*) => MergeStrategy.last
     case PathList("com", "codahale", xs @ _*) => MergeStrategy.last
     case PathList("com", "yammer", xs @ _*) => MergeStrategy.last
     case "about.html" => MergeStrategy.rename
     case "overview.html" => MergeStrategy.last
     case "META-INF/ECLIPSEF.RSA" => MergeStrategy.last
     case "META-INF/mailcap" => MergeStrategy.last
     case "META-INF/mimetypes.default" => MergeStrategy.last
     case "plugin.properties" => MergeStrategy.last
     case "log4j.properties" => MergeStrategy.last
     case x =>
       val oldStrategy = (assemblyMergeStrategy in assembly).value
       oldStrategy(x)
   }
   ```
1. Create a file named `src/main/scalaapp.scala` with the application code:

   ```scala
   package com.yandex.cloud.dataproc.scala

   import org.apache.spark.{SparkConf, SparkContext}
   import org.apache.spark.sql.SQLContext

     object Main {
       def main(args: Array[String]) {
         if (args.length != 2){ //check arguments
           System.err.println("Usage spark-app.jar <input_dir> <output_dir>");
           System.exit(-1);
         }
         val inDir = args(0); //URI to source data
         val outDir = args(1); //URI to the folder where results are logged
         val conf = new SparkConf().setAppName("Month Stat - Scala App")
         val sc = new SparkContext(conf)
         val sqlContext = new org.apache.spark.sql.SQLContext(sc)
         val df = sqlContext.read.parquet(inDir)
         val monthStat = df.groupBy("Month").count()
         val defaultFS = sc.hadoopConfiguration.get("fs.defaultFS") //get the HDFS server endpoint
         val jobId = conf.get("spark.yarn.tags").replace("dataproc_job_", ""); //get the job ID
         if (outDir.toLowerCase().startsWith("s3a://")) {
           monthStat.repartition(1).write.format("csv").save(outDir + jobId)
         } else {
           monthStat.repartition(1).write.format("csv").save(defaultFS + "/" + outDir + jobId)
         }

         sc.stop()
       }
     }
   ```
1. Run the app build in the `spark-app` folder:

   ```bash
   sbt clean && sbt compile && sbt assembly
   ```

The file will be available at the following path: `./target/scala-2.11/spark-app-assembly-0.1.0-SNAPSHOT.jar`.

#### Upload the JAR file to {{ objstorage-name }} {#scala-upload}

To make sure that Spark has access to the compiled JAR file, upload the file to the {{ objstorage-name }} bucket that the {{ dataproc-name }} cluster service account has access to. You can upload the file using [s3cmd](../../storage/tools/s3cmd.md):

```bash
s3cmd put ./target/scala-2.11/spark-app_2.11-0.1.0-SNAPSHOT.jar \
    s3://<your bucket>/bin/
```

In the current example, the file is uploaded to `s3://<your bucket>/bin/spark-app_2.11-0.1.0-SNAPSHOT.jar`.

### Run the job in the {{ dataproc-name }} cluster {#scala-run}

For the Data Proc Agent to be able to pick up the job from the user's subnet, enable NAT or configure a NAT instance. For more information about how to do this, see [{#T}](./configure-network.md).

Below are two CLI command templates for running Spark jobs: with results output to {{ objstorage-name }} and HDFS.

{% list tabs %}

- {{ objstorage-name }}

   ```bash
   {{ yc-dp }} job create-spark \
      --cluster-id=<cluster ID> \
      --name=<job name> \
      --main-class="com.yandex.cloud.dataproc.scala.Main" \
      --main-jar-file-uri="s3a://<your bucket>/bin/spark-app_2.11-0.1.0-SNAPSHOT.jar" \
      --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
      --args="s3a://<your bucket>/jobs_results/"
   ```

- HDFS

   A CSV file with the execution result is created in the `/tmp/jobs/<job ID>/` folder in HDFS.

   ```bash
   {{ yc-dp }} job create-spark \
      --cluster-id=<cluster ID> \
      --name=<job name> \
      --main-class="com.yandex.cloud.dataproc.scala.Main" \
      --main-jar-file-uri="s3a://<your bucket>/bin/spark-app_2.11-0.1.0-SNAPSHOT.jar" \
      --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
      --args="tmp/jobs/"
   ```

   Example message saying that the job was run successfully:

   ```text
   done (1m2s)
   id: {your_job_id}
   cluster_id: {your_cluster_id}
   name: test02
   status: DONE
   spark_job:
     args:
     - s3a://yc-mdb-examples/dataproc/example01/set01
     - s3a://<your bucket>/jobs_results/
     main_jar_file_uri: s3a://<your bucket>/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar
     main_class: com.yandex.cloud.dataproc.scala.Main
   ```

{% endlist %}

### Running a PySpark Job {#cli-python}

Basic steps:

1. Prepare the Python application code.
2. Upload the file with the code to the {{ objstorage-name }} bucket that the cluster service account has access to.
3. Run the job in the {{ dataproc-name }} cluster.

The version of the Python application must match the version available from the image. You can check the version on the [{#T}](../concepts/environment.md) page. For image version 2.0, use Python 3.8.10.

To launch an app:

1. Create a file named `job.py` with the following code:

   ```python
   import sys

   from pyspark import SparkContext, SparkConf
   from pyspark.sql import SQLContext

   def main():

       if len(sys.argv) != 3:
           print('Usage job.py <input_dir> <output_dir>')
           sys.exit(1)

       in_dir = sys.argv[1]
       out_dir = sys.argv[2]

       conf = SparkConf().setAppName('Month Stat - Python')
       sc = SparkContext(conf=conf)
       sql = SQLContext(sc)
       df = sql.read.parquet(in_dir)
       month_stat = df.groupBy('Month').count()
       job_id = dict(sc._conf.getAll())['spark.yarn.tags'].replace('dataproc_job_', '')
       if out_dir.startswith('s3a://'):
           month_stat.repartition(1).write.format('csv').save(out_dir + job_id)
       else:
           default_fs = sc._jsc.hadoopConfiguration().get('fs.defaultFS')
           month_stat.repartition(1).write.format('csv').save(default_fs + out_dir + job_id)


   if __name__ == '__main__':
       main()
   ```

1. To make sure that PySpark has access to your code, upload the `job.py` file to the {{ objstorage-name }} bucket that the {{ dataproc-name }} cluster service account has access to. You can upload the file using [s3cmd](../../storage/tools/s3cmd.md):

   ```bash
   s3cmd put ./job.py s3://<your bucket>/bin/
   ```

1. Run the CLI command and write the result:

   * To a bucket {{ objstorage-name }}:

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<cluster ID> \
         --name=<job name> \
         --main-python-file-uri="s3a://<your bucket>/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="s3a://<your bucket>/jobs_results/"
      ```

   * To HDFS:

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<cluster ID> \
         --name=<job name> \
         --main-python-file-uri="s3a://<your bucket>/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="tmp/jobs/"
      ```

      A CSV file with the execution result is created in the `/tmp/jobs/<job ID>/` folder in HDFS.

1. To view the job logs:

   ```bash
   {{ yc-dp }} job log <job name> \
      --cluster-id=<cluster ID>
   ```
