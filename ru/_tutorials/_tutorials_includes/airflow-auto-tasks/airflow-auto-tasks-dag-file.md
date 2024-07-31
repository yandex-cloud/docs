Ниже используется [направленный ациклический граф (DAG)](../../../managed-airflow/concepts/index.md#about-the-service) с двумя вершинами:
   * `yq_operator` — выполняет простой запрос к {{ yq-full-name }};
   * `output_operator` — выводит результат выполнения вершины `yq_operator`.

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
1. [Откройте веб-интерфейс {{ AF }}](../../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый DAG `yq_hello_world_operator`.

    {% note info %}

    Загрузка DAG-файла из бакета может занять несколько минут.

    {% endnote %}

1. Чтобы запустить DAG, в строке с его именем сначала нажмите кнопку ![image](../../../_assets/managed-airflow/trigger-dag.png =18x), затем — **Trigger DAG**.