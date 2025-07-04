1. [Get your cloud ready](#before-begin).
1. [Set up your environment](#prepare).
1. [Create an autoscaling instance group with a network load balancer](#create-vm-group).
1. [Add a network load balancer with a target group](#connect-balancer).
1. [Test your instance group and network load balancer](#check-service).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [before](../../_includes/compute/before-solution.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-autoscale/paid-resources.md) %}

## Set up your environment {#prepare}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) named `for-autoscale`: To create, update, and delete VM instances in your group, as well as integrate the group with {{ network-load-balancer-name }}, assign the [compute.editor](../../compute/security/index.md#compute-editor) and [load-balancer.editor](../../network-load-balancer/security/index.md#load-balancer-editor) roles to the service account:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your service account.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**. In the window that opens:
        * In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `for-autoscale`.
        * To assign the service account a role for the current folder, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `compute.editor` and `load-balancer.editor`.
        * Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Create a service account:

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        ```bash
        yc iam service-account create --name for-autoscale
        ```

        Result:

        ```text
        id: ajelabcde12f********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T14:32:18.900092Z"
        name: for-autoscale
        ```

     1. Assign the `compute.editor` role to the service account:

        ```bash
        yc resource-manager folder add-access-binding <catalog_ID> \
          --role compute.editor \
          --subject serviceAccount:<service_account_ID>
        ```

     1. Assign the `load-balancer.editor` role to the service account:

        ```bash
        yc resource-manager folder add-access-binding <catalog_ID> \
          --role load-balancer.editor \
          --subject serviceAccount:<service_account_ID>
        ```

   - API {#api}

     Use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and [subnets](../../vpc/concepts/network.md#subnet) in two availability zones:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to create your network.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter `yc-auto-network`.
     1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, enable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

   - CLI {#cli}

     1. Create a network:

        ```bash
        yc vpc network create --name yc-auto-network
        ```

        Result:

        ```text
        id: enpabce123hd********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T14:57:15Z"
        name: yc-auto-network
        ```

     1. Create a subnet in the `{{ region-id }}-a` availability zone:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hd******** \
          --range 192.168.1.0/24 \
          --zone {{ region-id }}-a
        ```

        Result:

        ```text
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T16:23:12Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Create a subnet in the `{{ region-id }}-b` availability zone:

        ```bash
        yc vpc subnet create \
          --network-id enpabce123hd******** \
          --range 192.168.2.0/24 \
          --zone {{ region-id }}-b
        ```

        Result:

        ```text
        id: b1csa2b3clid********
        folder_id: b0g12ga82bcv********
        created_at: "2020-11-30T16:25:02Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-b
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API {#api}

     1. Create a network.

        Use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.
     1. Create subnets in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones.

        Use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

   {% endlist %}

1. Create a [security group](../../vpc/concepts/security-groups.md):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
     1. Open the **Security groups** tab.
     1. Create a security group for the load balancer:
        1. Click **Create group**.
        1. Enter the group **Name**: `sg-autoscale`.
        1. Select `yc-auto-network` for **Network**.
        1. Under **Rules**, create rules by following the steps below the table:

           Traffic<br>direction | Description | Port<br>range | Protocol | Source /<br>destination type | Source /<br>destination
           --- | --- | --- | --- | --- | ---
           Egress | any | All | Any | CIDR | 0.0.0.0/0
           Ingress | ext-http | 80 | TCP | CIDR | 0.0.0.0/0
           Inbound | healthchecks | 80 | TCP | Load balancer health checks | —

           1. Select the **Egress** or **Ingress** tab.
           1. Click **Add rule**.
           1. In the **Port range** field of the window that opens, specify a port or range of ports open for inbound or outbound traffic.
           1. In the **Protocol** field, specify the protocol or leave **Any** to allow traffic over any protocol.
           1. In the **Purpose** or **Source** field, select the rule purpose:
              * **CIDR**: Rule will apply to the range of [IP addresses](../../vpc/concepts/address.md). In the **CIDR blocks** field, specify the CIDR ranges of the source or destination subnets. To add more CIDRs, click **Add CIDR**.
              * **Security group**: Rule will apply to the VMs from the current group or the selected security group.
              * **Load balancer health checks**: Rule allowing a load balancer to health-check VMs.
           1. Click **Save**. Repeat these steps to create all rules from the table.
        1. Click **Save**.

   {% endlist %}

## Create an autoscaling instance group with a network load balancer {#create-vm-group}

1. In this tutorial, you will be creating all instance groups from a [{{ coi }}](../../cos/concepts/index.md). Each VM instance will have a Docker container running a web server that emulates the service load.

   {% include [get-latest-coi](../../_includes/container-registry/get-latest-coi.md) %}

1. Save the specification of the instance group with a network load balancer to the `specification.yaml` file:

   ```yaml
   name: auto-group
   service_account_id: <service_account_ID>
   scale_policy:
     auto_scale:
       min_zone_size: 1
       max_size: 6
       measurement_duration: 60s
       warmup_duration: 120s
       stabilization_duration: 60s
       initial_size: 2
       cpu_utilization_rule:
         utilization_target: 40
   deploy_policy:
     max_unavailable: 1
   allocation_policy:
     zones:
       - zone_id: {{ region-id }}-a
       - zone_id: {{ region-id }}-b
   load_balancer_spec:
     target_group_spec:
       name: auto-group-tg
   instance_template:
     service_account_id: <service_account_ID>
     platform_id: standard-v3
     resources_spec:
       memory: 2G
       cores: 2
       core_fraction: 100
     metadata:
       docker-container-declaration: |-
         spec:
           containers:
           - image: {{ registry }}/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
     boot_disk_spec:
       mode: READ_WRITE
       disk_spec:
         type_id: network-hdd
         size: 30G
         image_id: fd8iv792kira******** # ID of the public {{ coi }}
     network_interface_specs:
       - network_id: <cloud_network_ID>
         primary_v4_address_spec: { one_to_one_nat_spec: { ip_version: IPV4 }}
   ```

1. In `specification.yaml`, replace the values in angle brackets with actual values from the previous steps.
1. Create an instance group named `auto-group` using `specification.yaml`:

   {% list tabs group=instructions %}

   - CLI {#cli}

     Run this command:

     ```bash
     yc compute instance-group create --file=specification.yaml
     ```

     Result:

     ```text
     done (2m45s)
     id: cl0hmabc1nd2********
     folder_id: b0g12ga82bcv********
     ...
       target_group_id: enpoi5jhfps3********
     ...
         name: auto-group-tg
     service_account_id: ajelabcde12f********
     status: ACTIVE
     ```

   - API {#api}

     Use the [CreateFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) method for the `InstanceGroup` resource.

   {% endlist %}

1. Check your instance group:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, click ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
     1. Select `auto-group`.

   - CLI {#cli}

     ```bash
     yc compute instance-group list-instances auto-group
     ```

     Result:

     ```text
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     | epdab0c1ji2a******** | cl0habce1nd2********-fned | 84.201.163.202 | 192.168.1.34 | RUNNING_ACTUAL [4m26s] |                |
     | ef0uabc1s2fb******** | cl0habce1nd2********-craq | 130.193.56.102 | 192.168.2.19 | RUNNING_ACTUAL [4m14s] |                |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     ```

   - API {#api}

     To view a list of the instance groups you created, use the [list](../../compute/instancegroup/api-ref/InstanceGroup/list.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/List](../../compute/instancegroup/api-ref/grpc/InstanceGroup/list.md) gRPC API call.

   {% endlist %}

## Add a network load balancer with a target group {#connect-balancer}

1. Create a network load balancer named `group-balancer` and add it to the instance group you created:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to create a load balancer.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
     1. Enter `group-balancer` as the name.
     1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** field, specify `{{ ui-key.yacloud.common.label_auto }}`.
     1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**. In the window that opens, specify:
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**: `http`.
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**: `80`. The load balancer will listen for inbound traffic on this port.
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**: `80`. The load balancer will redirect traffic to this port.
        * Click **{{ ui-key.yacloud.common.add }}**.
     1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
     1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** field, select `auto-group-tg` and click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. In the window that opens, specify:
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**: `tcp`
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
        * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `80`
        * Click **{{ ui-key.yacloud.common.apply }}**.
     1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

     ```bash
     yc load-balancer network-load-balancer create \
       --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
       --name group-balancer \
       --target-group healthcheck-name=tcp,healthcheck-tcp-port=80,target-group-id=enpoi5jhfps3********
     ```

     Result:

     ```text
     done (16s)
     id: b0rbabc1m2ed********
     folder_id: b0g12ga82bcv********
     ...
         healthy_threshold: "2"
         tcp_options:
           port: "80"
     ```

   - API {#api}

     1. Create a load balancer using the [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/create.md) gRPC API call.
     1. Add a listener to the load balancer using the [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) REST API method for the `NetworkLoadBalancer` resource or the [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/addListener.md) gRPC API call.
     1. Attach the target group to the load balancer using the [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) REST API method for the `NetworkLoadBalancer` resource or the [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/attachTargetGroup.md) gRPC API call.
     1. Add the load balancer to the instance group using the [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) REST API method for the [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/addTargets.md) gRPC API call.

   {% endlist %}

1. Check the `group-balancer` network load balancer and make sure it is linked to the instance group:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the load balancer.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. Select `group-balancer`.

   - CLI {#cli}

     ```bash
     yc load-balancer network-load-balancer list
     ```

     Result:

     ```text
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     | b0rbabc1m2ed******** | group-balancer | {{ region-id }} | EXTERNAL |              1 | b0rdabckribe********   | ACTIVE |
     +----------------------+----------------+-----------------+----------+----------------+------------------------+--------+
     ```

   - API {#api}

     Use the [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/list.md) gRPC API call.

   {% endlist %}

## Test your instance group and network load balancer {#check-service}

{% include [check-service](../_tutorials_includes/vm-autoscale/check-service.md) %}

### Autoscaling test {#check-highload}

{% include [check-highload](../_tutorials_includes/vm-autoscale/check-highload.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../network-load-balancer/operations/load-balancer-delete.md) the network load balancer.
1. [Delete](../../compute/operations/instance-groups/delete.md) the instance group.
