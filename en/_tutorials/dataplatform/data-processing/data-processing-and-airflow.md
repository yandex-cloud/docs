# Automating operations with {{ dataproc-full-name }} using {{ maf-full-name }}


{{ maf-full-name }} enables you to create [Directed Acyclic Graphs (DAGs) of tasks](../../../managed-airflow/concepts/index.md) to automate your operations with [{{ dataproc-full-name }}](../../../data-proc/index.yaml). Below is an example of a DAG that includes multiple tasks:

1. Create a {{ dataproc-name }} cluster.
1. Create and run a [PySpark job](../../../data-proc/concepts/jobs.md).
1. Delete a {{ dataproc-name }} cluster.

With a DAG like this, a cluster's lifetime is short. Since the cost of {{ dataproc-name }} resources [depends on their usage time](../../../data-proc/pricing.md), you can use resources with higher capacity in the cluster and quickly handle a larger amount of data at no additional cost.

In this DAG, a {{ dataproc-name }} cluster is created without using Hive. In the example below, a [{{ metastore-full-name }} cluster](../../../metadata-hub/concepts/metastore.md) is used for storing table metadata. The saved metadata can then be used by another {{ dataproc-name }} cluster.

To automate operations with {{ dataproc-name }} using {{ maf-name }}:

1. [Set up your infrastructure](#infra).
1. [Prepare a PySpark job](#prepare-a-job).
1. [Prepare and run a DAG file](#dag).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ maf-name }} cluster fee: Computing resources of the cluster components (see [{{ AF }} pricing](../../../managed-airflow/pricing.md)).
* NAT gateway fee (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* {{ objstorage-name }} bucket fee: Storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* {{ dataproc-name }} cluster fee: Using VM computing resources and {{ compute-name }} network disks, and {{ cloud-logging-name }} for log management (see [{{ dataproc-name }} pricing](../../../data-proc/pricing.md)).


## Set up your infrastructure {#infra}

The example below illustrates two scenarios. Select the one you find most relevant:

* **High security level**. This is a recommended scenario, as it respects the [principle of least privilege](../../../iam/best-practices/using-iam-securely.md#restrict-access). The scenario entails the following:

   * Splitting access permissions across different service accounts. You have to create a separate service account for each cluster and assign it only those roles required for this account's cluster to function.
   * Using multiple buckets for different tasks and storing different data in separate buckets. For example, the results of running a PySpark job get written to one bucket, and logs, to another.
   * Setting up security groups. This way, you can restrict traffic and grant access only to authorized resources.

* **Simplified setup** This scenario implies a lower security level:

   * Using a single service account with more privileges than required.
   * Storing all data in a single bucket but in different folders.
   * No security groups are set up.

{% list tabs group=instructions %}

* High security level

   Set up your infrastructure:

   1. [Create service accounts](../../../iam/operations/sa/create.md) with the following roles:

      #|
      || **Service account** | **Roles** ||
      || `airflow-agent` for an {{ AF }} cluster |
      * [dataproc.editor](../../../iam/roles-reference.md#dataproc-editor): To manage a {{ dataproc-name }} cluster from a DAG.
      * [{{ roles-vpc-user }}](../../../iam/roles-reference.md#vpc-user): To use the [{{ vpc-full-name }} subnet](../../../vpc/concepts/network.md#subnet) in the {{ AF }} cluster.
      * [{{ roles.maf.integrationProvider }}](../../../iam/roles-reference.md#managed-airflow-integrationProvider): To enable the {{ AF }} cluster to [interact with other resources](../../../managed-airflow/concepts/impersonation.md).
      * [iam.serviceAccounts.user](../../../iam/roles-reference.md#iam-serviceAccounts-user): To specify the `data-processing-agent` service account when creating a {{ dataproc-name }} cluster. ||
      || `metastore-agent` for a {{ metastore-name }} cluster |
      * [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider): To enable the {{ metastore-name }} cluster to [interact with other resources](../../../metadata-hub/concepts/metastore-impersonation.md). ||
      || `data-processing-agent` for a {{ dataproc-name }} cluster |
      {% include [sa-roles](../../../_includes/data-processing/sa-roles.md) %}
      ||
      |#

   1. [Create buckets](../../../storage/operations/buckets/create.md):

      * `<bucket_for_Managed_Airflow>`
      * `<bucket_for_PySpark_job_source_code>`
      * `<bucket_for_PySpark_job_output_data>`
      * `<bucket_for_collecting_Spark_logs>`

      You need multiple buckets with different access permissions.

   1. [Grant permissions](../../../storage/operations/buckets/edit-acl.md) for the buckets as follows:

      * `<bucket_for_Managed_Airflow>`: `READ` permission to the `airflow-agent` service account.
      * `<bucket_for_PySpark_job_source_code>`: `READ` permission to the `data-processing-agent` service account.
      * `<bucket_for_PySpark_job_output_data>`: `READ and WRITE` permissions to the `data-processing-agent` and `metastore-agent` service accounts.
      * `<bucket_for_collecting_Spark_logs>`: `READ and WRITE` permissions to the `data-processing-agent` service account.

   1. [Create a cloud network](../../../vpc/operations/network-create.md) named `data-processing-network`.

      This will automatically create three subnets in different availability zones.

   1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) for the `data-processing-network-{{ region-id }}-a` subnet.
   1. For the {{ metastore-name }} cluster, [create a security group](../../../vpc/operations/security-group-create.md) named `metastore-sg` in the `data-processing-network` network. Add the following rules to the group:

      * For incoming client traffic:

         * Port range: `30000-32767`
         * Protocol: `Any`
         * Source: `CIDR`
         * CIDR blocks: `0.0.0.0/0`

      * For incoming load balancer traffic:

         * Port range: `10256`
         * Protocol: `Any`
         * Source: `Load balancer health checks`

   1. For the {{ maf-name }} and {{ dataproc-name }} clusters, create a security group named `airflow-sg` in the `data-processing-network` network. Add the following rules to the group:

      * For incoming service traffic:

         * Port range: `{{ port-any }}`
         * Protocol: `Any`
         * Source: `Security group`
         * Security group: `Self`

      * For outgoing service traffic:

         * Port range: `{{ port-any }}`
         * Protocol: `Any`
         * Source: `Security group`
         * Security group: `Self`

      * For outgoing HTTPS traffic:

         * Port range: `{{ port-https }}`
         * Protocol: `TCP`
         * Destination type: `CIDR`
         * CIDR blocks: `0.0.0.0/0`

      * For outgoing traffic, to allow {{ dataproc-name }} cluster connections to {{ metastore-name }}:

         * Port range: `{{ port-metastore }}`
         * Protocol: `Any`
         * Source: `Security group`
         * Security group: `metastore-sg` (`From list`)

   1. [Create a {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) cluster with the following parameters:

      * **Service account**: `metastore-agent`
      * **Network**: `data-processing-network`
      * **Subnet**: `data-processing-network-{{ region-id }}-a`
      * **Security group**: `metastore-sg`

   1. [Create a {{ maf-name }}](../../../managed-airflow/operations/cluster-create.md) cluster with the following parameters:

      * **Service account**: `airflow-agent`
      * **Availability zone**: `{{ region-id }}-a`
      * **Network**: `data-processing-network`
      * **Subnet**: `data-processing-network-{{ region-id }}-a`
      * **Security group**: `airflow-sg`
      * **Bucket name**: `<bucket_for_Managed_Airflow>`

* Simplified setup

   Set up your infrastructure:

   1. [Create a service account](../../../iam/operations/sa/create.md) named `my-editor` with the following roles:

      * [dataproc.editor](../../../iam/roles-reference.md#dataproc-editor): To manage a {{ dataproc-name }} cluster from a DAG.
      * [editor](../../../iam/roles-reference.md#editor): To perform other operations.

   1. [Create a bucket](../../../storage/operations/buckets/create.md) named `<bucket_for_jobs_and_data>`.

      You do not need to [grant a permission](../../../storage/operations/buckets/edit-acl.md) for this bucket to the service account as the `editor` role is enough.

   1. [Create a cloud network](../../../vpc/operations/network-create.md) named `data-processing-network`.

      This automatically creates three subnets in different availability zones and a security group.

   1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) for the `data-processing-network-{{ region-id }}-a` subnet.
   1. [Create a {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) cluster with the following parameters:

      * **Service account**: `my-editor`
      * **Network**: `data-processing-network`
      * **Subnet**: `data-processing-network-{{ region-id }}-a`
      * **Security group**: Default group in `data-processing-network`

   1. [Create a {{ maf-name }}](../../../managed-airflow/operations/cluster-create.md) cluster with the following parameters:

      * **Service account**: `my-editor`
      * **Availability zone**: `{{ region-id }}-a`
      * **Network**: `data-processing-network`
      * **Subnet**: `data-processing-network-{{ region-id }}-a`
      * **Security group**: Default group in `data-processing-network`
      * **Bucket name**: `<bucket_for_jobs_and_data>`

{% endlist %}

## Prepare a PySpark job {#prepare-a-job}

For a PySpark job, we will use a Python script that creates a table and is stored in the {{ objstorage-name }} bucket. Prepare a script file:

{% list tabs group=instructions %}

* High security level

   1. Create a local file named `create-table.py` and copy the following script to it:

      {% cut "create-table.py" %}

      ```python
      from pyspark.sql.types import *
      from pyspark.sql import SparkSession

      # Creating a Spark session
      spark = SparkSession.builder \
          .appName("create-table") \
          .enableHiveSupport() \
          .getOrCreate()

      # Creating a data schema
      schema = StructType([StructField('Name', StringType(), True),
      StructField('Capital', StringType(), True),
      StructField('Area', IntegerType(), True),
      StructField('Population', IntegerType(), True)])

      # Creating a dataframe
      df = spark.createDataFrame([('Australia', 'Canberra', 7686850, 19731984), ('Austria', 'Vienna', 83855, 7700000)], schema)

      # Writing the dataframe to a bucket as a _countries_ table
      df.write.mode("overwrite").option("path","s3a://<bucket_for_PySpark_job_output_data>/countries").saveAsTable("countries")
      ```

      {% endcut %}

   1. In `<bucket_for_PySpark_job_source_code>`, create a `scripts` folder and [upload](../../../storage/operations/objects/upload.md#simple) the `create-table.py` file to it.

* Simplified setup

   1. Create a local file named `create-table.py` and copy the following script to it:

      {% cut "create-table.py" %}

      ```python
      from pyspark.sql.types import *
      from pyspark.sql import SparkSession

      # Creating a Spark session
      spark = SparkSession.builder \
          .appName("create-table") \
          .enableHiveSupport() \
          .getOrCreate()

      # Creating a data schema
      schema = StructType([StructField('Name', StringType(), True),
      StructField('Capital', StringType(), True),
      StructField('Area', IntegerType(), True),
      StructField('Population', IntegerType(), True)])

      # Creating a dataframe
      df = spark.createDataFrame([('Australia', 'Canberra', 7686850, 19731984), ('Austria', 'Vienna', 83855, 7700000)], schema)

      # Writing the dataframe to a bucket as a _countries_ table
      df.write.mode("overwrite").option("path","s3a://<bucket_for_jobs_and_data>/countries").saveAsTable("countries")
      ```

      {% endcut %}

   1. In `<bucket_for_jobs_and_data>`, create a `scripts` folder and [upload](../../../storage/operations/objects/upload.md#simple) the `create-table.py` file to it.

{% endlist %}

## Prepare and run a DAG file {#dag}

A DAG will have multiple vertices that form a sequence of consecutive actions:

1. {{ maf-name }} creates a temporary lightweight {{ dataproc-name }} cluster whose settings are set in the DAG. This cluster automatically connects to the previously created {{ metastore-name }} cluster.
1. When the {{ dataproc-name }} cluster is ready, a PySpark job is run.
1. Once the job is executed, the temporary {{ dataproc-name }} cluster is deleted.

To prepare a DAG:

{% list tabs group=instructions %}

* High security level

   1. [Create an SSH key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Save the public part of the key: you will need it to create a {{ dataproc-name }} cluster.
   1. Create a local file named `Data-Processing-DAG.py`, copy the following script to it and insert your infrastructure data in variables:

      {% cut "Data-Processing-DAG.py" %}

      ```python
      import uuid
      import datetime
      from airflow import DAG
      from airflow.utils.trigger_rule import TriggerRule
      from airflow.providers.yandex.operators.yandexcloud_dataproc import (
          DataprocCreateClusterOperator,
          DataprocCreatePysparkJobOperator,
          DataprocDeleteClusterOperator,
      )

      # Your infrastructure data
      YC_DP_AZ = 'ru-central1-a'
      YC_DP_SSH_PUBLIC_KEY = '<public_part_of_SSH_key>'
      YC_DP_SUBNET_ID = '<subnet_ID>'
      YC_DP_SA_ID = '<ID_of_data_processing_agent_service_account>'
      YC_DP_METASTORE_URI = '<IP_address>'
      YC_SOURCE_BUCKET = '<bucket_for_PySpark_job_source_code>'
      YC_DP_LOGS_BUCKET = '<bucket_for_collecting_Spark_logs>'

      # DAG settings
      with DAG(
              'DATA_INGEST',
              schedule_interval='@hourly',
              tags=['data-processing-and-airflow'],
              start_date=datetime.datetime.now(),
              max_active_runs=1,
              catchup=False
      ) as ingest_dag:
          # Step 1: Creating a Yandex Data Proc cluster
          create_spark_cluster = DataprocCreateClusterOperator(
              task_id='dp-cluster-create-task',
              cluster_name=f'tmp-dp-{uuid.uuid4()}',
              cluster_description='A temporary cluster for running a PySpark job orchestrated by {{ maf-name }}',
              ssh_public_keys=YC_DP_SSH_PUBLIC_KEY,
              service_account_id=YC_DP_SA_ID,
              subnet_id=YC_DP_SUBNET_ID,
              s3_bucket=YC_DP_LOGS_BUCKET,
              zone=YC_DP_AZ,
              cluster_image_version='2.1',
              masternode_resource_preset='s2.small',
              masternode_disk_type='network-ssd',
              masternode_disk_size=200,
              computenode_resource_preset='m2.large',
              computenode_disk_type='network-ssd',
              computenode_disk_size=200,
              computenode_count=2,
              computenode_max_hosts_count=5,  # The number of data handling subclusters will be automatically scaled up if the load is high.
              services=['YARN', 'SPARK'],     # A lightweight cluster is being created.
              datanode_count=0,               # Without data storage subclusters.
              properties={                    # With a reference to a remote Metastore cluster.
                  'spark:spark.hive.metastore.uris': f'thrift://{YC_DP_METASTORE_URI}:9083',
              },
          )

          # Step 2: Running a PySpark job
          poke_spark_processing = DataprocCreatePysparkJobOperator(
              task_id='dp-cluster-pyspark-task',
              main_python_file_uri=f's3a://{YC_SOURCE_BUCKET}/scripts/create-table.py',
          )

          # Step 3: Deleting a {{ dataproc-name }} cluster
          delete_spark_cluster = DataprocDeleteClusterOperator(
              task_id='dp-cluster-delete-task',
              trigger_rule=TriggerRule.ALL_DONE,
          )

          # Building a DAG based on the above steps
          create_spark_cluster >> poke_spark_processing >> delete_spark_cluster
      ```

      Where:

      * `YC_DP_AZ`: Availability zone for the {{ dataproc-name }} cluster.
      * `YC_DP_SSH_PUBLIC_KEY`: Public part of the SSH key for the {{ dataproc-name }} cluster.
      * `YC_DP_SUBNET_ID`: Subnet ID.
      * `YC_DP_SA_ID`: ID of the service account for {{ dataproc-name }}.
      * `YC_DP_METASTORE_URI`: IP address of the {{ metastore-name }} cluster.
      * `YC_SOURCE_BUCKET`: Bucket with the Python script for the PySpark job.
      * `YC_DP_LOGS_BUCKET`: Bucket for logs.

      {% endcut %}

   1. Upload the DAG to the {{ maf-name }} cluster: in `<bucket_for_Managed_Airflow>`, create a folder named `dags` and upload the `Data-Processing-DAG.py` file to it.
   1. Open the {{ AF }} web interface.
   1. Make sure the **DAGs** section now contains the new DAG named `DATA_INGEST` and tagged as `data-processing-and-airflow`.

      It may take a few minutes to upload a DAG file from the bucket.

   1. To run the DAG, click ![image](../../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

* Simplified setup

   1. [Create an SSH key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Save the public part of the key: you will need it to create a {{ dataproc-name }} cluster.
   1. Create a local file named `Data-Processing-DAG.py`, copy the following script to it and insert your infrastructure data in variables:

      {% cut "Data-Processing-DAG.py" %}

      ```python
      import uuid
      import datetime
      from airflow import DAG
      from airflow.utils.trigger_rule import TriggerRule
      from airflow.providers.yandex.operators.yandexcloud_dataproc import (
          DataprocCreateClusterOperator,
          DataprocCreatePysparkJobOperator,
          DataprocDeleteClusterOperator,
      )

      # Your infrastructure data
      YC_DP_AZ = 'ru-central1-a'
      YC_DP_SSH_PUBLIC_KEY = '<public_part_of_SSH_key>'
      YC_DP_SUBNET_ID = '<subnet_ID>'
      YC_DP_SA_ID = '<ID_of_my_editor_service_account>'
      YC_DP_METASTORE_URI = '<IP_address>'
      YC_BUCKET = '<bucket_for_jobs_and_data>'

      # DAG settings
      with DAG(
              'DATA_INGEST',
              schedule_interval='@hourly',
              tags=['data-processing-and-airflow'],
              start_date=datetime.datetime.now(),
              max_active_runs=1,
              catchup=False
      ) as ingest_dag:
          # Step 1: Creating a Yandex Data Proc cluster
          create_spark_cluster = DataprocCreateClusterOperator(
              task_id='dp-cluster-create-task',
              cluster_name=f'tmp-dp-{uuid.uuid4()}',
              cluster_description='A temporary cluster for running a PySpark job orchestrated by {{ maf-name }}',
              ssh_public_keys=YC_DP_SSH_PUBLIC_KEY,
              service_account_id=YC_DP_SA_ID,
              subnet_id=YC_DP_SUBNET_ID,
              s3_bucket=YC_BUCKET,
              zone=YC_DP_AZ,
              cluster_image_version='2.1',
              masternode_resource_preset='s2.small',
              masternode_disk_type='network-ssd',
              masternode_disk_size=200,
              computenode_resource_preset='m2.large',
              computenode_disk_type='network-ssd',
              computenode_disk_size=200,
              computenode_count=2,
              computenode_max_hosts_count=5,  # The number of data handling subclusters will be automatically scaled up if the load is high.
              services=['YARN', 'SPARK'],     # A lightweight cluster is being created.
              datanode_count=0,               # Without data storage subclusters.
              properties={                    # With a reference to a remote Metastore cluster.
                  'spark:spark.hive.metastore.uris': f'thrift://{YC_DP_METASTORE_URI}:9083',
              },
          )

          # Step 2: Running a PySpark job
          poke_spark_processing = DataprocCreatePysparkJobOperator(
              task_id='dp-cluster-pyspark-task',
              main_python_file_uri=f's3a://{YC_BUCKET}/scripts/create-table.py',
          )

          # Step 3: Deleting a {{ dataproc-name }} cluster
          delete_spark_cluster = DataprocDeleteClusterOperator(
              task_id='dp-cluster-delete-task',
              trigger_rule=TriggerRule.ALL_DONE,
          )

          # Building a DAG based on the above steps
          create_spark_cluster >> poke_spark_processing >> delete_spark_cluster
      ```

      Where:

      * `YC_DP_AZ`: Availability zone for the {{ dataproc-name }} cluster.
      * `YC_DP_SSH_PUBLIC_KEY`: Public part of the SSH key for the {{ dataproc-name }} cluster.
      * `YC_DP_SUBNET_ID`: Subnet ID.
      * `YC_DP_SA_ID`: `my-editor` service account ID.
      * `YC_DP_METASTORE_URI`: IP address of the {{ metastore-name }} cluster.
      * `YC_BUCKET` — `<bucket_for_jobs_and_data>`.

      {% endcut %}

   1. Upload the DAG to the {{ maf-name }} cluster: in `<bucket_for_jobs_and_data>`, create a folder named `dags` and upload the `Data-Processing-DAG.py` file to it.
   1. Open the {{ AF }} web interface.
   1. Make sure the **DAGs** section now contains the new DAG named `DATA_INGEST` and tagged as `data-processing-and-airflow`.

      It may take a few minutes to upload a DAG file from the bucket.

   1. To run a DAG, click ![image](../../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

{% endlist %}

## Check the result {#check-out}

{% list tabs group=instructions %}

* High security level

   1. To monitor task execution results, click the DAG name. The results are displayed in the **Grid** tab.
   1. Wait until the status of all the three tasks in the DAG changes to **Success**. Simultaneously, you can check that a {{ dataproc-name }} cluster is being created, the PySpark job is running, and the same cluster is being deleted in the [management console]({{ link-console-main }}).
   1. Make sure your `<bucket_for_PySpark_job_output_data>` now contains a folder named `countries` with the `part-00000-...` file. The data from the created table is now stored in the {{ objstorage-name }} bucket and the table metadata is stored in the {{ metastore-name }} cluster.
   1. Make sure there are PySpark job logs in `<bucket_for_collecting_Spark_logs>`.

* Simplified setup

   1. To monitor task execution results, click the DAG name. The results are displayed in the **Grid** tab.
   1. Wait until the status of all the three tasks in the DAG changes to **Success**. Simultaneously, you can check that a {{ dataproc-name }} cluster is being created, the PySpark job is running, and the same cluster is being deleted in the [management console]({{ link-console-main }}).
   1. Make sure there is a folder named `countries` with the `part-00000-...` file in `<bucket_for_jobs_and_data>`. The data from the created table is now stored in the {{ objstorage-name }} bucket and the table metadata is stored in the {{ metastore-name }} cluster.
   1. Make sure there are PySpark job logs in `<bucket_for_jobs_and_data>`. These logs are written to the `dataproc`, `user`, and `var` folders.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

* High security level

   1. [Service accounts](../../../iam/operations/sa/delete.md).
   1. [{{ objstorage-name }}](../../../storage/operations/buckets/delete.md) buckets
   1. [{{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md) cluster.
   1. [{{ maf-name }}](../../../managed-airflow/operations/cluster-delete.md) cluster.
   1. [Route table](../../../vpc/operations/delete-route-table.md)
   1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md).
   1. [Security groups](../../../vpc/operations/security-group-delete.md).
   1. [Cloud subnets](../../../vpc/operations/subnet-delete.md) created in `data-processing-network` by default.
   1. [Cloud network](../../../vpc/operations/network-delete.md).

* Simplified setup

   1. [Service account](../../../iam/operations/sa/delete.md).
   1. [{{ objstorage-name }}](../../../storage/operations/buckets/delete.md) bucket.
   1. [{{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md) cluster.
   1. [{{ maf-name }}](../../../managed-airflow/operations/cluster-delete.md) cluster.
   1. [Route table](../../../vpc/operations/delete-route-table.md).
   1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md).
   1. [Security group](../../../vpc/operations/security-group-delete.md) created in `data-processing-network` by default.
   1. [Cloud subnets](../../../vpc/operations/subnet-delete.md) created in `data-processing-network` by default.
   1. [Cloud network](../../../vpc/operations/network-delete.md).

{% endlist %}
