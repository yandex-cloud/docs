# Updating an instance group under load


Using this step-by-step guide, you will configure an [instance group](../../compute/concepts/instance-groups/index.md) and check its operation when updating the configuration. To do this:
1. [Prepare your cloud](#before-you-begin).
1. [Prepare the environment](#create-environment).
1. [Create an instance group from a {{ coi }}](#create-vm-group).
1. [Create a load on an instance](#start-load-testing).
1. [Update the instance group under load](#update-spec).
1. [Stop the load and get the results](#end-load-testing).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before](../../_includes/compute/before-solution.md) %}


### Required paid resources {#paid-resources}

The cost of support for the {{ yandex-cloud }} instance group includes a fee for:
* [Disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md): [{{ compute-full-name }} pricing](../../compute/pricing.md).
* Using a dynamic or static [public IP address](../../vpc/concepts/address.md): [{{ vpc-full-name }} pricing](../../vpc/pricing.md).


## Prepare the environment {#create-environment}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) named `for-load` and assign it the `editor` role:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your service account.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `for-load`.
     1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `editor` [role](../../iam/concepts/access-control/roles.md).
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Create a service account:

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        ```bash
        yc iam service-account create --name for-load
        ```

        The result will be as follows:

        ```bash
        id: ajeab0cnib1p********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:31:32.561702Z"
        name: for-load
        ```

     1. Assign the role to the service account:

        ```bash
        yc resource-manager folder add-access-binding b0g12ga82bcv******** \
          --role editor \
          --subject serviceAccount:ajeab0cnib1p********
        ```

   - API {#api}

     1. Create a service account named `for-load`:
         Use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.
     1. Assign the service account the `editor` role for the current folder:
         Use the [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and [subnets](../../vpc/concepts/network.md#subnet) in two [availability zones](../../overview/concepts/geo-scope.md):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to create a network.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `yc-auto-network`.
     1. Select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

   - CLI {#cli}

     1. Create a network:

        ```bash
        yc vpc network create --name yc-auto-network
        ```

        The result will be as follows:

        ```bash
        id: enpabce123hd********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:33:32.561702Z"
        name: yc-auto-network
        ```

     1. Create a subnet in the `{{ region-id }}-d` availability zone:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.1.0/24 --zone {{ region-id }}-d
        ```

        The result will be as follows:

        ```bash
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:34:32.561702Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-d
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Create a subnet in the `{{ region-id }}-b` availability zone:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.2.0/24 --zone {{ region-id }}-b
        ```

        The result will be as follows:

        ```bash
        id: b1csa2b3clid********
        folder_id: b0g12ga82bcv********
        created_at: "2021-02-09T17:35:32.561702Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API {#api}

     1. Create a network:
         Use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.
     1. Create subnets in the `{{ region-id }}-d` and `{{ region-id }}-b` availability zones:
         Use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

   {% endlist %}

## Create an instance group from a {{ coi }} {#create-vm-group}

1. All instance groups are created from [{{ coi }}](../../cos/concepts/index.md). Each instance contains a Docker container running a web server that emulates the service utilization.

   {% list tabs group=instructions %}


   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select a folder to host your instance group.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, select ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
     1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
        * In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, specify `group-for-load`.
        * Select **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** `for-load`.
     1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select `{{ region-id }}-d` and `{{ region-id }}-b` in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field.
     1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** and do the following in the window that opens:
        * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab.
        * Click **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
        * In the **{{ ui-key.yacloud.compute.instances.create.section_coi }}** window:
          * In the **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}** field, specify `nginx`.
          * In the **{{ ui-key.yacloud.compute.instances.create.field_coi-image }}** field, click **{{ ui-key.yacloud.component.image-field.button_custom-image }}** and enter `{{ registry }}/yc/demo/autoscaling-example-app:v1`.
          * Click **{{ ui-key.yacloud.common.apply }}**.
        * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:
          * For the boot disk, specify the **{{ ui-key.yacloud.compute.disk-form.field_size }}** of `30 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
        * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
          * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** field, select `for-load`.
        * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
          * In the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field, select `for-load`.
          * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the name of the user to be created on the VM.
          * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.
        * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
     1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
        * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}** field, enter `4`.
     1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
        * In the **{{ ui-key.yacloud.compute.groups.create.field_scale-type }}** field, select `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}`.
        * Set **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** to `6`.
     1. Under **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**:
        * Enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
        * In the **{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** field, specify `load-generator`.
     1. Click **{{ ui-key.yacloud.common.create }}**.
 

   - CLI {#cli}

     1. Find out the ID of the latest version of the [public](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

        A {{ coi }} in a [{{ container-registry-full-name }}](../../container-registry/) registry may be updated and changed with new releases. This will not automatically update the VM image to the latest version. To create an instance group with the latest {{ coi }} version, you should check its availability yourself:

        ```bash
        yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
        ```

        The result will be as follows:
  
        ```bash
        id: fd8iv792kira********
        folder_id: standard-images
        created_at: "2021-01-29T13:30:22Z"
        ...
        status: READY
        os:
          type: LINUX
        ```

     1. Save the specification of the instance group with network load balancer to the `specification.yaml` file:

        {% include [updating-under-load-yaml-spec-init](../../_includes/instance-groups/updating-under-load-yaml-spec-init.md) %}

        {% note info %}

        You can provide an SSH key in the [VM metadata](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images) using the `ssh-keys` parameter or in the `user-data` string with the user metadata. This tutorial uses the first option.

        {% endnote %}

     1. Create an instance group named `group-for-load` using the `specification.yaml` specification:

         ```bash
         yc compute instance-group create --file=specification.yaml
         ```

         The result will be as follows:

         ```bash
         done (2m18s)
         id: cl0kabcquk1g********
         folder_id: b0g12ga82bcv********
         ...
         service_account_id: ajeab0cnib1p********
         status: ACTIVE
         application_load_balancer_state: {}
         ```

   - API {#api}

     1. Get the ID of the latest `container-optimized-image` version in the `standard-images` family:
         Use the [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) REST API method for the [Image](../../compute/api-ref/Image/index.md) resource or the [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/Image/getLatestByFamily.md) gRPC API call.
     1. Create an instance group based on the following specification:

         {% include [updating-under-load-yaml-spec-init](../../_includes/instance-groups/updating-under-load-yaml-spec-init.md) %}

         Use the [createFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/CreateFromYaml](../../compute/instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API call.

   {% endlist %}
   
1. Make sure that the instance group was created:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, select ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
     1. Click the `group-for-load` instance group name.

   - CLI {#cli}

     ```bash
     yc compute instance-group list-instances group-for-load
     ```

     The result will be as follows:

     ```bash
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     |     INSTANCE ID      |           NAME            |   EXTERNAL IP   | INTERNAL IP |        STATUS        | STATUS MESSAGE |
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     ...
     | fhmab0cfsfd1******** | cl0kabcquk1g********-oxig | 178.154.226.108 | 10.130.0.8  | RUNNING_ACTUAL [49m] |                |
     | epdabchpdef0******** | cl0kabcquk1g********-aqyg | 130.193.40.55   | 10.129.0.20 | RUNNING_ACTUAL [43m] |                |
     +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
     ```

   - API {#api}

     To view the list of created instance groups, use the [list](../../compute/instancegroup/api-ref/InstanceGroup/list.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/List](../../compute/instancegroup/api-ref/grpc/InstanceGroup/list.md) gRPC API call.

   {% endlist %}

### Add a network load balancer to the created instance group {#enable-balancer}

1. Create a network load balancer named `load-generator` and connect it to the instance group you created:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder you want to create a load balancer in.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
     1. In the **{{ ui-key.yacloud.common.name }}** field, specify `load-generator`.
     1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** field, select `{{ ui-key.yacloud.common.label_auto }}`.
     1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
     1. In the window that opens:
        * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}** field, specify `http`.
        * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** field, enter `80` for the port the balancer will receive incoming traffic at.
        * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** field, enter `80`: the balancer will redirect traffic to this port.
        * Click **{{ ui-key.yacloud.common.add }}**.
     1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
     1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** list, select `load-generator`.
     1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**:
        * In the window that opens, enter the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** `/hello`: the load balancer will use this path to send health check requests to target group VMs.
        * Click **{{ ui-key.yacloud.common.apply }}**.
     1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

     1. Get the ID of the `load-generator` target group:
     
        ```bash
        yc load-balancer target-group get load-generator | grep "^id"
        ```
        
        The result will be as follows:
        
        ```bash
        id: enpsa475ej51********
        ```
        
     1. Create a network load balancer:
     
        ```bash
        yc load-balancer network-load-balancer create \
          --name load-generator \
          --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
          --target-group healthcheck-http-port=80,healthcheck-http-path=/hello,target-group-id=<target_group_ID>
        ```

        The result will be as follows:

        ```bash
        done (14s)
        id: b0ruab1ccvpd********
        folder_id: b1csa2b3clid********
        ...
            healthy_threshold: "2"
            http_options:
              port: "80"
              path: /hello
        ```

   - API {#api}

     1. Create a load balancer using the [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/create.md) gRPC API call.
     1. Add a listener to the load balancer using the [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) REST API method for the `NetworkLoadBalancer` resource or the [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/addListener.md) gRPC API call.
     1. Connect the target group to the load balancer using the [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) REST API method for the `NetworkLoadBalancer` resource or the [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/attachTargetGroup.md) gRPC API call.
     1. Add the load balancer to the instance group using the [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) REST API method for the [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/addTargets.md) gRPC API call.

   {% endlist %}

1. Check that the network load balancer named `load-generator` has been created and linked to the instance group:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the load balancer.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Click the name of the `load-generator` network load balancer.

   - CLI {#cli}

     ```bash
     yc load-balancer network-load-balancer list
     ```

     The result will be as follows:
     

     ```bash
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     | b0ruab1ccvpd******** | load-generator | {{ region-id }}     | EXTERNAL |              1 | b0r1tabcphde********   | ACTIVE |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     ```
     
     

   - API {#api}

     Use the [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/list.md) gRPC API call.

   {% endlist %}

## Create a load on an instance {#start-load-testing}

1. Get the IP address of the load balancer that you created:

   {% list tabs group=instructions %}
   
   - Management console {#console}
   
     1. In the [management console]({{ link-console-main }}), select the folder containing the load balancer.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Copy the **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}** of the `load-generator` load balancer.
     
   - CLI {#cli}
   
     ```bash
     yc load-balancer network-load-balancer get load-generator | grep "address"
     ```
     
     The result will be as follows:

     ```bash
       address: 84.252.133.110
     ```
     
   - API {#api}
   
     Use the [get](../../network-load-balancer/api-ref/NetworkLoadBalancer/get.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Get](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/get.md) gRPC API call.
     
   {% endlist %}
     
1. Run the command to create a load:

   ```bash
   wrk -t20 -c20 -d20m --timeout 20s http://<load_balancer_IP_address>/sleep
   ```

   The command will launch the `wrk` utility that will send requests to 20 threads using 20 connections to the network load balancer for 20 minutes. The request timeout is 20 seconds. The load balancer will distribute the resulting load among the VMs from the group.

   After you launch `wrk`, a testing start message will appear on the screen:

   ```bash
   Running 20m test @ http://84.252.133.110/sleep
     20 threads and 20 connections
   ```
   
   Proceed to the next step without waiting for the command to complete.

## Update the instance group under load {#update-spec}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Click the `group-for-load` instance group name.
  1. Click ![edit](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter the new disk size of `35 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Under **{{ ui-key.yacloud.compute.group.overview.section_instances-state }}**, you will see disk size changes for all VM instances in the group, step-by-step.

- CLI {#cli}

   1. In the `specification.yaml` specification, enter the new disk size of 35 GB and save the file:
   
      ```yaml
      ...
      size: 35G
      ...
      ```
   
   1. Update the instance group:

      ```bash
      yc compute instance-group update --name=group-for-load --file=specification.yaml
      ```

      The result will be as follows:

      ```bash
      done (9m24s)
      id: cl10kktrjcn8********
      folder_id: b1g7gvsi89m3********
      ...
         name: load-generator
      service_account_id: ajehbk07uus3********
      status: ACTIVE
      ```
      
- API {#api}

  1. In the specification, enter the new disk size of 35 GB:
     
     ```yaml
     ...
     size: 35G
     ...
     ```
  
  1. To update the `load-generator` instance group based on the new specification, use the [updateFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/updateFromYaml.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/UpdateFromYaml](../../compute/instancegroup/api-ref/grpc/InstanceGroup/updateFromYaml.md) gRPC API call.

{% endlist %}

## Stop the load and get the results {#end-load-testing}

Stop `wrk` by pressing **Ctrl** + **C**.

The result will be as follows:

```bash
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    10.00s     1.70ms  10.01s    68.21%
    Req/Sec     0.00      0.00     0.00    100.00%
  1148 requests in 17.47m, 211.89KB read
Requests/sec:      1.09
Transfer/sec:     206.94B
```

If there is no error line, e.g., `Socket errors`, in the result, it means all requests were processed.

## How to delete the resources you created {#clear-out}

To delete the created resources:

{% list tabs group=instructions %}

- Management console {#console}

   1. Delete the load balancer:
      1. In the [management console]({{ link-console-main }}), select the folder you created the load balancer in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
      1. To the right of the `load-generator` line, click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.remove }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.common.remove }}**.
   1. Delete the instance group:
      1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
      1. To the right of the `load-generator` line, click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_delete }}**.
   1. Delete the service account:
      1. In the [management console]({{ link-console-main }}), select the folder where you created the service account.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
      1. In the list that opens, click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.iam.folder.service-accounts.button_action-delete }}** in the row with the `yc-auto-sa` service account.
      1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-accounts.popup-confirm_button_delete }}**.
   1. Delete the network and subnets:
      1. In the [management console]({{ link-console-main }}), select the folder where you created the network and subnets.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. Select the `yc-auto-network` network.
      1. Under **{{ ui-key.yacloud.vpc.network.overview.section_subnetworks }}**:
         1. To the right of the `yc-auto-subnet-1` line, click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
         1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.
         1. Delete the `yc-auto-subnet-2` subnet as well.
      1. In the top-right corner, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   Run the following commands one by one:

   ```bash
   yc load-balancer network-load-balancer delete load-generator
   yc compute instance-group delete load-generator
   yc iam service-account delete yc-auto-sa
   yc vpc subnet delete yc-auto-subnet-1
   yc vpc subnet delete yc-auto-subnet-2
   yc vpc network delete yc-auto-network
   ```
  
- API {#api}

  1. Delete the `load-generator` load balancer using the [delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Delete](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/delete.md) gRPC API call.
  1. Delete the `load-generator` instance group using the [delete](../../compute/instancegroup/api-ref/InstanceGroup/delete.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Delete](../../compute/instancegroup/api-ref/grpc/InstanceGroup/delete.md) gRPC API call.
  1. Delete the `yc-auto-sa` service account using the [delete](../../iam/api-ref/ServiceAccount/delete.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Delete](../../iam/api-ref/grpc/ServiceAccount/delete.md) gRPC API call.
  1. Delete the `yc-auto-subnet-1` and `yc-auto-subnet-2` subnets using the [delete](../../vpc/api-ref/Subnet/delete.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Delete](../../vpc/api-ref/grpc/Subnet/delete.md) gRPC API call.
  1. Delete the `yc-auto-network` network using the [delete](../../vpc/api-ref/Network/delete.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Delete](../../vpc/api-ref/grpc/Network/delete.md) gRPC API call.

{% endlist %}