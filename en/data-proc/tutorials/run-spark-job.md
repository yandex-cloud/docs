---
title: "Apache Spark and PySpark. Starting and managing applications"
keywords:
  - apache spark
  - spark
  - PySpark
---

# Launching and managing applications for Spark and PySpark

There are multiple ways to run a Spark or PySpark job in a {{ dataproc-name }} cluster:

* [Spark Shell](#spark-shell) (a command shell for Scala and Python programming languages). This method runs calculations line by line, rather than using a script. For more information about Spark Shell, see the [Spark documentation](https://spark.apache.org/docs/latest/quick-start).
* [spark-submit script](#spark-submit). Saves the calculation results to HDFS. For more information about `spark-submit`, see the [Spark documentation](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications).
* [{{ yandex-cloud }} CLI commands](#run-cli-jobs). These allow you to save calculation results not only to HDFS but also to a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md).

Below is an example demonstrating the calculation of 2018 US air traffic statistics based on data from [transtats.bts.gov](https://transtats.bts.gov/). The data set is stored in [Parquet](https://parquet.apache.org/) format in a public {{ objstorage-full-name }} bucket named `yc-mdb-examples`.

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=resources %}

- Manually {#manual}

   1. [Create a network](../../vpc/operations/network-create.md) named `data-proc-network`. Disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** when creating it.
   1. In `data-proc-network`, [create a subnet](../../vpc/operations/subnet-create.md) with the following parameters:

      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `data-proc-subnet-a`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.1.0/24`

   1. [Create a NAT gateway](../../vpc/operations/create-nat-gateway.md) and a routing table named `data-proc-route-table` in `data-proc-network`. Associate the routing table with the `data-proc-subnet-a` subnet.
   1. In the `data-proc-network` subnet, [create a security group](../../vpc/operations/security-group-create.md) named `data-proc-security-group` with the following rules:

      * One rule for inbound and another one for outbound service traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`

      * Rule for incoming traffic (for online access to subcluster hosts):

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

      * Rule for outgoing HTTPS traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

      * Rule for outgoing HTTP traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-http }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   1. [Create a service account](../../iam/operations/sa/create.md) named `data-proc-sa` with the following roles:

      * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent)
      * [storage.admin](../../storage/security/index.md#storage-admin)

   1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md) named `data-proc-bucket` with restricted access.
   1. [Grant the `data-proc-sa` service account](../../storage/operations/buckets/edit-acl.md) `READ and WRITE` permissions for `data-proc-bucket`.
   1. [Create a {{ dataproc-name }} cluster](../operations/cluster-create.md) in any suitable configuration with the following settings:

      * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `data-proc-sa`
      * **{{ ui-key.yacloud.mdb.forms.config_field_zone }}**: `{{ region-id }}-a`
      * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: `data-proc-bucket`
      * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `data-proc-network`
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `data-proc-security-group`
      * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** for subclusters: Provided

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. [Clone the repository](https://github.com/yandex-cloud-examples/yc-data-proc-spark-pyspark). It contains a provider settings file and an infrastructure configuration file.

      The configuration file describes the following:

      * Network
      * Subnet
      * NAT gateway and routing table
      * Security groups
      * Service account to work with cloud resources
      * Bucket to store job dependencies and results
      * {{ dataproc-name }} cluster

   1. Specify the required parameters in the `.tf` files.
   1. Run the `terraform init` command in the directory containing the repository. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Using Spark Shell {#spark-shell}

1. [Use SSH to connect](../operations/connect.md#data-proc-ssh) to the {{ dataproc-name }} cluster's master host.
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

Spark Submit allows you to run pre-written applications using the `spark-submit` script. In this example, we will calculate the number of flights by month.

{% list tabs %}

- PySpark Submit

   1. [Use SSH to connect](../operations/connect.md#data-proc-ssh) to the {{ dataproc-name }} cluster's master host.
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

   This example describes how to build and run an application using the [Scala](https://scala-lang.org) programming language. To build our applications, we use the standard Scala build utility, [sbt](https://scala-lang.org/download/).

   To create and launch a Spark application:

   1. [Use SSH to connect](../operations/connect.md#data-proc-ssh) to the {{ dataproc-name }} cluster's master host.
   1. [Install](https://docs.scala-lang.net/getting-started/index.html#using-the-scala-installer-recommended-way) sbt, the standard build utility for Scala. It comes bundled with the Scala programming language.
   1. Create a folder, such as `spark-app`.
   1. Add a file to the created folder with the `./src/main/scala/app.scala` path.
   1. Paste the following code to the `app.scala` file:

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

   1. Prepare the data for building your application:

      1. To find out the version of Scala installed on your system, run the `scala -version` command.
      1. To find out your `spark-core` and `spark-sql` versions, check the contents of the `/usr/lib/spark/jars` folder:

         ```bash
         ls /usr/lib/spark/jars
         ```

         The versions are specified in the names of JAR files. For example:

         ```text
         spark-core_2.12-3.0.3.jar
         spark-sql_2.12-3.0.3.jar
         ```

         The version you need is `3.0.3`.

   1. In the `spark-app` folder, create a file named `build.sbt` with the following configuration:

      ```scala
      scalaVersion := "<scala_version>"

      libraryDependencies ++= Seq(
          "org.apache.spark" %% "spark-core" % "<spark_core_version>" % "provided",
          "org.apache.spark" %% "spark-sql" % "<spark_sql_version>" % "provided"
      )
      ```

      For example:

      ```scala
      scalaVersion := "2.12.10"

      libraryDependencies ++= Seq(
          "org.apache.spark" %% "spark-core" % "3.0.3" % "provided",
          "org.apache.spark" %% "spark-sql" % "3.0.3" % "provided"
      )
      ```

   1. Compile and build your JAR file:

      ```bash
      sbt compile && sbt package
      ```

   1. Get the name of the JAR file you built:

      ```bash
      ls ~/spark-app/target/scala-<scala_version>
      ```

      The result: `spark-app_2.12-0.1.0-SNAPSHOT.jar`.

   1. Launch the resulting application:

      ```bash
      /usr/bin/spark-submit --class com.yandex.cloud.dataproc.scala.Main target/scala-<scala_version>/<built_JAR_file_name>
      ```

      For example:

      ```bash
      /usr/bin/spark-submit --class com.yandex.cloud.dataproc.scala.Main target/scala-2.12/spark-app_2.12-0.1.0-SNAPSHOT.jar
      ```

   1. The result of running the application is exported to HDFS. You can list the resulting files using the command:

      ```bash
      hdfs dfs -ls /tmp/month_stat
      ```

{% endlist %}

### Terminating the application {#yarn-kill}

By default, the resources of the running application are managed by the YARN component. If you need to terminate or remove the application from the queue, use the `yarn` utility:

1. List the applications:

   ```bash
   yarn application -list
   ```
1. Terminate the application you no longer need:

   ```bash
   yarn application -kill <app_ID>
   ```

For more information about YARN commands, see [YARN Commands](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YarnCommands.html).

## Running jobs using the {{ yandex-cloud }} CLI {#run-cli-jobs}

{% include [cli-job-intro](../../_includes/data-proc/cli-job-intro.md) %}

You can save the calculation results to HDFS on the {{ dataproc-name }} cluster or to the `data-proc-bucket` bucket you specified when creating the cluster.

All service and debugging information will be saved to `data-proc-bucket`. For each job, the {{ dataproc-name }} agent creates a separate folder with a path, such as `dataproc/clusters/<cluster_ID>/jobs/<job_ID>`.

Below are the two application versions, one for [Python](#cli-python) and one for [Scala](#cli-scala).

### Running a PySpark job {#cli-python}

To run a PySpark job:

1. [Install additional dependencies](#infra-for-python).
1. [Prepare and run a PySpark job](#run-cli-pyspark).

#### Install additional dependencies {#infra-for-python}

On a local computer:

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Install and configure](../../storage/tools/s3cmd.md) the S3cmd console client to work with {{ objstorage-full-name }}.
1. Install Python. Make sure the Python version matches the version available from the image. You can check the version under [{#T}](../concepts/environment.md). For image version 2.0, use Python 3.8.10:

   ```bash
   sudo apt update && sudo apt install python3.8
   ```

#### Prepare and run a PySpark job {#run-cli-pyspark}

1. Create a file named `job.py` with the following code:

   ```python
   import sys

   from pyspark import SparkContext, SparkConf
   from pyspark.sql import SQLContext

   def main():

       if len(sys.argv) != 3:
           print('Usage job.py <input_directory> <output_directory>')
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

1. To make sure that PySpark has access to your code, upload the `job.py` file to the {{ objstorage-name }} bucket that the {{ dataproc-name }} cluster service account has access to:

   ```bash
   s3cmd put ./job.py s3://data-proc-bucket/bin/
   ```

1. Run the job.

   The run command varies depending on whether you want to save the job results to {{ objstorage-name }} or to HDFS.

   {% list tabs group=storage_system %}

   - {{ objstorage-name }} {#storage}

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<cluster_ID> \
         --name=<job_name> \
         --main-python-file-uri="s3a://data-proc-bucket/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="s3a://data-proc-bucket/jobs_results/"
      ```

      In the command, specify the following:

      * `--cluster-id`: Cluster ID. You can get it with a [list of clusters in the folder](../operations/cluster-list.md#list).
      * `--name`: Arbitrary Spark job name.

      A CSV file with the execution results is saved to `data-proc-bucket`.

   - HDFS directory {#hdfs}

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<cluster_ID> \
         --name=<job_name> \
         --main-python-file-uri="s3a://data-proc-bucket/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="tmp/jobs/"
      ```

      In the command, specify the following:

      * `--cluster-id`: Cluster ID. You can get it with a [list of clusters in the folder](../operations/cluster-list.md#list).
      * `--name`: Arbitrary Spark job name.

      A CSV file with the execution result is saved to the `/tmp/jobs/<job_ID>/` folder in HDFS.

   {% endlist %}

1. (Optional) View the job logs:

   ```bash
   {{ yc-dp }} job log <job_ID> --cluster-id=<cluster_ID>
   ```

### Running Spark jobs {#cli-scala}

To run a Spark job:

1. [Install additional dependencies](#infra-for-scala).
1. [Build a Scala application](#scala-build).
1. [Upload the JAR file to {{ objstorage-name }}](#scala-upload).
1. [Run the Spark job in the {{ dataproc-name }} cluster](#scala-run).

#### Install additional dependencies {#infra-for-scala}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Use SSH to connect](../operations/connect.md#data-proc-ssh) to the {{ dataproc-name }} cluster's master host.
1. [Install](https://docs.scala-lang.net/getting-started/index.html#using-the-scala-installer-recommended-way) `sbt`, the standard build utility for Scala. It comes bundled with the Scala programming language.
1. [Install and configure](../../storage/tools/s3cmd.md) the S3cmd console client to work with {{ objstorage-full-name }}.

#### Build a Scala application {#scala-build}

To simplify dependency management, build the application to a single JAR file (fat JAR) using the [sbt-assembly](https://github.com/sbt/sbt-assembly) plugin:

1. Create a folder named `spark-app` with the `project` and `src/main/scala` subdirectories.
1. Create a file named `spark-app/project/plugins.sbt` that describes the connection of the `sbt-assembly` plugin to assemble a single JAR file:

   ```scala
   addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "<sbt_assembly_version>")
   ```

   You can check the version of the `sbt-assembly` plugin in its [repository](https://github.com/sbt/sbt-assembly), under **Releases**.

1. Run the `scala -version` command to learn the version of Scala installed on your system.
1. Create a file named `spark-app/build.sbt` with a description of the dependencies and the strategy for merging them into a single JAR file. Specify the Scala version in the `build.sbt` file:

   ```scala
   scalaVersion := "<Scala_version>"

   libraryDependencies ++= Seq(
       "org.apache.spark" %% "spark-core" % "2.4.4",
       "org.apache.spark" %% "spark-sql" % "2.4.4",
   )

   assembly / assemblyMergeStrategy := {
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
     case "git.properties" => MergeStrategy.last
     case x =>
       val oldStrategy = (assembly / assemblyMergeStrategy).value
       oldStrategy(x)
   }
   ```
1. Create a file named `spark-app/src/main/scala/app.scala` with the application code:

   ```scala
   package com.yandex.cloud.dataproc.scala

   import org.apache.spark.{SparkConf, SparkContext}
   import org.apache.spark.sql.SQLContext

     object Main {
       def main(args: Array[String]) {
         if (args.length != 2){ //check the argument
           System.err.println("Usage spark-app.jar <input_directory> <output_directory>");
           System.exit(-1);
         }
         val inDir = args(0); //URI to source data
         val outDir = args(1); //URI to the output directory
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

   {% cut "If you get the `Error looking up function 'stat'` error" %}

   If you get the `java.lang.UnsatisfiedLinkError: Error looking up function 'stat': java: undefined symbol: stat` error and your master host OS is Ubuntu, run each `sbt` command with the `-Dsbt.io.jdktimestamps=true` flag:

   ```bash
   sbt clean -Dsbt.io.jdktimestamps=true && \
   sbt compile -Dsbt.io.jdktimestamps=true && \
   sbt assembly -Dsbt.io.jdktimestamps=true
   ```

   {% endcut %}

The file will be available at the following path: `spark-app/target/scala-<Scala_version>/spark-app-assembly-0.1.0-SNAPSHOT.jar`.

#### Upload the JAR file to {{ objstorage-name }} {#scala-upload}

For Spark to have access to the assembled JAR file, upload the file to `data-proc-bucket`. You can upload the file using [s3cmd](../../storage/tools/s3cmd.md):

```bash
s3cmd put ~/spark-app/target/scala-<Scala_version>/spark-app-assembly-0.1.0-SNAPSHOT.jar s3://data-proc-bucket/bin/
```

The file is uploaded to `s3://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar`.

#### Run the Spark job in the {{ dataproc-name }} cluster {#scala-run}

1. Disconnect from the cluster master host.
1. Run the job.

   The run command varies depending on whether you want to save the job results to {{ objstorage-name }} or to HDFS.

   {% list tabs group=storage_system %}

   - {{ objstorage-name }} {#storage}

      ```bash
      {{ yc-dp }} job create-spark \
         --cluster-id=<cluster_ID> \
         --name=<job_name> \
         --main-class="com.yandex.cloud.dataproc.scala.Main" \
         --main-jar-file-uri="s3a://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="s3a://data-proc-bucket/jobs_results/"
      ```

      In the command, specify the following:

      * `--cluster-id`: Cluster ID. You can get it with a [list of clusters in the folder](../operations/cluster-list.md#list).
      * `--name`: Arbitrary Spark job name.

      A CSV file with the execution results is saved to `data-proc-bucket`.

   - HDFS directory {#hdfs}

      ```bash
      {{ yc-dp }} job create-spark \
         --cluster-id=<cluster_ID> \
         --name=<job_name> \
         --main-class="com.yandex.cloud.dataproc.scala.Main" \
         --main-jar-file-uri="s3a://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="tmp/jobs/"
      ```

      In the command, specify the following:

      * `--cluster-id`: Cluster ID. You can get it with a [list of clusters in the folder](../operations/cluster-list.md#list).
      * `--name`: Arbitrary Spark job name.

      A CSV file with the execution result is saved to the `/tmp/jobs/<job_ID>/` folder in HDFS.

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
        - s3a://data-proc-bucket/jobs_results/
        main_jar_file_uri: s3a://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar
        main_class: com.yandex.cloud.dataproc.scala.Main
      ```

   {% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=resources %}

- Manually {#manual}

   1. [Delete the {{ dataproc-name }} cluster](../operations/cluster-delete.md).
   1. If you reserved public static IP addresses for the clusters, release and [delete them](../../vpc/operations/address-delete.md).
   1. [Delete the subnet](../../vpc/operations/subnet-delete.md).
   1. Delete the routing table and NAT gateway.
   1. [Delete the network](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

   To delete the infrastructure [created with {{ TF }}](#infra):

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `data-proc-for-spark-jobs.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   All the resources described in the configuration file will be deleted.

{% endlist %}
