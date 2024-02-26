# Running instance groups with auto scaling

In this tutorial, you will deploy an [instance group with an automatic scaling policy](../../compute/concepts/instance-groups/scale.md#auto-scale) applied if the permitted load is exceeded.

VM instances will be deployed in two availability zones and their load will be balanced by a {{ network-load-balancer-name }} [network load balancer](../../network-load-balancer/concepts/index.md).

To create an instance group:

1. [Prepare your cloud](#before-begin).
1. [Prepare the environment](#prepare).
1. [Create an instance group with auto scaling and network load balancer](#create-vm-group).
1. [Add a network load balancer with a target group](#connect-balancer).
1. [Test your instance group and network load balancer](#check-service).
1. [Test auto scaling](#check-highload).

If you no longer need the resources you created, [delete them](#delete-infrastructure).


You can also deploy an infrastructure for scaling your instance group via {{ TF }} using a [ready-made configuration file](#terraform).


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [before](../../_includes/compute/before-solution.md) %}

## Prepare the environment {#prepare}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) with the name `for-autoscale` and assign it the `editor` role:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select a folder to create a service account in.
      1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. In the window that opens:
         * In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `for-autoscale`.
         * To assign the service account a [role](../../iam/concepts/access-control/roles.md) for the current folder, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `editor` role.
         * Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

      1. Create a service account:

         {% include [default-catalogue](../../_includes/default-catalogue.md) %}

         ```bash
         yc iam service-account create --name for-autoscale
         ```

         Command result:

         ```bash
         id: ajelabcde12f********
         folder_id: b0g12ga82bcv********
         created_at: "2020-11-30T14:32:18.900092Z"
         name: for-autoscale
         ```

      1. Assign the role to the service account:

         ```bash
         yc resource-manager folder add-access-binding b1g23ga82bcv******** \
           --role editor \
           --subject serviceAccount:ajelabcde12f********
         ```

   
   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).


   - API {#api}

      Use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API call.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and [subnets](../../vpc/concepts/network.md#subnet) in two [availability zones](../../overview/concepts/geo-scope.md):

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a network.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter `yc-auto-network` as the network name.
      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
      1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

   - CLI {#cli}

      1. Create a network:

         ```bash
         yc vpc network create --name yc-auto-network
         ```

         Command result:

         ```bash
         id: enpabce123hd********
         folder_id: b0g12ga82bcv********
         created_at: "2020-11-30T14:57:15Z"
         name: yc-auto-network
         ```

      1. Create a subnet in the `{{ region-id }}-a` zone:

         ```bash
         yc vpc subnet create \
           --network-id enpabce123hd******** \
           --range 192.168.1.0/24 \
           --zone {{ region-id }}-a
         ```

         Command result:

         ```bash
         id: e1lnabc23r1c********
         folder_id: b0g12ga82bcv********
         created_at: "2020-11-30T16:23:12Z"
         network_id: enpabce123hd********
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

      1. Create a subnet in the `{{ region-id }}-b` zone:

         ```bash
         yc vpc subnet create \
           --network-id enpabce123hd******** \
           --range 192.168.2.0/24 \
           --zone {{ region-id }}-b
         ```

         Command result:

         ```bash
         id: b1csa2b3clid********
         folder_id: b0g12ga82bcv********
         created_at: "2020-11-30T16:25:02Z"
         network_id: enpabce123hd********
         zone_id: {{ region-id }}-b
         v4_cidr_blocks:
         - 192.168.2.0/24
         ```

   
   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).


   - API {#api}

      1. Create a network:
         Use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create) gRPC API call.
      1. Create subnets in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones:
         Use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create) gRPC API call.

   {% endlist %}

1. Create a security group:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
      1. Open the **Security groups** tab.
      1. Create a security group for the load balancer:

      1. Click **Create group**.
      1. Enter the **Name** of the group: `sg-autoscale`.
      1. Select the **Network**: `yc-auto-network`.
      1. Under **Rules**, create rules using the instructions below the table:

         | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
         | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | healthchecks | 80 | TCP | Load balancer health checks | N/A |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the appropriate protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:

         * **CIDR**: Rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
         * **Security group**: Rule will apply to the VMs from the current group or the selected security group.
         * **Load balancer health checks**: Rule allowing a load balancer to health check VMs.

         1. Click **Save**. Repeat the steps to create all the rules from the table.

      1. Click **Save**.

   
   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).


   {% endlist %}

## Create an instance group with auto scaling and network load balancer {#create-vm-group}

1. All instance groups are created from [{{ coi }}](../../cos/concepts/index.md). Each instance contains a Docker container running a web server that emulates the service utilization.

   {% include [get-latest-coi](../../_includes/container-registry/get-latest-coi.md) %}

1. Save the specification of the instance group with network load balancer to the file `specification.yaml`:

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
         image_id: fd8iv792kira******** # ID of the public Container Optimized Image.
     network_interface_specs:
       - network_id: <cloud_network_ID>
         primary_v4_address_spec: { one_to_one_nat_spec: { ip_version: IPV4 }}
   ```

1. In the `specification.yaml` file, replace the values in angle brackets for the real values you got in the previous steps.
1. Create an instance group named `auto-group` using the specification `specification.yaml`:

   {% list tabs group=instructions %}

   - CLI {#cli}

      Run this command:

      ```bash
      yc compute instance-group create --file=specification.yaml
      ```

      Command result:

      ```bash
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

   
   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).


   - API {#api}

      Use the [CreateFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) method for the `InstanceGroup` resource.

   {% endlist %}

1. Make sure that the instance group was created:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, click ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
      1. Select the `auto-group` instance group.

   - CLI {#cli}

      ```bash
      yc compute instance-group list-instances auto-group
      ```

      Command result:

      ```bash
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      | epdab0c1ji2a******** | cl0habce1nd2********-fned | 84.201.163.202 | 192.168.1.34 | RUNNING_ACTUAL [4m26s] |                |
      | ef0uabc1s2fb******** | cl0habce1nd2********-craq | 130.193.56.102 | 192.168.2.19 | RUNNING_ACTUAL [4m14s] |                |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      ```

   
   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).


   - API {#api}

      To view the list of created instance groups, use the [list](../../compute/api-ref/InstanceGroup/list.md) REST API method for the [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/List](../../compute/api-ref/grpc/instance_group_service.md#List) gRPC API call.

   {% endlist %}

## Add a network load balancer with a target group {#connect-balancer}

1. Create a network load balancer named `group-balancer` and connect it to the instance group you created:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a load balancer.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
      1. Name it `group-balancer`.
      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** field, specify `{{ ui-key.yacloud.common.label_auto }}`.
      1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**. In the window that opens, specify:
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**: `http`.
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** (the load balancer will use this port to accept incoming traffic): `80`.
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** (the load balancer will redirect traffic to this port): `80`.
         * Click **{{ ui-key.yacloud.common.add }}**.
      1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** field, select the `auto-group-tg` instance group and click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. In the window that opens, specify:
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**: `tcp`.
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `80`.
         * Click **{{ ui-key.yacloud.common.apply }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

      ```bash
      yc load-balancer network-load-balancer create \
        --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
        --name group-balancer \
        --target-group healthcheck-name=tcp,healthcheck-tcp-port=80,target-group-id=enpoi5jhfps3********
      ```

      Command result:

      ```bash
      done (16s)
      id: b0rbabc1m2ed********
      folder_id: b0g12ga82bcv********
      ...
          healthy_threshold: "2"
          tcp_options:
            port: "80"
      ```

   
   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).


   - API {#api}

      1. Create a load balancer using the [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Create](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Create) gRPC API call.
      1. Add a listener to the load balancer using the [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) REST API method for the `NetworkLoadBalancer` resource or the [NetworkLoadBalancerService/AddListener](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AddListener) gRPC API call.
      1. Attach the target group to the load balancer using the [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) REST API method for the `NetworkLoadBalancer` resource or the [NetworkLoadBalancerService/AttachTargetGroup](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#AttachTargetGroup) gRPC API call.
      1. Add the load balancer to the instance group using the [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) REST API method for the [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) resource or the [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/target_group_service.md#AddTargets) gRPC API call.

   {% endlist %}

1. Make sure that the network load balancer `group-balancer` is created and attached to the instance group:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the load balancer.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
      1. Select `group-balancer` as your load balancer.

   - CLI {#cli}

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Command result:

      
      ```bash
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      |          ID          |      NAME      |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      | b0rbabc1m2ed******** | group-balancer | {{ region-id }} | EXTERNAL |              1 | b0rdabckribe********   | ACTIVE |
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      ```



   
   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).


   - API {#api}

      Use the [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/List](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#List) gRPC API call.

   {% endlist %}

## Test your instance group and network load balancer {#check-service}

1. Create a load on an instance.

   To do this, save the script named `request.sh` in the home directory. The script will send a request to one of the instances through the `group-balancer` load balancer. The request will utilize 100% CPU for 30 seconds.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   curl "http://$EXTERNAL_IP/burn-cpu?time=30000&load=100"
   ```

1. Run the script:

   {% list tabs group=instructions %}

   - CLI {#cli}

      ```bash
      sh request.sh
      ```

      Command result:

      ```bash
      projects/b0g12ga82bcv********/zones/{{ region-id }}-b
      ```

   {% endlist %}

1. View the instance utilization:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, click ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
      1. Select the `auto-group` instance group.
      1. Go to the **{{ ui-key.yacloud.compute.group.switch_monitoring }}** tab.
         The load balancer sent the request to an instance in the group. In the availability zone this instance belongs to, the average CPU utilization is higher than in other zones (see the **Average CPU utilization in zone** chart).

   {% endlist %}

### Test auto scaling {#check-highload}

To test auto scaling for your instance group, increase the CPU utilization of each instance. In the `specification.yaml` file, the parameter `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` has the value `40`: it means that the target utilization level is 40% CPU. If you exceed the target utilization, {{ ig-name }} increases the number of instances in the group.

1. Increase the utilization of the instance group.

   To do this, save the script named `load.sh` in the home directory. The script sends requests to the instance group through 12 threads for 10 minutes. Each VM instance utilizes 20% CPU on each core that processes the request. The instance group utilization is 240% CPU at any given time. To be sure that requests are evenly distributed across the instances in the group, the script executes multiple parallel requests utilizing 20% CPU rather than one request utilizing 240% CPU.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   wrk -H "Connection: close" -t12 -c12 -d10m "http://$EXTERNAL_IP/burn-cpu?time=5000&load=20"
   ```

1. Run the script:

   {% list tabs group=instructions %}

   - CLI {#cli}

      ```bash
      sh load.sh
      ```

      Command result:

      ```bash
      Running 10m test @ http://130.193.56.111/burn-cpu?time=5000&load=20
        12 threads and 12 connections
        Thread Stats   Avg      Stdev     Max   +/- Stdev
      ...
      Requests/sec: 15.04
      Transfer/sec: 3.20KB
      ```

   {% endlist %}

1. View the utilization levels:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the `auto-group` instance group.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, click ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
      1. Select the `auto-group` instance group.
      1. Go to the **{{ ui-key.yacloud.compute.group.switch_monitoring }}** tab.
         The chart **Number of instances in zone** shows how the number of instances changed in each availability zone. The chart **Average CPU utilization in zone** shows average CPU utilization in each availability zone.
      1. Go to the **{{ ui-key.yacloud.compute.group.switch_logs }}** tab.
         The page displays messages relating to auto scaling of the instance group.

      The total utilization of 240% CPU was evenly distributed between two instances in two availability zones and exceeded the target utilization of 40% CPU. {{ ig-name }} created one instance more in each availability zone to result in four instances in the group. When the script stopped utilizing the CPU, {{ ig-name }} automatically decreased the number of instances in the group to two.

   {% endlist %}

## Delete the infrastructure {#delete-infrastructure}

1. Delete the network load balancer:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the `group-balancer` load balancer.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
      1. In the `group-balancer` line, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

   - CLI {#cli}

      ```bash
      yc load-balancer network-load-balancer delete group-balancer
      ```

      Command result:

      ```bash
      done (15s)
      ```

   - API {#api}

      Use the [delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) REST API method for the [NetworkLoadBalancer](../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Delete](../../network-load-balancer/api-ref/grpc/network_load_balancer_service.md#Delete) gRPC API call.

   {% endlist %}

1. Delete the instance group:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the `auto-group` instance group.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, click ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
      1. In the `auto-group` instance group line, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.groups.button_action-delete }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_delete }}**.

   - CLI {#cli}

      ```bash
      yc compute instance-group delete auto-group
      ```

      Command result:

      ```bash
      done (1m20s)
      ```

   - API {#api}

      Use the [delete](../../compute/api-ref/InstanceGroup/delete.md) REST API method for the [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Delete](../../compute/api-ref/grpc/instance_group_service.md#Delete) gRPC API call.

   {% endlist %}

1. Delete the subnets:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the subnets.
      1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** section.
      1. Select the network with the appropriate subnets.
      1. In the line of the subnet you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.
      1. Repeat the previous three steps to delete the remaining subnets.

   - CLI {#cli}

      1. Delete the subnet in the `{{ region-id }}-a` zone:

         ```bash
         yc vpc subnet delete e1lnabc23r1c********
         ```

         Command result:

         ```bash
         done (1s)
         id: e1lnabc23r1c********
         folder_id: b0g12ga82bcv********
         created_at: "2020-11-30T16:23:12Z"
         network_id: enpabce123hd********
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

      1. Delete the subnet in the `{{ region-id }}-b` zone:

         ```bash
         yc vpc subnet delete b1csa2b3clid********
         ```

         Command result:

         ```bash
         done (1s)
         id: b1csa2b3clid********
         folder_id: b0g12ga82bcv********
         created_at: "2020-11-30T16:25:02Z"
         network_id: enpabce123hd********
         zone_id: {{ region-id }}-b
         v4_cidr_blocks:
         - 192.168.2.0/24
         ```

   - API {#api}

      Use the [delete](../../vpc/api-ref/Subnet/delete.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Delete](../../vpc/api-ref/grpc/subnet_service.md#Delete) gRPC API call.

   {% endlist %}

1. Delete the network:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the network.
      1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** section.
      1. In the line of the network you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

   - CLI {#cli}

      ```bash
      yc vpc network delete yc-auto-network
      ```

      Command result:

      ```bash
      id: enpabce123hd********
      folder_id: b0g12ga82bcv********
      created_at: "2020-11-30T14:57:15Z"
      name: yc-auto-network
      ```

   - API {#api}

      Use the [delete](../../vpc/api-ref/Network/delete.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Delete](../../vpc/api-ref/grpc/network_service.md#Delete) gRPC API call.

   {% endlist %}

1. Delete the service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
      1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. In the line of the service account you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.iam.folder.service-accounts.button_action-delete }}**.
      1. Confirm the deletion.

   - CLI {#cli}

      ```bash
      yc iam service-account delete for-autoscale
      ```

      Command result:

      ```bash
      done (2s)
      ```

   - API {#api}

      Use the [delete](../../iam/api-ref/ServiceAccount/delete.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Delete](../../iam/api-ref/grpc/service_account_service.md#Delete) gRPC API call.

   {% endlist %}


## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To set up scaling for your instance group using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).

1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Clone the repository with configuration files:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-vm-group-with-autoscale.git
         ```

      1. Go to the directory with the repository. Make sure it contains the following files:
         * `vm-autoscale.tf`: Configuration of the infrastructure you create.
         * `declaration.yaml`: Description of the Docker container with a web server that will be run on a VM instance to simulate the service load.
         * `config.tpl`: Description of VM user parameters.
         * `vm-autoscale.auto.tfvars`: User data.

   - Manually {#manual}

      1. Create a directory for configuration files.

      1. In the directory, create:

         1. The `vm-autoscale.tf` configuration file:

            {% cut "vm-autoscale.tf" %}

            {% include [vm-autoscale-tf-config](../../_includes/instance-groups/vm-autoscale-tf-config.md) %}

            {% endcut %}

         1. The `declaration.yaml` file with a description of the Docker container with a web server that will be run on a VM instance to simulate the service load:

            {% cut "declaration.yaml" %}

            ```yaml
            spec:
            containers:
            - image: cr.yandex/yc/demo/web-app:v1
              securityContext:
                privileged: false
              tty: false
              stdin: false
            ```

            {% endcut %}

         1. The `config.tpl` file with VM user parameters:

            {% cut "config.tpl" %}

            ```yaml
            users:
              - name: "${VM_USER}"
                groups: sudo
                shell: /bin/bash
                sudo: 'ALL=(ALL) NOPASSWD:ALL'
                ssh_authorized_keys:
                  - "${SSH_KEY}"
            ```

            {% endcut %}

         1. The `vm-autoscale.auto.tfvars` file with user data:

            {% cut "vm-autoscale.auto.tfvars" %}

            ```hcl
            folder_id = "<folder_ID>"
            vm_user   = "<VM_username>"
            ssh_key   = "<public_SSH_key_contents>"
            ```

            {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_iam_service_account]({{ tf-provider-link }}Resources/iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-link }}Resources/resourcemanager_folder_iam_member)
   * [yandex_vpc_network]({{ tf-provider-link }}Resources/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-link }}Resources/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-link }}Resources/vpc_security_group)
   * [yandex_compute_instance_group]({{ tf-provider-link }}Resources/compute_instance_group)
   * [yandex_lb_network_load_balancer]({{ tf-provider-link }}Resources/lb_network_load_balancer)

1. In the `vm-autoscale.auto.tfvars` file, set the user-defined parameters:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM username.
   * `ssh_key`: Contents of the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Test your instance group and network load balancer](#check-service).

1. [Test auto scaling](#check-highload).

