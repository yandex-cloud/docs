# Automating tasks using {{ maf-full-name }}

{{ maf-short-name }} is a popular tool for automation of data operations. {{ yq-full-name }} supports integration with {{ maf-short-name }} using the [`apache-airflow-providers-yandex`](https://pypi.org/project/apache-airflow-providers-yandex/) pip package.

Below, we consider a [directed acyclic graph (DAG)](../../managed-airflow/concepts/index.md#about-the-service) with two vertices:
   * `yq_operator`: Runs a simple query to {{ yq-full-name }}.
   * `output_operator`: Outputs the result of the `yq_operator` vertex execution.

To automate {{ yq-full-name }} operations using {{ maf-name }}, do the following:

1. [Prepare your infrastructure](#infra).
1. [Prepare the DAG file and run the graph](#dag).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#infra}

1. [Create a service account](../../iam/operations/sa/create.md) named `airflow-sa` with the `editor` role.

1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for the service account. Save its ID and the secret key.

1. [Create a bucked](../../storage/operations/buckets/create.md) named `airflow-bucket`.

1. [Create a cloud network](../../vpc/operations/network-create.md) named `yq-network`.

   This automatically creates three subnets in different availability zones and a security group.

1. [Create a NAT gateway](../../vpc/operations/create-nat-gateway.md) named `yq-nat` and a routing table named `yq-route-table` in `yq-network`. Link the table to the `yq-network-ru-central1-a` subnet.

1. [Create a {{ maf-name }} cluster](../../managed-airflow/operations/cluster-create.md) with the following parameters:

   * **Service account**: `airflow-sa`
   * **Availability zone**: `{{ region-id }}-a`
   * **Subnet**: `yq-network-{{ region-id }}-a`
   * **Security group**: Default group in the `yq-network` network
   * **Dependencies** → **Pip packages**: `apache-airflow-providers-yandex>=3.10`
   * **Bucket name**: `airflow-bucket`
   * **Key ID** and **secret key**: Belong to the static access key

## Prepare the DAG file and run the graph {#dag}

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

1. In the previously created `airflow-bucket`, create the `files/dags` folder and upload the `yq_dag.py` file to it.

1. [Open the {{ AF }} web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Make sure that a new graph named **yq_hello_world_operator** has appeared in the `DAGs` section.

   It may take a few minutes to upload a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-out}

1. In the **DAGs** section, open the `yq_hello_world_operator` graph.
1. Go to the **Grid** section.
1. Select the **yq_operator** task.
1. Go to the **XCom** section.
1. Make sure the `return_value` line has the `'rows': [['Hello, world!']]` element. This indicates the query was successful.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../iam/operations/sa/delete.md)
1. [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md)
1. [Cloud network](../../vpc/operations/network-delete.md)
1. Route table
1. NAT gateway
1. [{{ maf-name }} cluster](../../managed-airflow/operations/cluster-delete.md)
