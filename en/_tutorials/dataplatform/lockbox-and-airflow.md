# Storing {{ AF }} connections and variables in {{ lockbox-full-name }}

When working with {{ maf-full-name }}, you can use [{{ lockbox-full-name }}](../../lockbox/index.yaml) to store artifacts that can be used in DAG files: connections, variables, and configuration data. {{ lockbox-name }} integrates into {{ maf-short-name }} via the [{{ lockbox-name }} Secret Backend](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/secrets-backends/yandex-cloud-lockbox-secret-backend.html) provider. As a result, access to the secret storage is configured automatically.

Below, we consider a [directed acyclic graph (DAG)](../../managed-airflow/concepts/index.md#about-the-service) running the `SELECT 1;` SQL query to a database in a {{ mpg-full-name }} cluster. Data for connecting to the DB is stored in {{ lockbox-name }} and automatically substituted into the graph.

To use configuration data from a {{ lockbox-name }} secret in the graph:

1. [Prepare your infrastructure](#create-infrastracture).
1. [Create a {{ lockbox-name }} secret](#create-lockbox-secret).
1. [Prepare the DAG file and run the graph](#dag).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#create-infrastracture}

1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `airflow-sa` with the following roles:

   * `managed-airflow.integrationProvider`
   * `lockbox.payloadViewer`

   {% note info }

   You do not have to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }} secret](../../lockbox/operations/secret-access.md) once you [create it](#create-lockbox-secret).

   {% endnote %}

1. [Create an {{ objstorage-name }}](../../storage/operations/buckets/create.md) bucket in any configuration.

1. {% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}

1. [Create a {{ maf-name }} cluster](../../managed-airflow/operations/cluster-create.md#create-cluster) with the following parameters:

   * **Service account**: `airflow-sa`
   * **Bucket name**: Name of the new bucket
   * **{{ ui-key.yacloud.airflow.field_lockbox }}**: Make sure to enable this option

1. [Create a {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) cluster with the following parameters:

   * **DB name**: `db1`
   * **Username**: `user1`
   * **Password**: `user1-password`

## Create a {{ lockbox-full-name }} secret {#create-lockbox-secret}

For the {{ AF }} cluster to work correctly, your {{ lockbox-name }} secret's name must have this format: `airflow/<artifact_type>/<artifact_ID>`, where:

   * `<artifact_type>`: Type of the artifact that will be stored in the secret. The following types are available:
     * `connections`: Connections
     * `variables`: Variables
     * `config`: Configuration data
   * `<artifact_ID>`: ID that will be used to access the artifact in {{ AF }}.

[Create a {{ lockbox-name }}](../../lockbox/operations/secret-create.md) secret with the following parameters:

   * **{{ ui-key.yacloud.common.name }}**: `airflow/connections/pg`
   * **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**: `Custom`
   * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: `airflow/connections/pg`
   * **{{ ui-key.yacloud.lockbox.forms.label_value }}**: Select **{{ ui-key.yacloud.lockbox.forms.value_payload-entry-value-type-text }}** and specify the following contents:

      ```json
      {
        "conn_type": "postgres",
        "host": "<{{ PG }}_cluster_host_FQDN>",
        "port": {{ port-mpg }},
        "schema": "db1",
        "login": "user1",
        "password": "user1-password"
      }
      ```

The secret will store the data to connect to the database in the {{ mpg-name }} cluster.

For more information on how to get the FQDN of a {{ PG }} cluster host, see the [documentation](https://yandex.cloud/ru/docs/managed-postgresql/operations/connect#fqdn).

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `test_lockbox_connection.py` and copy the following script to it:

   ```python
   from airflow import DAG
   from airflow.providers.postgres.operators.postgres import PostgresOperator
   from datetime import datetime

   with DAG(
     dag_id='test_lockbox_connection',
     start_date=datetime(2024, 4, 19),
     schedule="@once",
     catchup=False,
   ) as dag:
     check_conn = PostgresOperator(
         task_id="check_conn",
         postgres_conn_id='pg',
         sql="SELECT 1;",
     )
   ```

1. Upload the `test_lockbox_connection.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.

1. [Open the {{ AF }} web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).

1. Make sure a new graph named `test_lockbox_connection` has appeared in the **DAGs** section.

   It may take a few minutes to upload a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `test_lockbox_connection` graph.
1. Go to the **Graph** section.
1. Select the **check_conn** job.
1. Go to **Logs**.
1. Make sure the logs contain the `Rows affected: 1` string. This means the query was successful.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../iam/operations/sa/delete.md)
1. [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md)
1. [{{ lockbox-name }} secret](../../lockbox/operations/secret-delete.md)
1. [{{ maf-name }} cluster](../../managed-airflow/operations/cluster-delete.md#delete)
1. [{{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md#delete)
