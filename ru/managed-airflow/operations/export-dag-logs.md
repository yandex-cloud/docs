---
title: Получение логов выполнения DAG
description: Используйте направленный ациклический граф (DAG), чтобы получить логи выполнения DAG.
---

# Получение логов выполнения DAG

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) вы можете получать логи выполнения DAG и при необходимости экспортировать их в отдельное хранилище.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `export_dag_logs.py` и скопируйте в него скрипт:

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
   
   Переменная `AIRFLOW_CONN_S3_DAG_LOGS` уже задана на воркере, ее не нужно задавать дополнительно.
   
   {% endnote %}

1. Загрузите DAG-файл `export_dag_logs.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `export_dag_logs`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

{% list tabs group=instructions %}
   
- Версия {{ AF }} ниже 3.0 {#version-2}

  1. В разделе **DAGs** нажмите на граф `export_dag_logs`.
  1. Перейдите в раздел **Graph**.
  1. Выберите задание **list_logs_bucket**.
  1. Перейдите в раздел **Logs**.
  1. Убедитесь, что в логах есть строка `Log files: {content}`, где `content` — список логов выполнения DAG. Это значит, что запрос выполнен успешно.

- Версия {{ AF }} 3.0 и выше {#version-3}

  1. В разделе **Dags** нажмите на граф `export_dag_logs`.
  1. Перейдите в раздел **Tasks**.
  1. Выберите задание **list_logs_bucket**.
  1. Перейдите в раздел **Task Instances**.
  1. Выберите экземпляр задания.
  1. Откроется раздел **Logs**.
  1. Убедитесь, что в логах есть строка `Log files: {content}`, где `content` — список логов выполнения DAG. Это значит, что запрос выполнен успешно.

{% endlist %}