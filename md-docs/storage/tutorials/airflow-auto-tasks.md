# Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™

{% note warning %}

Руководство тестировалось на кластерах с версией Apache Airflow™ ниже 3.0.

{% endnote %}

Managed Service for Apache Airflow™ — это популярный инструмент для автоматизации операций с данными. Yandex Query поддерживает интеграцию с Managed Service for Apache Airflow™ с помощью pip-пакета [`apache-airflow-providers-yandex`](https://pypi.org/project/apache-airflow-providers-yandex/).

Чтобы создать инфраструктуру для автоматизации задач Yandex Query c помощью Managed Service for Apache Airflow™, выполните следующие шаги:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Подготовьте бакет в Yandex Object Storage](#bucket).
1. [Настройте NAT для доступа в интернет](#nat-routing).
1. [Создайте кластер Managed Service for Apache Airflow™](#create-airflow-cluster).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Сервис Query: объем считанных данных при исполнении запросов ([тарифы Query](../../query/pricing.md)).
* Кластер Managed Service for Apache Airflow™: вычислительные ресурсы компонентов кластера ([тарифы Managed Service for Apache Airflow™](../../managed-airflow/pricing.md)).

## Создайте сервисный аккаунт {#create-service-account}

[Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `airflow-sa` с [ролью](../../iam/roles-reference.md#editor) `editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан кластер Managed Service for Apache Airflow™:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта: `airflow-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `editor`.
  1. Нажмите кнопку **Создать**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт `airflow-sa`:

      ```bash
      yc iam service-account create airflow-sa
      ```

      Результат:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-21T10:36:29.726397755Z"
      name: airflow-sa
      ```

      Сохраните идентификатор сервисного аккаунта `airflow-sa` (`id`) и каталога, в котором его создали (`folder_id`).

  1. Назначьте сервисному аккаунту роль `editor` на каталог, указав сохраненные ранее идентификаторы каталога и сервисного аккаунта:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `editor` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте облачную сеть и подсети {#create-network}

Все ресурсы, созданные в руководстве, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Нажмите кнопку **Создать сеть**.
  1. В поле **Имя** укажите `yq-network`.
  1. В поле **Дополнительно** выберите опцию `Создать подсети`.
  1. Нажмите кнопку **Создать сеть**.

- Yandex Cloud CLI {#cli}

  1. Создайте сеть `yq-network`:

      ```bash
      yc vpc network create yq-network
      ```

      Результат:

      ```
      id: enptrcle5q3d********
      folder_id: b1g9hv2loamq********
      created_at: "2022-04-04T05:25:03Z"
      name: yq-network
      default_security_group_id: enpbsnnop4ak********
      ```

      Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсети:

      * В [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`:

        ```bash
        yc vpc subnet create yq-network-ru-central1-a \
          --zone ru-central1-a \
          --network-name yq-network \
          --range 10.1.0.0/16
        ```

        Результат:

        ```
        id: b0c3pte4o2kn********
        folder_id: b1g9hv2loamq********
        created_at: "2022-04-04T09:28:08Z"
        name: yq-network-ru-central1-a
        network_id: enptrcle5q3d********
        zone_id: ru-central1-a
        v4_cidr_blocks:
        - 10.1.0.0/16
        ```

      * В зоне доступности `ru-central1-b`:

        ```bash
        yc vpc subnet create yq-network-ru-central1-b \
          --zone ru-central1-b \
          --network-name yq-network \
          --range 10.2.0.0/16
        ```

      * В зоне доступности `ru-central1-d`:

        ```bash
        yc vpc subnet create yq-network-ru-central1-d \
          --zone ru-central1-d \
          --network-name yq-network \
          --range 10.3.0.0/16
        ```

      Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать подсети, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}

## Подготовьте бакет в Object Storage {#bucket}

### Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите [уникальное имя](../concepts/bucket.md#naming) бакета, например `airflow-bucket`.
  1. В полях **Чтение объектов** и **Чтение списка объектов** выберите `Для всех`.
  1. Нажмите кнопку **Создать бакет**.

- AWS CLI {#cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

  1. Создайте бакет, указав для него [уникальное имя](../concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```
      
      Результат:
      
      ```
      make_bucket: s3://airflow-bucket
      ```

  1. Включите [публичный доступ](../concepts/acl.md#predefined-acls) к чтению объектов и списка объектов в созданном бакете:

      ```bash
      aws --endpoint-url https://storage.yandexcloud.net \
        s3api put-bucket-acl \
        --bucket <имя_бакета> \
        --acl public-read
      ```

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../api-ref/Bucket/create.md) для ресурса [Bucket](../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../api-ref/grpc/Bucket/create.md) или методом S3 API [create](../s3/api-ref/bucket/create.md).

{% endlist %}

### Настройте ACL для бакета {#configure-acl-bucket}

[Отредактируйте ACL](../operations/buckets/edit-acl.md) созданного бакета так, чтобы у сервисного аккаунта `airflow-sa` было разрешение `READ`.

## Настройте NAT для доступа в интернет {#nat-routing}

### Создайте NAT-шлюз {#create-nat}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите **Шлюзы**.
  1. Нажмите кнопку **Создать шлюз** и в открывшемся окне:
      1. В поле **Имя** укажите имя `yq-nat`.
      1. В поле **Тип** выберите `NAT-шлюз`.
      1. Нажмите кнопку **Сохранить**.

- Yandex Cloud CLI {#cli}

  Создайте NAT-шлюз в каталоге по умолчанию:

  ```bash
  yc vpc gateway create \
    --name yq-nat
  ```

  Результат:

  ```text
  id: enpkq1sb7hed********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:20:36Z"
  name: yq-nat
  shared_egress_gateway: {}
  ```

  Подробнее о команде `yc vpc gateway create` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/gateway/create.md).

  Сохраните идентификатор (`id`) NAT-шлюза, он понадобится при создании таблицы маршрутизации.

- API {#api}

  Чтобы создать NAT-шлюз, воспользуйтесь методом REST API [create](../../vpc/api-ref/Gateway/create.md) для ресурса [Gateway](../../vpc/api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/Create](../../vpc/api-ref/grpc/Gateway/create.md).

{% endlist %}

### Создайте таблицу маршрутизации {#create-route}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите **Таблицы маршрутизации**.
  1. Нажмите кнопку **Создать таблицу маршрутизации** и введите параметры таблицы маршрутизации:
      1. Введите имя `yq-route-table`.
      1. Выберите сеть `yq-network`.
      1. Нажмите кнопку **Добавить маршрут**.
          * В поле **Next hop** выберите `Шлюз`.
          * В поле **Шлюз** выберите NAT-шлюз `yq-nat`. Префикс назначения заполнится автоматически.
      1. Нажмите кнопку **Добавить**.
  1. Нажмите кнопку **Создать таблицу маршрутизации**.

- Yandex Cloud CLI {#cli}

  Создайте таблицу маршрутизации с NAT-шлюзом `yq-nat` в качестве next hop и префиксом назначения `0.0.0.0/0`:

  ```bash
  yc vpc route-table create \
    --name=yq-route-table \
    --network-name=yq-network \
    --route destination=0.0.0.0/0,gateway-id=<идентификатор_NAT-шлюза>
  ```

  Результат:

  ```text
  id: enp4v8foko6s********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:22:47Z"
  name: yq-route-table
  network_id: enppoggov6ub********
  static_routes:
    - destination_prefix: 0.0.0.0/0
      gateway_id: enpkq1sb7hed********
  ```

  Подробнее о команде `yc vpc route-table create` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/route-table/create.md).


- API {#api}

  Чтобы создать таблицу маршрутизации, воспользуйтесь методом REST API [create](../../vpc/api-ref/RouteTable/create.md) для ресурса [RouteTable](../../vpc/api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Create](../../vpc/api-ref/grpc/RouteTable/create.md).

{% endlist %}

### Привяжите таблицу маршрутизации к подсети {#bind-route}

Привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик подсети через NAT-шлюз:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **Подсети**.
  1. В строке подсети `yq-network-ru-central1-a` нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg).
  1. Нажмите **Привязать таблицу маршрутизации** и выберите таблицу `yq-route-table`.
  1. Нажмите кнопку **Привязать**.

- Yandex Cloud CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc subnet update yq-network-ru-central1-a \
    --route-table-name=yq-route-table
  ```

  Результат:

  ```text
  id: e9b6n3jj3gh6********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:24:58Z"
  name: yq-network-ru-central1-a
  network_id: enppoggov6ub********
  zone_id: ru-central1-a
  v4_cidr_blocks:
    - 10.1.0.0/16
  route_table_id: enp4v8foko6s********
  dhcp_options: {}
  ```

  Подробнее о команде `yc vpc subnet update` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/update.md).

- API {#api}

  Чтобы привязать таблицу маршрутизации к подсети, воспользуйтесь методом REST API [update](../../vpc/api-ref/Subnet/update.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../../vpc/api-ref/grpc/Subnet/update.md).

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Создайте кластер Managed Service for Apache Airflow™ {#create-airflow-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно [создать кластер](../../managed-airflow/operations/cluster-create.md).
  1. Перейдите в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
  1. Нажмите кнопку **Создать кластер**.
  1. В блоке **Базовые параметры** укажите имя кластера. Имя должно быть уникальным в рамках каталога.
  1. В блоке **Настройки доступа** задайте пароль пользователя-администратора. Пароль должен иметь длину не менее 8 символов и содержать как минимум:

        * одну заглавную букву;
        * одну строчную букву;
        * одну цифру;
        * один специальный символ.

     {% note info %}

     Сохраните пароль локально или запомните его. Сервис не показывает пароли после создания.

     {% endnote %}

  1. В блоке **Сетевые настройки** выберите:

      * [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`;
      * облачную сеть `yq-network`;
      * подсеть `yq-network-ru-central1-a`;
      * [группу безопасности](../../vpc/concepts/security-groups.md) по умолчанию.

        Настройки группы безопасности не влияют на доступ к [веб-интерфейсу Apache Airflow™](../../managed-airflow/operations/af-interfaces.md#web-gui).

  1. В блоке **Зависимости** укажите название pip-пакета и ограничение на его версии:

      ```text
      apache-airflow-providers-yandex>=3.10
      ```

  1. В блоке **Хранилище DAG-файлов** выберите созданный ранее бакет.

  1. Нажмите кнопку **Создать**.

{% endlist %}

## Подготовьте DAG-файл и запустите граф {#dag}

Ниже используется [направленный ациклический граф (DAG)](../../managed-airflow/concepts/index.md#about-the-service) с двумя вершинами:
   * `yq_operator` — выполняет простой запрос к Yandex Query;
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
        schedule="@hourly",
        start_date=datetime.datetime.now(),
    ) as dag:

        yq_operator = YQExecuteQueryOperator(
            task_id="yq_operator", sql="SELECT 'Hello, world!'"
        )

        def print_context(ds=None, **kwargs):
            ti = kwargs["ti"]
            print(ti.xcom_pull(task_ids="yq_operator"))

        output_operator = PythonOperator(
            task_id="output_operator", provide_context=True, python_callable=print_context
        )

        yq_operator >> output_operator

    if __name__ == "__main__":
        dag.test()
    ```

    {% endcut %}

1. Загрузите DAG в кластер Managed Service for Apache Airflow™. Для этого создайте в бакете `airflow-bucket` папку `files/dags` и загрузите в нее файл `yq_dag.py`.
1. [Откройте веб-интерфейс Apache Airflow™](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый DAG `yq_hello_world_operator`.

    {% note info %}

    Загрузка DAG-файла из бакета может занять несколько минут.

    {% endnote %}

1. Чтобы запустить DAG, в строке с его именем сначала нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x), затем — **Trigger DAG**.

## Проверьте результат {#check-out}

1. В разделе **DAGs** откройте граф `yq_hello_world_operator`.
1. Перейдите в раздел **Grid**.
1. Выберите задание **yq_operator**.
1. Перейдите в раздел **XCom**.
1. Убедитесь, что в строке `return_value` есть элемент `'rows': [['Hello, world!']]`. Это значит, что запрос выполнен успешно.

## Удалите созданные ресурсы {#clear-out}

Чтобы удалить инфраструктуру и перестать платить за созданные ресурсы:

1. [Удалите](../operations/buckets/delete.md) бакет Object Storage.
1. [Отвяжите и удалите](../../vpc/operations/delete-route-table.md) таблицу маршрутизации.
1. [Удалите](../../vpc/operations/delete-nat-gateway.md#delete-nat-gateway) NAT-шлюз.
1. [Удалите](../../managed-airflow/operations/cluster-delete.md) кластер Apache Airflow™.
1. При необходимости удалите [подсети](../../vpc/operations/subnet-delete.md), [сеть](../../vpc/operations/network-delete.md) и [сервисный аккаунт](../../iam/operations/sa/delete.md).