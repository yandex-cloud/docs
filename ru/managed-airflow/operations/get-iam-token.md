---
title: Получение IAM-токена
description: С помощью направленного ациклического графа (DAG), вы можете получить IAM-токен сервисного аккаунта, который привязан к кластеру {{ AF }}.
---

# Получение IAM-токена

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service), вы можете получить [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, который привязан к кластеру {{ AF }}.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `get_iam_token.py` и скопируйте в него скрипт:

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

1. Загрузите DAG-файл `get_iam_token.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `get_iam_token`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `get_iam_token`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **print_iam_token**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть строка `"token: ", iam_token`. Это значит, что запрос выполнен успешно.
