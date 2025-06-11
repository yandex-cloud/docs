# Creating an L7 load balancer with DDoS protection using the management console or CLI


To create an L7 load balancer with DDoS protection using the {{ yandex-cloud }} management console or CLI:

1. [Get your cloud ready](#before-begin).
1. [Create a cloud network](#create-network).
1. [Create security groups](#create-security-groups).
1. [Create an instance group](#create-vms).
1. [Reserve a static public IP address](#reserve-ip).
1. [Create a backend group](#create-backend-group).
1. [Create an HTTP router](#create-http-routers-sites).
1. [Create an L7 load balancer](#create-balancer).
1. [Test the load balancer](#test).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/alb-with-ddos-protection/paid-resources.md) %}


## Prepare a service account {#prepare-sa}

{% include [alb-warning.md](../../_includes/instance-groups/alb-warning.md) %}

{% include [sa.md](../../_includes/instance-groups/sa.md) %}

To be able to create, update, and delete VMs in the group, as well as integrate the group with an {{ alb-name }} L7 load balancer, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account.

## Create a cloud network {#create-network}

All resources you create in the tutorial will belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Enter `ddos-network` for the network name.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a cloud network in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc vpc network create \
       --name ddos-network
     ```

     For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create [subnets](../../vpc/concepts/network.md#subnet) in each [availability zone](../../overview/concepts/geo-scope.md) by specifying the cloud network ID using the `--network-name` parameter:

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-a \
       --network-name ddos-network \
       --zone {{ region-id }}-a \
       --range 192.168.0.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-b \
       --network-name ddos-network \
       --zone {{ region-id }}-b \
       --range 192.168.1.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-d \
       --network-name ddos-network \
       --zone {{ region-id }}-d \
       --range 192.168.2.0/24
     ```

     For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

{% endlist %}


## Create security groups {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow the load balancer to receive inbound traffic and redirect it to the VMs so they can receive it. In this tutorial, we will create two security groups: one for the load balancer and another one for all VMs.

To create security groups:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Create a security group for the load balancer:

     1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Specify **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** for the security group: `ddos-sg-balancer`.
     1. Select **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** `ddos-network`.
     1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

        Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br>destination | {{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}
        --- | --- | --- | --- | --- | ---
        `Outbound` | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Incoming` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Inbound` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Inbound` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | —

        1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
        1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports open for incoming or outgoing traffic.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic transmission over any protocol.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the purpose of the rule:

           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDR and subnet masks traffic will come to or from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`: Rule will apply to the VMs from the current group or the selected security group.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`: Rule allowing a load balancer to health-check VMs.

        1. Click **{{ ui-key.yacloud.common.save }}**. Repeat these steps to create all rules from the table.

     1. Click **{{ ui-key.yacloud.common.save }}**.

  1. Similarly, create a security group for the VM named `ddos-sg-vms` with the same `ddos-network` and the following rules:

     Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
     --- | --- | --- | --- | --- | ---
     `Inbound` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `ddos-sg-balancer`
     `Incoming` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

- CLI {#cli}

  To create a security group for your load balancer, run this command:

  ```bash
  yc vpc security-group create \
    --name ddos-sg-balancer \
    --rule "direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks" \
    --network-name ddos-network
  ```

  To create a security group for your VM, run this command:

  ```bash
  yc vpc security-group create \
    --name ddos-sg-vms \
    --rule "direction=ingress,port=22,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,security-group-id=<security_group_ID>" \
    --network-name ddos-network
  ```

  Where `security-group-id` is the `ddos-sg-balancer` security group ID.

  For more information about the `yc vpc security-group create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

{% endlist %}


## Create an instance group {#create-vms}

Your application backends will be deployed on the VM instance of the [target group](../../application-load-balancer/concepts/target-group.md). The VM target group will be connected to the load balancer thus enabling requests to the backend endpoints of your application. In this tutorial, an [instance group](../../compute/concepts/instance-groups/index.md) with the minimum configuration will do.

To create an instance group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:

     * Enter the instance group **{{ ui-key.yacloud.compute.groups.create.field_name }}**: `ddos-group`.
     * Select the [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete VMs in the group, as well as integrate the group with an {{ alb-name }} L7 load balancer, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account.

  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select multiple availability zones to ensure the fault tolerance of your hosting.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to configure a basic instance:

     * Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a **{{ ui-key.yacloud.common.description }}** for the template.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, open the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Select [LEMP](/marketplace/products/yc/lemp) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify:

       * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `HDD`.
       * Disk **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `3 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

     * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify:

       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Cascade Lake`.
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `5%`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

     * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

       * Select the `ddos-network` cloud network and its subnets.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`.
       * Select the `ddos-sg-vms` security group.

     * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the VM access credentials:

       * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

        To establish an SSH connection, you need to create a key pair. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, specify the instance group **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}**: `2`.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, select **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** and enter `tg-ddos` as the group name. [Read more about target groups](../../application-load-balancer/concepts/target-group.md).
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Get the resource IDs required to create an instance group using the following commands:

     * [yc iam service-account get <service_account_name>](../../cli/cli-ref/iam/cli-ref/service-account/get.md): For the service account.
     * [yc vpc network get ddos-network](../../cli/cli-ref/vpc/cli-ref/network/get.md): For `ddos-network`.
     * [yc vpc subnet get <subnet_name>](../../cli/cli-ref/vpc/cli-ref/subnet/get.md): For the `ddos-network-ru-a`, `ddos-network-ru-b`, and `ddos-network-ru-d` subnets.
     * [yc compute image get-latest-by-family lemp --folder-id standard-images](../../cli/cli-ref/compute/cli-ref/image/get-latest-from-family.md): For the boot disk image.
     * [yc vpc security-group get ddos-sg-vms](../../cli/cli-ref/vpc/cli-ref/security-group/get.md): For the `ddos-sg-vms` security group.

  1. Create a YAML file named `specification.yaml`.
  1. Add to it the description of the base instance configuration:

     ```yaml
     name: ddos-group
     service_account_id: <service_account_ID> // The service account must have the editor role.
     description: "DDoS alb scenario"
     instance_template:
         platform_id: standard-v3
         resources_spec:
             memory: 1g
             cores: 2
             core_fraction: 5
         boot_disk_spec:
             mode: READ_WRITE
             disk_spec:
                 image_id: <image_ID>
                 type_id: network-hdd
                 size: 3g
         network_interface_specs:
             - network_id: <cloud_network_ID>
               subnet_ids:
                 - <subnet_ID_in_{{ region-id }}-a>
                 - <subnet_ID_in_{{ region-id }}-b>
                 - <subnet_ID_in_{{ region-id }}-d>
               primary_v4_address_spec: {}
               security_group_ids:
                 - <security_group_ID>
     deploy_policy:
         max_unavailable: 1
         max_expansion: 0
     scale_policy:
         fixed_scale:
             size: 2
     allocation_policy:
         zones:
             - zone_id: {{ region-id }}-a
             - zone_id: {{ region-id }}-b
             - zone_id: {{ region-id }}-d
     application_load_balancer_spec:
         target_group_spec:
             name: tg-ddos
     ```

     Where `security_group_ids` is the `ddos-sg-vms` security group ID.

  1. Create an instance group in the default folder:

     ```bash
     yc compute instance-group create \
       --file specification.yaml
     ```

     Result:

     ```text
     done (25s)
     id: cl1qjhlcdofg********
     folder_id: b1g86q4m5vej********
     created_at: "2021-08-30T19:25:02.031Z"
     name: ddos-group
     description: DDoS scenario
     instance_template:
       platform_id: standard-v2
       resources_spec:
         memory: "1073741824"
         cores: "2"
         core_fraction: "5"
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           type_id: network-hdd
           size: "3221225472"
           image_id: fd8r6kq84o7b********
       network_interface_specs:
       - network_id: enp3srbi9u49********
         subnet_ids:
         - e9b17pi15695********
         - e2lt87g1rlig********
         - b0c7kl8riq24********
         primary_v4_address_spec: {}
         security_group_ids:
         - enpi08rif04d********
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "2"
     deploy_policy:
       max_unavailable: "1"
       startup_duration: 0s
       strategy: PROACTIVE
     allocation_policy:
       zones:
       - zone_id: {{ region-id }}-a
       - zone_id: {{ region-id }}-b
       - zone_id: {{ region-id }}-d
     load_balancer_state: {}
     managed_instances_state:
       target_size: "2"
     service_account_id: aje2stn6id9k********
     status: ACTIVE
     application_load_balancer_spec:
       target_group_spec:
         name: first-target-group
     application_load_balancer_state:
       target_group_id: ds78imh0ds2e********
     ```

     For more information about the `yc compute instance-group create` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance-group/create.md).

{% endlist %}


## Reserve a static public IP address {#reserve-ip}

{% note info %}

You cannot do this using the [CLI](../../cli/).

{% endnote %}

To protect a load balancer against DDoS attacks, reserve a static public IP address with the **{{ ui-key.yacloud.common.field_ddos-protection-provider }}** option enabled:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}** and click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. Select the availability zone where you want to reserve the IP address.
  1. Enable **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**.
  1. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}


## Create a backend group {#create-backend-group}

You must link the target group created with the instance group to the [backend group](../../application-load-balancer/concepts/backend-group.md) that defines traffic allocation settings.

For the backends, the groups will implement [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks): the load balancer will periodically send health check requests to the VMs and expect a response for a certain period.

To create a backend group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Enter the backend group **{{ ui-key.yacloud.common.name }}**: `ddos-backend-group`.
  1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**.
  1. Enter the backend **{{ ui-key.yacloud.common.name }}**: `backend-1`.
  1. In the **{{ ui-key.yacloud.alb.label_target-groups }}** field, select the `tg-ddos` group.
  1. Specify **{{ ui-key.yacloud.alb.label_port }}** the backend VMs will use to receive incoming traffic from the load balancer: `80`.
  1. Click **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
  1. Specify **{{ ui-key.yacloud.alb.label_port }}** the backend VMs will use to accept health check connections: `80`.
  1. Specify **{{ ui-key.yacloud.alb.label_path }}** the load balancer will use for health checks: `/`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a backend group:

     ```bash
     yc alb backend-group create ddos-backend-group
     ```

     Result:

     ```text
     id: a5dg2cv4ngne********
     name: ddos-backend-group
     folder_id: aoerb349v3h4********
     created_at: "2021-08-08T20:46:21.688940670Z"
     ```

     For more information about the `yc alb backend-group create` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/backend-group/create.md).

  1. Add a backend and a health check to the group:

     ```bash
     yc alb backend-group add-http-backend \
       --backend-group-name ddos-backend-group \
       --name backend-1 \
       --weight 1 \
       --port 80 \
       --target-group-id=<target_group_ID> \
       --http-healthcheck timeout=1s,interval=1s,port=80,path=/
     ```

     Where:
     * `--backend-group-name`: Backend group name.
     * `--name`: Backend name.
     * `--weight`: Backend weight.
     * `--port`: Port.
     * `--target-group-id`: Target group ID.
     * `--http-healthcheck`: Resource health check properties.
       * `port`: Port.
       * `timeout`: Timeout.
       * `interval`: Interval.
       * `host`: Host address.
       * `path`: Path.

     Result:

     ```text
     done (21s)
     id: ds7fea2pggr2********
     name: ddos-backend-group
     folder_id: b1g86q4m5vej********
     http:
     backends:
     - name: backend-1
       backend_weight: "1"
       port: "80"
       target_groups:
         target_group_ids:
         - ds78ate00f8e********
       healthchecks:
       - timeout: 1s
         interval: 1s
         healthcheck_port: "80"
         http:
           path: /
     created_at: "2021-08-08T07:59:22.922603189Z"
     ```

     For more information about the `yc alb backend-group add-http-backend` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/backend-group/add-http-backend.md).

{% endlist %}


## Create an HTTP router {#create-http-routers-sites}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines the HTTP routing rules.

To create an HTTP router and add a route to it:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Specify the HTTP router **{{ ui-key.yacloud.common.name }}**: `ddos-router`.
  1. Click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Specify the virtual host **{{ ui-key.yacloud.common.name }}**: `ddos-host`.
  1. Specify the **{{ ui-key.yacloud.alb.label_authority }}** value: `alb-with-ddos.com`.
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Set **{{ ui-key.yacloud.common.name }}** to `route-1`.
  1. In the **{{ ui-key.yacloud.alb.label_path }}** field, select `{{ ui-key.yacloud.alb.label_match-prefix }}` and specify the `/` path.
  1. In the **{{ ui-key.yacloud.alb.label_route-action }}** field, keep `{{ ui-key.yacloud.alb.label_route-action-route }}`.
  1. In the **{{ ui-key.yacloud.alb.label_backend-group }}** list, select the group you created earlier.
  1. Do not change other settings. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Run this command:

     ```bash
     yc alb http-router create ddos-router
     ```

     Result:

     ```text
     id: a5dcsselagj4********
     name: ddos-router
     folder_id: aoerb349v3h4********
     created_at: "2021-08-08T21:04:59.438292069Z"
     ```

     For more information about the `yc alb http-router create` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/http-router/create.md).

  1. Create a virtual host by specifying the HTTP router name:

     ```bash
     yc alb virtual-host create ddos-host \
       --http-router-name ddos-router
       --authority alb-with-ddos.com
     ```

     For more information about the `yc alb virtual-host create` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).

  1. Add a route by specifying the router name and the routing parameters:

     ```bash
     yc alb virtual-host append-http-route route-1 \
       --virtual-host-name ddos-host \
       --http-router-name ddos-router \
       --prefix-path-match / \
       --backend-group-name ddos-backend-group \
       --request-timeout 60s
     ```

     Result:

     ```text
     done (1s)
      name: ddos-host
      routes:
      - name: route-1
        http:
          match:
            path:
              prefix_match: /
          route:
            backend_group_id: ds7fea2pggr2********
            timeout: 60s
     ```

     For more information about the `yc alb virtual-host append-http-route` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

{% endlist %}


## Create a load balancer {#create-balancer}

To create a load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_load-balancers }}**.
  1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
  1. Enter the load balancer name: `ddos-protect-alb`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select `ddos-network` and the `ddos-sg-balancer` security group.
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select the subnets for the load balancer nodes in each availability zone and enable traffic.
  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}**. Set the listener settings:

     1. Specify the listener name: `ddos-listener`.
     1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, enable traffic.
     1. Set the port to `80`.
     1. Select the **{{ ui-key.yacloud.alb.label_address-list }}** type and specify the [previously reserved](#reserve-ip) IP address with DDoS protection.

  1. In the **{{ ui-key.yacloud.alb.label_http-router }}** field, select `ddos-router`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Create a load balancer with nodes in the cloud network subnets:

     ```bash
     yc alb load-balancer create ddos-protect-alb \
       --network-name ddos-network \
       --location subnet-name=ddos-network-ru-a,zone={{ region-id }}-a \
       --location subnet-name=ddos-network-ru-b,zone={{ region-id }}-b \
       --location subnet-name=ddos-network-ru-d,zone={{ region-id }}-d
     ```

     For more information about the `yc alb load-balancer create` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/create.md).

  1. Add a listener:

     ```bash
     yc alb load-balancer add-listener ddos-protect-alb \
       --listener-name ddos-listener \
       --http-router-id <HTTP_router_ID> \
       --external-ipv4-endpoint port=80, address=<IP_address_with_DDoS_protection>
     ```

     For more information about the `yc alb load-balancer add-listener` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/add-listener.md).

{% endlist %}

After creating the load balancer, [test](#test) it.

## Test the load balancer {#test}

{% include [test](../_tutorials_includes/alb-with-ddos-protection/test.md) %}


## How to delete the resources you created {#clear-out}

To shut down the hosting and stop paying for the created resources:

1. Delete the non-billable resources that block the deletion of billable resources:

   1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `ddos-protect-alb` L7 load balancer.
   1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the `ddos-router` HTTP router.
   1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the `ddos-backend-group` backend group.

1. [Delete](../../compute/operations/instance-groups/delete.md) the `ddos-group` instance group.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address you reserved.