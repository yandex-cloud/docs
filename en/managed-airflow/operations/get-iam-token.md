---
title: Getting an IAM token
description: Using a directed acyclic graph (DAG), you can get the IAM token of the service account attached to an {{ AF }} cluster.
---

# Getting an IAM token

Using a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service), you can get the [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account attached to an {{ AF }} cluster.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `get_iam_token.py` and paste the following script to it:

   ```python
   from airflow.decorators import dag, task
   import yandexcloud


   @dag(schedule=None)
   def get_iam_token():
       @task
       def print_iam_token():
           sdk = yandexcloud.SDK()
           token = sdk._channels._token_requester.get_token()
           print("token: ", token[:20])

       print_iam_token()


   get_iam_token()
   ```

1. Upload the `get_iam_token.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `get_iam_token` has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `get_iam_token` graph.
1. Go to the **Graph** section.
1. Select **print_iam_token**.
1. Go to **Logs**.
1. Make sure the logs contain the `"token: ", iam_token` line. This means the query was successful.
