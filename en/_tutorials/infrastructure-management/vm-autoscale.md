# Running instance groups with auto scaling

To create an [instance group with auto scaling](../../compute/concepts/instance-groups/scale.md#auto-scale) and a [network load balancer](../../network-load-balancer/concepts/index.md), follow these steps.

## Getting started {#before-you-begin}

{% include [before](../../_includes/compute/before-solution.md) %}

## Prepare the environment {#prepare}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) with the name `for-autoscale` and assign it the `editor` role:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
      1. Go to the **Service accounts** tab.
      1. Click **Create service account**.
      1. Enter the name `for-autoscale`.
      1. To assign the service account a [role](../../iam/concepts/access-control/roles.md) for the current folder, click **Add role** and select the role `editor`.
      1. Click **Create**.

   - CLI

      1. Create a service account:

         {% include [default-catalogue](../../_includes/default-catalogue.md) %}

         ```bash
         yc iam service-account create --name for-autoscale
         ```

         Command result:

         ```bash
         id: ajelabcde12f33nol1v5
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T14:32:18.900092Z"
         name: for-autoscale
         ```

      1. Assign the role to the service account:

         ```bash
         yc resource-manager folder add-access-binding b1g23ga82bcv0cdeferg \
           --role editor \
           --subject serviceAccount:ajelabcde12f33nol1v5
         ```

   - API

      Use the [Create](../../iam/api-ref/ServiceAccount/create.md) method for the `ServiceAccount` resource.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and [subnets](../../vpc/concepts/network.md#subnet) in two [availability zones](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a network.
      1. Select **{{ vpc-name }}**.
      1. Click **Create network**.
      1. Enter the network name `yc-auto-network`.
      1. Select the additional option **Create subnets**.
      1. Click **Create network**.

   - CLI

      1. Create a network:

         ```bash
         yc vpc network create --name yc-auto-network
         ```

         Command result:

         ```bash
         id: enpabce123hde4ft1r3t
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T14:57:15Z"
         name: yc-auto-network
         ```

      1. Create a subnet in the `{{ region-id }}-a` zone:

         ```bash
         yc vpc subnet create \
           --network-id enpabce123hde4ft1r3t \
           --range 192.168.1.0/24 \
           --zone {{ region-id }}-a
         ```

         Command result:

         ```bash
         id: e1lnabc23r1c9d0efoje
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T16:23:12Z"
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

      1. Create a subnet in the `{{ region-id }}-b` zone:

         ```bash
         yc vpc subnet create \
           --network-id enpabce123hde4ft1r3t \
           --range 192.168.2.0/24 \
           --zone {{ region-id }}-b
         ```

         Command result:

         ```bash
         id: b1csa2b3clideftjb121
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T16:25:02Z"
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-b
         v4_cidr_blocks:
         - 192.168.2.0/24
         ```

   - API

      1. Create a network using the method [Create](../../vpc/api-ref/Network/create.md) for the `Network` resource.
      1. Create subnets in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones using the [Create](../../vpc/api-ref/Subnet/create.md) method for the `Subnet` resource.

   {% endlist %}

## Create an instance group with auto scaling and network load balancer {#create-vm-group}

1. All instance groups are created from the image [{{ coi }}](../../cos/concepts/index.md). Each instance contains a Docker container running a web server that emulates the service utilization.

   {% include [get-latest-coi](../../_includes/container-registry/get-latest-coi.md) %}

1. Save the specification of the instance group with network load balancer to the file `specification.yaml`:

   ```yaml
   name: auto-group
   service_account_id: <service account ID>
   scale_policy:
     auto_scale:
       min_zone_size: 1
       max_size: 6
       measurement_duration: 60s
       warmup_duration: 120s
       cooldown_duration: 60s
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
     service_account_id: <service account ID>
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
         size: 10G
         image_id: fd8iv792kirahcnqnt0q # ID of the public Container Optimized Image.
     network_interface_specs:
       - network_id: <cloud network ID>
         primary_v4_address_spec: { one_to_one_nat_spec: { ip_version: IPV4 }}
   ```

1. In the `specification.yaml` file, replace the values in angle brackets for the real values you got in the previous steps.
1. Create an instance group named `auto-group` using the specification `specification.yaml`:

   {% list tabs %}

   - CLI

      Run this command:

      ```bash
      yc compute instance-group create --file=specification.yaml
      ```

      Command result:

      ```bash
      done (2m45s)
      id: cl0hmabc1nd2hdefgb7k
      folder_id: b0g12ga82bcv0cdeferg
      ...
          name: auto-group-tg
      service_account_id: ajelabcde12f33nol1v5
      status: ACTIVE
      ```

   - API

      Use the method [CreateFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) for the resource `InstanceGroup`.

   {% endlist %}

1. Make sure that the instance group was created:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
      1. Select **{{ compute-short-name }}**.
      1. Go to **Instance groups**.
      1. Click the `auto-group` instance group name.

   - CLI

      ```bash
      yc compute instance-group list-instances auto-group
      ```

      Command result:

      ```bash
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      | epdab0c1ji2ad4ef8l1s | cl0habce1nd2hqstgd7e-fned | 84.201.163.202 | 192.168.1.34 | RUNNING_ACTUAL [4m26s] |                |
      | ef0uabc1s2fbde6f5tlu | cl0habce1nd2hqstga7b-craq | 130.193.56.102 | 192.168.2.19 | RUNNING_ACTUAL [4m14s] |                |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      ```

   - API

      See the list of the instance groups you created using the method [List](../../compute/api-ref/InstanceGroup/list.md) for the resource `InstanceGroup`.

   {% endlist %}

## Add a network load balancer with a target group {#connect-balancer}

1. Create a network load balancer named `group-balancer` and connect it to the instance group you created:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a load balancer.
      1. Select **{{ network-load-balancer-short-name }}**.
      1. Click **Create load balancer**.
      1. **Name** it `group-balancer`.
      1. In the **Public address** field, select the value **Auto**.
      1. Click **Add listener** under **Listeners**.
         * In the window that opens, enter `http` as the **Listener name**.
         * In the **Port** field, enter `80`: the balancer will use this port to accept the incoming traffic.
         * In the **Target port** field, enter `80`: the balancer will redirect traffic to this port.
         * Click **Add**.
      1. Under **Target groups**, click **Add target group**.
      1. In the **Target group** field, select the instance group `auto-group` and click **Configure**:
         * In the **Health check settings** window that opens, specify `tcp` in the **Name** field.
         * In the **Type** field, select **TCP**.
         * In the **Port** field, enter `80`.
         * Click **Apply**.
      1. Click **Create**.

   - CLI

      ```bash
      yc load-balancer network-load-balancer create \
        --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
        --name group-balancer \
        --target-group healthcheck-name=tcp,healthcheck-tcp-port=80,target-group-id=cl0hmabc1nd2hdefgb7k
      ```

      Command result:

      ```bash
      done (16s)
      id: b0rbabc1m2edfu2ss579
      folder_id: b0g12ga82bcv0cdeferg
      ...
          healthy_threshold: "2"
          tcp_options:
            port: "80"
      ```

   - API

      1. Create a load balancer using the method [create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) for the `NetworkLoadBalancer` resource.
      1. Add a listener to the balancer using the method [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) for the `NetworkLoadBalancer` resource.
      1. Attach the target group to the balancer using the method [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) for the `NetworkLoadBalancer` resource.
      1. Add the balancer to the instance group using the method [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) for the `TargetGroup` resource.

   {% endlist %}

1. Make sure that the network load balancer `group-balancer` is created and attached to the instance group:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the load balancer.
      1. Select **{{ network-load-balancer-short-name }}**.
      1. Click the load balancer name `group-balancer`.

   - CLI

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Command result:

      
      ```bash
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      |          ID          |      NAME      |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      | b0rbabc1m2edfu2ss579 | group-balancer | {{ region-id }} | EXTERNAL |              1 | b0rdabckribed1fbv2l1   | ACTIVE |
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      ```



   - API

      Use the [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) method for the `NetworkLoadBalancer` resource.

   {% endlist %}

## Test your instance group and network load balancer {#check-service}

1. Create a load on an instance.

   To do this, save the script named `request.sh` in the home directory. The script will send a request to one of the instances through the `group-balancer` load balancer. The request will utilize 100% CPU for 30 seconds.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   curl "http://$EXTERNAL_IP/burn-cpu?time=30000&load=100"
   ```

1. Run the script:

   {% list tabs %}

   - CLI

      ```bash
      sh request.sh
      ```

      Command result:

      ```bash
      projects/b0g12ga82bcv0cdeferg/zones/{{ region-id }}-b
      ```

   {% endlist %}

1. View the instance utilization:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
      1. Select **{{ compute-short-name }}**.
      1. Go to **Instance groups**.
      1. Click the `auto-group` instance group name.
      1. Select the **Monitoring** tab.
         The load balancer sent the request to an instance in the group. In the availability zone this instance belongs to, the average CPU utilization is higher than in other zones (see the chart **Average CPU utilization in zone**).

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

   {% list tabs %}

   - CLI

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

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the `auto-group` instance group.
      1. Select **{{ compute-short-name }}**.
      1. Go to **Instance groups**.
      1. Click the `auto-group` instance group name.
      1. Select the **Monitoring** tab.
         The chart **Number of instances in zone** shows how the number of instances changed in each availability zone. The chart **Average CPU utilization in zone** shows average CPU utilization in each availability zone.
      1. Click the **Logs** tab.
         The page displays messages relating to auto scaling of the instance group.

      The total utilization of 240% CPU was evenly distributed between two instances in two availability zones and exceeded the target utilization of 40% CPU. {{ ig-name }} created one instance more in each availability zone to result in four instances in the group. When the script stopped utilizing the CPU, {{ ig-name }} automatically decreased the number of instances in the group to two.

   {% endlist %}

## Delete the infrastructure {#delete-infrastructure}

1. Delete the network load balancer:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the `group-balancer` load balancer.
      1. Select **{{ network-load-balancer-short-name }}**.
      1. Click ![image](../../_assets/vertical-ellipsis.svg) in the `group-balancer` row.
      1. In the resulting menu, click **Delete**.
      1. In the **Delete load balancer** window that opens, click **Delete**.

   - CLI

      ```bash
      yc load-balancer network-load-balancer delete group-balancer
      ```

      Command result:

      ```bash
      done (15s)
      ```

   - API

      Use the [Delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) method for the `NetworkLoadBalancer` resource.

   {% endlist %}

1. Delete the instance group:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the `auto-group` instance group.
      1. Select **{{ compute-short-name }}**.
      1. Go to **Instance groups**.
      1. Click ![image](../../_assets/vertical-ellipsis.svg) for the `auto-group` instance group.
      1. In the resulting menu, click **Delete**.
      1. In the **Delete instance group** window that opens, click **Delete**.

   - CLI

      ```bash
      yc compute instance-group delete auto-group
      ```

      Command result:

      ```bash
      done (1m20s)
      ```

   - API

      Use the method [Delete](../../compute/api-ref/InstanceGroup/delete.md) for the resource `InstanceGroup`.

   {% endlist %}

1. Delete the subnets:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the subnets.
      1. Open the **{{ vpc-name }}** section.
      1. Click the name of the subnets' network.
      1. Click ![image](../../_assets/options.svg) in the line of the subnet to delete.
      1. In the resulting menu, click **Delete**.
      1. In the window that opens, click **Delete**.
      1. Repeat the previous three steps to delete the remaining subnets.

   - CLI

      1. Delete the subnet in the `{{ region-id }}-a` zone:

         ```bash
         yc vpc subnet delete e1lnabc23r1c9d0efoje
         ```

         Command result:

         ```bash
         done (1s)
         id: e1lnabc23r1c9d0efoje
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T16:23:12Z"
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

      1. Delete the subnet in the `{{ region-id }}-b` zone:

         ```bash
         yc vpc subnet delete b1csa2b3clideftjb121
         ```

         Command result:

         ```bash
         done (1s)
         id: b1csa2b3clideftjb121
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T16:25:02Z"
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-b
         v4_cidr_blocks:
         - 192.168.2.0/24
         ```

   - API

      Use the method [Delete](../../vpc/api-ref/Subnet/delete.md) for the resource `Subnet`.

   {% endlist %}

1. Delete the network:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the network.
      1. Open the **{{ vpc-name }}** section.
      1. Click ![image](../../_assets/options.svg) in the line of the network to delete.
      1. In the resulting menu, click **Delete**.
      1. In the window that opens, click **Delete**.

   - CLI

      ```bash
      yc vpc network delete yc-auto-network
      ```

      Command result:

      ```bash
      id: enpabce123hde4ft1r3t
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2020-11-30T14:57:15Z"
      name: yc-auto-network
      ```

   - API

      Use the method [Delete](../../vpc/api-ref/Network/delete.md) for the resource `Network`.

   {% endlist %}

1. Delete the service account:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
      1. Go to the **Service accounts** tab.
      1. Click ![image](../../_assets/options.svg) next to the service account and select **Delete service account**.
      1. Confirm the deletion.

   - CLI

      ```bash
      yc iam service-account delete for-autoscale
      ```

      Command result:

      ```bash
      done (2s)
      ```

   - API

      Use the method [Delete](../../iam/api-ref/ServiceAccount/delete.md) for the resource `ServiceAccount`.

   {% endlist %}