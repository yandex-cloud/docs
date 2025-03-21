---
title: Подключение к базе данных {{ maf-full-name }}
description: Вы можете программно подключиться к базе данных {{ maf-name }} и обновить данные подключений с помощью направленного ациклического графа (DAG).
---

# Подключение к базе данных {{ maf-full-name }}

Вы можете программно подключиться к базе данных {{ maf-name }} и обновить данные подключений с помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service).

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `update_connections.py` и скопируйте в него скрипт:

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

1. Загрузите DAG-файл `update_connections.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `update_connections`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `update_connections`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **update_connections_task**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть список обновленных подключений. Это значит, что запрос выполнен успешно.



