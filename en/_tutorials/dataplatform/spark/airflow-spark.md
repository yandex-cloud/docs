# Running a PySpark job using {{ maf-full-name }}

You can use a {{ maf-full-name }} cluster to automate your work with [{{ msp-full-name }}](../../../managed-spark/index.yaml), including the following operations:
* Creating {{ SPRK }} clusters.
* Waiting for clusters to start.
* Running {{ SPRK }} jobs.
* Checking the results.
* Shutting down resources and deleting clusters.

Do it by creating a [directed acyclic graph (DAG) for jobs](../../../managed-airflow/concepts/index.md). The {{ AF }} cluster will use this DAG to automatically perform all its {{ SPRK }}-related actions.

Using {{ SPRK }} via {{ AF }} allows you to:
* Run jobs on a schedule to create reports and data snapshots, perform maintenance, metric updates, etc.
* Build pipelines comprising data analysis, experiments, model fine-tuning, and other tasks.
* Quickly process massive volumes of data on the fly without having to pay for a permanent infrastructure with high-power resources.

This tutorial describes the minimum steps for {{ AF }} integration with {{ SPRK }}, while not using any [{{ objstorage-name }}](../../../storage/concepts/index.md) S3 storage or [{{ metastore-name }}](../../../metadata-hub/concepts/metastore.md) cluster. In this configuration, the {{ SPRK }} cluster can only work with in-memory data: create temporary dataframes, apply standard transformations and functions, cache results, and use temporary views for SQL queries.

{% note info %}

To work with permanent databases and tables and for long-term storage of results, you need an external {{ objstorage-name }} storage and, if necessary, an {{ metastore-name }} cluster for data management.

{% endnote %}

The {{ AF }} to {{ SPRK }} integration is illustrated with a DAG that performs the following operations:

1. Creating an {{ SPRK }} cluster.
1. Running a PySpark job.
1. Deleting the {{ SPRK }} cluster.

To implement the above example:

