# Automatically scaling an instance group for handling messages from a queue in {{ message-queue-full-name }}

This use case describes integration within {{ compute-full-name }}, [{{ message-queue-full-name }}](/services/message-queue), and [{{ monitoring-full-name }}](/services/monitoring).

In this use case, an [instance group](../../compute/concepts/instance-groups/index.md) is created. All instances in the group handle messages from the same {{ message-queue-name }} queue (for example, they receive messages and delete them after a while). The number of enqueued messages is registered in a {{ monitoring-name }} metric, and the instance group is [automatically scaled](../../compute/concepts/instance-groups/scale.md#auto-scale) based on this metric.

An [opportunistic VM shutdown strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy) is chosen for scaling the instance group: the instances stop on their own once they handle all the messages and only then are deleted from the group when reducing its size. This ensures that the instances won't be forcibly deleted and will handle the last messages even if the queue empties before message handling is completed.

To perform this use case:

1. [Prepare the environment](#prepare).
1. [Create a queue in {{ message-queue-name }}](#create-queue).
1. [Create an image with an application](#create-image).
1. [Create an instance group](#create-ig).
1. [Check the instance group scalability](#test-autoscale).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

This use case uses a folder named `example-folder` as an example.

### Required paid resources {#paid-resources}

The cost of the infrastructure includes:

* Fee for using VMs and storing an [image](../../compute/concepts/image.md) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outgoing VM traffic (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Fee for queue requests (see [{{ message-queue-name }} pricing](../../message-queue/pricing.md)).

## Prepare the environment {#prepare}

### Create auxiliary {{ yandex-cloud }} resources {#create-aux-resources}

{% list tabs group=instructions %}

- Management console {#console}

   1. Create a service account named `queue-autoscale-sa` and assign it the `editor` role for the `example-folder` folder:

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `queue-autoscale-sa`.
      1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `editor` role.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key to the `access_key` file:

      1. In the list of service accounts, select `queue-autoscale-sa`.
      1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-description }}** field, select `Message Queue`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Insert the key ID and secret key into `access_key` in the following format:

         ```yaml
         access_key:
           key_id: <key_ID>
         secret: <secret_key>
         ```

   1. Create a cloud network named `queue-autoscale-network`:

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `queue-autoscale-network`.
      1. Disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

   1. Create a subnet named `queue-autoscale-subnet-a` in the `{{ region-id }}-a` zone:

      1. In the list of networks, select `queue-autoscale-network`.
      1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
      1. Specify the subnet parameters:

         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `queue-autoscale-subnet-a`.
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`.
         * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.1.0/24`.

      1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

   1. Create a service account named `queue-autoscale-sa`:

      ```bash
      yc iam service-account create --name queue-autoscale-sa
      ```

      Where `--name`: Service account name (`queue-autoscale-sa`).

      Result:

      ```
      id: aje6brh817ro********
      folder_id: b0g12ga82bcv********
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

      * `--service-account-name`: Name of the service account created in step 1 (`queue-autoscale-sa`).
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

      * `--service-account-name`: Name of the service account created in step 1: `queue-autoscale-sa`.
      * `--description`: Key description.

      Result:

      ```
      access_key:
        id: ajevb6bx51w3********
        service_account_id: aje6brh817ro********
        created_at: "2021-10-04T16:25:19.143847764Z"
        description: {{ message-queue-name }}
        key_id: g3VybpVKdq_Y********
      secret: WVUqnwmC4LSUep0GTKGkbcht9K3Xav7VSOeD_mRG
      ```

   1. Create a cloud network named `queue-autoscale-network`:

      ```bash
      yc vpc network create queue-autoscale-network
      ```

      Result:

      ```bash
      id: enpabce123hd********
      folder_id: b0g12ga82bcv********
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

      * `--network-name`: Name of the network where the subnet is created (`queue-autoscale-network`).
      * `--range`: Subnet CIDR.
      * `--zone`: Availability zone where the subnet is created `{{ region-id }}-a`.

      Result:

      ```bash
      id: e1lnabc23r1c********
      folder_id: b0g12ga82bcv********
      created_at: "2021-10-04T16:29:12.450858436Z"
      name: queue-autoscale-subnet-a
      network_id: enpabce123hd********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.1.0/24
      ```

- API {#api}

   1. Create a service account named `queue-autoscale-sa` using the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API call or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method. The response will contain the service account ID.
   1. Assign the service account the `editor` role for `example-folder` using the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/folder_service.md#UpdateAccessBindings) gRPC API call or the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method. In the request body, specify the service account ID.
   1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key to the `access_key` file:

      1. Use the [AccessKeyService/Create](../../iam/api-ref/grpc/access_key_service.md#Create) gRPC API call or the [create](../../iam/api-ref/AccessKey/create.md) REST API method.
      1. Insert the key ID and secret key into `access_key` in the following format:

         ```yaml
         access_key:
           key_id: <key_ID>
         secret: <secret_key>
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
          aws_access_key_id     = <key_ID>
          aws_secret_access_key = <secret_key>
      ```

   1. In your home folder, create a file named `.aws/config`. In it, specify `{{ region-id }}` as the default region:

      ```
      [default]
          region = {{ region-id }}
      ```

## Create a queue in {{ message-queue-name }} {#create-queue}

{% list tabs group=instructions %}

- Management console {#console}

   1. Create a queue named `queue-autoscale-queue`:

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
      1. Click **{{ ui-key.yacloud.ymq.queues.button_create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, specify `queue-autoscale-queue`.
      1. Click **{{ ui-key.yacloud.common.create }}**.

   1. Save the queue URL to the `queue` file:

      1. In the list of queues, select `queue-autoscale-queue`.
      1. Copy the queue **{{ ui-key.yacloud.ymq.queue.overview.label_url }}**.
      1. Paste the URL into the `queue` file in the following format:

         ```yaml
         QueueUrl: <queue_URL>
         ```

- AWS CLI {#cli}

   1. Create a queue named `queue-autoscale-queue` and save its URL to the `queue` file:

      ```bash
      aws sqs create-queue \
        --endpoint https://message-queue.{{ api-host }} \
        --queue-name queue-autoscale-queue \
        --output yaml \
      | tee queue
      ```

      Where:

      * `--endpoint`: Root URL of the {{ message-queue-name }} API: `https://message-queue.{{ api-host }}`.
      * `--queue-name`: Name of the queue: `queue-autoscale-queue`.

      Result:

      ```yaml
      QueueUrl: https://message-queue.{{ api-host }}/b1gvlrnlei4l********/dj6000000003n58805qi/queue-autoscale-queue
      ```

- API {#api}

   1. Create a queue named `queue-autoscale-queue` using the [CreateQueue](../../message-queue/api-ref/queue/CreateQueue.md). The response will contain the queue URL.
   1. Paste the queue URL into the `queue` file in the following format:

      ```yaml
      QueueUrl: <queue_URL>
      ```

{% endlist %}

## Create an image with an application {#create-image}

1. If you do not have Packer installed yet, download and install it by following the [instructions](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) on the official website. You can also download a Packer distribution for your platform from a [mirror](https://hashicorp-releases.yandexcloud.net/packer/).

   {% note info %}

   {{ yandex-cloud }} requires Packer 1.5 or higher.

   {% endnote %}

1. Configure the [Yandex Compute Builder plugin](https://developer.hashicorp.com/packer/plugins/builders/yandex):

   1. Create a `config.pkr.hcl` file with the following contents:

      ```hcl
      packer {
        required_plugins {
          yandex = {
            version = ">= 1.1.2"
            source  = "{{ packer-source-link }}"
          }
        }
      }
      ```

   1. Install the plugin:

      ```bash
      packer init <config.pkr.hcl_file_path>
      ```

      Result:

      ```text
      Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
      ```

1. Download the [archive with files for the image](https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip) (ZIP, 3 KB) and unpack it:

   ```bash
   wget https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip
   unzip queue-autoscale-server.zip
   ```

1. In the `server-packer.json` file, change the object in the `builders` array:

   * In the `service_account_id` field, specify the ID of the `queue-autoscale-sa` service account.

      {% cut "How do I find out the service account ID" %}

      {% list tabs group=instructions %}

      - Management console {#console}

         1. In the [management console]({{ link-console-main }}), select `example-folder`.
         1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
         1. In the list of service accounts, select `queue-autoscale-sa`.
         1. Copy the service account **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id }}**.

      - CLI {#cli}

         Run the following command:

         ```bash
         yc iam service-account get queue-autoscale-sa
         ```

         Result:

         ```
         id: aje6brh817ro********
         folder_id: b0g12ga82bcv********
         created_at: "2021-10-04T16:19:10.153346507Z"
         name: queue-autoscale-sa
         ```

      - API {#api}

         Use the [list](../../iam/api-ref/ServiceAccount/list.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/List](../../iam/api-ref/grpc/service_account_service.md#List) gRPC API call.

      {% endlist %}

      {% endcut %}

   * In the `folder_id` field, specify the ID of the folder in {{ yandex-cloud }}.

      {% cut "How do I find out the folder ID" %}

      {% list tabs group=instructions %}

      - Management console {#console}

         On the [cloud page]({{ link-console-cloud }}), find `example-folder` in the **{{ ui-key.yacloud.iam.cloud.folders.section_folders }}** list and copy its **{{ ui-key.yacloud.common.id }}**.

      - CLI {#cli}

         Run the following command:

         ```bash
         yc resource-manager folder get example-folder
         ```

         Result:

         ```
         id: b1g9hv2loamq********
         cloud_id: b1g2y61sxwqx********
         created_at: "2021-10-04T13:21:32.788067492Z"
         name: example-folder
         status: ACTIVE
         ```

      - API {#api}

         Use the [list](../../resource-manager/api-ref/Folder/list.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/List](../../resource-manager/api-ref/grpc/folder_service.md#List) gRPC API call.

      {% endlist %}

      {% endcut %}

   * In the `subnet_id` field, specify the ID of the `queue-autoscale-subnet-a` subnet.

      {% cut "How do I find out the subnet ID" %}

      {% list tabs group=instructions %}

      - Management console {#console}

         1. In the [management console]({{ link-console-main }}), select `example-folder`.
         1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
         1. Go to ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
         1. In the list of subnets, find `queue-autoscale-subnet-a` and copy its **{{ ui-key.yacloud.vpc.network.overview.column_subnetwork_id }}**.

      - CLI {#cli}

         Run the following command:

         ```bash
         yc vpc subnet get queue-autoscale-subnet-a
         ```

         Result:

         ```
         id: e1lnabc23r1c********
         folder_id: b0g12ga82bcv********
         created_at: "2021-10-04T16:29:12.450858436Z"
         name: queue-autoscale-subnet-a
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

      - API {#api}

         Use the [list](../../vpc/api-ref/Subnet/list.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/List](../../vpc/api-ref/grpc/subnet_service.md#List) gRPC API call.

      {% endlist %}

      {% endcut %}

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md) to enable the service account to work with {{ compute-name }} and save the token to `key.json`:

   {% list tabs group=instructions %}

   - CLI {#cli}

      ```bash
      yc iam key create \
        --service-account-name queue-autoscale-sa \
        --description "{{ compute-name }}" \
        --output key.json
      ```

      Where:

      * `--service-account-name`: Name of the previously created service account (`queue-autoscale-sa`).
      * `--description`: Key description.
      * `--output`: Path to the file to save the key to `key.json`.

      Result:

      ```
      id: ajevh3a0hrqf********
      service_account_id: aje6brh817ro********
      created_at: "2021-10-04T16:35:19.057777570Z"
      description: {{ compute-name }}
      key_algorithm: RSA_2048
      ```

   - API {#api}

      Use the [create](../../iam/api-ref/Key/create.md) REST API method for the [Key](../../iam/api-ref/Key/index.md) resource or the [KeyService/Create](../../iam/api-ref/grpc/key_service.md#Create) gRPC API call.

   {% endlist %}

1. Run the following command to create an image:

   ```bash
   packer build server-packer.json
   ```

   Result:

   ```
   ...
   Build 'builder' finished after 2 minutes 48 seconds.

   ==> Wait completed after 2 minutes 48 seconds

   ==> Builds finished. The artifacts of successful builds are:
   --> builder: A disk image was created: queue-autoscale-image-v1633354734 (id: fd8hlbuhjc4m********) with family name queue-autoscale-image
   ```

## Create an instance group {#create-ig}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select `example-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:

      * In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, specify `queue-autoscale-ig`.
      * Select **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** `queue-autoscale-sa`.

   1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select `{{ region-id }}-a` in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** and do the following in the window that opens:

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** tab and click **{{ ui-key.yacloud.common.select }}**.
      1. In the window that opens, select the created image as a boot disk:

         1. Go to the **{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}** tab.
         1. Select an image whose name begins with `queue-autoscale-image`.
         1. Click **{{ ui-key.yacloud_monitoring.actions.common.apply }}**.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

         * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** field, select `queue-autoscale-network`.
         * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}` so that your VMs have internet access and can receive messages from the queue.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

         * In the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field, select `queue-autoscale-sa`.
         * Enter your username and the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to connect to the VM.

      1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

   1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**, specify the following values:

      * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}**: `1`
      * **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}**: `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`

   1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, specify the following values:

      * **{{ ui-key.yacloud.compute.groups.create.field_scale-type }}**: `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}`
      * **{{ ui-key.yacloud.compute.groups.create.field_auto-scale-type }}**: `{{ ui-key.yacloud.compute.groups.create.value_scale-regional }}`
      * **{{ ui-key.yacloud.compute.groups.create.field_min-zone-size }}**: `0`
      * **{{ ui-key.yacloud.compute.groups.create.field_max-size }}**: `5`
      * **{{ ui-key.yacloud.compute.groups.create.field_measurement-duration }}**: `60 {{ ui-key.yacloud.common.units.label_time-sec_many }}`
      * **{{ ui-key.yacloud.compute.groups.create.field_warmup-duration }}**: `0 {{ ui-key.yacloud.common.units.label_time-min_zero }}`
      * **{{ ui-key.yacloud.compute.groups.create.field_cooldown-duration }}**: `5 {{ ui-key.yacloud.common.units.label_time-min_many }}`
      * **{{ ui-key.yacloud.compute.groups.create.field_initial-size }}**: `1`

   1. Under **{{ ui-key.yacloud.compute.groups.create.label_custom-metrics }}**, specify the following values:

      * **{{ ui-key.yacloud.compute.groups.create.field_metric }}**: `{{ ui-key.yacloud.compute.groups.create.metric-type-custom }}`.
      * **{{ ui-key.yacloud.compute.groups.create.field_folder-id }}**: `message-queue`.
      * **{{ ui-key.yacloud.compute.groups.create.field_metric-name }}**: `queue.messages.stored_count`.
      * **{{ ui-key.yacloud.compute.groups.create.field_metric-labels }}**: The `queue` key and the `queue-autoscale-queue` value
      * **{{ ui-key.yacloud.compute.groups.create.field_metric-type }}**: `GAUGE`.
      * **{{ ui-key.yacloud.compute.groups.create.field_metric-rule-type }}**: `WORKLOAD`.
      * **{{ ui-key.yacloud.compute.groups.create.field_metric-target }}**: `5`

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   1. Get the ID of the image you created at the previous steps:

      ```bash
      yc compute image get-latest-from-family queue-autoscale-image
      ```

      Result:

      ```
      id: fd8hlbuhjc4m********
      folder_id: b0g12ga82bcv********
      created_at: "2021-10-04T16:38:54.345168059Z"
      name: queue-autoscale-image-v1633354734
      description: Image for autoscaling an instance group based on the size of a queue
      family: queue-autoscale-image
      storage_size: "3858759680"
      min_disk_size: "5368709120"
      product_ids:
      - f2e6fnj3erf1********
      status: READY
      os:
        type: LINUX
      ```

   1. Edit the `spec.yaml` instance group specification file:

      * In the `folder_id` field, specify the ID of the folder in {{ yandex-cloud }}.
      * In the `image_id` field, specify the ID of the created image.
      * In the `network_id` field, specify the `queue-autoscale-network` ID, and in the `subnet_ids` field, the `queue-autoscale-subnet-a` ID.

         {% cut "How do I find out the network ID" %}

         {% list tabs group=instructions %}

         - CLI {#cli}

            Run this command:

            ```bash
            yc vpc network get queue-autoscale-network
            ```

            Result:

            ```
            id: enpabce123hd********
            folder_id: b0g12ga82bcv********
            created_at: "2021-10-04T16:28:15.905337847Z"
            name: queue-autoscale-network
            ```

         - Management console {#console}

            1. In the [management console]({{ link-console-main }}), select `example-folder`.
            1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
            1. In the list of networks, find `queue-autoscale-network` and copy its **{{ ui-key.yacloud.vpc.networks.column_id }}**.

         - API {#api}

            Use the [list](../../vpc/api-ref/Network/list.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/List](../../vpc/api-ref/grpc/network_service.md#List) gRPC API call.

         {% endlist %}

         {% endcut %}

      * In the `service_account_id` field, specify the ID of the `queue-autoscale-sa` service account.

      To learn how to get the IDs of resources (except for images and networks), see step 3 in the section [Create an image with an application](#create-image).

   1. Create an instance group named `queue-autoscale-ig` according to the following specification:

      ```bash
      yc compute instance-group create --file spec.yaml
      ```

      Where `--file`: Path to the instance group specification file (`spec.yaml`).

- API {#api}

   1. Get the ID of the previously created image from the `queue-autoscale-image` family. To do this, use the [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/image_service.md#GetLatestByFamily) gRPC API call or the [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) REST API method.
   1. Edit the `spec.yaml` instance group specification file:

      * In the `folder_id` field, specify the ID of the folder in {{ yandex-cloud }}.
      * In the `image_id` field, specify the ID of the created image.
      * In the `network_id` field, specify the `queue-autoscale-network` ID, and in the `subnet_ids` field, the `queue-autoscale-subnet-a` ID.

         {% cut "How do I find out the network ID" %}

         {% list tabs group=instructions %}

         - Management console {#console}

            1. In the [management console]({{ link-console-main }}), select `example-folder`.
            1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
            1. In the list of networks, find `queue-autoscale-network` and copy its **{{ ui-key.yacloud.vpc.networks.column_id }}**.

         - CLI {#cli}

            Run the following command:

            ```bash
            yc vpc network get queue-autoscale-network
            ```

            Result:

            ```
            id: enpabce123hd********
            folder_id: b0g12ga82bcv********
            created_at: "2021-10-04T16:28:15.905337847Z"
            name: queue-autoscale-network
            ```

         - API {#api}

            Use the [list](../../vpc/api-ref/Network/list.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/List](../../vpc/api-ref/grpc/network_service.md#List) gRPC API call.

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

   {% list tabs group=instructions %}

   - Management console {#console}

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
   1. While handling the messages, the number of instances in the group increased from one to five and, after all messages were handled, the group became empty (the **Compute: Instance Groups** dashboard, the **Number of instances in zone B** chart).

## Delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. [Delete](../../compute/operations/instance-groups/delete.md) `queue-autoscale-ig`.
1. [Delete](../../compute/operations/image-control/delete.md) `queue-autoscale-image`.
1. [Delete](../../message-queue/operations/message-queue-delete-queue.md) the `queue-autoscale-queue` queue.
1. [Delete](../../vpc/operations/subnet-delete.md) the `queue-autoscale-subnet-a` subnet.
1. [Delete](../../vpc/operations/network-delete.md) the `queue-autoscale-network`.
1. [Delete](../../iam/operations/sa/delete.md) the `queue-autoscale-sa` service account.
