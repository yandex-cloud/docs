---
title: Connecting to a {{ maf-full-name }} database
description: You can connect to a {{ maf-name }} database using software and update connection data using a directed acyclic graph (DAG).
---

# Connecting to a {{ maf-full-name }} database

You can connect to a {{ maf-name }} database using software and update connection data using a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service).

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `update_connections.py` and paste the following script to it:

   ```python
   import json
   from airflow.decorators import dag, task
   from airflow.settings import Session
   from airflow.models import Connection


   @dag(schedule=None)
   def update_connections():
       @task
       def update_connections_task():
           with Session() as session:
               connections = session.query(Connection)
               for conn in connections:
                   extra = conn.extra_dejson
                   print(f"extra: {extra}")
                   update_count = extra.get('update_count', 0)
                   extra['update_count'] = update_count + 1
                   conn.set_extra(json.dumps(extra))
                   session.add(conn)
               session.commit()

       update_connections_task()


   update_connections()
   ```

1. Upload the `update_connections.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `update_connections` has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `update_connections` graph.
1. Go to the **Graph** section.
1. Select **update_connections_task**.
1. Go to **Logs**.
1. Make sure the logs contain a list of updated connections. This means the query was successful.



