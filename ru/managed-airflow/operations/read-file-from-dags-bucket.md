---
title: Чтение файла из {{ objstorage-full-name }}
description: Используйте направленный ациклический граф (DAG) для чтения файлов из {{ objstorage-full-name }} сервисного аккаунта, который привязан к кластеру {{ AF }}.
---

# Чтение файла из {{ objstorage-full-name }}

Используйте [направленный ациклический граф (DAG)](../concepts/index.md#about-the-service) для чтения файлов из {{ objstorage-full-name }} сервисного аккаунта, который привязан к кластеру {{ AF }}.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `read_file_from_dags_bucket.py` и скопируйте в него скрипт:

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

1. Загрузите DAG-файл `read_file_from_dags_bucket.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `read_file_from_dags_bucket`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `read_file_from_dags_bucket`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **read_file**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть строка `file content: {content}`, где `content` — содержимое файла. Это значит, что запрос выполнен успешно.
