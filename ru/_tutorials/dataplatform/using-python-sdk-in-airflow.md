# Отправка запросов к API {{ yandex-cloud }} через {{ yandex-cloud }} Python SDK

При работе с {{ maf-name }} вы можете использовать [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) для выполнения запросов к API {{ yandex-cloud }}. Сервис поддерживает отправку запросов к любым типам облачных ресурсов. При этом ручная настройка аутентификации в облаке не требуется. {{ yandex-cloud }} Python SDK аутентифицируется через [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, который привязан к кластеру {{ AF }}.

Ниже рассматривается [направленный ациклический граф (DAG)](../../managed-airflow/concepts/index.md#about-the-service), отправляющий запрос к API {{ yandex-cloud }}. Запрос возвращает список виртуальных машин в каталоге, в котором создан кластер {{ AF }}.

Чтобы использовать {{ yandex-cloud }} Python SDK для отправки запросов к API {{ yandex-cloud }}:

1. [Подготовьте инфраструктуру](#create-infrastracture).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ maf-name }}: вычислительные ресурсы компонентов кластера и объем исходящего трафика. (см. [тарифы {{ AF }}](../../managed-airflow/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Плата за бакет {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов, хранилища, операционной системы (для отдельных ОС) и публичного IP-адреса (опционально) (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).


## Подготовьте инфраструктуру {#create-infrastructure}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `airflow-sa` с ролями:

   * `compute.viewer`;
   * `{{ roles.maf.integrationProvider }}`.

1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md) с произвольными настройками.

1. {% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}

1. [Создайте кластер {{ maf-name }}](../../managed-airflow/operations/cluster-create.md#create-cluster) с параметрами:

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

   Аутентификация в облаке происходит через IAM-токен сервисного аккаунта, который привязан к кластеру {{ AF }}. В созданном с параметрами по умолчанию объекте `yandexcloud.SDK()` данные для аутентификации через IAM-токен подставляются автоматически.

1. [Загрузите DAG-файл](../../storage/operations/objects/upload.md) `test_python_sdk.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.

1. [Откройте веб-интерфейс {{ AF }}](../../managed-airflow/operations/af-interfaces.md#web-gui).

1. Убедитесь, что в разделе **DAGs** появился новый граф `test_python_sdk`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `test_python_sdk`.
1. Перейдите в раздел **Grid**.
1. Выберите задание **list_instances**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах перечислены виртуальные машины из каталога, в котором создан кластер {{ AF }}. Это значит, что запрос выполнен успешно.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Кластер {{ maf-name }}](../../managed-airflow/operations/cluster-delete.md#delete).
1. [Виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
