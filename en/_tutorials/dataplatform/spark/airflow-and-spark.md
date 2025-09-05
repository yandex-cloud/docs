# Automating operations with {{ msp-full-name }} using {{ maf-full-name }}


With {{ maf-full-name }}, you can create a [directed acyclic task graph (DAG)](../../../managed-airflow/concepts/index.md) to automate your operations with [{{ msp-full-name }}](../../../managed-spark/index.yaml). Below is an example of a DAG that includes multiple tasks:

1. Create a {{ SPRK }} cluster.
1. Run a PySpark job.
1. Delete the {{ SPRK }} cluster.

With a DAG like this, a cluster is short-lived. In a cluster, you can engage higher capacity resources and process more data quickly.

In this DAG, an {{ SPRK }} cluster is created. We use a [{{ metastore-full-name }} cluster](../../../metadata-hub/concepts/metastore.md) to store tabular metadata in the example below. The saved metadata can then be used by another {{ SPRK }} cluster.

To use {{ msp-full-name }} in {{ maf-full-name }}:

1. [Set up your infrastructure](#infra).
1. [Prepare a PySpark job](#prepare-a-job).
1. [Prepare and run a DAG file](#dag).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ AF }} cluster fee: Computing resources of the cluster components (see [{{ maf-full-name }} pricing](../../../managed-airflow/pricing.md)).
* Fee for the {{ metastore-name }} cluster computing resources (see [{{ metadata-hub-full-name }} pricing](../../../metadata-hub/pricing.md#metastore)).
* {{ objstorage-name }} bucket fee: storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* Fee for collecting and storing logs (see [{{ cloud-logging-name }} pricing](../../../logging/pricing.md)).


## Set up your infrastructure {#infra}

The example below illustrates two scenarios. Select the one you find most relevant:

* **High security level**. This is a recommended scenario because it follows the [principle of least privilege](../../../iam/best-practices/using-iam-securely.md#restrict-access). This scenario entails the following:

   * Splitting access permissions across different service accounts. You have to create a separate service account for each cluster and assign it only those roles required for this account's cluster to function.
   * Using multiple buckets for different tasks and storing different data in separate buckets. For example, a DAG is loaded into one bucket, while the results of the PySpark job are written into another bucket.
   * Setting up security groups. This way, you can restrict traffic and grant access only to authorized resources.

* **Simplified setup**. This scenario implies a lower security level:

   * Using a single service account with more privileges than required.
   * Storing all data in a single bucket but in different folders.
   * No security groups are set up.

{% list tabs group=instructions %}

* High security level

  Set up your infrastructure:

  1. [Create service accounts](../../../iam/operations/sa/create.md) with the following roles:

     #|
     || **Service account** | **Roles** ||
     || `airflow-agent` for a {{ AF }} cluster |
     * [{{ roles.maf.integrationProvider }}](../../../iam/roles-reference.md#managed-airflow-integrationProvider): To enable the {{ AF }} cluster to [interact with other resources](../../../managed-airflow/concepts/impersonation.md).
     * [managed-spark.editor](../../../iam/roles-reference.md#managed-spark-editor): To manage an {{ SPRK }} cluster from a DAG.
     * [iam.serviceAccounts.user](../../../iam/roles-reference.md#iam-serviceAccounts-user): To specify the `spark-agent` service account when creating an {{ SPRK }} cluster.
     * [{{ roles-vpc-user }}](../../../iam/roles-reference.md#vpc-user): To use the [{{ vpc-full-name }} subnet](../../../vpc/concepts/network.md#subnet) in the {{ AF }} cluster.
     * [logging.editor](../../../iam/roles-reference.md#logging-editor): To work with log groups.
     * [logging.reader](../../../iam/roles-reference.md#logging-reader): To read logs.
     * [mdb.viewer](../../../iam/roles-reference.md#mdb-viewer): To get operation statuses.
     * [{{ roles.metastore.viewer }}](../../../iam/roles-reference.md#managed-metastore-viewer): To view information about Hive Metastore clusters. ||
     || `metastore-agent` for a {{ metastore-name }} cluster |
     * [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider): To enable the {{ metastore-name }} cluster to [interact with other resources](../../../metadata-hub/concepts/metastore-impersonation.md). ||
     || `spark-agent` for a {{ SPRK }} cluster |
     * [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider): To enable the {{ SPRK }} cluster to interact with other resources. ||
     |#

  1. [Create buckets](../../../storage/operations/buckets/create.md):

     * `<Airflow_DAG_source_code_bucket>`.
     * `<bucket_for_PySpark_job_source_code>`.
     * `<bucket_for_PySpark_job_output_data>`.

     You need multiple buckets with different access permissions.

  1. [Grant permissions](../../../storage/operations/buckets/edit-acl.md) for the buckets as follows:

     * `<Airflow_DAG_source_code_bucket>`: `READ` permission to the `airflow-agent` service account.
     * `<bucket_for_PySpark_job_source_code>`: `READ` permission to the `spark-agent` service account.
     * `<bucket_for_PySpark_job_output_data>`: `READ and WRITE` permissions to the `spark-agent` and `metastore-agent` service accounts.

  1. [Create a cloud network](../../../vpc/operations/network-create.md) named `datalake-network`.

     This will automatically create three subnets in different availability zones.

  1. For the {{ metastore-name }} cluster, [create a security group](../../../vpc/operations/security-group-create.md) named `metastore-sg` in the `datalake-network`. Add the following rules to the group:

     * For incoming client traffic:

        * Port range: `30000-32767`
        * Protocol: `Any`
        * Source: `CIDR`
        * CIDR blocks: `0.0.0.0/0`

     * For incoming load balancer traffic:

        * Port range: `10256`
        * Protocol: `Any`
        * Source: `Load balancer health checks`

  1. For the {{ AF }} cluster, create a security group named `airflow-sg` in `datalake-network`. Add the following rule to the group:

     * For outgoing HTTPS traffic:

        * Port range: `{{ port-https }}`
        * Protocol: `TCP`
        * Destination: `CIDR`
        * CIDR blocks: `0.0.0.0/0`

  1. For the {{ SPRK }} cluster, create a security group named `spark-sg` in `datalake-network`. Add the following rule to the group:

     * For outgoing traffic, to allow {{ SPRK }} cluster connections to {{ metastore-name }}:

        * Port range: `{{ port-metastore }}`
        * Protocol: `Any`
        * Destination: `CIDR`
        * CIDR blocks: `0.0.0.0/0`

  1. [Create a {{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-create.md) with the following parameters:

     * **Service account**: `metastore-agent`
     * **Network**: `datalake-network`
     * **Subnet**: `datalake-network-{{ region-id }}-a`
     * **Security group**: `metastore-sg`

     {% note info %}
   
     Wait for the operation to complete.
   
     {% endnote %}

  1. [Create a {{ maf-name }} cluster](../../../managed-airflow/operations/cluster-create.md) with the following parameters:

     * **Service account**: `airflow-agent`
     * **Availability zone**: `{{ region-id }}-a`
     * **Network**: `datalake-network`
     * **Subnet**: `datalake-network-{{ region-id }}-a`
     * **Security group**: `airflow-sg`
     * **Bucket name**: `<Airflow_DAG_source_code_bucket>`

* Simplified setup

  Set up your infrastructure:

  1. [Create a service account](../../../iam/operations/sa/create.md) named `integration-agent` with the following roles:

     * [{{ roles.maf.integrationProvider }}](../../../iam/roles-reference.md#managed-airflow-integrationProvider): To enable the {{ AF }} cluster to [interact with other resources](../../../managed-airflow/concepts/impersonation.md).
     * [managed-spark.editor](../../../iam/roles-reference.md#managed-spark-editor): To manage an {{ SPRK }} cluster from a DAG.
     * [iam.serviceAccounts.user](../../../iam/roles-reference.md#iam-serviceAccounts-user): To specify the `spark-agent` service account when creating an {{ SPRK }} cluster.
     * [{{ roles-vpc-user }}](../../../iam/roles-reference.md#vpc-user): To use the [{{ vpc-full-name }} subnet](../../../vpc/concepts/network.md#subnet) in the {{ AF }} cluster.
     * [logging.editor](../../../iam/roles-reference.md#logging-editor): To work with log groups.
     * [logging.reader](../../../iam/roles-reference.md#logging-reader): To read logs.
     * [mdb.viewer](../../../iam/roles-reference.md#mdb-viewer): To get operation statuses.
     * [{{ roles.metastore.viewer }}](../../../iam/roles-reference.md#managed-metastore-viewer): To view information about {{ metastore-full-name }} clusters.
     * [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider): To enable the {{ metastore-name }} cluster to [interact with other resources](../../../metadata-hub/concepts/metastore-impersonation.md).
     * [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider): To enable the {{ SPRK }} cluster to interact with other resources. 

  1. [Create a bucket](../../../storage/operations/buckets/create.md) named `<bucket_for_jobs_and_data>` and [provide](../../../storage/operations/buckets/edit-acl.md) `READ and WRITE` permissions to the `integration-agent` service account.

  1. [Create a cloud network](../../../vpc/operations/network-create.md) named `datalake-network`.

      This will automatically create three subnets in different availability zones and a security group.

  1. [Create a {{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-create.md) with the following parameters:

     * **Service account**: `integration-agent`
     * **Network**: `datalake-network`
     * **Subnet**: `datalake-network-{{ region-id }}-a`
     * **Security group**: Default group in `datalake-network`

     {% note info %}
   
     Wait for the operation to complete.
   
     {% endnote %}

  1. [Create a {{ maf-name }} cluster](../../../managed-airflow/operations/cluster-create.md) with the following parameters:

     * **Service account**: `integration-agent`
     * **Availability zone**: `{{ region-id }}-a`
     * **Network**: `datalake-network`
     * **Subnet**: `datalake-network-{{ region-id }}-a`
     * **Security group**: Default group in `datalake-network`
     * **Bucket name**: `<bucket_for_jobs_and_data>`

{% endlist %}

## Prepare a PySpark job {#prepare-a-job}

For a PySpark job, we will use a Python script that creates a table and is stored in the {{ objstorage-name }} bucket. Prepare a script file:

{% list tabs group=instructions %}

* High security level

  1. Create a local file named `job_with_table.py` and paste the following script to it:

     {% cut "job_with_table.py" %}

     {% include [pyspark](../../_tutorials_includes/spark/job-with-table-pyspark.md) %}

     { % endcut %}

  1. In `<bucket_for_PySpark_job_source_code>`, create a folder named `scripts` and [upload](../../../storage/operations/objects/upload.md#simple) the `job_with_table.py` file to it.

* Simplified setup

  1. Create a local file named `job_with_table.py` and paste the following script to it:

     {% cut "job_with_table.py" %}

     {% include [pyspark](../../_tutorials_includes/spark/job-with-table-pyspark.md) %}

     { % endcut %}

  1. In `<bucket_for_jobs_and_data>`, create a folder named `scripts` and [upload](../../../storage/operations/objects/upload.md#simple) the `job_with_table.py` file to it.

{% endlist %}

## Prepare and run a DAG file {#dag}

A DAG will have multiple vertices that form a sequence of consecutive actions:

1. {{ maf-full-name }} creates a temporary {{ SPRK }} cluster with settings specified in the DAG. This cluster automatically connects to the previously created {{ metastore-name }} cluster.
1. When the {{ SPRK }} cluster is ready, a PySpark job is run.
1. Once the job is complete, the temporary {{ SPRK }} cluster is deleted.

To prepare a DAG:

{% list tabs group=instructions %}

* High security level

  1. Create a local file named `dag.py`, paste the following script to it and substitute the variables with your infrastructure data:

     {% cut "dag.py" %}

     ```python
     import logging
     import pendulum
     from airflow.models.dag import DAG
     from airflow.decorators import task
     from airflow.providers.yandex.hooks.yandex import YandexCloudBaseHook

     from yandexcloud.operations import OperationError


     YANDEX_CONN_ID = '<connection_ID>'

     # Your infrastructure data
     FOLDER_ID = '<folder_ID>'
     SERVICE_ACCOUNT_ID = '<spark-agent_service_account_ID>'
     SUBNET_IDS = [<subnet_ID>]
     SECURITY_GROUP_IDS = [<security_group_ID>]
     METASTORE_CLUSTER_ID = '<Metastore_cluster_ID>'

     JOB_NAME = 'job_with_table'
     JOB_SCRIPT = 's3a://<bucket_for_PySpark_job_source_code>/scripts/job_with_table.py'
     JOB_ARGS = []
     JOB_PROPERTIES = {
         'spark.executor.instances': '1',
         'spark.sql.warehouse.dir': 's3a://<bucket_for_PySpark_job_output_data>/warehouse',
     }


     @task
     # Step 1: Creating a {{ SPRK }} cluster
     def create_cluster(yc_hook, cluster_spec):
         spark_client = yc_hook.sdk.wrappers.Spark()
         try:
             spark_client.create_cluster(cluster_spec)
         except OperationError as job_error:
             cluster_id = job_error.operation_result.meta.cluster_id
             if cluster_id:
                 spark_client.delete_cluster(cluster_id=cluster_id)
             raise
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
     # Step 3: Deleting a {{ SPRK }} cluster
     def delete_cluster(yc_hook, cluster_id):
         if cluster_id:
             spark_client = yc_hook.sdk.wrappers.Spark()
             spark_client.delete_cluster(cluster_id=cluster_id)


     # DAG settings
     with DAG(
         dag_id="example_spark",
         start_date=pendulum.datetime(2025, 1, 1),
         schedule=None,
     ):
         yc_hook = YandexCloudBaseHook(yandex_conn_id=YANDEX_CONN_ID)

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
             metastore_cluster_id=METASTORE_CLUSTER_ID,
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

     * `YANDEX_CONN_ID`: Connection ID.
     * `FOLDER_ID`: ID of the folder you will create the {{ SPRK }} cluster in.
     * `SERVICE_ACCOUNT_ID`: ID of the service account you will use to create the {{ SPRK }} cluster.
     * `SUBNET_IDS`: Subnet ID.

        {% note info %}
      
        {{ SPRK }} must have the same subnet as {{ metastore-name }}.
      
        {% endnote %}

     * `SECURITY_GROUP_IDS`: ID of the security group for the {{ SPRK }} cluster.
     * `METASTORE_CLUSTER_ID`: {{ metastore-name }} cluster ID.
     * `JOB_NAME`: PySpark job name.
     * `JOB_SCRIPT`: Path to PySpark job file.
     * `JOB_ARGS`: PySpark job arguments.
     * `JOB_PROPERTIES`: PySpark job properties.

     {% endcut %}

  1. Upload the DAG to the {{ AF }} cluster: in `<Airflow_DAG_source_code_bucket>`, create a folder named `dags` and upload the `dag.py` file to it.
  1. Open the {{ AF }} web interface.
  1. Make sure the new `example_spark` DAG file has appeared in the **DAGs** section.

     It may take a few minutes to upload a DAG file from the bucket.

  1. To run the DAG, click ![image](../../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

* Simplified setup

  1. Create a local file named `dag.py`, paste the following script to it and substitute the variables with your infrastructure data:

     {% cut "dag.py" %}

     ```python
     import logging
     import pendulum
     from airflow.models.dag import DAG
     from airflow.decorators import task
     from airflow.providers.yandex.hooks.yandex import YandexCloudBaseHook

     from yandexcloud.operations import OperationError


     YANDEX_CONN_ID = '<connection_ID>'

     # Your infrastructure data
     FOLDER_ID = '<folder_ID>'
     SERVICE_ACCOUNT_ID = '<integration-agent_service_account_ID>'
     SUBNET_IDS = [<subnet_ID>]
     SECURITY_GROUP_IDS = [<security_group_ID>]
     METASTORE_CLUSTER_ID = '<Metastore_cluster_ID>'

     JOB_NAME = 'job_with_table'
     JOB_SCRIPT = 's3a://<bucket_for_jobs_and_data>/scripts/job_with_table.py'
     JOB_ARGS = []
     JOB_PROPERTIES = {
         'spark.executor.instances': '1',
         'spark.sql.warehouse.dir': 's3a://<bucket_for_jobs_and_data>/warehouse',
     }


     @task
     # Step 1: Creating a {{ SPRK }} cluster
     def create_cluster(yc_hook, cluster_spec):
         spark_client = yc_hook.sdk.wrappers.Spark()
         try:
             spark_client.create_cluster(cluster_spec)
         except OperationError as job_error:
             cluster_id = job_error.operation_result.meta.cluster_id
             if cluster_id:
                 spark_client.delete_cluster(cluster_id=cluster_id)
             raise
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
     # Step 3: Deleting a {{ SPRK }} cluster
     def delete_cluster(yc_hook, cluster_id):
         if cluster_id:
             spark_client = yc_hook.sdk.wrappers.Spark()
             spark_client.delete_cluster(cluster_id=cluster_id)


     # DAG settings
     with DAG(
         dag_id="example_spark",
         start_date=pendulum.datetime(2025, 1, 1),
         schedule=None,
     ):
         yc_hook = YandexCloudBaseHook(yandex_conn_id=YANDEX_CONN_ID)

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
             metastore_cluster_id=METASTORE_CLUSTER_ID,
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

     * `YANDEX_CONN_ID`: Connection ID.
     * `FOLDER_ID`: ID of the folder you will create the {{ SPRK }} cluster in.
     * `SERVICE_ACCOUNT_ID`: ID of the service account you will use to create the {{ SPRK }} cluster.
     * `SUBNET_IDS`: Subnet ID.

        {% note info %}
      
        {{ SPRK }} must have the same subnet as {{ metastore-name }}.
      
        {% endnote %}

     * `SECURITY_GROUP_IDS`: ID of the security group for the {{ SPRK }} cluster.
     * `METASTORE_CLUSTER_ID`: {{ metastore-name }} cluster ID.
     * `JOB_NAME`: PySpark job name.
     * `JOB_SCRIPT`: Path to PySpark job file.
     * `JOB_ARGS`: PySpark job arguments.
     * `JOB_PROPERTIES`: PySpark job properties.

     { % endcut %}

  1. Upload the DAG to the {{ AF }} cluster: in `<bucket_for_jobs_and_data>`, create a folder named `dags` and upload the `dag.py` file to it.
  1. Open the {{ AF }} web interface.
  1. Make sure the new `example_spark` DAG file has appeared in the **DAGs** section.

     It may take a few minutes to upload a DAG file from the bucket.

  1. To run a DAG, click ![image](../../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

{% endlist %}

## Check the result {#check-out}

{% list tabs group=instructions %}

* High security level

  1. To monitor task execution results, click the DAG name.
  1. Wait until the status of all the three tasks in the DAG changes to **Success**. Simultaneously, you can check that a {{ SPRK }} cluster is being created, the PySpark job is running, and the same cluster is being deleted in the [management console]({{ link-console-main }}).
  1. Make sure `<bucket_for_PySpark_job_output_data>` now contains `database_1`. The data from the new DB is now stored in the {{ objstorage-name }} bucket, and the DB metadata is stored in the {{ metastore-name }} cluster.

* Simplified setup

  1. To monitor task execution results, click the DAG name.
  1. Wait until the status of all the three tasks in the DAG changes to **Success**. Simultaneously, you can check that a {{ SPRK }} cluster is being created, the PySpark job is running, and the same cluster is being deleted in the [management console]({{ link-console-main }}).
  1. Make sure `<bucket_for_jobs_and_data>` now contains `database_1`. The data from the new DB is now stored in the {{ objstorage-name }} bucket, and the DB metadata is stored in the {{ metastore-name }} cluster.

{% endlist %}
 
## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

* High security level

  1. [Service accounts](../../../iam/operations/sa/delete.md).
  1. [{{ objstorage-name }} buckets](../../../storage/operations/buckets/delete.md).
  1. [{{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-delete.md).
  1. [{{ AF }} cluster](../../../managed-airflow/operations/cluster-delete.md).
  1. [Security groups](../../../vpc/operations/security-group-delete.md).
  1. [Cloud subnets](../../../vpc/operations/subnet-delete.md) created in `datalake-network` by default.
  1. [Cloud network](../../../vpc/operations/network-delete.md).

* Simplified setup

  1. [Service account](../../../iam/operations/sa/delete.md)
  1. [{{ objstorage-name }} bucket](../../../storage/operations/buckets/delete.md)
  1. [{{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-delete.md).
  1. [{{ AF }} cluster](../../../managed-airflow/operations/cluster-delete.md).
  1. [Security group](../../../vpc/operations/security-group-delete.md) created in `datalake-network` by default.
  1. [Cloud subnets](../../../vpc/operations/subnet-delete.md) created in `datalake-network` by default.
  1. [Cloud network](../../../vpc/operations/network-delete.md).

{% endlist %}

