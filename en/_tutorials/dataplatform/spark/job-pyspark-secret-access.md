# Using a {{ lockbox-name }} secret in a PySpark job to connect to {{ mpg-full-name }}

You can use a [{{ lockbox-name }}](../../../lockbox/concepts/secret.md) secret to connect to a [{{ mpg-full-name }}](../../../managed-postgresql/index.yaml) cluster from a PySpark job in [{{ msp-full-name }}](../../../managed-spark/index.yaml). To do this, grant the {{ msp-full-name }} cluster [service account](../../../iam/concepts/users/service-accounts.md) access to the secret. {{ connection-manager-full-name }} creates the secret automatically when creating the {{ mpg-name }} user.

For the PySpark job, we use a Python script stored in a {{ objstorage-full-name }} bucket. The script retrieves the user password from the secret and uses it to connect to the {{ mpg-name }} cluster.

To get information from the secret and connect to the {{ mpg-name }} cluster:

1. [Set up your infrastructure](#infra).
1. [Configure permissions for access to the user's secret](#set-up-roles).
1. [Prepare a PySpark job](#prepare-a-job).
1. [Run the job and check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ msp-full-name }} cluster: computing resources of cluster components (see [{{ msp-full-name }} pricing](../../../managed-spark/pricing.md)).
* {{ mpg-name }} cluster, which includes the use of computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* {{ objstorage-name }} bucket: use of storage, data operations (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* NAT gateway: hourly use of the gateway and its outgoing traffic (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).

There is no charge for using {{ lockbox-name }} secrets created with {{ connection-manager-name }}.

## Set up your infrastructure {#infra}

1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) named `spark-agent` and assign it the following roles:
  
    * [managed-spark.integrationProvider](../../../managed-spark/security.md#managed-spark-integrationProvider): For {{ msp-full-name }} integration with other services.
    * [storage.editor](../../../storage/security/index.md#storage-editor): For access to the PySpark job file in the {{ objstorage-name }} bucket.
  
1. [Create a bucket](../../../storage/operations/buckets/create.md). 
1. [Grant](../../../storage/operations/buckets/edit-acl.md) the `READ` permission to the `spark-agent` service account for the new bucket.

1. [Create a cloud network](../../../vpc/operations/network-create.md) named `spark-network`.

    This will automatically create three subnets in different availability zones.

1. In `spark-network`, [create a security group](../../../vpc/operations/security-group-create.md) named `spark-sg` for the {{ msp-full-name }} cluster to allow outgoing TCP connections on:
    
    * Port `{{ port-mpg }}` to connect to {{ PG }}.
    * Port `443` to download Maven packages.

1. In `spark-network`, create a security group named `pg-sg` for the {{ mpg-name }} cluster to allow incoming TCP connections on port `{{ port-mpg }}`.

1. [Create a {{ msp-full-name }} cluster](../../../managed-spark/operations/cluster-create.md) with the following settings:

    * **Service account**: `spark-agent`
    * **Network**: `spark-network`
    * **Security group**: `spark-sg`

1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) for the subnet where the {{ msp-full-name }} cluster was created. The NAT gateway is required to download the {{ PG }} JDBC driver from the Maven repository.

1. [Create a {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md) cluster with the following settings:

    * **Network**: `spark-network`
    * **Security group**: `pg-sg`

## Configure permissions for access to a {{ mpg-name }} user's secret {#set-up-roles}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the infrastructure.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click the connection ID next to the user you need.
    
      This will take you to the {{ connection-manager-name }} connection page for the selected user.
  
  1. On the page that opens, click the secret ID.

      This will open the page of the {{ lockbox-name }} secret storing the {{ PG }} user password.

  1. On the left-hand panel, select ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Select the `spark-agent` service account you want to grant secret access to.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select `lockbox.payloadViewer`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To configure access to the {{ mpg-name }} user secret:
  
  1. Get the secret ID from the {{ connection-manager-name }} connection:

      ```bash
      yc metadata-hub connection-manager connection list \
        --mdb-cluster-id <{{ PG }}_cluster_ID>
      ```

      You can get the cluster ID with the [list of clusters in the folder](../../../managed-postgresql/operations/cluster-list.md).
  
  1. Configure access to the user secret:

      ```bash
      yc lockbox secret add-access-binding <secret_ID> \
        --role lockbox.payloadViewer \
        --service-account-name spark-agent 
      ```

      The `spark-agent` service account will get access to the {{ mpg-name }} user secret.

{% endlist %}

## Prepare a PySpark job {#prepare-a-job}

1. Create a local file named `job-mpg-connection-with-secret.py` and paste the following script to it:

    {% cut "job-mpg-connection-with-secret.py" %}

    {% include [py](../../_tutorials_includes/spark/job-mpg-connection-with-secret.md) %}

    {% endcut %}

1. In the script file, specify the following settings:
    
    * Secret ID.
    * [Host FQDN](../../../managed-postgresql/operations/connect/fqdn.md) to connect to the {{ mpg-name }} cluster.
    * Database name.
    * Table name.

## Run the job and check the result {#check-out}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Upload](../../../storage/operations/objects/upload.md#simple) the `job-mpg-connection-with-secret.py` file to the bucket.
  1. In the {{ msp-full-name }} cluster, [create a job](../../../managed-spark/operations/jobs-pyspark.md) with the following settings:
      
      * **Job type**: **PySpark**
      * **Main python file**: `s3a://<bucket_name>/job-mpg-connection-with-secret.py`
      * **Packages**: `org.postgresql:postgresql:42.7.3`

  1. Wait for the PySpark job you created to change its status to **Done**.
  1. [Get job execution logs](../../../managed-spark/operations/jobs-pyspark.md#get-logs).

      The job logs will display rows from the table specified in the script.

- CLI {#cli}
  
  1. Upload the `job-mpg-connection-with-secret.py` file to the bucket:

      ```bash
      yc storage s3api put-object \
        --body <local_file_path> \
        --bucket <bucket_name> \
        --key "job-mpg-connection-with-secret.py"
      ```
  
  1. Run the job:

      ```bash
      yc managed-spark job create-pyspark \
        --cluster-id <cluster_ID> \
        --name "<job_name>" \
        --main-python-file-uri s3a://<bucket_name>/job-mpg-connection-with-secret.py \
        --packages org.postgresql:postgresql:42.7.3
      ```

      You can get the cluster ID with the [list of clusters in the folder](../../../managed-spark/operations/cluster-list.md#list-clusters).

      The command will return the job ID. Save it as you will need it to get job execution logs.

  1. Get job execution logs:

      ```bash
      yc managed-spark job log <job_ID> \
        --cluster-id <cluster_ID>
      ```

      The job logs will display rows from the table specified in the script.

{% endlist %}
 
## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [{{ msp-full-name }} cluster](../../../managed-spark/operations/cluster-delete.md).
1. [{{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).
1. [{{ objstorage-name }} bucket](../../../storage/operations/buckets/delete.md). Before deleting the bucket, [delete all its objects](../../../storage/operations/objects/delete.md).
1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md).