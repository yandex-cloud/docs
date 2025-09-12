# Automating {{ yq-full-name }} tasks with {{ maf-full-name }}

{{ maf-short-name }} is a popular tool for automating data operations. {{ yq-full-name }} supports integration with {{ maf-short-name }} using the [`apache-airflow-providers-yandex`](https://pypi.org/project/apache-airflow-providers-yandex/) pip package.

To create an infrastructure for automation of {{ yq-full-name }} tasks with {{ maf-short-name }}, follow these steps:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#create-service-account).
1. [Create a cloud network and subnets](#create-network).
1. [Prepare a bucket in {{ objstorage-name }}](#bucket).
1. [Configure an egress NAT](#nat-routing).
1. [Create a {{ maf-name }} cluster](#create-airflow-cluster).
1. [Prepare the DAG file and run the graph](#dag).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [airflow-auto-tasks-paid-resources](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-paid-resources.md) %}

## Create a service account {#create-service-account}

[Create](../../iam/operations/sa/create.md) a service account named `airflow-sa` with the `editor` [role](../../iam/roles-reference.md#editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ maf-name }} cluster will be created:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account: `airflow-sa`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `editor` role.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `airflow-sa`:

      ```bash
      yc iam service-account create airflow-sa
      ```

      Result:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-21T10:36:29.726397755Z"
      name: airflow-sa
      ```

      Save the ID of the `airflow-sa` service account (`id`) and the ID of the folder where you created it (`folder_id`).

  1. Assign the `editor` role for the folder to the service account by specifying the folder and service account IDs you previously saved:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role editor \
        --subject serviceAccount:<service_account_ID>
      ```

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the `editor` role for a folder to a service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}

## Create a cloud network and subnets {#create-network}

All resources you create in this tutorial will belong to the same [cloud network](../../vpc/concepts/network.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `yq-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select `{{ ui-key.yacloud.vpc.networks.create.field_is-default }}`.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a network named `yq-network`:

      ```bash
      yc vpc network create yq-network
      ```

      Result:

      ```
      id: enptrcle5q3d********
      folder_id: b1g9hv2loamq********
      created_at: "2022-04-04T05:25:03Z"
      name: yq-network
      default_security_group_id: enpbsnnop4ak********
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create subnets:

      * [Availability zone](../../overview/concepts/geo-scope.md): `{{ region-id }}-a`

        ```bash
        yc vpc subnet create yq-network-{{ region-id }}-a \
          --zone {{ region-id }}-a \
          --network-name yq-network \
          --range 10.1.0.0/16
        ```

        Result:

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

      * Availability zone: `{{ region-id }}-b`:

        ```bash
        yc vpc subnet create yq-network-{{ region-id }}-b \
          --zone {{ region-id }}-b \
          --network-name yq-network \
          --range 10.2.0.0/16
        ```

      * Availability zone: `{{ region-id }}-d`:

        ```bash
        yc vpc subnet create yq-network-{{ region-id }}-d \
          --zone {{ region-id }}-d \
          --network-name yq-network \
          --range 10.3.0.0/16
        ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. To create a network, use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

  1. To create subnets, use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}

## Prepare a bucket in {{ objstorage-name }} {#bucket}

### Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a [unique name](../../storage/concepts/bucket.md#naming) for the bucket, e.g., `airflow-bucket`.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** and **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}

  {% include [aws-cli-install](../../_includes/aws-cli-install.md) %}

  1. Create a bucket with a [unique name](../../storage/concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3 mb s3://<bucket_name>
      ```
      
      Result:
      
      ```
      make_bucket: s3://airflow-bucket
      ```

  1. Enable [public access](../../storage/concepts/acl.md#predefined-acls) to read objects and their list in the bucket you created:

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3api put-bucket-acl \
        --bucket <bucket_name> \
        --acl public-read
      ```

- API {#api}

  To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}

### Set up the bucket ACL {#configure-acl-bucket}

{% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}

## Configure an egress NAT {#nat-routing}

### Create a NAT gateway {#create-nat}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Click **{{ ui-key.yacloud.vpc.gateways.button_create-gateway }}**, and in the window that opens:
      1. In the **{{ ui-key.yacloud.vpc.gateways.field_name }}** field, enter `yq-nat`.
      1. In the **{{ ui-key.yacloud.vpc.gateways.field_type }}** field, select `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Create a NAT gateway in the default folder:

  ```bash
  yc vpc gateway create \
    --name yq-nat
  ```

  Result:

  ```text
  id: enpkq1sb7hed********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:20:36Z"
  name: yq-nat
  shared_egress_gateway: {}
  ```

  For more information about the `yc vpc gateway create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/gateway/create.md).

  Save the NAT gateway `id`. You will need it when creating a route table.

- API {#api}

  To create a NAT gateway, use the [create](../../vpc/api-ref/Gateway/create.md) REST API method for the [Gateway](../../vpc/api-ref/Gateway/index.md) resource or the [GatewayService/Create](../../vpc/api-ref/grpc/Gateway/create.md) gRPC API call.

{% endlist %}

### Create a route table {#create-route}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_route-table }}** and specify the route table parameters:
      1. Enter the name: `yq-route-table`.
      1. Select the network: `yq-network`.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
          * In the **{{ ui-key.yacloud.vpc.route-table-form.label_next-hop-address }}** field, select `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}`.
          * In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the `yq-nat` NAT gateway. The destination prefix will apply automatically.
      1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
  1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Create a route table with the `yq-nat` NAT gateway as the next hop and the `0.0.0.0/0` destination prefix:

  ```bash
  yc vpc route-table create \
    --name=yq-route-table \
    --network-name=yq-network \
    --route destination=0.0.0.0/0,gateway-id=<NAT_gateway_ID>
  ```

  Result:

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

  For more information about the `yc vpc route-table create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/route-table/create.md).


- API {#api}

  To create a route table, use the [create](../../vpc/api-ref/RouteTable/create.md) REST API method for the [RouteTable](../../vpc/api-ref/RouteTable/index.md) resource or the [RouteTableService/Create](../../vpc/api-ref/grpc/RouteTable/create.md) gRPC API call.

{% endlist %}

### Associate the route table with a subnet {#bind-route}

Associate the route table with a subnet to route the subnet traffic via the NAT gateway:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. In the `yq-network-{{ region-id }}-a` row, click ![image](../../_assets/console-icons/ellipsis.svg).
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}** and select `yq-route-table`.
  1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc vpc subnet update yq-network-{{ region-id }}-a \
    --route-table-name=yq-route-table
  ```

  Result:

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

  For more information about the `yc vpc subnet update` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/update.md).

- API {#api}

  To associate a route table with a subnet, use the [update](../../vpc/api-ref/Subnet/update.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Update](../../vpc/api-ref/grpc/Subnet/update.md) gRPC API call.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Create a {{ maf-name }} cluster {#create-airflow-cluster}

{% include [airflow-auto-tasks-create-cluster](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-create-cluster.md) %}

## Prepare the DAG file and run the graph {#dag}

{% include [airflow-auto-tasks-dag-file](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-dag-file.md) %}

## Check the result {#check-out}

{% include [airflow-auto-tasks-test](../_tutorials_includes/airflow-auto-tasks/airflow-auto-tasks-test.md) %}

## Delete the resources you created {#clear-out}

To delete the infrastructure and stop paying for the resources you created:

1. [Delete](../../storage/operations/buckets/delete.md) the {{ objstorage-name }} bucket.
1. [Disassociate and delete](../../vpc/operations/delete-route-table.md) the route table.
1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md#delete-nat-gateway).
1. [Delete](../../managed-airflow/operations/cluster-delete.md) the {{ AF }} cluster.
1. Delete the [subnets](../../vpc/operations/subnet-delete.md), [network](../../vpc/operations/network-delete.md), and the [service account](../../iam/operations/sa/delete.md), if required.
