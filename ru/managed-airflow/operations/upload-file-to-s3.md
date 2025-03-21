---
title: Загрузка файла в {{ objstorage-full-name }}
description: Используйте направленный ациклический граф (DAG) для загрузки файлов в {{ objstorage-name }}.
---

# Загрузка файла в {{ objstorage-full-name }}

Используйте [направленный ациклический граф (DAG)](../concepts/index.md#about-the-service) для загрузки файлов в {{ objstorage-name }}.

## Создайте бакет для загрузки файлов {#create-bucket}

1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с именем `username-airflow` для загрузки файлов.
1. [Предоставьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ и WRITE` для сервисного аккаунта `airflow-sa` на созданный ранее бакет.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `upload_file_to_s3.py` и скопируйте в него скрипт:

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

1. Загрузите DAG-файл `upload_file_to_s3.py` в первый созданный бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `upload_file_to_s3`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

[Проверьте наличие файла](../../storage/operations/objects/info.md) в веб-интерфейсе {{ objstorage-name }} бакета `username-airflow`.
