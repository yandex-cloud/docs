# Updating an instance group under load

Using this step-by-step guide, you will configure an [instance group](../concepts/instance-groups/index.md) and check its operation when updating the configuration. To do this:

1. [Before you start](#before-you-begin).
1. [Prepare the environment](#create-environment).
1. [Create an instance group from a {{ coi }}](#create-vm-group).
1. [Create a load on an instance](#start-load-testing).
1. [Update the instance group under load](#update-spec).
1. [Stop the load and get the results](#end-load-testing).

If you no longer need these resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before](../../_includes/compute/before-solution.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of support for the {{ yandex-cloud }} instance group includes a fee for:
* Disks and continuously running VMs: [{{compute-full-name}} pricing](../../compute/pricing.md).
* Using a dynamic or static external IP address: [{{vpc-full-name}} pricing](../../vpc/pricing.md).

{% endif %}

## Prepare the environment {#create-environment}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) named `for-load` and assign it the `editor` role:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a folder where you wish to create an service account.
      1. Go to the **Service accounts** tab.
      1. Click **Create service account**.
      1. Enter the name `for-load`.
      1. To assign the service account a [role](../../iam/concepts/access-control/roles.md) for the current folder, click **Add role** and select the role `editor`.
      1. Click **Create**.

   - CLI

      1. Create a service account:

         {% include [default-catalogue](../../_includes/default-catalogue.md) %}

         ```bash
         yc iam service-account create --name for-load
         ```

         Result:

         ```bash
         id: ajeab0cnib1pdefe21dm
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-02-09T17:31:32.561702Z"
         name: for-load
         ```

      1. Assign the role to the service account:

         ```bash
         yc resource-manager folder add-access-binding b0g12ga82bcv0cdeferg \
           --role editor \
           --subject serviceAccount:ajeab0cnib1pdefe21dm
         ```

   - API

      Use the methods:

      1. [Create](../../iam/api-ref/ServiceAccount/create.md) for the `ServiceAccount` resource to create a `for-load` service account.
      1. [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) for the `Folder` resource in order to assign the `editor` role to the service account in the current folder.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and [subnets](../../vpc/concepts/network.md#subnet) in two [availability zones](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create an instance group.
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

         Result:

         ```bash
         id: enpabce123hde4ft1r3t
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-02-09T17:33:32.561702Z"
         name: yc-auto-network
         ```

      1. Create a subnet in the `{{ region-id }}-a` zone:

         ```bash
         yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.1.0/24 --zone {{ region-id }}-a
         ```

         Result:

         ```bash
         id: e1lnabc23r1c9d0efoje
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-02-09T17:34:32.561702Z"
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

      1. Create a subnet in the `{{ region-id }}-b` zone:

         ```bash
         yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.2.0/24 --zone {{ region-id }}-b
         ```

         Result:

         ```bash
         id: b1csa2b3clideftjb121
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-02-09T17:35:32.561702Z"
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-b
         v4_cidr_blocks:
         - 192.168.2.0/24
         ```

   - API

      1. Create a network using the method [Create](../../vpc/api-ref/Network/create.md) for the `Network` resource.

      1. Create subnets in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones using the [Create](../../vpc/api-ref/Subnet/create.md) method for the `Subnet` resource.

   {% endlist %}

## Create an instance group from a {{ coi }}{#create-vm-group}

1. All the instance groups are created from the image [{{ coi }}](../../cos/concepts/index.md). Each instance contains a Docker container running a web server that emulates the service utilization.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a network.
      1. Select **{{ compute-name }}**.
      1. On the **Virtual machines** page, go to the **Instance groups** tab.
      1. Click **Create group**.
      1. Under **Basic parameters**:
         * Enter the **Name** of the group `group-for-load`.
         * Select the `for-load` **Service account**.
      1. Under **Allocation**, select the `{{ region-id }}-a` and `{{ region-id }}-b` **Availability zones**.
      1. Under **Instance template**, click **Define**:
         * Under **Image/boot disk selection**, select the **Container Solution** tab.
         * Click **Configure**.
         * In the **Docker container settings** window:
            * **Name** it `nginx`.
            * In the **Docker image** field, click the **Enter link** button and enter `cr.yandex/yc/demo/autoscaling-example-app:v1`.
            * Click **Apply**.
         * In the **Disks** section:
            * For the boot disk, specify the **Size** of 30 GB.
         * Under **Network settings**:
            * Select the `for-load` **Network**.
         * Under **Access**:
            * Select the `for-load` **Service account**.
            * In the **Login** field, enter the name of the user to be created on the VM.
            * In the **SSH key** field, paste the contents of the public key file.
         * Click **Save**.
      1. Under **Allow when creating and updating**:
         * In the **Reduce below target value** field, enter `4`.
      1. In the **Scalability** section:
         * In the **Type** field, select `Fixed`.
         * Set the **Size** to `6`.
      1. Under **Integration with Load Balancer**:
         * Enable the option **Create target group**.
         * In the **Name of the target group** field, enter `load-generator`.
      1. Click **Create**.

   - CLI

      1. Find out the ID of the latest version of the {{ coi }} [public image](../../compute/operations/images-with-pre-installed-software/get-list.md).

         A {{ coi }} in a [{{ container-registry-name }}](../../container-registry/) registry can be updated and changed according to the new releases. In this case, the image on a VM isn't updated to the latest version automatically. To create an instance group with the latest {{ coi }} version, you need to check whether it's available yourself:

         ```bash
         yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
         ```

         Result:

         ```bash
         id: fd8iv792kirahcnqnt0q
         folder_id: standard-images
         created_at: "2021-01-29T13:30:22Z"
         ...
         status: READY
         os:
           type: LINUX
         ```

      1. Save the specification of the instance group with the network load balancer to the file `specification.yaml`:

         {% include [updating-under-load-yaml-spec-init](../../_includes/instance-groups/updating-under-load-yaml-spec-init.md) %}

         {% note info %}

         You can send an SSH key to the [VM metadata](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images) using the `ssh-keys` parameter or in the `user-data` string with the user metadata. This tutorial uses the first option.

         {% endnote %}

      1. Create an instance group named `group-for-load` using the specification `specification.yaml`:

         ```bash
         yc compute instance-group create --file=specification.yaml
         ```

         Result:

         ```bash
         done (2m18s)
         id: cl0kabcquk1gomdefbkk
         folder_id: b0g12ga82bcv0cdeferg
         ...
         service_account_id: ajeab0cnib1pdefe21dm
         status: ACTIVE
         application_load_balancer_state: {}
         ```

   - API

      Use the methods:

      1. [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) for the `Image` resource to get the ID of the latest version of the `container-optimized-image` image in the `standard-images` family.
      1. [createFromYaml](../api-ref/InstanceGroup/createFromYaml.md) for the `InstanceGroup` resource to create an instance group to meet the following specification:

         {% include [updating-under-load-yaml-spec-init](../../_includes/instance-groups/updating-under-load-yaml-spec-init.md) %}

   {% endlist %}

1. Make sure that the instance group was created:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
      1. Select **{{ compute-name }}**.
      1. Go to **Instance groups**.
      1. Click the `group-for-load` instance group name.

   - CLI

      ```bash
      yc compute instance-group list-instances group-for-load
      ```

      Result:

      ```bash
      +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
      |     INSTANCE ID      |           NAME            |   EXTERNAL IP   | INTERNAL IP |        STATUS        | STATUS MESSAGE |
      +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
      ...
      | fhmab0cfsfd125efpvn1 | cl0kabcquk1gomdefbkk-oxig | 178.154.226.108 | 10.130.0.8  | RUNNING_ACTUAL [49m] |                |
      | epdabchpdef0f1e21j14 | cl0kabcquk1gomdefbkk-aqyg | 130.193.40.55   | 10.129.0.20 | RUNNING_ACTUAL [43m] |                |
      +----------------------+---------------------------+-----------------+-------------+----------------------+----------------+
      ```

   - API

      See the list of the instance groups you created using the method [List](../api-ref/InstanceGroup/list.md) for the resource `InstanceGroup`.

   {% endlist %}

### Add a network load balancer to the created instance group {#enable-balancer}

1. Create a network load balancer named `load-generator` and connect it to the instance group you created:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a load balancer.
      1. In the list of services, select **{{ network-load-balancer-name }}**.
      1. Click **Create a network load balancer**.
      1. **Name** it `load-generator`.
      1. In the **Public address** field, select the value **Auto**.
      1. Click **Add listener** under **Listeners**.

         * In the window that opens, enter `http` as the **Listener name**.
         * In the **Port** field, enter `80`: the balancer will use this port to accept incoming traffic.
         * In the **Target port** field, enter `80`: the balancer will redirect traffic to this port.
         * Click **Add**.

      1. Under **Target groups**, click **Add target group**.
      1. In the **Target group** drop-down list, select `load-generator`.
      1. In the target group block, click **Configure**:

         * In the window that opens, enter the **Path** `/hello`: the load balancer will use this path to send health check requests to target group VMs.
         * Click **Apply**.

      1. Click **Create**.

   - CLI

      1. Get the ID of the `load-generator` target group:

         ```bash
         yc load-balancer target-group get load-generator | grep "^id"
         ```

         Result:

         ```bash
         id: enpsa475ej51enuam897
         ```

      1. Create a network load balancer:

         ```bash
         yc load-balancer network-load-balancer create \
           --name load-generator \
           --listener external-ip-version=ipv4,name=http,port=80,protocol=tcp,target-port=80 \
           --target-group healthcheck-http-port=80,healthcheck-http-path=/hello,target-group-id=<target group ID>
         ```

         Result:

         ```bash
         done (14s)
         id: b0ruab1ccvpd26efgii4
         folder_id: b1csa2b3clideftjb121
         ...
             healthy_threshold: "2"
             http_options:
               port: "80"
               path: /hello
         ```

   - API

      1. Create a load balancer using the method [Create](../../network-load-balancer/api-ref/NetworkLoadBalancer/create.md) for the `NetworkLoadBalancer` resource.

      1. Add a listener to the balancer using the method [addListener](../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) for the `NetworkLoadBalancer` resource.

      1. Attach the target group to the balancer using the method [attachTargetGroup](../../network-load-balancer/api-ref/NetworkLoadBalancer/attachTargetGroup.md) for the `NetworkLoadBalancer` resource.

      1. Add the balancer to the instance group using the method [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) for the `TargetGroup` resource.

   {% endlist %}

1. Make sure that the network load balancer `load-generator` is created and attached to the instance group:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the load balancer.
      1. Select **{{ network-load-balancer-name }}**.
      1. Click on the name of the network load balancer `load-generator`.

   - CLI

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Result:

      {% if product == "yandex-cloud" %}

      ```bash
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      |          ID          |      NAME      |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      | b0ruab1ccvpd26efgii4 | load-generator | {{ region-id }} | EXTERNAL |              1 | b0r1tabcphde28fj1dd3   | ACTIVE |
      +----------------------+----------------+-------------+----------+----------------+------------------------+--------+
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```bash
      +----------------------+----------------+-----------+----------+----------------+------------------------+--------+
      |          ID          |      NAME      | REGION ID |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+----------------+-----------+----------+----------------+------------------------+--------+
      | b0ruab1ccvpd26efgii4 | load-generator | il1       | EXTERNAL |              1 | b0r1tabcphde28fj1dd3   | ACTIVE |
      +----------------------+----------------+-----------+----------+----------------+------------------------+--------+
      ```

      {% endif %}

   - API

      Use the [list](../../network-load-balancer/api-ref/NetworkLoadBalancer/list.md) method for the `NetworkLoadBalancer` resource.

   {% endlist %}

## Create a load on an instance {#start-load-testing}

1. Get the IP address of the load balancer that you created:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a load balancer.
      1. In the list of services, select **{{ network-load-balancer-name }}**.
      1. Copy the **IP address** of the load balancer.

   - CLI

      ```bash
      yc load-balancer network-load-balancer get load-generator | grep "address"
      ```

      Result:

      ```bash
        address: 84.252.133.110
      ```

   - API

      Use the [get](../../network-load-balancer/api-ref/NetworkLoadBalancer/get.md) method for the `NetworkLoadBalancer` resource.

   {% endlist %}

1. Run the command to create a load:

   ```bash
   wrk -t20 -c20 -d20m --timeout 20s http://<load balancer IP address>/sleep
   ```

   The command will launch the `wrk` utility that will send requests to 20 threads using 20 connections to the network load balancer for 20 minutes. The request timeout is 20 seconds. The load balancer will distribute the resulting load among the VMs from the group.

   After you launch `wrk`, a message that testing has started will appear on the screen:

   ```bash
   Running 20m test @ http://84.252.133.110/sleep
     20 threads and 20 connections
   ```

   Proceed to the next step without waiting for the command to complete.

## Update the instance group under load {#update-spec}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
   1. Select **{{ compute-name }}**.
   1. Go to **Instance groups**.
   1. Click the `group-for-load` instance group name.
   1. On the group page, click ![pencil](../../_assets/pencil.svg) **Edit**.
   1. Under **Instance template**, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Edit**.
      * Under **Disks**, enter the new disk size of 35 GB.
      * Click **Save**.
   1. Click **Save changes**.
   1. Under **VM states**, you'll see disk size changes for all VMs in the group step-by-step.

- CLI

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

      Result:

      ```bash
      done (9m24s)
      id: cl10kktrjcn8polprdav
      folder_id: b1g7gvsi89m34qmcm3ke
      ...
         name: load-generator
      service_account_id: ajehbk07uus3s73pcq13
      status: ACTIVE
      ```

- API

   1. In the specification, enter the new disk size of 35 GB:

      ```yaml
      ...
      size: 35G
      ...
      ```

   1. Use the method [updateFromYaml](../../compute/api-ref/InstanceGroup/updateFromYaml.md) for the resource `InstanceGroup` to update the `load-generator` instance group according to the new specification.

{% endlist %}

## Stop the load and get the results {#end-load-testing}

Stop `wrk` by pressing **Ctrl** + **C**.

Result:

```bash
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    10.00s     1.70ms  10.01s    68.21%
    Req/Sec     0.00      0.00     0.00    100.00%
  1148 requests in 17.47m, 211.89KB read
Requests/sec:      1.09
Transfer/sec:     206.94B
```

If there is no error line in the result, such as `Socket errors`, it means that all requests were processed.

## How to delete created resources {#clear-out}

To delete the created resources:

{% list tabs %}

- Management console

   1. Delete the load balancer:
      1. Go to the root of the folder.
      1. In the list of services, select **{{ network-load-balancer-name }}**.
      1. To the right of the `load-generator` load balancer line, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. In the window that opens, click **Delete**.
   1. Delete the instance group:
      1. Go to the root of the folder.
      1. In the list of services, select **{{ compute-name }}**.
      1. Go to the **Instance groups** tab.
      1. To the right of the `load-generator` instance group line, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. In the window that opens, click **Delete**.
   1. Delete the service account:
      1. Go to the root of the folder.
      1. Go to the **Service accounts** tab.
      1. To the right of the `yc-auto-sa` account line, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. In the window that opens, click **Delete**.
   1. Delete the network and subnets:
      1. Go to the root of the folder.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Select the network `yc-auto-network`.
      1. Under **Subnets**:
         1. To the right of the `yc-auto-subnet-1` subnet line, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
         1. In the window that opens, click **Delete**.
         1. Also delete the subnet `yc-auto-subnet-2`.
      1. In the upper-right corner, click **Delete**.

- CLI

   Run the following commands one-by-one:

   ```bash
   yc load-balancer network-load-balancer delete load-generator
   yc compute instance-group delete load-generator
   yc iam service-account delete yc-auto-sa
   yc vpc subnet delete yc-auto-subnet-1
   yc vpc subnet delete yc-auto-subnet-2
   yc vpc network delete yc-auto-network
   ```

- API

   Use the methods:

   1. [delete](../../network-load-balancer/api-ref/NetworkLoadBalancer/delete.md) for the `NetworkLoadBalancer` resource to delete the `load-generator` load balancer.
   1. [delete](../../compute/api-ref/InstanceGroup/delete.md) for the `InstanceGroup` resource to delete the `load-generator` instance group.
   1. [delete](../../iam/api-ref/ServiceAccount/delete.md) for the `ServiceAccount` resource to delete the `yc-auto-sa` service account.
   1. [delete](../../vpc/api-ref/Subnet/delete.md) for the `Subnet` resource to delete the `yc-auto-subnet-1` and `yc-auto-subnet-2` subnets.
   1. [delete](../../vpc/api-ref/Network/delete.md) for the resource `Network` to delete the network `yc-auto-network`.

{% endlist %}
