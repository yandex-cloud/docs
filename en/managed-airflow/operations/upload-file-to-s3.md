---
title: Uploading a file to {{ objstorage-full-name }}
description: Use a directed acyclic graph (DAG) to upload files to {{ objstorage-full-name }}.
---

# Uploading a file to {{ objstorage-full-name }}

Use a [directed acyclic graph (DAG)](../concepts/index.md#about-the-service) to upload files to {{ objstorage-full-name }}.

## Create a bucket for uploading files {#create-bucket}

1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) named `username-airflow` to upload your files to.
1. [Grant](../../storage/operations/buckets/edit-acl.md) `airflow-sa` the `READ and WRITE` permissions for the bucket you created.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `upload_file_to_s3.py` and paste the following script to it:

   ```python
   from airflow.decorators import dag, task
   import boto3
   import botocore
   import botocore.config
   import yandexcloud


   def _upload_file_to_s3(bucket_name: str, object_path: str, content: str):
       sdk = yandexcloud.SDK()

       def provide_cloud_auth_header(request, **kwargs):
           request.headers.add_header("X-YaCloud-SubjectToken", sdk._channels._token_requester.get_token())

       session = boto3.Session()
       session.events.register('request-created.s3.*', provide_cloud_auth_header)
       client = session.resource(
           "s3",
           endpoint_url="https://storage.yandexcloud.net",
           config=botocore.config.Config(
               signature_version=botocore.UNSIGNED,
               retries=dict(
                   max_attempts=5,
                   mode="standard",
               ),
           ),
       )
       client.Bucket(name=bucket_name).put_object(Key=object_path, Body=content)


   @dag(schedule=None)
   def upload_file_to_s3():
       @task
       def upload():
           _upload_file_to_s3(
               bucket_name="username-airflow",
               object_path="data/airflow.txt",
               content="Hello from Managed Airflow!"
           )

       upload()


   upload_file_to_s3()

   ```

1. Upload the `upload_file_to_s3.py` DAG file to the first bucket you created. This will automatically create a graph with the same name in the {{ AF }} web interface.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure a new graph named `upload_file_to_s3` has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

Using the {{ objstorage-name }} web interface, [check](../../storage/operations/objects/info.md) that the file is in the `username-airflow` bucket.
