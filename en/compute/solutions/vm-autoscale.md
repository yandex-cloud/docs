# Running instance groups with auto scaling

To create an [instance group with auto scaling](../concepts/instance-groups/scale.md#auto-scale) and [network load balancer](../../load-balancer/concepts/index.md), do the following.

## Before you start {#before-you-begin}

1. If you don't have the {{ yandex-cloud }} command line interface yet, [install it](../../cli/quickstart.md#install).

1. For the scripts from the tutorial to run correctly, download and install the [jq](https://stedolan.github.io/jq/download/) utility.

1. To check auto scaling, install the [wrk](https://github.com/wg/wrk) benchmarking tool.

## Prepare the {#prepare} environment

1. Create a [service account](../../iam/concepts/users/service-accounts.md) with the name `for-autoscale` and assign it the `editor` role:

   {% list tabs %}

   - Management console
     1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
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

        Command execution result:

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

     Use the method [Create](../../iam/api-ref/ServiceAccount/create.md) for the `ServiceAccount` resource.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and [subnets](../../vpc/concepts/network.md#subnet) in two [availability zones](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Management console
     1. In the [management console]({{ link-console-main }}), select the folder where you want to create a network.
     1. Select **Virtual Private Cloud**.
     1. Click **Create network**.
     1. Enter the network name `yc-auto-network`.
     1. Select the additional option **Create subnets**.
     1. Click **Create network**.

   - CLI

     1. Create a network:

        ```bash
        yc vpc network create --name yc-auto-network
        ```

        Command execution result:

        ```bash
        id: enpabce123hde4ft1r3t
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T14:57:15Z"
        name: yc-auto-network
        ```

     1. Create a subnet in the `ru-central1-b` zone:

        ```bash
        yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.1.0/24 --zone ru-central1-b
        ```

        Command execution result:

        ```bash
        id: e1lnabc23r1c9d0efoje
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:23:12Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: ru-central1-b
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

     1. Create a subnet in the `ru-central1-c` zone:

        ```bash
        yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.2.0/24 --zone ru-central1-c
        ```

        Command execution result:

        ```bash
        id: b1csa2b3clideftjb121
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T16:25:02Z"
        network_id: enpabce123hde4ft1r3t
        zone_id: ru-central1-c
        v4_cidr_blocks:
        - 192.168.2.0/24
        ```

   - API

     1. Create a network using the method [Create](../../vpc/api-ref/Network/create.md) for the resource `Networks`.

     1. Create subnets in the `ru-central1-b` and `ru-central1-c` availability zones using the method [Create](../../vpc/api-ref/Subnet/create.md) for the resource `Subnets`.

   {% endlist %}

## Create an instance group with auto scaling and network load balancer {#create-vm-group}

1. Save the specification of the instance group with network load balancer to the file `specification.yaml`:

   ```yaml
   name: auto-group
   service_account_id: ajelabcde12f33nol1v5
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
       - zone_id: ru-central1-b
       - zone_id: ru-central1-c
   load_balancer_spec:
     target_group_spec:
       name: auto-group-tg
   instance_template:
     service_account_id: ajelabcde12f33nol1v5
     platform_id: standard-v1
     resources_spec:
       memory: 2G
       cores: 2
       core_fraction: 100
     metadata:
       docker-container-declaration: |-
         spec:
           containers:
           - image: cr.yandex/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
     boot_disk_spec:
       mode: READ_WRITE
       disk_spec:
         type_id: network-hdd
         size: 10G
         image_id: fd81a49qficqvt0dthu8
     network_interface_specs:
       - network_id: enpabce123hde4ft1r3t
         primary_v4_address_spec: { one_to_one_nat_spec: { ip_version: IPV4 }}
   ```

1. Create an instance group named `auto-group` using the specification `specification.yaml`:

   {% list tabs %}

   - CLI

     Run the command:

     ```bash
     yc compute instance-group create --file=specification.yaml
     ```

     Command execution result:

     ```bash
     done (2m45s)
     id: cl0hmabc1nd2hdefgb7k
     folder_id: b0g12ga82bcv0cdeferg
     ...
         name: auto-group-tg
     service_account_id: ajelabcde12f33nol1v5
     status: ACTIVE
     ```

     All the instance groups are created from the image [{{ coi }}](../../cos/concepts/index.md).Each instance contains a Docker container running a web server that emulates the service utilization.

   - API

     Use the method [CreateFromYaml](../api-ref/InstanceGroup/createFromYaml.md) for the resource `InstanceGroup`.

   {% endlist %}

1. Make sure that the instance group was created:

   {% list tabs %}

   - Management console
     1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
     1. Select **Compute Cloud**.
     1. Go to **Instance groups**.
     1. Click the `auto-group` instance group name.

   - CLI

     ```bash
     yc compute instance-group list-instances auto-group
     ```

     Command execution result:

     ```bash
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     | epdab0c1ji2ad4ef8l1s | cl0habce1nd2hqstgd7e-fned | 84.201.163.202 | 192.168.1.34 | RUNNING_ACTUAL [4m26s] |                |
     | ef0uabc1s2fbde6f5tlu | cl0habce1nd2hqstga7b-craq | 130.193.56.102 | 192.168.2.19 | RUNNING_ACTUAL [4m14s] |                |
     +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
     ```

   - API

     See the list of the instance groups you created using the method [List](../api-ref/InstanceGroup/list.md) for the resource `InstanceGroup`.

   {% endlist %}

## Add a network load balancer with a target group {#connect-balancer}

1. Create a network load balancer named `group-balancer` and connect it to the instance group you created:

   {% list tabs %}

   - Management console
     1. In the [management console]({{ link-console-main }}), select the folder where you want to create a load balancer.
     1. Select **Load Balancer**.
     1. Click **Create load balancer**.
     1. Enter **Name** `group-balancer`.
     1. In the **Public address** field, select the value **Auto**.
     1. Click **Add listener** under **Listeners**.
        * In the window that opens, enter **Listener name** `http`.
        * In the **Port** field, enter `80`: the balancer will use this port to accept the incoming traffic.
        * In the **Target port** field, enter `80`: the balancer will redirect traffic to this port.
        * Click **Add**.
     1. Under **Target groups**, click **Add target group**.
     1. In the **Target group** field, select the instance group `auto-group` and click **Configure**:
        * In the window that opens (**Health check settings**), enter the **Name** `tcp`.
        * Select the **Type** **TCP**.
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

     Command execution result:

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

     1. Create a load balancer using the method [Create](../../load-balancer/api-ref/NetworkLoadBalancer/create.md) for the resource `NetworkLoadBalancers`.

     1. Add a listener to the balancer using the method [AddListener](../../load-balancer/api-ref/NetworkLoadBalancer/addListener.md) for the resource `NetworkLoadBalancers`.

     1. Attach the target group to the balancer using the method [AttachTargetGroup](../../load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) for the resource `NetworkLoadBalancers`.

     1. Add the balancer to the instance group using the method [AddTargets](../../load-balancer/api-ref/TargetGroup/addTargets.md) for the resource `TargetGroups`.

   {% endlist %}

1. Make sure that the network balancer `group-balancer` is created and linked to the instance group:

   {% list tabs %}

   - Management console
     1. In the [management console]({{ link-console-main }}), select the folder where you created the load balancer.
     1. Select **Load Balancer**.
     1. Click the load balancer name `group-balancer`.

   - CLI

     ```bash
     yc load-balancer network-load-balancer list
     ```

     Command execution result:

     ```bash
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     |          ID          |      NAME      |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     | b0rbabc1m2edfu2ss579 | group-balancer | ru-central1 | EXTERNAL |              1 | b0rdabckribed1fbv2l1   | ACTIVE |
     +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
     ```

   - API

     Use the method [List](../../load-balancer/api-ref/NetworkLoadBalancer/list.md) for the resource `NetworkLoadBalancer`.

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

     Command execution result:

     ```bash
     projects/b0g12ga82bcv0cdeferg/zones/ru-central1-b
     ```

   {% endlist %}

1. View the instance utilization:

   {% list tabs %}

   - Management console
     1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
     1. Select **Compute Cloud**.
     1. Go to **Instance groups**.
     1. Click the `auto-group` instance group name.
     1. Select the **Monitoring** tab.
The load balancer sent the request to an instance in the group. In the availability zone this instance belongs to, the average CPU utilization is higher than in other zones (see the chart **Average CPU utilization in zone**).

   {% endlist %}

### Test auto scaling {#check-highload}

To test auto scaling for your instance group, increase the CPU utilization of each instance. In the `specification.yaml` file, the parameter `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` has the value `40`: it means that the target utilization level is 40% CPU. If you exceed the target utilization, {{ ig-name }} increases the number of instances in the group.

1. Increase the utilization of the instance group.

   To do this, save the script named `load.sh` in the home directory. The script will send requests through 12 threads for 10 minutes, utilizing 20% CPU of each instance. The instance group utilization is 240% CPU at any given time. To be sure that requests are evenly distributed across the instances in the group, the script executes multiple parallel requests utilizing 20% CPU rather than one request utilizing 240% CPU.

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

     Command execution result:

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
     1. Select **Compute Cloud**.
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
     1. In the [management console]({{ link-console-main }}), select the folder where you created the load balancer `group-balancer`.
     1. Select **Load Balancer**.
     1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of the load balancer `group-balancer`.
     1. In the menu that opens, click **Delete**.
     1. In the **Delete load balancer** window that opens, click **Delete**.

   - CLI

     ```bash
     yc load-balancer network-load-balancer delete group-balancer
     ```

     Command execution result:

     ```bash
     done (15s)
     ```

   - API

     Use the method [Delete](../../load-balancer/api-ref/NetworkLoadBalancer/delete.md) for the resource `NetworkLoadBalancer`.

   {% endlist %}

1. Delete the instance group:

   {% list tabs %}

   - Management console
     1. In the [management console]({{ link-console-main }}), select the folder where you created the `auto-group` instance group.
     1. Select **Compute Cloud**.
     1. Go to **Instance groups**.
     1. Click ![image](../../_assets/vertical-ellipsis.svg) for the instance group `auto-group`.
     1. In the menu that opens, click **Delete**.
     1. In the **Delete instance group** window that opens, click **Delete**.

   - CLI

     ```bash
     yc compute instance-group delete auto-group
     ```

     Command execution result:

     ```bash
     done (1m20s)
     ```

   - API

     Use the method [Delete](../api-ref/InstanceGroup/delete.md) for the resource `InstanceGroup`.

   {% endlist %}

