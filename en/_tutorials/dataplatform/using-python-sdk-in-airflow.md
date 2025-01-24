# Sending requests to the {{ yandex-cloud }} API via the {{ yandex-cloud }} Python SDK

When working with {{ maf-name }}, you can use the [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) to make requests to the {{ yandex-cloud }} API. The service supports sending requests to any type of cloud resources. You do not need to set up authentication in the cloud manually. {{ yandex-cloud }} Python SDK authenticates via the [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account linked to the {{ AF }} cluster.

As an example, we use a [directed acyclic graph (DAG)](../../managed-airflow/concepts/index.md#about-the-service) which submits a request to the {{ yandex-cloud }} API. The request returns a list of virtual machines in the folder where the {{ AF }} cluster is created.

To use the {{ yandex-cloud }} Python SDK to send requests to the {{ yandex-cloud }} API:

1. [Prepare your infrastructure](#create-infrastracture).
1. [Prepare the DAG file and run the graph](#dag).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#create-infrastructure}

1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `airflow-sa` with the following roles:

   * `compute.viewer`
   * `{{ roles.maf.integrationProvider }}`

1. [Create an {{ objstorage-full-name }}](../../storage/operations/buckets/create.md) bucket in any configuration.

1. {% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}

1. [Create a {{ maf-name }} cluster](../../managed-airflow/operations/cluster-create.md#create-cluster) with the following parameters:

   * **Service account**: `airflow-sa`
   * **Bucket name**: Name of the new bucket

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) in any configuration.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `test_python_sdk.py` and copy the following script to it:

   {% cut "test_python_sdk.py" %}

   ```python
   from airflow import DAG
   from airflow.models import Connection
   from airflow.operators.python_operator import PythonOperator
   from datetime import datetime

   import yandexcloud
   from yandex.cloud.compute.v1.instance_service_pb2 import (
       ListInstancesRequest,
   )
   from yandex.cloud.compute.v1.instance_service_pb2_grpc import InstanceServiceStub

   def list_instances():
       conn = Connection.get_connection_from_secrets("yandexcloud_default")
       folder_id = conn.extra_dejson.get('folder_id')

       sdk = yandexcloud.SDK()
       instance_service = sdk.client(InstanceServiceStub)
       response = instance_service.List(ListInstancesRequest(folder_id=folder_id))
       print("instances: ", response.instances)

   with DAG(
       dag_id='test_python_sdk',
       start_date=datetime(2024, 5, 24),
       schedule="@once",
       catchup=False,
   ) as dag:
       PythonOperator(
           task_id='list_instances',
           python_callable=list_instances,
       )
   ```

   {% endcut %}

   To authenticate in the cloud, the IAM token of the service account attached to the {{ AF }} cluster is used. The `yandexcloud.SDK()` object is created with default parameters and automatically populated with the data required to authenticate with the IAM token.

1. [Upload](../../storage/operations/objects/upload.md) the `test_python_sdk.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.

1. [Open the {{ AF }} web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).

1. Make sure a new graph named `test_python_sdk` has appeared in the **DAGs** section.

   It may take a few minutes to upload a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `test_python_sdk` graph.
1. Go to the **Grid** section.
1. Select the **list_instances** task.
1. Go to **Logs**.
1. Make sure the logs list the virtual machines from the folder where the {{ AF }} cluster is created. This means the query was successful.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../iam/operations/sa/delete.md)
1. [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md)
1. [{{ maf-name }} cluster](../../managed-airflow/operations/cluster-delete.md#delete)
1. [Virtual machine](../../compute/operations/vm-control/vm-delete.md)
