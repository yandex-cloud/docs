---
title: Connecting to {{ mpg-full-name }}
description: You can use a directed acyclic graph (DAG) to configure a connection to a database in a {{ mpg-full-name }} cluster.
---

# Connecting to {{ mpg-full-name }}

You can use a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service) to configure a connection to a database in a {{ mpg-full-name }} cluster. Data for connecting to the DB is stored in {{ lockbox-name }} and automatically substituted into the graph.

## Getting started {#before-begin}

1. [Create a {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) cluster with the following parameters:
   * **DB name**: `db1`
   * **Username**: `user1`
   * **Password**: `user1-password`

1. Issue the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer) to your service account.

   {% note info }

   You do not have to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }}](../../lockbox/operations/secret-access.md) secret once you [create it](#create-lockbox-secret).

   {% endnote %}

## Create a {{ lockbox-full-name }} secret {#create-lockbox-secret}

[Create a {{ lockbox-name }} secret](../../lockbox/operations/secret-create.md) named `airflow/connections/pg1` and containing `json.dumps(conn)`, where `conn` is a connection to a {{ mpg-name }} cluster.

```json
conn = {
         "conn_type": "postgres",
         "host": "<{{ PG }}_cluster_host_FQDN>",
         "port": 6432,
         "schema": "db1",
         "login": "user1",
         "password": "user1-password"
}
```

The `airflow/connections/pg1` secret will store the data for connection to the database in the {{ mpg-name }} cluster.

For more information on how to learn the FQDN of a {{ PG }} cluster host, see [{#T}](../../managed-postgresql/operations/connect.md#fqdn).

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `postgres_operator.py` and copy the following script to it:

   ```python
   from airflow import DAG
   from airflow.providers.postgres.operators.postgres import PostgresOperator


   with DAG(
       dag_id='postgres_operator',
       schedule=None,
   ):
       PostgresOperator(
           task_id="check_conn",
           postgres_conn_id='pg1',
           sql="SELECT 3;",
       )
   ```

1. Upload the `postgres_operator.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `postgres_operator` has appeared in the **DAGs** section.

   It may take a few minutes to upload a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `postgres_operator` graph.
1. Go to the **Graph** section.
1. Select the **check_conn** job.
1. Go to **Logs**.
1. Make sure the logs contain the `Rows affected: 3` string. This means the query was successful.
