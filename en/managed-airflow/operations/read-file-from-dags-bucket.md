---
title: Reading a file from {{ objstorage-full-name }}
description: Use a directed acyclic graph to read files from {{ objstorage-full-name }} of the service account linked to an {{ AF }} cluster.
---

# Reading a file from {{ objstorage-full-name }}

Use a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service) to read files from {{ objstorage-full-name }} of the service account linked to an {{ AF }} cluster.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `read_file_from_dags_bucket.py` and copy the following script to it:

   ```python
   from airflow.settings import DAGS_FOLDER
   from airflow.decorators import dag, task


   @dag(schedule=None)
   def read_file_from_dags_bucket():
       @task
       def read_file():
           with open(f'{DAGS_FOLDER}/data/airflow.txt') as file:
               content = file.read()
               print(f"file content: {content}")

       read_file()


   read_file_from_dags_bucket()
   ```

1. Upload the `read_file_from_dags_bucket.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `read_file_from_dags_bucket` has appeared in the **DAGs** section.

   It may take a few minutes to upload a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `read_file_from_dags_bucket` graph.
1. Go to the **Graph** section.
1. Select the **read_file** job.
1. Go to **Logs**.
1. Make sure the logs contain the `file content: {content}` string, where `content` is the file content. This means the query was successful.
