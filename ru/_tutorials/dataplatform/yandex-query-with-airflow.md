# Автоматизация задач с помощью {{ maf-full-name }}

{{ maf-short-name }} является популярным инструментом для автоматизации операций с данными. {{ yq-full-name }} поддерживает интеграцию с {{ maf-short-name }} с помощью pip-пакета [`apache-airflow-providers-yandex`](https://pypi.org/project/apache-airflow-providers-yandex/).

Ниже рассматривается [направленный ациклический граф (DAG)](../../managed-airflow/concepts/index.md#about-the-service) с двумя вершинами:
   * `yq_operator` — выполняет простой запрос к {{ yq-full-name }};
   * `output_operator` — выводит результат выполнения вершины `yq_operator`.

Чтобы автоматизировать работу {{ yq-full-name }} с помощью {{ maf-name }}, выполните следующие шаги:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `airflow-sa` с ролью `editor`.

1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта. Сохраните его идентификатор и секретный ключ.

1. [Создайте бакет](../../storage/operations/buckets/create.md) `airflow-bucket`.

1. [Создайте облачную сеть](../../vpc/operations/network-create.md) `yq-network`.

   Вместе с ней автоматически создадутся три подсети в разных зонах доступности и группа безопасности.

1. [Создайте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) `yq-nat` и таблицу маршрутизации `yq-route-table` в сети `yq-network`. Привяжите таблицу к подсети `yq-network-ru-central1-a`.

1. [Создайте кластер {{ maf-name }}](../../managed-airflow/operations/cluster-create.md) с параметрами:

   * **Сервисный аккаунт** — `airflow-sa`.
   * **Зона доступности** — `{{ region-id }}-a`.
   * **Подсеть** — `yq-network-{{ region-id }}-a`.
   * **Группа безопасности** — группа по умолчанию в сети `yq-network`.
   * **Зависимости** → **Pip-пакеты** — `apache-airflow-providers-yandex>=3.10`.
   * **Имя бакета** — `airflow-bucket`.
   * **Идентификатор ключа** и **секретный ключ** — принадлежат статическому ключу доступа.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `yq_dag.py` и скопируйте в него скрипт:

   {% cut "yq_dag.py" %}

   ```python
   import datetime

   from airflow.models.dag import DAG
   from airflow.providers.yandex.operators.yq import YQExecuteQueryOperator
   from airflow.operators.python_operator import PythonOperator

   with DAG(
       dag_id="yq_hello_world_operator",
       schedule_interval="@hourly",
       start_date=datetime.datetime.now()
   ) as dag:

       yq_operator = YQExecuteQueryOperator(task_id="yq_operator", sql="SELECT 'Hello, world!'")

       def print_context(ds=None, **kwargs):
           ti = kwargs['ti']
           print(ti.xcom_pull(task_ids='yq_operator'))

       output_operator = PythonOperator(
           task_id = "output_operator",
           provide_context=True,
           python_callable = print_context
           )

       yq_operator >> output_operator

   if __name__ == "__main__":
       dag.test()
   ```

   {% endcut %}

1. В созданном ранее бакете `airflow-bucket` создайте папку `files/dags` и загрузите в нее файл `yq_dag.py`

1. [Откройте веб-интерфейс {{ AF }}](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `yq_hello_world_operator`.

    Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-out}

1. В разделе **DAGs** откройте граф `yq_hello_world_operator`.
1. Перейдите в раздел **Grid**.
1. Выберите задание **yq_operator**.
1. Перейдите в раздел **XCom**.
1. Убедитесь, что в строке `return_value` есть элемент `'rows': [['Hello, world!']]`. Это значит, что запрос выполнен успешно.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Облачную сеть](../../vpc/operations/network-delete.md).
1. Таблицу маршрутизации.
1. NAT-шлюз.
1. [Кластер {{ maf-name }}](../../managed-airflow/operations/cluster-delete.md).
