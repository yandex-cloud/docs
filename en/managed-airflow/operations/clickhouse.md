---
title: Connecting to {{ mch-full-name }}
description: You can use a directed acyclic graph (DAG) to configure a connection to a database in a {{ mch-full-name }} cluster.
---

# Connecting to {{ mch-full-name }}

With a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service), you can configure a connection to a database in a {{ mch-full-name }} cluster. Data for connecting to the DB is stored in {{ lockbox-name }} and automatically inserted into the graph.

## Getting started {#before-begin}

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with the following parameters:
   * **DB name**: `default-bd`
   * **Username**: `admin`
   * **Password**: `admin-password`

   {% note warning %}
   
   You cannot create a database named `default`.
   
   {% endnote %}

1. [Create](../../storage/operations/buckets/create.md) a {{ objstorage-full-name }} bucket to store the DAG file in.

1. [Configure the {{ maf-name }} cluster](cluster-update.md):

   1. Enable the **{{ ui-key.yacloud.airflow.field_lockbox }}** option allowing you to use secrets in [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../concepts/impersonation.md#lockbox-integration).
   1. Under **{{ ui-key.yacloud.mdb.forms.section_dependencies }}**, add the `airflow-clickhouse-plugin` pip package.
   1. Under **{{ ui-key.yacloud.airflow.section_storage }}**, select the {{ objstorage-name }} bucket you created earlier. Your DAG file will be fetched from it.

1. Issue the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer) to your service account.

   {% note info }

   There is no need to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }} secret](../../lockbox/operations/secret-access.md) once you [create it](#create-lockbox-secret).

   {% endnote %}

## Create a {{ lockbox-full-name }} secret {#create-lockbox-secret}

{% include [lockbox-description](../../_includes/mdb/maf/lockbox-description.md) %}

[Create a {{ lockbox-name }}](../../lockbox/operations/secret-create.md) secret with the following parameters:
   * **{{ ui-key.yacloud.common.name }}**: `airflow/connections/ch`.
   * **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**: `Custom`.
   * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: `conn`.
   * **{{ ui-key.yacloud.lockbox.forms.label_value }}**: Select **{{ ui-key.yacloud.lockbox.forms.value_payload-entry-value-type-text }}** and specify the following contents:

      ```json
      {
        "conn_type": "clickhouse",
        "host": "<ClickHouse®_cluster_host_FQDN>",
        "port": 9440,
        "schema": "default-bd",
        "login": "admin",
        "password": "admin-password",
        "extra": {
            "secure": "True"
        }
      }
      ```

For more information on how to get the FQDN of a {{ CH }} cluster host, see [{#T}](../../managed-clickhouse/operations/connect/fqdn.md).

The secret will store the data to connect to the database in the {{ mch-name }} cluster.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `clickhouse.py` and paste the following script to it:

   ```python
   from airflow.decorators import dag, task
   from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook


   @dag(schedule=None)
   def clickhouse():
       @task
       def query_clickhouse():
           ch_hook = ClickHouseHook(clickhouse_conn_id="ch")
           result = ch_hook.execute('select 1;')
           print(f'query result: {result}')

       query_clickhouse()


   clickhouse()
   
   ```

1. Upload the `clickhouse.py` DAG file to the bucket you created earlier.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure there is a new graph named `clickhouse` in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

{% list tabs group=instructions %}
   
- {{ AF }} version below 3.0 {#version-2}

  1. In the **DAGs** section, open the `clickhouse` graph.
  1. Go to the **Graph** section.
  1. Select **query_clickhouse**.
  1. Go to **Logs**.
  1. Make sure the logs contain the `query result: [(1,)]` line. This means the query was successful.

- {{ AF }} version 3.0 or higher {#version-3}

  1. In the **DAGs** section, click `clickhouse`.
  1. Go to **Tasks**.
  1. Select **query_clickhouse**.
  1. Go to **Tasks Instances**.
  1. Select the task instance.
  1. The **Logs** section will open.
  1. Make sure the logs contain the `query result: [(1,)]` line. This means the query was successful.

{% endlist %}
