---
title: Loading a variable from {{ lockbox-name }}
description: 'When working with {{ maf-full-name }}, you can use {{ lockbox-full-name }} to store artifacts that can be used in DAG files: connections, variables, and configuration data. You can load a variable from {{ lockbox-name }} using a directed acyclic graph (DAG).'
---

# Loading a variable from {{ lockbox-name }}

When working with {{ maf-full-name }}, you can use [{{ lockbox-full-name }}](../../lockbox/index.yaml) to store artifacts that can be used in DAG files: connections, variables, and configuration data. {{ lockbox-name }} integrates into {{ maf-short-name }} via the [{{ lockbox-name }} Secret Backend](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/secrets-backends/yandex-cloud-lockbox-secret-backend.html) provider. As a result, access to the secret storage is configured automatically.

You can load a variable from {{ lockbox-name }} using a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service). Data for connecting to the DB is stored in {{ lockbox-name }} and automatically inserted into the graph.

## Getting started {#before-begin}

Grant the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer) to your service account.

{% note info }

There is no need to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }} secret](../../lockbox/operations/secret-access.md) once you [create it](#create-lockbox-secret).

{% endnote %}

## Create a {{ lockbox-full-name }} secret {#create-lockbox-secret}

[Create a {{ lockbox-name }} secret](../../lockbox/operations/secret-create.md) with the following parameters:
* **{{ ui-key.yacloud.common.name }}**: `airflow/variables/var_query`
* **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**: `Custom`
* **{{ ui-key.yacloud.lockbox.forms.label_key }}**: `value`
* **{{ ui-key.yacloud.lockbox.forms.label_value }}**: `SELECT 2`

The `airflow/variables/var_query` secret will store the `value` variable with `SELECT 2` as its value.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `load_variable_from_lockbox.py` and paste the following script to it:

   ```python
   from airflow.decorators import dag, task
   from airflow.models import Variable


   @dag(schedule=None)
   def load_variable_from_lockbox():
       @task
       def print_var_query():
           query = Variable.get_variable_from_secrets("var_query")
           print("query: ", query)
      
       print_var_query()


   load_variable_from_lockbox()
   ```

1. Upload the `load_variable_from_lockbox.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `load_variable_from_lockbox` has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `load_variable_from_lockbox` graph.
1. Go to the **Graph** section.
1. Select **print_var_query**.
1. Go to **Logs**.
1. Make sure the logs contain the `query: SELECT 2` line. This means the query was successful.

