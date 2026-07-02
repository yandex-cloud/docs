[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Airflow™](../index.md) > [Практические руководства](index.md) > Другие руководства > Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK

# Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK

# Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK

{% note warning %}

Руководство тестировалось на кластерах с версией Apache Airflow™ ниже 3.0.

{% endnote %}

При работе с Managed Service for Apache Airflow™ вы можете использовать [Yandex Cloud Python SDK](https://github.com/yandex-cloud/python-sdk) для выполнения запросов к API Yandex Cloud. Сервис поддерживает отправку запросов к любым типам облачных ресурсов. При этом ручная настройка аутентификации в облаке не требуется. Yandex Cloud Python SDK аутентифицируется через [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, который привязан к кластеру Apache Airflow™.

Ниже рассматривается [направленный ациклический граф (DAG)](../concepts/index.md#about-the-service), отправляющий запрос к API Yandex Cloud. Запрос возвращает список виртуальных машин в каталоге, в котором создан кластер Apache Airflow™.

Чтобы использовать Yandex Cloud Python SDK для отправки запросов к API Yandex Cloud:

1. [Подготовьте инфраструктуру](#create-infrastracture).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Airflow™: вычислительные ресурсы компонентов кластера ([тарифы Managed Service for Apache Airflow™](../pricing.md)).
* Бакет Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).


## Подготовьте инфраструктуру {#create-infrastructure}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `airflow-sa` с ролями:

   * `compute.viewer`;
   * `managed-airflow.integrationProvider`.

1. [Создайте бакет Object Storage](../../storage/operations/buckets/create.md) с произвольными настройками.

1. [Отредактируйте ACL](../../storage/operations/buckets/edit-acl.md) созданного бакета так, чтобы у сервисного аккаунта `airflow-sa` было разрешение `READ`.

1. [Создайте кластер Managed Service for Apache Airflow™](../operations/cluster-create.md#create-cluster) с параметрами:

   * **Сервисный аккаунт** — `airflow-sa`.
   * **Имя бакета** — имя созданного бакета.

1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) с произвольными настройками.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `test_python_sdk.py` и скопируйте в него скрипт:

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

   Аутентификация в облаке происходит через IAM-токен сервисного аккаунта, который привязан к кластеру Apache Airflow™. В созданном с параметрами по умолчанию объекте `yandexcloud.SDK()` данные для аутентификации через IAM-токен подставляются автоматически.

1. [Загрузите DAG-файл](../../storage/operations/objects/upload.md) `test_python_sdk.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе Apache Airflow™ автоматически.

1. [Откройте веб-интерфейс Apache Airflow™](../operations/af-interfaces.md#web-gui).

1. Убедитесь, что в разделе **DAGs** появился новый граф `test_python_sdk`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе Apache Airflow™:

1. В разделе **DAGs** откройте граф `test_python_sdk`.
1. Перейдите в раздел **Grid**.
1. Выберите задание **list_instances**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах перечислены виртуальные машины из каталога, в котором создан кластер Apache Airflow™. Это значит, что запрос выполнен успешно.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет Object Storage](../../storage/operations/buckets/delete.md).
1. [Кластер Managed Service for Apache Airflow™](../operations/cluster-delete.md#delete).
1. [Виртуальную машину](../../compute/operations/vm-control/vm-delete.md).