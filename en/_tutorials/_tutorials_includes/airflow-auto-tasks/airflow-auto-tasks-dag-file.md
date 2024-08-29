Below, we consider a [directed acyclic graph (DAG)](../../../managed-airflow/concepts/index.md#about-the-service) with two vertices:
* `yq_operator`: Runs a simple query to {{ yq-full-name }}.
* `output_operator`: Outputs the result of the `yq_operator` vertex execution.

To prepare a DAG:

1. Create a local file named `yq_dag.py` and copy the following script into it:

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

1. Upload the DAG file into the {{ maf-name }} cluster. To do this, create a folder named `files/dags` in the `airflow-bucket` bucket and upload the `yq_dag.py` file to it.
1. [Open the {{ AF }} web interface](../../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Make sure that a new DAG file named `yq_hello_world_operator` has appeared in the **DAGs** section.

   {% note info %}

   It may take a few minutes to upload a DAG file from the bucket.

   {% endnote %}

1. To run DAG, first click ![image](../../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name and then click **Trigger DAG**.
