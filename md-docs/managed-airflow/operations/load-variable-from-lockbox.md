# Загрузка переменной из Yandex Lockbox

При работе с Yandex Managed Service for Apache Airflow™ вы можете использовать [Yandex Lockbox](../../lockbox/index.md) для хранения артефактов, которые могут использоваться в DAG-файлах: подключений, переменных и конфигурационных данных. Yandex Lockbox интегрируется в Managed Service for Apache Airflow™ через провайдер [Yandex Lockbox Secret Backend](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/secrets-backends/yandex-cloud-lockbox-secret-backend.html). В результате доступ к хранилищу секретов настраивается автоматически.

Загрузку переменной из Yandex Lockbox можно выполнить с помощью [направленого ациклического графа (DAG)](../concepts/index.md#about-the-service). Данные для подключения к БД хранятся в Yandex Lockbox и автоматически подставляются в граф.

## Перед началом работы {#before-begin}

Выдайте своему сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

{% note info %}

Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет Yandex Lockbox](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

{% endnote %}

## Создайте секрет Yandex Lockbox {#create-lockbox-secret}

Для корректной работы кластера Apache Airflow™ секрет в Yandex Lockbox должен иметь имя в формате `airflow/<тип_артефакта>/<идентификатор_артефакта>`, где:
   * `<тип_артефакта>` — определяет, какие данные будут храниться в секрете. Возможные значения:
     * `connections` — подключения;
     * `variables` — переменные;
     * `config` — данные конфигурации.
   * `<идентификатор_артефакта>` — идентификатор, который будет использоваться для обращения к артефакту в Apache Airflow™.

[Создайте секрет Yandex Lockbox](../../lockbox/operations/secret-create.md) с параметрами:
* **Имя** — `airflow/variables/var_query`;
* **Тип секрета** — `Пользовательский`;
* **Ключ** — `value`;
* **Значение** — `SELECT 2`.

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

1. Загрузите DAG-файл `load_variable_from_lockbox.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе Apache Airflow™ автоматически.
1. [Откройте веб-интерфейс Apache Airflow™](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `load_variable_from_lockbox`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе Apache Airflow™:

{% list tabs group=instructions %}
   
- Версия Apache Airflow™ ниже 3.0 {#version-2}

  1. В разделе **DAGs** нажмите на граф `load_variable_from_lockbox`.
  1. Перейдите в раздел **Graph**.
  1. Выберите задание **print_var_query**.
  1. Перейдите в раздел **Logs**.
  1. Убедитесь, что в логах есть строка `query: SELECT 2`. Это значит, что запрос выполнен успешно.

- Версия Apache Airflow™ 3.0 и выше {#version-3}

  1. В разделе **Dags** нажмите на граф `load_variable_from_lockbox`.
  1. Перейдите в раздел **Tasks**.
  1. Выберите задание **print_var_query**.
  1. Перейдите в раздел **Task Instances**.
  1. Выберите экземпляр задания.
  1. Откроется раздел **Logs**.
  1. Убедитесь, что в логах есть строка `query: SELECT 2`. Это значит, что запрос выполнен успешно.

{% endlist %}