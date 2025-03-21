---
title: Загрузка переменной из {{ lockbox-name }}
description: 'При работе с {{ maf-full-name }} вы можете использовать {{ lockbox-full-name }} для хранения артефактов, которые могут использоваться в DAG-файлах: подключений, переменных и конфигурационных данных. Загрузку переменной из {{ lockbox-name }} можно выполнить с помощью направленого ациклического графа (DAG).'
---

# Загрузка переменной из {{ lockbox-name }}

При работе с {{ maf-full-name }} вы можете использовать [{{ lockbox-full-name }}](../../lockbox/index.yaml) для хранения артефактов, которые могут использоваться в DAG-файлах: подключений, переменных и конфигурационных данных. {{ lockbox-name }} интегрируется в {{ maf-short-name }} через провайдер [{{ lockbox-name }} Secret Backend](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/secrets-backends/yandex-cloud-lockbox-secret-backend.html). В результате доступ к хранилищу секретов настраивается автоматически.

Загрузку переменной из {{ lockbox-name }} можно выполнить с помощью [направленого ациклического графа (DAG)](../concepts/index.md#about-the-service). Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

## Перед началом работы {#before-begin}

Выдайте своему сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

{% note info }

Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

{% endnote %}

## Создайте секрет {{ lockbox-full-name }} {#create-lockbox-secret}

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) с параметрами:
* **{{ ui-key.yacloud.common.name }}** — `airflow/variables/var_query`;
* **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** — `Пользовательский`;
* **{{ ui-key.yacloud.lockbox.forms.label_key }}** — `value`;
* **{{ ui-key.yacloud.lockbox.forms.label_value }}** — `SELECT 2`.

В секрете `airflow/variables/var_query` будет сохранена переменная `value` со значением `SELECT 2`.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `load_variable_from_lockbox.py` и скопируйте в него скрипт:

   ```python
   from airflow.decorators import dag, task
   from airflow.models import Variable


   @dag(schedule=None)
   def load_variable_from_lockbox():
       @task
       def print_var_query():
           query = Variable.get_variable_from_secrets("var_query")
           print("query: ", query)
      
       print_var_query()


   load_variable_from_lockbox()
   ```

1. Загрузите DAG-файл `load_variable_from_lockbox.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `load_variable_from_lockbox`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `load_variable_from_lockbox`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **print_var_query**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть cтрока `query: SELECT 2`. Это значит, что запрос выполнен успешно.

