# Автоматизация задач {{ yq-full-name }} с помощью {{ maf-full-name }}

{{ maf-short-name }} — это популярный инструмент для автоматизации операций с данными. {{ yq-full-name }} поддерживает интеграцию с {{ maf-short-name }} с помощью pip-пакета [`apache-airflow-providers-yandex`](https://pypi.org/project/apache-airflow-providers-yandex/).

Чтобы создать инфраструктуру для автоматизации задач {{ yq-full-name }} c помощью {{ maf-short-name }}, выполните следующие шаги:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Подготовьте бакет в {{ objstorage-name }}](#bucket).
1. [Настройте NAT для доступа в интернет](#nat-routing).
1. [Создайте кластер {{ maf-name }}](#create-airflow-cluster).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [airflow-auto-tasks-paid-resources](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-paid-resources.md) %}

## Создайте сервисный аккаунт {#create-service-account}

[Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `airflow-sa` с [ролью](../../iam/roles-reference.md#editor) `editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан кластер {{ maf-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта: `airflow-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `editor`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `yq-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию `{{ ui-key.yacloud.vpc.networks.create.field_is-default }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

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

      * В [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`:

        ```bash
        yc vpc subnet create yq-network-{{ region-id }}-a \
          --zone {{ region-id }}-a \
          --network-name yq-network \
          --range 10.1.0.0/16
        ```

        Результат:

        ```
        id: b0c3pte4o2kn********
        folder_id: b1g9hv2loamq********
        created_at: "2022-04-04T09:28:08Z"
        name: yq-network-{{ region-id }}-a
        network_id: enptrcle5q3d********
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 10.1.0.0/16
        ```

      * В зоне доступности `{{ region-id }}-b`:

        ```bash
        yc vpc subnet create yq-network-{{ region-id }}-b \
          --zone {{ region-id }}-b \
          --network-name yq-network \
          --range 10.2.0.0/16
        ```

      * В зоне доступности `{{ region-id }}-d`:

        ```bash
        yc vpc subnet create yq-network-{{ region-id }}-d \
          --zone {{ region-id }}-d \
          --network-name yq-network \
          --range 10.3.0.0/16
        ```

      Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать подсети, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}

## Подготовьте бакет в {{ objstorage-name }} {#bucket}

### Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите [уникальное имя](../../storage/concepts/bucket.md#naming) бакета, например `airflow-bucket`.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}

  {% include [aws-cli-install](../../_includes/aws-cli-install.md) %}

  1. Создайте бакет, указав для него [уникальное имя](../../storage/concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3 mb s3://<имя_бакета>
      ```
      
      Результат:
      
      ```
      make_bucket: s3://airflow-bucket
      ```

  1. Включите [публичный доступ](../../storage/concepts/acl.md#predefined-acls) к чтению объектов и списка объектов в созданном бакете:

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3api put-bucket-acl \
        --bucket <имя_бакета> \
        --acl public-read
      ```

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}

### Настройте ACL для бакета {#configure-acl-bucket}

{% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}

## Настройте NAT для доступа в интернет {#nat-routing}

### Создайте NAT-шлюз {#create-nat}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.gateways.button_create-gateway }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud.vpc.gateways.field_name }}** укажите имя `yq-nat`.
      1. В поле **{{ ui-key.yacloud.vpc.gateways.field_type }}** выберите `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

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

  1. На панели слева выберите **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.overview.button_create_route-table }}** и введите параметры таблицы маршрутизации:
      1. Введите имя `yq-route-table`.
      1. Выберите сеть `yq-network`.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
          * В поле **{{ ui-key.yacloud.vpc.route-table-form.label_next-hop-address }}** выберите `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}`.
          * В поле **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** выберите NAT-шлюз `yq-nat`. Префикс назначения заполнится автоматически.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

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

  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. В строке подсети `yq-network-{{ region-id }}-a` нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg).
  1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}** и выберите таблицу `yq-route-table`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc subnet update yq-network-{{ region-id }}-a \
    --route-table-name=yq-route-table
  ```

  Результат:

  ```text
  id: e9b6n3jj3gh6********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:24:58Z"
  name: yq-network-{{ region-id }}-a
  network_id: enppoggov6ub********
  zone_id: {{ region-id }}-a
  v4_cidr_blocks:
    - 10.1.0.0/16
  route_table_id: enp4v8foko6s********
  dhcp_options: {}
  ```

  Подробнее о команде `yc vpc subnet update` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/update.md).

- API {#api}

  Чтобы привязать таблицу маршрутизации к подсети, воспользуйтесь методом REST API [update](../../vpc/api-ref/Subnet/update.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../../vpc/api-ref/grpc/Subnet/update.md).

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Создайте кластер {{ maf-name }} {#create-airflow-cluster}

{% include [airflow-auto-tasks-create-cluster](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-create-cluster.md) %}

## Подготовьте DAG-файл и запустите граф {#dag}

{% include [airflow-auto-tasks-dag-file](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-dag-file.md) %}

## Проверьте результат {#check-out}

{% include [airflow-auto-tasks-test](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-test.md) %}

## Удалите созданные ресурсы {#clear-out}

Чтобы удалить инфраструктуру и перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/buckets/delete.md) бакет {{ objstorage-name }}.
1. [Отвяжите и удалите](../../vpc/operations/delete-route-table.md) таблицу маршрутизации.
1. [Удалите](../../vpc/operations/delete-nat-gateway.md#delete-nat-gateway) NAT-шлюз.
1. [Удалите](../../managed-airflow/operations/cluster-delete.md) кластер {{ AF }}.
1. При необходимости удалите [подсети](../../vpc/operations/subnet-delete.md), [сеть](../../vpc/operations/network-delete.md) и [сервисный аккаунт](../../iam/operations/sa/delete.md).
