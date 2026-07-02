[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Airflow™](../index.md) > [Пошаговые инструкции](index.md) > Подключения > Managed Service for Apache Airflow™: подключение к базе данных

# Подключение к базе данных Yandex Managed Service for Apache Airflow™

{% note warning %}

Инструкция работает для версий Apache Airflow™ ниже 3.0. Начиная с версии Apache Airflow™ 3.0 прямой доступ к БД запрещен.

{% endnote %}

Вы можете программно подключиться к базе данных Managed Service for Apache Airflow™ и обновить данные подключений с помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service).

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

1. Загрузите DAG-файл `update_connections.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе Apache Airflow™ автоматически.
1. [Откройте веб-интерфейс Apache Airflow™](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `update_connections`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе Apache Airflow™:

1. В разделе **DAGs** нажмите на граф `update_connections`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **update_connections_task**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть список обновленных подключений. Это значит, что запрос выполнен успешно.