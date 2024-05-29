# Automating tasks using {{ maf-short-name }}

{{ maf-short-name }} is a popular tool for automation of data operations. {{ yq-full-name }} supports integration with {{ maf-short-name }} using the [`apache-airflow-providers-yandex`](https://pypi.org/project/apache-airflow-providers-yandex/) pip package.

To automate {{ yq-full-name }} operations using {{ maf-name }}, do the following:

1. [Prepare your infrastructure](#infra).
1. [Prepare and run a DAG file](#dag).
1. [Check the result](#check-out).
1. [Delete the resources you created](#clear-out).


## Prepare the infrastructure {#infra}

1. [Create a service account](../../iam/operations/sa/create.md) named `airflow-sa` with the `editor` role.

1. Create a [static access key](../../iam/operations/sa/create-access-key.md) for the service account. Save its ID and the secret key.

1. [Create a bucked](../../storage/operations/buckets/create.md) named `airflow-bucket`.

1. [Create a cloud network](../../vpc/operations/network-create.md) named `yq-network`.

   This automatically creates three subnets in different availability zones and a security group.

1. [Create a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the `yq-network` network.

1. [Create a route table](../../vpc/operations/static-route-create.md) named `yq-route-table` with the `yq-nat` gateway as the `Next hop`.

1. Link the `yq-route-table` route table to the `yq-network-{{ region-id }}-a` subnet. To do this, [go to the properties](../../vpc/operations/subnet-update.md) of the `yq-network` cloud network, and find a row with the `yq-network-{{ region-id }}-a` subnet in the `Subnets` table. Click ![image](../../_assets/console-icons/ellipsis.svg), select **Link a route table**, and specify `yq-route-table`.

1. [Create a {{ maf-name }} cluster](../../managed-airflow/operations/cluster-create.md) with the following parameters:

   * **Service account**: `airflow-sa`
   * **Availability zone**: `{{ region-id }}-a`
   * **Subnet**: `yq-network-{{ region-id }}-a`
   * **Security group**: Default group in the `yq-network` network
   * **Dependencies** → **Pip packages**: `apache-airflow-providers-yandex>=3.10`
   * **Bucket name**: `airflow-bucket`
   * **Key ID** and **secret key**: Belong to the static access key

## Prepare and run a DAG file {#dag}

[DAG](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html) will consist of the `yq_operator` vertex, which executes a simple query to {{ yq-full-name }}, and the `output_operator` vertex, which outputs the result of the `yq_operator` vertex execution.

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
1. [Open the {{ AF }} web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Make sure that a new DAG file named `yq_hello_world_operator` has appeared in the **DAGs** section.

   {% note info %}

   It may take a few minutes to load the DAG file from the bucket.

   {% endnote %}

1. To run the DAG, first click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name and then click **Trigger DAG**.

## Check the result {#check-out}

1. To monitor task execution results, click the DAG name. The results are displayed in the **Grid** tab.
1. Wait until the task status in the DAG changes to **Success**.
1. The results are displayed under **Grid** → **output_operator** → **XCom**.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../iam/operations/sa/delete.md).
1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md).
1. [{{ maf-name }} cluster](../../managed-airflow/operations/cluster-delete.md).
1. Route table.
1. NAT gateway.

