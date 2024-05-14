# Автоматизация задач с помощью {{ maf-short-name }}

{{ maf-short-name }} является популярным инструментом для автоматизации операций с данными. {{ yq-full-name }} поддерживает интеграцию с {{ maf-short-name }} с помощью pip-пакета [`apache-airflow-providers-yandex`](https://pypi.org/project/apache-airflow-providers-yandex/).

Чтобы автоматизировать работу {{ yq-full-name }} с помощью {{ maf-name }}, выполните следующие шаги:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте и запустите DAG-файл](#dag).
1. [Проверьте результат](#check-out).
1. [Удалите созданные ресурсы](#clear-out).


## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `airflow-sa` с ролью `editor`.

1. Создайте [статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта. Сохраните его идентификатор и секретный ключ.

1. [Создайте бакет](../../storage/operations/buckets/create.md) `airflow-bucket`.

1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `yq-network`.

   Вместе с ней автоматически создадутся три подсети в разных зонах доступности и группа безопасности.

1. [Создайте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для сети `yq-network`.

1. [Создайте таблицу маршрутизации](../../vpc/operations/static-route-create.md) `yq-route-table`, в качестве `Next hop` укажите шлюз `yq-nat`.

1. Привяжите таблицу маршрутизации `yq-route-table` к подсети `yq-network-{{ region-id }}-a`. Для этого [перейдите в свойства облачной сети](../../vpc/operations/subnet-update.md) `yq-network`, в таблице `Подсети` найдите строку с подсетью `yq-network-{{ region-id }}-a`. Нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите пункт **Привязать таблицу маршрутизации**, укажите `yq-route-table`.

1. [Создайте кластер {{ maf-name }}](../../managed-airflow/operations/cluster-create.md) с параметрами:

   * **Сервисный аккаунт** — `airflow-sa`.
   * **Зона доступности** — `{{ region-id }}-a`.
   * **Подсеть** — `yq-network-{{ region-id }}-a`.
   * **Группа безопасности** — группа по умолчанию в сети `yq-network`.
   * **Зависимости** → **Pip-пакеты** — `apache-airflow-providers-yandex>=3.10`.
   * **Имя бакета** `airflow-bucket`.
   * **Идентификатор ключа** и **секретный ключ** — принадлежат статическому ключу доступа.

## Подготовьте и запустите DAG-файл {#dag}

[DAG](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html) будет состоять из вершины `yq_operator`, выполняющей простой запрос к {{ yq-full-name }}, и вершины `output_operator`, выводящей результат выполнения вершины `yq_operator`.

Чтобы подготовить DAG:

1. Создайте локально файл с именем `yq_dag.py`, скопируйте в него скрипт:

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

1. Загрузите DAG в кластер {{ maf-name }}. Для этого создайте в бакете `airflow-bucket` папку `files/dags` и загрузите в нее файл `yq_dag.py`.
1. [Откройте веб-интерфейс {{ AF }}](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый DAG `yq_hello_world_operator`.

    {% note info %}

    Загрузка DAG-файла из бакета может занять несколько минут.

    {% endnote %}

1. Чтобы запустить DAG, в строке с его именем сначала нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x), затем — **Trigger DAG**.

## Проверьте результат {#check-out}

1. Чтобы отслеживать результаты выполнения задач, нажмите на название DAG. Результаты отображаются во вкладке **Grid**.
1. Дождитесь, когда задача в DAG перейдет в статус **Success**.
1. Результаты запуска отображаются во вкладке **Grid** → **output_operator** → **XCom**.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакеты {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Кластер {{ maf-name }}](../../managed-airflow/operations/cluster-delete.md).
1. Таблицу маршрутизации.
1. NAT-шлюз.