1. [Set up your infrastructure](#infra).
1. [Prepare a PySpark job](#prepare-a-job).
1. [Prepare and run a DAG file](#dag).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for the computing resources of {{ maf-name }} cluster components (see [{{ maf-full-name }} pricing](../../../managed-airflow/pricing.md)).
* {{ objstorage-name }} bucket fee for storage and data operations (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* {{ cloud-logging-name }} fee for the amount of data written and the time of its retention (see [{{ cloud-logging-name }} pricing](../../../logging/pricing.md)).
* Fee for the computing resources of {{ msp-full-name }} cluster components (see [{{ msp-full-name }} pricing](../../../managed-spark/pricing.md)).


## Set up the infrastructure {#infra}

In this tutorial uses a simplified infrastructure setup:

* A single service account with advanced privileges.
* A single bucket for the whole data.
* The default security group.

This setup is good for testing but does not ensure a sufficient security level for real-world scenarios. To make the solution more secure, adhere to the [principle of least privilege](../../../iam/best-practices/using-iam-securely.md#restrict-access).

Set up the infrastructure:

1. [Create a service account](../../../iam/operations/sa/create.md) named `integration-agent` with the following roles:

   * [{{ roles.maf.integrationProvider }}](../../../iam/roles-reference.md#managed-airflow-integrationProvider): To enable the {{ AF }} cluster to [interact with other resources](../../../managed-airflow/concepts/impersonation.md).
   * [managed-spark.editor](../../../iam/roles-reference.md#managed-spark-editor): To manage your {{ SPRK }} cluster from a DAG.
   * [iam.serviceAccounts.user](../../../iam/roles-reference.md#iam-serviceAccounts-user): To select the `integration-agent` service account when creating the {{ SPRK }} cluster.
   * [{{ roles-vpc-user }}](../../../iam/roles-reference.md#vpc-user): To use the [{{ vpc-full-name }} subnet](../../../vpc/concepts/network.md#subnet) in the {{ AF }} cluster.
   * [logging.editor](../../../iam/roles-reference.md#logging-editor): To work with log groups.
   * [logging.reader](../../../iam/roles-reference.md#logging-reader): To read logs.
   * [mdb.viewer](../../../iam/roles-reference.md#mdb-viewer): To get operation statuses.

1. [Create a bucket](../../../storage/operations/buckets/create.md).

1. [Grant](../../../storage/operations/buckets/edit-acl.md) the `READ and WRITE` permissions for the bucket to the `integration-agent` service account.

1. [Create a cloud network](../../../vpc/operations/network-create.md) named `datalake-network`.

   This will automatically create three subnets in different availability zones and a security group.

1. [Create a {{ maf-name }} cluster](../../../managed-airflow/operations/cluster-create.md) with the following parameters:

   * **Service account**: `integration-agent`.
   * **Availability zone**: `{{ region-id }}-a`.
   * **Network**: `datalake-network`.
   * **Subnet**: `datalake-network-{{ region-id }}-a`.
   * **Security group**: Default group in `datalake-network`.
   * **Bucket name**: The name of the previously created bucket.

## Prepare a PySpark job {#prepare-a-job}

For a PySpark job, we will use a Python script that:

1. Creates a dataframe with numbers from 0 to 9.
1. Outputs the number of rows in the new dataframe.
1. Outputs the first five rows in table format. 

The script will be stored in the {{ objstorage-name }} bucket.

Prepare a script file:

1. Create a local file named `job_minimal.py` and paste the following script to it:

   ```python
   from pyspark.sql import SparkSession

   spark = (SparkSession.builder.appName("hello_spark").getOrCreate())
   
   df = spark.range(10).toDF("id")

   print("Row count:", df.count())
   df.show(5, truncate=False)
   
   spark.stop()
   ```

1. In the bucket, create a folder named `scripts` and [upload](../../../storage/operations/objects/upload.md#simple) the `job_minimal.py` file to it.

## Prepare and run a DAG file {#dag}

A DAG will have multiple vertices that form a sequence of actions:

1. {{ maf-name }} creates a temporary {{ SPRK }} cluster with settings specified in the DAG.
1. When the {{ SPRK }} cluster is ready, a PySpark job is run.
1. Once the job is complete, the temporary {{ SPRK }} cluster is deleted.

To prepare a DAG:

1. Create a local file named `dag.py`, paste the following script to it and substitute the variables with your infrastructure data:

   {% cut "dag.py" %}

   ```python
   import logging
   import pendulum
   from airflow.models.dag import DAG
   from airflow.decorators import task
   from airflow.providers.yandex.hooks.yandex import YandexCloudBaseHook
   from airflow.exceptions import AirflowSkipException

   from yandexcloud.operations import OperationError

   # Your infrastructure data
   FOLDER_ID = '<folder_ID>'
   SERVICE_ACCOUNT_ID = '<integration-agent_service_account_ID>'
   SUBNET_IDS = ['<subnet_ID>']
   SECURITY_GROUP_IDS = ['<security_group_ID>']

   JOB_NAME = 'job_minimal'
   JOB_SCRIPT = 's3a://<bucket_name>/scripts/job_minimal.py'
   JOB_ARGS = []
   JOB_PROPERTIES = {
       'spark.executor.instances': '1',
   }


   @task
   # Step 1: Creating an {{ SPRK }} cluster
   def create_cluster(yc_hook, cluster_spec):
       spark_client = yc_hook.sdk.wrappers.Spark()
       spark_client.create_cluster(cluster_spec)
       return spark_client.cluster_id


   @task
   # Step 2: Running a PySpark job
   def run_spark_job(yc_hook, cluster_id, job_spec):
       spark_client = yc_hook.sdk.wrappers.Spark()
       try:
           job_operation = spark_client.create_pyspark_job(cluster_id=cluster_id, spec=job_spec)
           job_id = job_operation.response.id
           job_info = job_operation.response
       except OperationError as job_error:
           job_id = job_error.operation_result.meta.job_id
           job_info, _ = spark_client.get_job(cluster_id=cluster_id, job_id=job_id)
           raise
       finally:
           job_log = spark_client.get_job_log(cluster_id=cluster_id, job_id=job_id)
           for line in job_log:
               logging.info(line)
           logging.info("Job info: %s", job_info)


   @task(trigger_rule="all_done")
   # Step 3: Deleting the {{ SPRK }} cluster
   def delete_cluster(yc_hook, cluster_id):
       if cluster_id:
           spark_client = yc_hook.sdk.wrappers.Spark()
           spark_client.delete_cluster(cluster_id=cluster_id)
    else:
        raise AirflowSkipException("cluster_id is empty; nothing to delete")

   # DAG settings
   with DAG(
       dag_id="example_spark",
       start_date=pendulum.datetime(2025, 1, 1),
       schedule=None,
   ):
       yc_hook = YandexCloudBaseHook()

       cluster_spec = yc_hook.sdk.wrappers.SparkClusterParameters(
           folder_id=FOLDER_ID,
           service_account_id=SERVICE_ACCOUNT_ID,
           subnet_ids=SUBNET_IDS,
           security_group_ids=SECURITY_GROUP_IDS,
           driver_pool_resource_preset="c2-m8",
           driver_pool_size=1,
           executor_pool_resource_preset="c4-m16",
           executor_pool_min_size=1,
           executor_pool_max_size=2,
       )
       cluster_id = create_cluster(yc_hook, cluster_spec)

       job_spec = yc_hook.sdk.wrappers.PysparkJobParameters(
           name=JOB_NAME,
           main_python_file_uri=JOB_SCRIPT,
           args=JOB_ARGS,
           properties=JOB_PROPERTIES,
       )
       task_job = run_spark_job(yc_hook, cluster_id, job_spec)
       task_delete = delete_cluster(yc_hook, cluster_id)

       task_job >> task_delete
   ```

   Where:

   * `FOLDER_ID`: ID of the folder you will create the {{ SPRK }} cluster in.
   * `SERVICE_ACCOUNT_ID`: ID of the service account you will use to create the {{ SPRK }} cluster.
   * `SUBNET_IDS`: `datalake-network-{{ region-id }}-a` subnet ID.
   * `SECURITY_GROUP_IDS`: ID of the security group for the {{ SPRK }} cluster.
   * `JOB_NAME`: PySpark job name.
   * `JOB_SCRIPT`: Path to the PySpark job file in the bucket.
   * `JOB_ARGS`: PySpark job arguments.
   * `JOB_PROPERTIES`: PySpark job properties.

   {% endcut %}

1. Upload the DAG to the {{ AF }} cluster by creating a folder named `dags` in the bucket and uploading the `dag.py` file to it.
1. Open the [{{ AF }} web interface](../../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Make sure the new `example_spark` DAG has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. Run the DAG by clicking ![image](../../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-out}

1. In the [{{ AF }} web interface](../../../managed-airflow/operations/af-interfaces.md#web-gui), click the `example_spark` DAG name and monitor the progress of the jobs.
1. Wait until all three jobs in the DAG get **Success** status. 
1. Navigate to the `Graph` tab.
1. In the graph that opens, click the job named `run_spark_job` and go to the `Logs` tab.
1. Make sure the [PySpark job](#prepare-a-job) has produced a correct output to the log. Do it by finding these log lines:

   ```
   Row count: 10
   ```

   ```
   +---+
   |id |
   +---+
   |0  |
   |1  |
   |2  |
   |3  |
   |4  |
   +---+
   ```

{% note info %}

In the [management console]({{ link-console-main }}), you can monitor the {{ SPRK }} cluster creation, PySpark job completion, and cluster deletion processes.

{% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../../iam/operations/sa/delete.md).
1. [{{ objstorage-name }} bucket](../../../storage/operations/buckets/delete.md).
1. [{{ AF }} cluster](../../../managed-airflow/operations/cluster-delete.md).
1. [Security group](../../../vpc/operations/security-group-delete.md) created in `datalake-network` by default.
1. [Cloud subnets](../../../vpc/operations/subnet-delete.md) created in `datalake-network` by default.
1. [Cloud network](../../../vpc/operations/network-delete.md) named `datalake-network`.
