# Automatically scaling an instance group for handling messages from a queue in {{ message-queue-full-name }}

This use case describes integration between {{ compute-full-name }}, {% if lang == "ru" %}[{{ message-queue-full-name }}](https://cloud.yandex.ru/services/message-queue), and [{{ monitoring-full-name }}](https://cloud.yandex.ru/services/monitoring){% endif %}{% if lang == "en" %}[{{ message-queue-full-name }}](https://cloud.yandex.com/en/services/message-queue), and [{{ monitoring-full-name }}](https://cloud.yandex.com/en/services/monitoring){% endif %}.

In this use case, an [instance group](../../compute/concepts/instance-groups/index.md) is created. All instances in the group handle messages from the same {{ message-queue-name }} queue (for example, they receive messages and delete them after a while). The number of enqueued messages is registered in a {{ monitoring-name }} metric, and the instance group is [automatically scaled](../../compute/concepts/instance-groups/scale.md#auto-scale) based on this metric.

An [opportunistic VM shutdown strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy) is chosen for scaling the instance group: the instances stop on their own once they handle all the messages and only then are deleted from the group when reducing its size. This ensures that the instances won't be forcibly deleted and will handle the last messages even if the queue empties before message handling is completed.

To perform this use case:

1. [Prepare the environment](#prepare).
1. [Create a queue in {{ message-queue-name }}](#create-queue).
1. [Create an image with an application](#create-image).
1. [Create an instance group](#create-ig).
1. [Check the instance group scalability](#test-autoscale).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

This use case uses a folder named `example-folder` as an example.

### Required paid resources {#paid-resources}

The cost of the infrastructure includes:

* A fee for using VMs and storing an [image](../../compute/concepts/image.md) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* A fee for using public IP addresses and outgoing traffic from VMs (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* A fee for queue requests (see [{{ message-queue-name }} pricing](../../message-queue/pricing.md)).

## Prepare the environment {#prepare}

### Create auxiliary {{ yandex-cloud }} resources {#create-aux-resources}

{% list tabs %}

- Management console

   1. Create a service account named `queue-autoscale-sa` and assign it the `editor` role for the `example-folder` folder:

      1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
      1. Go to the **Service accounts** tab and click **Create service account**.
      1. **Name** the service account: `queue-autoscale-sa`.
      1. Click **Add role** and choose the `editor` role.
      1. Click **Create**.

   1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key to the `access_key` file:

      1. In the list of service accounts, select `queue-autoscale-sa`.
      1. Click **Create new key**.
      1. Click **Create static access key**.
      1. In the key **Description**, specify: `Message Queue`.
      1. Click **Create**.
      1. Insert the key ID and secret key into `access_key` in the following format:

         ```yaml
         access_key:
           key_id: <key ID>
         secret: <secret key>
         ```

   1. Create a cloud network named `queue-autoscale-network`:

      1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Click **Create network**.
      1. **Name** the network: `queue-autoscale-network`.
      1. Disable the **Create subnets** option.
      1. Click **Create network**.

   1. Create a subnet named `queue-autoscale-subnet-a` in the `{{ region-id }}-a` zone:

      1. In the list of networks, select `queue-autoscale-network`.
      1. Click **Add subnet**.
      1. Specify the subnet parameters:

         * **Name**: `queue-autoscale-subnet-a`.
         * **Zone**: `{{ region-id }}-a`.
         * **CIDR**: `192.168.1.0/24`.

      1. Click **Create subnet**.

- CLI

   1. Create a service account named `queue-autoscale-sa`:

      ```bash
      yc iam service-account create --name queue-autoscale-sa
      ```

      Where `--name`: Service account name (`queue-autoscale-sa`).

      Result:

      ```
      id: aje6brh817ro8o6vo6tv
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2021-10-04T16:19:10.153346507Z"
      name: queue-autoscale-sa
      ```

   1. Assign the service account the `editor` role for `example-folder`:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --service-account-name queue-autoscale-sa \
        --role editor
      ```

      Where:

      * `--service-account-name`: The name of the service account created in step 1 (`queue-autoscale-sa`).
      * `--role`: The role assigned (`editor`).

      Result:

      ```
      done (1s)
      ```

   1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key to the `access_key` file:

      ```bash
      yc iam access-key create \
        --service-account-name queue-autoscale-sa \
        --description "{{ message-queue-name }}" \
      | tee access_key
      ```

      Where:

      * `--service-account-name`: The name of the service account created in step 1 (`queue-autoscale-sa`).
      * `--description`: Key description.

      Result:

      ```
      access_key:
        id: ajevb6bx51w3wnep9clq
        service_account_id: aje6brh817ro8o6vo6tv
        created_at: "2021-10-04T16:25:19.143847764Z"
        description: {{ message-queue-name }}
        key_id: g3VybpVKdq_YiFEmDIht
      secret: WVUqnwmC4LSUep0GTKGkbcht9K3Xav7VSOeD_mRG
      ```

   1. Create a cloud network named `queue-autoscale-network`:

      ```bash
      yc vpc network create queue-autoscale-network
      ```

      Result:

      ```bash
      id: enpabce123hde4ft1r3t
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2021-10-04T16:28:15.905337847Z"
      name: queue-autoscale-network
      ```

   1. Create a subnet named `queue-autoscale-subnet-a` in the `{{ region-id }}-a` zone:

      ```bash
      yc vpc subnet create queue-autoscale-subnet-a \
        --network-name queue-autoscale-network
        --range 192.168.1.0/24
        --zone {{ region-id }}-a
      ```

      Where:

      * `--network-name`: The name of the network where the subnet is created (`queue-autoscale-network`).
      * `--range`: The subnet CIDR.
      * `--zone`: The availability zone where the subnet is created `{{ region-id }}-a`.

      Result:

      ```bash
      id: e1lnabc23r1c9d0efoje
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2021-10-04T16:29:12.450858436Z"
      name: queue-autoscale-subnet-a
      network_id: enpabce123hde4ft1r3t
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.1.0/24
      ```

- API

   1. Create a service account named `queue-autoscale-sa` using the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API call or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method. The response will contain the service account ID.
   1. Assign the service account the `editor` role for `example-folder` using the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/folder_service.md#UpdateAccessBindings) gRPC API call or the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method. In the request body, specify the service account ID.
   1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key to the `access_key` file:

      1. Use the [AccessKeyService/Create](../../iam/api-ref/grpc/access_key_service.md#Create) gRPC API call or the [create](../../iam/api-ref/AccessKey/create.md) REST API method.
      1. Insert the key ID and secret key into `access_key` in the following format:

         ```yaml
         access_key:
           key_id: <key ID>
         secret: <secret key>
         ```

   1. Create a cloud network named `queue-autoscale-network` using the [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create) gRPC API call or the [create](../../vpc/api-ref/Network/create.md) REST API method. The response will contain the network ID.
   1. Create a subnet named `queue-autoscale-subnet-a` in `{{ region-id }}-a` with the `192.168.1.0/24` CIDR using the [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create) gRPC API call or the [create](../../vpc/api-ref/Subnet/create.md) REST API method. In the request body, specify the network ID.

{% endlist %}

### Set up the AWS CLI {#setup-aws-cli}

{% note info %}

You will use the AWS CLI to perform the final step of the script: [checking instance group scalability](#test-autoscale). This is why you must install and configure it, even if you aren't going to use it for any other steps.

{% endnote %}

1. Download and install the AWS CLI as described in its [documentation](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).
1. Configure the AWS CLI to work with {{ yandex-cloud }}:

   1. In your home folder, create a file called `.aws/credentials` with the previously received static access key and its identifier:

      ```
      [default]
          aws_access_key_id     = <key ID>
          aws_secret_access_key = <secret key>
      ```

   1. In your home folder, create a file named `.aws/config`. In it, specify `{{ region-id }}` as the default region:

      ```
      [default]
          region = {{ region-id }}
      ```

## Create a queue in {{ message-queue-name }} {#create-queue}

{% list tabs %}

- Management console

   1. Create a queue named `queue-autoscale-queue`:

      1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
      1. In the list of services, select **{{ message-queue-name }}**.
      1. Click **Create queue**.
      1. **Name** the queue: `queue-autoscale-queue`.
      1. Click **Create**.

   1. Save the queue URL to the `queue` file:

      1. In the list of queues, select `queue-autoscale-queue`.
      1. Copy the queue **URL**.
      1. Paste the URL into the `queue` file in the following format:

         ```yaml
         QueueUrl: <queue URL>
         ```

- AWS CLI

   1. Create a queue named `queue-autoscale-queue` and save its URL to the `queue` file:

      ```bash
      aws sqs create-queue \
        --endpoint https://message-queue.{{ api-host }} \
        --queue-name queue-autoscale-queue \
        --output yaml \
      | tee queue
      ```

      Where:

      * `--endpoint`: The root URL of the {{ message-queue-name }} API: `https://message-queue.{{ api-host }}`.
      * `--queue-name`: The name of the queue (`queue-autoscale-queue`).

      Result:

      ```yaml
      QueueUrl: https://message-queue.{{ api-host }}/b1gvlrnlei4l5idm9cbj/dj6000000003n58805qi/queue-autoscale-queue
      ```

- API

   1. Create a queue named `queue-autoscale-queue` using the [CreateQueue](../../message-queue/api-ref/queue/CreateQueue.md). The response will contain the queue URL.
   1. Paste the queue URL into the `queue` file in the following format:

      ```yaml
      QueueUrl: <queue URL>
      ```

{% endlist %}

## Create an image with an application {#create-image}

1. If you don't have Packer installed yet, download and install it by following the [instructions](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) on the official website.

   {% note info %}

   {{ yandex-cloud }} requires Packer 1.5 or higher.

   {% endnote %}

1. Download the [archive with files for the image](https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip) (ZIP, 3 KB) and unpack it:

   ```bash
   wget https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip
   unzip queue-autoscale-server.zip
   ```

1. In the `server-packer.json` file, change the object in the `builders` array:

   * In the `service_account_id` field, specify the ID of the `queue-autoscale-sa` service account.

      {% cut "How do I find out the service account ID" %}

      {% list tabs %}

      - Management console

         1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
         1. Go to the **Service accounts** tab.
         1. In the list of service accounts, select `queue-autoscale-sa`.
         1. Copy the service account **ID**.

      - CLI

         Run the following command:

         ```bash
         yc iam service-account get queue-autoscale-sa
         ```

         Result:

         ```
         id: aje6brh817ro8o6vo6tv
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-10-04T16:19:10.153346507Z"
         name: queue-autoscale-sa
         ```

      - API

         Use the [ServiceAccountService/List](../../iam/api-ref/grpc/service_account_service.md#List) gRPC API call or the [list](../../iam/api-ref/ServiceAccount/list.md) REST API method.

      {% endlist %}

      {% endcut %}

   * In the `folder_id` field, specify the ID of the folder in {{ yandex-cloud }}.

      {% cut "How do I find out the folder ID" %}

      {% list tabs %}

      - Management console

         In the [management console]({{ link-console-main }}), find a folder named `example-folder` in the list and copy its **ID**.

      - CLI

         Run the following command:

         ```bash
         yc resource-manager folder get example-folder
         ```

         Result:

         ```
         id: b1g9hv2loamqfnbul7d9
         cloud_id: b1g2y61sxwqxrtw34qtq
         created_at: "2021-10-04T13:21:32.788067492Z"
         name: example-folder
         status: ACTIVE
         ```

      - API

         Use the [FolderService/List](../../resource-manager/api-ref/grpc/folder_service.md#List) gRPC API call or the [list](../../resource-manager/api-ref/Folder/list.md) REST API method.

      {% endlist %}

      {% endcut %}

   * In the `subnet_id` field, specify the ID of the `queue-autoscale-subnet-a` subnet.

      {% cut "How do I find out the subnet ID" %}

      {% list tabs %}

      - Management console

         1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
         1. In the list of services, select **{{ vpc-name }}**.
         1. Go to the **Subnets** tab.
         1. In the list of subnets, find `queue-autoscale-subnet-a` and copy its **ID**.

      - CLI

         Run the following command:

         ```bash
         yc vpc subnet get queue-autoscale-subnet-a
         ```

         Result:

         ```
         id: e1lnabc23r1c9d0efoje
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-10-04T16:29:12.450858436Z"
         name: queue-autoscale-subnet-a
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

      - API

         Use the [SubnetService/List](../../vpc/api-ref/grpc/subnet_service.md#List) gRPC API call or the [list](../../vpc/api-ref/Subnet/list.md) REST API method.

      {% endlist %}

      {% endcut %}

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md) to enable the service account to work with {{ compute-name }} and save the token to `key.json`:

   {% list tabs %}

   - CLI

      ```bash
      yc iam key create \
        --service-account-name queue-autoscale-sa \
        --description "{{ compute-name }}" \
        --output key.json
      ```

      Where:

      * `--service-account-name`: The name of the service account created earlier (`queue-autoscale-sa`).
      * `--description`: Key description.
      * `--output`: The path to the file to save the key to (`key.json`).

      Result:

      ```
      id: ajevh3a0hrqf65scefug
      service_account_id: aje6brh817ro8o6vo6tv
      created_at: "2021-10-04T16:35:19.057777570Z"
      description: {{ compute-name }}
      key_algorithm: RSA_2048
      ```

   {% endlist %}

1. Run the command to create an image:

   ```bash
   packer build server-packer.json
   ```

   Result:

   ```
   ...
   Build 'builder' finished after 2 minutes 48 seconds.

   ==> Wait completed after 2 minutes 48 seconds

   ==> Builds finished. The artifacts of successful builds are:
   --> builder: A disk image was created: queue-autoscale-image-v1633354734 (id: fd8hlbuhjc4mssrvknkv) with family name queue-autoscale-image
   ```

## Create an instance group {#create-ig}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. In the list of services, select **{{ compute-name }}**.
   1. Go to the **Instance groups** tab and click **Create group**.
   1. Specify the instance group's **Basic parameters**:

      * **Name**: `queue-autoscale-ig`.
      * **Service account**: `queue-autoscale-sa`.

   1. Under **Allocation**, select the `{{ region-id }}-a` availability zone.
   1. Under **Instance template**, click **Define** and set up the template:

      1. Under **Image/boot disk selection**, go to the **Custom **tab and click **Select**.
      1. In the window that opens, select the created image as a boot disk:

         1. Go to the **Image** tab.
         1. Select an image whose name begins with `queue-autoscale-image`.
         1. Click **Apply**.

      1. Under **Network settings**:

         * Select the `queue-autoscale-network` **network**. The `queue-autoscale-subnet-a` subnet will be selected automatically.
         * In the **Public address** field, select **Auto** so that your VMs have internet access and can receive messages from the queue.

      1. Under **Access**:

         * Select **Service account** `queue-autoscale-sa`.
         * Enter your username and the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to connect to the VM.

      1. Click **Save**.

   1. Under **Allow when creating and updating**, specify the following values:

      * **Stop simultaneously**: `1`.
      * **Stop VMs by strategy**: **Opportunistic**.

   1. Under **Scalability**, specify the following values:

      * **Type**: **Automatic**.
      * **Autoscaling type**: **Regional**.
      * **Minimum number of instances per zone**: 0.
      * **Maximum group size**: 5.
      * **Utilization measurement period**: 60 seconds.
      * **Instance warmup period**: 0 minutes.
      * **Stabilization period**: 5 minutes.
      * **Initial group size**: 1.

   1. Under **Metrics**, specify the following values:

      * **Metric**: **Custom**.
      * **Service ID**: `message-queue`.
      * **Metric name**: `queue.messages.stored_count`.
      * **Labels**: The `queue` key and the `queue-autoscale-queue` value.
      * **Metric type**: `GAUGE`.
      * **Rule type**: `WORKLOAD`.
      * **Target value**: 5.

   1. Click **Create**.

- CLI

   1. Get the ID of the image you created earlier:

      ```bash
      yc compute image get-latest-from-family queue-autoscale-image
      ```

      Result:

      ```
      id: fd8hlbuhjc4mssrvknkv
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2021-10-04T16:38:54.345168059Z"
      name: queue-autoscale-image-v1633354734
      description: Image for autoscaling an instance group based on the size of a queue
      family: queue-autoscale-image
      storage_size: "3858759680"
      min_disk_size: "5368709120"
      product_ids:
      - f2e6fnj3erf1sropamjr
      status: READY
      os:
        type: LINUX
      ```

   1. Edit the `spec.yaml` instance group specification file:

      * In the `folder_id` field, specify the ID of the folder in {{ yandex-cloud }}.
      * In the `image_id` field, specify the ID of the created image.
      * In the `network_id` field, specify the `queue-autoscale-network` ID, and in the `subnet_ids` field, the `queue-autoscale-subnet-a` ID.

         {% cut "How do I find out the network ID" %}

         {% list tabs %}

         - CLI

            Run the command:

            ```bash
            yc vpc network get queue-autoscale-network
            ```

            Result:

            ```
            id: enpabce123hde4ft1r3t
            folder_id: b0g12ga82bcv0cdeferg
            created_at: "2021-10-04T16:28:15.905337847Z"
            name: queue-autoscale-network
            ```

         - Management console

            1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
            1. In the list of services, select **{{ vpc-name }}**.
            1. In the list of networks, find `queue-autoscale-network` and copy its **ID**.

         - API

            Use the [NetworkService/List](../../vpc/api-ref/grpc/network_service.md#List) gRPC API call or the [list](../../vpc/api-ref/Network/list.md) REST API method.

         {% endlist %}

         {% endcut %}

      * In the `service_account_id` field, specify the ID of the `queue-autoscale-sa` service account.

      To learn how to get the IDs of resources (except for images and networks), see step 3 in the section [Create an image with an application](#create-image).

   1. Create an instance group named `queue-autoscale-ig` according to the following specification:

      ```bash
      yc compute instance-group create --file spec.yaml
      ```

      Where `--file`: Path to the instance group specification file (`spec.yaml`).

- API

   1. Get the ID of the previously created image from the `queue-autoscale-image` family. To do this, use the [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/image_service.md#GetLatestByFamily) gRPC API call or the [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) REST API method.
   1. Edit the `spec.yaml` instance group specification file:

      * In the `folder_id` field, specify the ID of the folder in {{ yandex-cloud }}.
      * In the `image_id` field, specify the ID of the created image.
      * In the `network_id` field, specify the `queue-autoscale-network` ID, and in the `subnet_ids` field, the `queue-autoscale-subnet-a` ID.

         {% cut "How do I find out the network ID" %}

         {% list tabs %}

         - API

            Use the [NetworkService/List](../../vpc/api-ref/grpc/network_service.md#List) gRPC API call or the [list](../../vpc/api-ref/Network/list.md) REST API method.

         - Management console

            1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
            1. In the list of services, select **{{ vpc-name }}**.
            1. In the list of networks, find `queue-autoscale-network` and copy its **ID**.

         - CLI

            Run the following command:

            ```bash
            yc vpc network get queue-autoscale-network
            ```

            Result:

            ```
            id: enpabce123hde4ft1r3t
            folder_id: b0g12ga82bcv0cdeferg
            created_at: "2021-10-04T16:28:15.905337847Z"
            name: queue-autoscale-network
            ```

         {% endlist %}

         {% endcut %}

      * In the `service_account_id` field, specify the ID of the `queue-autoscale-sa` service account.

      To learn how to get the IDs of resources (except for images and networks), see step 3 in the section [Create an image with an application](#create-image).

   1. Create an instance group named `queue-autoscale-ig` according to the `spec.yaml` specification. To do this, use the [InstanceGroupService/CreateFromYaml](../../compute/api-ref/grpc/instance_group_service.md#CreateFromYaml) gRPC API call or the [createFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) REST API method.

{% endlist %}

## Check the instance group scalability {#test-autoscale}

1. Edit the `messages.sh` file: in the `--queue-url` parameter, specify the URL of the queue from the `queue` file.
1. Run `messages.sh`. This starts sending 100 messages to the `queue-autoscale-queue`.
1. Open dashboards in {{ monitoring-full-name }}:

   {% list tabs %}

   - Management console

      1. Open the dashboard with information about the instance group:

         1. In [{{ monitoring-name }}]({{ link-monitoring }}), select the **Compute: Instance Groups** service dashboard.
         1. In the **Instance Group ID** field, select `queue-autoscale-ig`.

      1. Open the dashboard with queue information:

         1. In [{{ monitoring-name }}]({{ link-monitoring }}), select the **Message Queue** service dashboard.
         1. In the **Queue ID** field, select `queue-autoscale-queue`.

   {% endlist %}

1. Check the dashboard data to make sure that the following events occurred sequentially:

   1. 100 messages were enqueued in `queue-autoscale-queue` (the **Message Queue** dashboard, the **Sent messages, count** and **Messages in queue, count** charts).
   1. Instances in the `queue-autoscale-ig` group started to receive messages (the **Received messages, count** chart) and delete them from the queue (the **Deleted messages, count** and **Messages in queue, count** charts).
   1. While handling the messages, the number of instances in the group increased from one to five and, after all the messages were handled, the group was empty (the **Compute — Instance Groups** dashboard, the **Number of instances in zone B** chart).

## Delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. [Delete](../../compute/operations/instance-groups/delete.md) `queue-autoscale-ig`.
1. [Delete](../../compute/operations/image-control/delete.md) `queue-autoscale-image`.
1. [Delete](../../message-queue/operations/message-queue-delete-queue.md) the `queue-autoscale-queue` queue.
1. [Delete](../../vpc/operations/subnet-delete.md) the `queue-autoscale-subnet-a` subnet.
1. [Delete](../../vpc/operations/network-delete.md) the `queue-autoscale-network`.
1. [Delete](../../iam/operations/sa/delete.md) the `queue-autoscale-sa` service account.
