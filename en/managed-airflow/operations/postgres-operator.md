---
title: Connecting to {{ mpg-full-name }}
description: You can use a directed acyclic graph (DAG) to configure a connection to a database in a {{ mpg-full-name }} cluster.
---

# Connecting to {{ mpg-full-name }}

You can use a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service) to configure a connection to a database in a {{ mpg-full-name }} cluster. Data for connecting to the DB is stored in {{ lockbox-name }} and automatically inserted into the graph.

{% note tip %}

`apache-airflow-providers-postgres` 5.13.1 is used by default. If using a newer provider version, use SQLExecuteQueryOperator instead of PostgresOperator. For more information, see [the official documentation](https://airflow.apache.org/docs/apache-airflow-providers-postgres/6.0.0/operators/postgres_operator_howto_guide.html).

{% endnote %}

## Getting started {#before-begin}

1. [Create a {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) cluster with the following parameters:
   * **DB name**: `db1`
   * **Username**: `user1`
   * **Password**: `user1-password`

1. [Create](../../storage/operations/buckets/create.md) a {{ objstorage-full-name }} bucket to store the DAG file in.

1. [Configure the {{ maf-name }} cluster](cluster-update.md):

   1. Enable **{{ ui-key.yacloud.airflow.field_lockbox }}** to use [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) secrets to [store {{ AF }} configuration data, variables, and connection parameters](../concepts/impersonation.md#lockbox-integration).

   1. Under **{{ ui-key.yacloud.airflow.section_storage }}**, select the {{ objstorage-name }} bucket you created earlier. Your DAG file will be fetched from it.

1. Issue the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer) to your service account.

   {% note info }

   There is no need to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }}](../../lockbox/operations/secret-access.md) secret once you [create it](#create-lockbox-secret).

   {% endnote %}

## Create a {{ lockbox-full-name }} secret {#create-lockbox-secret}

For the {{ AF }} cluster to work correctly, your {{ lockbox-name }} secret's name must have this format: `airflow/<artifact_type>/<artifact_ID>`, where:
   * `<artifact_type>`: Decides what data will be stored in the secret. The possible values are:
     * `connections`: Connections
     * `variables`: Variables
     * `config`: Configuration data
   * `<artifact_ID>`: ID to use to access the artifact in {{ AF }}.

[Create a {{ lockbox-name }} secret](../../lockbox/operations/secret-create.md) with the following parameters:
   * **{{ ui-key.yacloud.common.name }}**: `airflow/connections/pg1`.
   * **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**: `Custom`.
   * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: `conn`.
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

For more information on how to get the FQDN of a {{ PG }} cluster host, see [{#T}](../../managed-postgresql/operations/connect.md#fqdn).

The secret will store the data to connect to the database in the {{ mpg-name }} cluster.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `postgres_operator.py` and paste the following script to it:

   ```python
   from airflow import DAG
   from airflow.providers.postgres.operators.postgres import PostgresOperator


   with DAG(
       dag_id='postgres_operator',
       schedule=None
   ):
       PostgresOperator(
           task_id="check_conn",
           postgres_conn_id='pg1',
           sql="SELECT 1;"
       )
   ```

1. Upload the `postgres_operator.py` DAG file to the bucket you created earlier.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `postgres_operator` has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `postgres_operator` graph.
1. Go to the **Graph** section.
1. Select **check_conn**.
1. Go to **Logs**.
1. Make sure the logs contain the `Rows affected: 1` line. This means the query was successful.
