---
title: Getting DAG execution logs
description: Use a directed acyclic graph (DAG) to get DAG execution logs.
---

# Getting DAG execution logs

Using a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service), you can get DAG execution logs and export them to a separate storage if required.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `export_dag_logs.py` and paste the following script to it:

   ```python
   import os
   import json

   from airflow.decorators import dag, task
   import boto3


   def system_logs_bucket_name() -> str:
       with open('/opt/airflow/airflow.cfg') as f:
           for line in f:
               line = line.strip()
               if not line.startswith('remote_base_log_folder'):
                   continue

               s3_path = line.split('=')[1].strip()
               return s3_path.split('//')[1]


   @dag(schedule=None)
   def export_dag_logs():
       @task
       def list_logs_bucket():
           str_conn = os.getenv('AIRFLOW_CONN_S3_DAG_LOGS')
           if not str_conn:
               raise Exception('env var AIRFLOW_CONN_S3_DAG_LOGS not found or empty')

           conn = json.loads(str_conn)
           bucket = system_logs_bucket_name()

           session = boto3.session.Session()
           s3 = session.client(
               service_name='s3',
               endpoint_url=conn['extra']['endpoint_url'],
               aws_access_key_id=conn['login'],
               aws_secret_access_key=conn['password'],
           )

           # Here we can do anything with logs, e.g. clone them to custom bucket
           resp = s3.list_objects_v2(Bucket=bucket)
           object_keys = [c['Key'] for c in resp['Contents']]

           print('Log files:\n')
           print('\n'.join(object_keys))

       list_logs_bucket()


   export_dag_logs()
   ```

   {% note info %}
   
   The `AIRFLOW_CONN_S3_DAG_LOGS` variable is already set on the worker and does not require any additional configuration.
   
   {% endnote %}

1. Upload the `export_dag_logs.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }}](af-interfaces.md#web-gui) web interface.
1. Make sure a new graph named `export_dag_logs` has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

{% list tabs group=instructions %}
   
- {{ AF }} version below 3.0 {#version-2}

  1. In the **DAGs** section, click the `export_dag_logs` graph.
  1. Go to the **Graph** section.
  1. Select **llist_logs_bucket**.
  1. Go to **Logs**.
  1. Make sure the logs contain the `Log files: {content}` line, where `content` is the list of DAG execution logs. This means the query was successful.

- {{ AF }} version 3.0 or higher {#version-3}

  1. In the **DAGs** section, click the `export_dag_logs` graph.
  1. Go to **Tasks**.
  1. Select **llist_logs_bucket**.
  1. Go to **Tasks Instances**.
  1. Select the task instance.
  1. The **Logs** section will open.
  1. Make sure the logs contain the `Log files: {content}` line, where `content` is the list of DAG execution logs. This means the query was successful.

{% endlist %}