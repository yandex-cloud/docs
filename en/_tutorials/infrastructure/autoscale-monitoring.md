# Autoscaling an instance group to process messages in {{ message-queue-full-name }}


This is an integration scenario for {{ compute-full-name }}, [{{ message-queue-full-name }}](/services/message-queue), and [{{ monitoring-full-name }}](/services/monitoring). 

In this scenario, we will create an [instance group](../../compute/concepts/instance-groups/index.md). All instances in this group process messages from the same queue in {{ message-queue-name }} (in our example, they receive messages and delete them after a while). The system registers the number of enqueued messages in the {{ monitoring-name }} metric and [autoscales](../../compute/concepts/instance-groups/scale.md#auto-scale) the instance group based on it. 

For scaling, we are going to use the [opportunistic shutdown strategy](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy). This means the VMs get stopped once they are done processing all messages, and only then get removed from the group. This ensures that the system will not forcibly remove the VMs and they will process all messages even if the queue gets empty before the processing is complete.

To work with this scenario, you will need to:

1. [Set up your environment](#prepare).
1. [Create a queue in {{ message-queue-name }}](#create-queue).
1. [Create an application image](#create-image).
1. [Create an instance group](#create-ig).
1. [Check the instance group scalability](#test-autoscale).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

As an example, we will use a folder named `example-folder`.

### Required paid resources {#paid-resources}

The infrastructure cost includes:

* Fee for using VMs and storing an [image](../../compute/concepts/image.md) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for public IP addresses and outbound VM traffic (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Fee for queue requests (see [{{ message-queue-name }} pricing](../../message-queue/pricing.md)).

## Set up your environment {#prepare}

### Create auxiliary {{ yandex-cloud }} resources {#create-aux-resources}

{% list tabs group=instructions %}

- Management console {#console}

  1. Create the `queue-autoscale-sa` service account and assign it the `editor` role for `example-folder`.
  
     1. In the [management console]({{ link-console-main }}), select `example-folder`.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `queue-autoscale-sa`.
     1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `editor` role.
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
     
  1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key into the `access_key` file:
  
     1. In the list of service accounts, select `queue-autoscale-sa`.
     1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
     1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-description }}** field, specify `Message Queue`.
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
     1. Add the key ID and secret key to the `access_key` file in the following format:
     
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
     1. Disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     
  1. Create a subnet named `queue-autoscale-subnet-d` in the `{{ region-id }}-d` availability zone:
  
     1. In the list of networks, select `queue-autoscale-network`.
     1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
     1. Specify the subnet parameters:
     
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `queue-autoscale-subnet-d`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-d`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.1.0/24`
        
     1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  1. Create a service account named `queue-autoscale-sa`:
  
     ```bash
     yc iam service-account create --name queue-autoscale-sa
     ```
     
     Where `--name` is the service account name, `queue-autoscale-sa`.
     
     Result:
     
     ```
     id: aje6brh817ro********
     folder_id: b0g12ga82bcv********
     created_at: "2021-10-04T16:19:10.153346507Z"
     name: queue-autoscale-sa
     ```
     
  1. Assign the `editor` role for `example-folder` to the service account:
  
     ```bash
     yc resource-manager folder add-access-binding example-folder \
       --service-account-name queue-autoscale-sa \
       --role editor
     ```
     
     Where:

     * `--service-account-name`: Service account name, `queue-autoscale-sa`.
     * `--role`: `editor` role.
     
     Result:
     
     ```
     done (1s)
     ```
     
  1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key into the `access_key` file:
    
     ```bash
     yc iam access-key create \
       --service-account-name queue-autoscale-sa \
       --description "{{ message-queue-name }}" \
     | tee access_key
     ```
    
     Where:

     * `--service-account-name`: Service account name, `queue-autoscale-sa`.
     * `--description`: Key description.
     
     Result:
     
     ```
     access_key:
       id: ajevb6bx51w3********
       service_account_id: aje6brh817ro********
       created_at: "2021-10-04T16:25:19.143847764Z"
       description: {{ message-queue-name }}
       key_id: g3VybpVKdq_Y********
     secret: WVUqnwmC4LSUep0GTKGkbcht9K3Xav7V********
     ```
     
  1. Create a cloud network named `queue-autoscale-network`:
  
     ```bash
     yc vpc network create queue-autoscale-network
     ```

     Result:

     ```text
     id: enpabce123hd********
     folder_id: b0g12ga82bcv********
     created_at: "2021-10-04T16:28:15.905337847Z"
     name: queue-autoscale-network
     ```

  1. Create a subnet named `queue-autoscale-subnet-d` in the `{{ region-id }}-d` availability zone:

     ```bash
     yc vpc subnet create queue-autoscale-subnet-d \
       --network-name queue-autoscale-network 
       --range 192.168.1.0/24 
       --zone {{ region-id }}-d
     ```
     
     Where:

     * `--network-name`: `queue-autoscale-network`, the one where you are creating the subnet.
     * `--range`: Subnet CIDR.
     * `--zone`: Subnet availability zone, `{{ region-id }}-d`.

     Result:

     ```text
     id: e1lnabc23r1c********
     folder_id: b0g12ga82bcv********
     created_at: "2021-10-04T16:29:12.450858436Z"
     name: queue-autoscale-subnet-d
     network_id: enpabce123hd********
     zone_id: {{ region-id }}-d
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```
     
- API {#api}

  1. To create the `queue-autoscale-sa` service account, use the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method. The response will contain the service account ID.
  1. To assign the service account the `editor` role for `example-folder`, use the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call or the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method. In the request body, specify the service account ID.
  1. Create a [static access key](../../iam/concepts/authorization/access-key.md) to enable the service account to work with {{ message-queue-name }} and save the key into the `access_key` file:
  
     1. Use the [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md) gRPC API call or the [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) REST API method.
     1. Add the key ID and secret key to the `access_key` file in the following format:
          
        ```yaml
        access_key:
          key_id: <key_ID>
        secret: <secret_key>
        ```
        
  1. To create the `queue-autoscale-network` cloud network, use the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call or the [create](../../vpc/api-ref/Network/create.md) REST API method. The response will contain the network ID.
  1. To create a subnet named `queue-autoscale-subnet-d` in the `{{ region-id }}-d` availability zone with the `192.168.1.0/24` CIDR, use the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call or the [create](../../vpc/api-ref/Subnet/create.md) REST API method. In the request body, specify the network ID.
  
{% endlist %}

### Set up the AWS CLI {#setup-aws-cli}

{% note info %}

You will need the AWS CLI to complete the final step of this scenario, i.e., to [check the instance group scalability](#test-autoscale). This is why you have to install and configure it.

{% endnote %}

1. Download and install the AWS CLI as described in the relevant [AWS guide](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).
1. Configure the AWS CLI to work with {{ yandex-cloud }}:
  
   1. In your home folder, create a file named `.aws/credentials` with the previously received static access key and its ID:
           
      ```
      [default]
          aws_access_key_id     = <key_ID>
          aws_secret_access_key = <secret_key>
      ```
        
   1. In your home folder, create the `.aws/config` file; in this file, specify the default region: `{{ region-id }}`:
           
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

     * `--endpoint`: {{ message-queue-name }} API root URL, `https://message-queue.{{ api-host }}`.
     * `--queue-name`: Queue name, `queue-autoscale-queue`.
     
     Result:
     
     ```yaml
     QueueUrl: https://message-queue.{{ api-host }}/b1gvlrnlei4l********/dj6000000003********/queue-autoscale-queue
     ```
     
- API {#api}

  1. To create the queue named `queue-autoscale-queue`, use the [CreateQueue](../../message-queue/api-ref/queue/CreateQueue.md) API method. The response will contain the queue URL.
  1. Paste the queue URL into the `queue` file in the following format:
          
     ```yaml
     QueueUrl: <queue_URL>
     ```

{% endlist %}

## Create an application image {#create-image}

1. If you do not have Packer installed, download and install it by following [this tutorial](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) on the official HashiCorp website. You can also download Packer for your platform [here](https://hashicorp-releases.yandexcloud.net/packer/).

   {% note info %}
   
   {{ yandex-cloud }} requires Packer 1.5 or higher.
   
   {% endnote %}

1. Configure the [Yandex Compute Builder plugin](https://developer.hashicorp.com/packer/plugins/builders/yandex):

    1. Create a file named `config.pkr.hcl` with the following contents:
        
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
        packer init <path_to_config.pkr.hcl>
        ```

        Result:

        ```text
        Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
        ```

1. Download the [image file archive](https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip) (ZIP, 3 KB) and unpack it:

   ```bash
   wget https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip
   unzip queue-autoscale-server.zip
   ```
   
1. In the `server-packer.json` file, change the object in the `builders` array:

   * In the `service_account_id` field, specify the `queue-autoscale-sa` ID.
   
     {% cut "How to find the service account ID" %}
     
     {% list tabs group=instructions %}

     - Management console {#console}

       1. In the [management console]({{ link-console-main }}), select `example-folder`.
       1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
       1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
       1. In the list that opens, select `queue-autoscale-sa`.
       1. Copy the service account **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id }}**.

     - CLI {#cli}
     
       Run this command:
       
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
     
       Use the [list](../../iam/api-ref/ServiceAccount/list.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/List](../../iam/api-ref/grpc/ServiceAccount/list.md) gRPC API call.
     
     {% endlist %}
     
     {% endcut %}
     
   * In the `folder_id` field, specify the {{ yandex-cloud }} folder ID.
   
     {% cut "How to find the folder ID" %}
     
     {% list tabs group=instructions %}
     
     - Management console {#console}
     
       On the [cloud page]({{ link-console-cloud }}), find `example-folder` in the **{{ ui-key.yacloud.iam.cloud.folders.section_folders }}** list and copy its **{{ ui-key.yacloud.common.id }}**.
     
     - CLI {#cli}
     
       Run this command:
       
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
     
       Use the [list](../../resource-manager/api-ref/Folder/list.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/List](../../resource-manager/api-ref/grpc/Folder/list.md) gRPC API call.
     
     {% endlist %}
     
     {% endcut %}
     
   * In the `subnet_id` field, specify the `queue-autoscale-subnet-d` ID.
   
     {% cut "How to find the subnet ID" %}
     
     {% list tabs group=instructions %}
     
     - Management console {#console}
     
       1. In the [management console]({{ link-console-main }}), select `example-folder`.
       1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
       1. Navigate to the ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}** tab.
       1. In the list of subnets, find `queue-autoscale-subnet-d` and copy its **{{ ui-key.yacloud.common.id }}**.
            
     - CLI {#cli}
     
       Run this command:
       
       ```bash
       yc vpc subnet get queue-autoscale-subnet-d
       ```
       
       Result:
       
       ```
       id: e1lnabc23r1c********
       folder_id: b0g12ga82bcv********
       created_at: "2021-10-04T16:29:12.450858436Z"
       name: queue-autoscale-subnet-d
       network_id: enpabce123hd********
       zone_id: {{ region-id }}-d
       v4_cidr_blocks:
       - 192.168.1.0/24
       ```
       
     - API {#api}
     
       Use the [list](../../vpc/api-ref/Subnet/list.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/List](../../vpc/api-ref/grpc/Subnet/list.md) gRPC API call.
     
     {% endlist %}
     
     {% endcut %}

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md) allowing the service account to work with {{ compute-name }} and save it to the `key.json` file:

   {% list tabs group=instructions %}
   
   - CLI {#cli}

     ```bash
     yc iam key create \
       --service-account-name queue-autoscale-sa \
       --description "{{ compute-name }}" \
       --output key.json
     ```
    
     Where:

     * `--service-account-name`: Service account name, `queue-autoscale-sa`.
     * `--description`: Key description.
     * `--output`: Path to the key storage file, `key.json`.
  
     Result:
       
     ```
     id: ajevh3a0hrqf********
     service_account_id: aje6brh817ro********
     created_at: "2021-10-04T16:35:19.057777570Z"
     description: {{ compute-name }}
     key_algorithm: RSA_2048
     ```
     
   - API {#api}

     Use the [create](../../iam/api-ref/Key/create.md) REST API method for the [Key](../../iam/api-ref/Key/index.md) resource or the [KeyService/Create](../../iam/api-ref/grpc/Key/create.md) gRPC API call.

   {% endlist %}
     
1. To create an image, run the following command:

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
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
  
     * In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, specify `queue-autoscale-ig`.
     * Select `queue-autoscale-sa` for **{{ ui-key.yacloud.compute.groups.create.field_service-account }}**.
     
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select `{{ region-id }}-d` in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** and do the following in the window that opens:
  
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab and click **{{ ui-key.yacloud.common.select }}**.
     1. In the window that opens, select the previously created image as a boot disk:
     
        1. Navigate to the **{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}** tab.
        1. Select an image with a name that begins with `queue-autoscale-image`.
        1. Click **{{ ui-key.yacloud_monitoring.actions.common.apply }}**.
        
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     
        * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** field, select `queue-autoscale-network`.
        * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}` so that your VMs have the internet access and can receive messages from the queue.
        
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
  
     * **{{ ui-key.yacloud.compute.groups.create.field_metric }}**: `{{ ui-key.yacloud.compute.groups.create.metric-type-custom }}`
     * **{{ ui-key.yacloud.compute.groups.create.field_folder-id }}**: `message-queue`
     * **{{ ui-key.yacloud.compute.groups.create.field_metric-name }}**: `queue.messages.stored_count`
     * **{{ ui-key.yacloud.compute.groups.create.field_metric-labels }}**: `queue` as the key and `queue-autoscale-queue` as the value
     * **{{ ui-key.yacloud.compute.groups.create.field_metric-type }}**: `GAUGE`
     * **{{ ui-key.yacloud.compute.groups.create.field_metric-rule-type }}**: `WORKLOAD`
     * **{{ ui-key.yacloud.compute.groups.create.field_metric-target }}**: `5`
     
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Get the ID of the image you created in the previous steps:
  
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
     
  1. Edit the `spec.yaml` file specifying the instance group:
  
     * In the `folder_id` field, specify the {{ yandex-cloud }} folder ID.
     * In the `image_id` field, specify the image ID.
     * In the `network_id` field, specify the `queue-autoscale-network` ID, and in the `subnet_ids` field, the `queue-autoscale-subnet-d` ID.
     
       {% cut "How to find the network ID" %}
            
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
         1. In the list of networks, find `queue-autoscale-network` and copy its **{{ ui-key.yacloud.common.id }}**.
          
       - API {#api}
        
         Use the [list](../../vpc/api-ref/Network/list.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/List](../../vpc/api-ref/grpc/Network/list.md) gRPC API call.
        
       {% endlist %}
        
       {% endcut %}
     
     * In the `service_account_id` field, specify the `queue-autoscale-sa` ID.
     
     To learn how to get the required IDs (except for the image ID and network ID), see [Create an application image](#create-image).
     
  1. Create the `queue-autoscale-ig` instance group using the following command:
  
     ```bash
     yc compute instance-group create --file spec.yaml
     ```
     
     Where `--file` is the path to the instance group specification file: `spec.yaml`.
     
- API {#api}

  1. To get the ID of the previously created image from the `queue-autoscale-image` family, use the [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/Image/getLatestByFamily.md) gRPC API call or the [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) REST API method.
  1. Edit the `spec.yaml` file specifying the instance group:
    
     * In the `folder_id` field, specify the {{ yandex-cloud }} folder ID.
     * In the `image_id` field, specify the image ID.
     * In the `network_id` field, specify the `queue-autoscale-network` ID, and in the `subnet_ids` field, the `queue-autoscale-subnet-d` ID.
     
       {% cut "How to find the network ID" %}
            
       {% list tabs group=instructions %}
          
       - Management console {#console}
        
         1. In the [management console]({{ link-console-main }}), select `example-folder`.
         1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
         1. In the list of networks, find `queue-autoscale-network` and copy its **{{ ui-key.yacloud.common.id }}**.
               
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
         
       - API {#api}
        
         Use the [list](../../vpc/api-ref/Network/list.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/List](../../vpc/api-ref/grpc/Network/list.md) gRPC API call.

       {% endlist %}
        
       {% endcut %}
       
     * In the `service_account_id` field, specify the `queue-autoscale-sa` ID.
     
     To learn how to get the required IDs (except for the image ID and network ID), see [Create an application image](#create-image).
     
  1. To create the `queue-autoscale-ig` instance group as specified in `spec.yaml`, use the [InstanceGroupService/CreateFromYaml](../../compute/instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API call or the [createFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) REST API method.

{% endlist %}

## Check the instance group scalability {#test-autoscale}

1. Edit the `messages.sh` file: in the `--queue-url` parameter, specify the URL of the queue from the `queue` file.
1. Run `messages.sh`. It will start sending messages to `queue-autoscale-queue` one by one; overall, it will send 100 messages.
1. Open dashboards in {{ monitoring-full-name }}:

   {% list tabs group=instructions %}
   
   - Management console {#console}
   
     1. Open the instance group information dashboard:
     
        1. In [{{ monitoring-name }}]({{ link-monitoring }}), select the **Compute — Instance Groups** dashboard.
        1. In the **Instance Group ID** field, select `queue-autoscale-ig`.
     
     1. Open the queue information dashboard:
     
        1. In [{{ monitoring-name }}]({{ link-monitoring }}), select the **Message Queue** dashboard.
        1. In the **Queue ID** field, select `queue-autoscale-queue`.
        
   {% endlist %}
   
1. Check the dashboard data to make sure the following events took place in this order:

   1. Number of enqueued messages in `queue-autoscale-queue` reached 100 (the **Message Queue** dashboard, the **Sent messages, count** and **Messages in queue, count** charts).
   1. VM instances from the `queue-autoscale-ig` group started receiving messages (the **Received messages, count** chart) and deleting them from the queue (the **Deleted messages, count** and **Messages in queue, count** charts).
   1. While processing the messages, the number of instances in the group increased from one to five and, after all messages were processed, the group became empty (the **Compute — Instance Groups** dashboard, the **Number of instances in zone B** chart).

## Delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the resources you created:

1. [Delete](../../compute/operations/instance-groups/delete.md) the `queue-autoscale-ig` instance group.
1. [Delete](../../compute/operations/image-control/delete.md) the image from the `queue-autoscale-image` family.
1. [Delete](../../message-queue/operations/message-queue-delete-queue.md) `queue-autoscale-queue`.
1. [Delete](../../vpc/operations/subnet-delete.md) `queue-autoscale-subnet-d`.
1. [Delete](../../vpc/operations/network-delete.md) `queue-autoscale-network`.
1. [Delete](../../iam/operations/sa/delete.md) the `queue-autoscale-sa` service account.
