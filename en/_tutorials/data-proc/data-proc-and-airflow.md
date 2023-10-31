# Automating operations with {{ dataproc-full-name }} using {{ maf-full-name }}

{{ maf-full-name }} enables you to create [Directed Acyclic Graphs (DAGs) of tasks](../../managed-airflow/concepts/index.md) to automate your operations with [{{ dataproc-full-name }}](../../data-proc/index.yaml). Below is an example of a DAG that includes multiple tasks:

1. Create a {{ dataproc-name }} cluster.
1. Create and run a [PySpark job](../../data-proc/concepts/jobs.md).
1. Delete a {{ dataproc-name }} cluster.

With a DAG like this, a cluster's lifetime is short. Since the cost of {{ dataproc-name }} resources [depends on their usage time](../../data-proc/pricing.md), you can use resources with higher capacity in the cluster and quickly handle a larger amount of data at no additional cost.

In this DAG, a {{ dataproc-name }} cluster is created without using Hive. In the example below, a [{{ metastore-full-name }} cluster](../../data-proc/concepts/metastore.md) is used for storing table metadata. The saved metadata can then be used by another {{ dataproc-name }} cluster.

To automate operations with {{ dataproc-name }} using {{ maf-name }}:

1. [Prepare your infrastructure](#infra).
1. [Prepare a PySpark job](#prepare-a-job).
1. [Create {{ AF }} connections](#connections).
1. [Prepare and run a DAG file](#dag).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).

{% note info %}

{{ maf-name }} and {{ metastore-name }} are at the [Preview](../../overview/concepts/launch-stages.md) stage. To get access, contact [tech support]({{ link-console-support }}) or your account manager.

{% endnote %}

## Prepare the infrastructure {#infra}

1. [Create a service account](../../iam/operations/sa/create.md) named `airflow-sa` with the following roles:

   * `storage.editor`
   * `dataproc.agent`
   * `editor`

1. Create the following keys for the service account:

   * [Static access key](../../iam/operations/sa/create-access-key.md). Save its ID and the secret key.
   * [Authorized key](../../iam/operations/authorized-key/create.md). Save the key's public part and download a file with the public and the private parts.

1. [Create buckets](../../storage/operations/buckets/create.md):

   * `airflow-bucket` for {{ maf-name }}
   * `pyspark-bucket` for a PySpark job
   * `output-bucket` for output data
   * `log-bucket` to store collected logs

   You need multiple buckets with different access rights.

1. [Grant the `airflow-sa` service account](../../storage/operations/buckets/edit-acl.md) the following bucket permissions:

   * `READ` for `airflow-bucket`
   * `READ` for `pyspark-bucket`
   * `READ and WRITE` for `output-bucket`
   * `READ and WRITE` for `log-bucket`

1. [Create a cloud network](../../vpc/operations/network-create.md) named `dataproc-network`.

   This automatically creates three subnets in different availability zones and a security group.

1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the `dataproc-network-ru-central1-a` subnet.
1. [Add these rules](../../vpc/operations/security-group-add-rule.md) to the security group in `dataproc-network`:

   {% cut "Security group rules" %}

   #|
   || **What service requires the rule** | **Why the rule is required** | **Rule settings** ||
   || {{ dataproc-name }} | For incoming service traffic
   |
   * Port range: `{{ port-any }}`
   * Protocol: ``Any``
   * Source: `Security group`
   * Security group: `Self` (`Self`) ||
   || {{ metastore-name }} | For incoming client traffic
   |
   * Port range: `30000-32767`
   * Protocol: ``Any``
   * Source: `CIDR`
   * CIDR blocks: `0.0.0.0/0` ||
   || {{ metastore-name }} | For incoming load balancer traffic
   |
   * Port range: `10256`
   * Protocol: ``Any``
   * Source: `Load balancer health checks` ||
   || {{ dataproc-name }} | For outgoing service traffic
   |
   * Port range: `{{ port-any }}`
   * Protocol: ``Any``
   * Source: `Security group`
   * Security group: `Self` (`Self`) ||
   || {{ dataproc-name }} | For outgoing HTTPS traffic
   |
   * Port range: `{{ port-https }}`
   * Protocol: `TCP`
   * Destination type: `CIDR`
   * CIDR blocks: `0.0.0.0/0` ||
   || {{ dataproc-name }} | For outgoing traffic to allow {{ dataproc-name }} cluster connections to {{ metastore-name }}
   |
   * Port range: `{{ port-metastore }}`
   * Protocol: ``Any``
   * Source: `CIDR`
   * CIDR blocks: `0.0.0.0/0` ||
   |#

   {% endcut %}

1. [Create a {{ metastore-name }} cluster](../../data-proc/operations/metastore/cluster-create.md) with the following settings:

   * **Network**: `dataproc-network`.
   * **Subnet**: `dataproc-network-ru-central1-a`.
   * **Security group**: Default group in `dataproc-network`.
   * **Key ID** and **secret key**: Belong to the static access key.

1. [Create a {{ maf-name }} cluster](../../managed-airflow/operations/cluster-create.md) with the following settings:

   * **Availability zone**: `ru-central1-a`.
   * **Network**: `dataproc-network`.
   * **Subnet**: `dataproc-network-ru-central1-a`.
   * **Security group**: Default group in `dataproc-network`.
   * **Bucket name**: `airflow-bucket`.
   * **Key ID** and **secret key**: Belong to the static access key.

## Prepare a PySpark job {#prepare-a-job}

For a PySpark job, we will use a Python script that creates a table and is stored in the {{ objstorage-name }} bucket. Prepare a script file:

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
   df = spark.createDataFrame([(''Australia', 'Canberra', 7686850, 19731984), ('Austria', 'Vienna', 83855, 7700000)], schema)

   # Writing the dataframe to a bucket as the countries table
   df.write.mode("overwrite").option("path","s3a://output-bucket/countries").saveAsTable("countries")
   ```

   {% endcut %}

1. Create a `scripts` folder in `pyspark-bucket` and [upload](../../storage/operations/objects/upload.md#simple) the `create-table.py` file to it.

## Create {{ AF }} connections {#connections}

For DAG tasks, we will use two connections: one for {{ objstorage-name }} and one for the service account. They will be specified in the DAG file. To create connections:

1. [Open the {{ AF }} web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Go to **Admin** → **Connections**.
1. Click ![image](../../_assets/managed-airflow/blue-plus.png =18x).
1. Create a connection for {{ objstorage-name }}. Specify its parameters:

   * **Connection Id**: `yc-s3`
   * **Connection Type**: `Amazon Elastic MapReduce`
   * **Run Job Flow Configuration**: JSON file, such as:

      ```json
      {
         "aws_access_key_id": "<static_key_ID>",
         "aws_secret_access_key": "<secret_key>",
         "host": "https://storage.yandexcloud.net/"
      }
      ```

      In the file, specify the data of the static access key that you [created earlier](#infra).

1. Click **Save**.
1. Click ![image](../../_assets/managed-airflow/blue-plus.png =18x) once again to create a connection for the service account.
1. Specify the connection parameters:

   * **Connection Id**: `yc-airflow-sa`.
   * **Connection Type**: `{{ yandex-cloud }}`.
   * **Service account auth JSON**: Contents of the JSON file with the authorized key.
   * **Public SSH key**: Public part of the [previously created](#infra) authorized key. Write the key as a single string without any line break characters.

   Leave the other fields empty.

1. Click **Save**.

## Prepare and run a DAG file {#dag}

A DAG will have multiple vertices that form a sequence of consecutive actions:

1. {{ maf-name }} creates a temporary lightweight {{ dataproc-name }} cluster whose settings are set in the DAG. This cluster automatically connects to the previously created {{ metastore-name }} cluster.
1. When the {{ dataproc-name }} cluster is ready, a PySpark job is run.
1. Once the job is executed, the temporary {{ dataproc-name }} cluster is deleted.

To prepare a DAG:

1. [Create an SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Save the public part of the key: you will need it to create a {{ dataproc-name }} cluster.
1. Create a local file named `Data-Proc-DAG.py`, copy the following script to it and insert your infrastructure data in variables:

   {% cut "Data-Proc-DAG.py" %}

   ```python
   import uuid
   import datetime
   from airflow import DAG, settings
   from airflow.models import Connection, Variable
   from airflow.utils.trigger_rule import TriggerRule
   from airflow.providers.amazon.aws.sensors.s3 import S3KeySensor
   from airflow.providers.amazon.aws.operators.s3 import S3DeleteObjectsOperator
   from airflow.providers.yandex.operators.yandexcloud_dataproc import (
       DataprocCreateClusterOperator,
       DataprocCreatePysparkJobOperator,
       DataprocDeleteClusterOperator,
   )

   # Your infrastructure data
   YC_DP_FOLDER_ID = ''                 # ID of the cloud folder.
   YC_DP_SSH_PUBLIC_KEY = ''            # Public part of the SSH key for the {{ dataproc-name }} cluster.
   YC_DP_SUBNET_ID = ''                 # Subnet ID.
   YC_DP_GROUP_ID = ''                  # Security group ID.
   YC_DP_SA_ID = ''                     # Service account ID.
   YC_DP_METASTORE_URI = ''             # IP address of the {{ metastore-name }} cluster.
   YC_DP_AZ = 'ru-central1-a'           # Availability zone for the {{ dataproc-name }} cluster.
   YC_SOURCE_BUCKET = 'pyspark-bucket'  # Bucket with the Python script for the PySpark job.
   YC_DP_LOGS_BUCKET = 'log-bucket'     # Bucket for storing logs.

   # Creating a connection for {{ objstorage-name }}
   session = settings.Session()
   ycS3_connection = Connection(
       conn_id='yc-s3'
   )
   if not session.query(Connection).filter(Connection.conn_id == ycS3_connection.conn_id).first():
       session.add(ycS3_connection)
       session.commit()

   # Creating a connection for the service account
   ycSA_connection = Connection(
       conn_id='yc-airflow-sa'
   )
   if not session.query(Connection).filter(Connection.conn_id == ycSA_connection.conn_id).first():
       session.add(ycSA_connection)
       session.commit()

   # DAG settings
   with DAG(
           'DATA_INGEST',
           schedule_interval='@hourly',
           tags=['data-proc-and-airflow'],
           start_date=datetime.datetime.now(),
           max_active_runs=1,
           catchup=False
   ) as ingest_dag:

       # Step 1: creating a {{ dataproc-name }} cluster
       create_spark_cluster = DataprocCreateClusterOperator(
           task_id='dp-cluster-create-task',
           folder_id=YC_DP_FOLDER_ID,
           cluster_name=f'tmp-dp-{uuid.uuid4()}',
           cluster_description='A temporary cluster for running a PySpark job orchestrated by {{ maf-name }}',
           ssh_public_keys=YC_DP_SSH_PUBLIC_KEY,
           subnet_id=YC_DP_SUBNET_ID,
           s3_bucket=YC_DP_LOGS_BUCKET,
           service_account_id=YC_DP_SA_ID,
           zone=YC_DP_AZ,
           cluster_image_version='2.1.7',
           enable_ui_proxy=False,
           masternode_resource_preset='s2.small',
           masternode_disk_type='network-ssd',
           masternode_disk_size=200,
           computenode_resource_preset='m2.large',
           computenode_disk_type='network-ssd',
           computenode_disk_size=200,
           computenode_count=2,
           computenode_max_hosts_count=5,  # The number of subclusters for handling data will be automatically scaled up if the load is high.
           services=['YARN', 'SPARK'],     # A lightweight cluster is created.
           datanode_count=0,               # Without data storage subclusters.
           properties={                    # With a reference to a remote {{ metastore-name }} cluster.
               'spark:spark.hive.metastore.uris': f'thrift://{YC_DP_METASTORE_URI}:9083',
           },
           security_group_ids=[YC_DP_GROUP_ID],
           connection_id=ycSA_connection.conn_id,
           dag=ingest_dag
       )

       # Step 2: running a PySpark job
       poke_spark_processing = DataprocCreatePysparkJobOperator(
           task_id='dp-cluster-pyspark-task',
           main_python_file_uri=f's3a://{YC_SOURCE_BUCKET}/scripts/create-table.py',
           connection_id=ycSA_connection.conn_id,
           dag=ingest_dag
       )

       # Step 3: deleting the {{ dataproc-name }} cluster
       delete_spark_cluster = DataprocDeleteClusterOperator(
           task_id='dp-cluster-delete-task',
           trigger_rule=TriggerRule.ALL_DONE,
           dag=ingest_dag
       )

       # Building a DAG based on the above steps
       create_spark_cluster >> poke_spark_processing >> delete_spark_cluster
   ```

   {% endcut %}

1. Upload the DAG to the {{ maf-name }} cluster: in your `airflow-bucket`, create a folder named `dags` and upload the `Data-Proc-DAG.py` file to it.
1. [Open the {{ AF }} web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Make sure the **DAGs** section now contains a new DAG named `DATA_INGEST` and tagged as `data-proc-and-airflow`.

   It may take a few minutes to load the DAG file from the bucket.

1. To run the DAG, first click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name and then click **Trigger DAG**.

## Check the result {#check-out}

1. To monitor task execution results, click the DAG name. The results are displayed in the **Grid** tab.
1. Wait until the status of all the three tasks in the DAG changes to **Success**. Simultaneously, you can check that a {{ dataproc-name }} cluster is being created, the PySpark job is running, and the same cluster is being deleted in the [management console]({{ link-console-main }}) .
1. Make sure your `output-bucket` now contains a folder named `countries` with the `part-00000-...` file. The data from the created table is now stored in the {{ objstorage-name }} bucket and the table metadata is stored in the {{ metastore-name }} cluster.
1. Make sure you have the PySpark job logs in your `log-bucket`.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../iam/operations/sa/delete.md).
1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md).
1. [{{ metastore-name }} cluster](../../data-proc/operations/metastore/cluster-delete.md).
1. [{{ maf-name }} cluster](../../managed-airflow/operations/cluster-delete.md).
1. Route table.
1. NAT gateway.
1. [Security group](../../vpc/operations/security-group-delete.md).
1. [Cloud subnets](../../vpc/operations/subnet-delete.md) created in `dataproc-network` by default.
1. [Cloud network](../../vpc/operations/network-delete.md).
