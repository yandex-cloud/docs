---
title: Connecting to {{ mch-full-name }}
description: With a directed acyclic graph (DAG), you can configure a connection to a database in a {{ mch-full-name }} cluster.
---

# Connecting to {{ mch-full-name }}

With a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service), you can configure a connection to a database in a {{ mch-full-name }} cluster. Data for connecting to the DB is stored in {{ lockbox-name }} and automatically substituted into the graph.

## Getting started {#before-begin}

1. [Create a {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) cluster with the following parameters:
   * **DB name**: `default`
   * **Username**: `admin`
   * **Password**: `admin-password`

1. Issue the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer) to your service account.

   {% note info }

   You do not have to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }}](../../lockbox/operations/secret-access.md) secret once you [create it](#create-lockbox-secret).

   {% endnote %}

## Create a {{ lockbox-full-name }} secret {#create-lockbox-secret}

[Create a {{ lockbox-name }} secret](../../lockbox/operations/secret-create.md) named `airflow/connections/ch1`, containing `json.dumps(conn)`, where `conn` is a connection to a {{ mch-name }} cluster. As `conn_type`, specify `SQLite` or another SQL DB.

```json
conn = {
         "conn_type": "SQLite",
         "host": "<{{ CH }}_cluster_host_FQDN>",
         "port": 9440,
         "schema": "default",
         "login": "admin",
         "password": "admin-password",
         "extra": {
             "secure": True,
         }
}
```
The secret will store the data to connect to the database in the {{ mch-name }} cluster.

For more information on how to find out the FQDN of a {{ CH }} cluster host, see [{#T}](../../managed-clickhouse/operations/connect/fqdn.md).

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `clickhouse.py` and copy the following script to it:

   ```python
   from airflow.decorators import dag, task
   from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook


   @dag(schedule=None)
   def clickhouse():
       @task
       def query_clickhouse():
           ch_hook = ClickHouseHook(clickhouse_conn_id="ch1")
           result = ch_hook.execute('select 1;')
           print(f'query result: {result}')

       query_clickhouse()


   clickhouse()
   ```

1. Upload the `clickhouse.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `clickhouse` has appeared in the **DAGs** section.

   It may take a few minutes to upload a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `clickhouse` graph.
1. Go to the **Graph** section.
1. Select the **query_clickhouse** job.
1. Go to **Logs**.
1. Make sure the logs contain the `query result: 1` string. This means the query was successful.
