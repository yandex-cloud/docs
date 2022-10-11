# Creating a load balancer with DDoS protection

In this scenario, you'll create an L7 load balancer with a listener and public IP address with [DDoS protection](../../vpc/ddos-protection/index.md).

To create an L7 load balancer with DDoS protection:

1. [Before you start](#before-begin).
1. [Create a cloud network](#create-network).
1. [Create security groups](#create-security-groups).
1. [Create an instance group](#create-vms).
1. [Reserve a static public IP address](#reserve-ip).
1. [Create a backend group](#create-backend-group).
1. [Create an HTTP router](#create-http-routers-sites).
1. [Create an L7 load balancer](#create-balancer).
1. [Test the load balancer](#test-work).

If you no longer need these resources, [delete them](#delete-resources).

## Before you start {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a cloud network {#create-network}

All resources you have created in the tutorial belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Name the network: `ddos-network`.
   1. In the **Advanced** field, select **Create subnets**.
   1. Click **Create network**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a cloud network in the default folder:

      ```bash
      yc vpc network create \
        --name ddos-network
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/create.md).

   1. Create subnets in each availability zone by specifying the cloud network ID via the `--network-name` flag:

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
        --name ddos-network-ru-c \
        --network-name ddos-network \
        --zone {{ region-id }}-c \
        --range 192.168.2.0/24
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

{% endlist %}

## Create security groups {#create-security-groups}

{% include [security-groups-note](../../application-load-balancer/_includes_service/security-groups-note.md) %}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that let the load balancer receive incoming traffic and redirect it to the VMs so they can receive the traffic. Two security groups will be created in the use case: the first one for the load balancer and the second one for all VMs.

To create security groups:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Create a security group for the load balancer:

      1. Click **Create group**.
      1. **Name** the group: `ddos-sg-balancer`.
      1. Select the `ddos-network` **network**.
      1. Under **Rules**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
         | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | healthchecks | 30080 | TCP | CIDR | 198.18.235.0/24<br/>198.18.248.0/24 |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:

            * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
            * **Security group**: The rule will apply to the VMs from the current group or the selected security group.

         1. Click **Save**. Repeat the steps to create all rules from the table.

      1. Click **Save**.

   1. Similarly create a security group for the VM named `ddos-sg-vms` with the same `ddos-network` network and the following rules:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source type | Source |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | balancer | 80 | TCP | Security group | `ddos-sg-balancer` |
      | Incoming | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |

- CLI

   To create a security group for your load balancer, run the command:

   ```bash
   yc vpc security-group create \
     --name ddos-sg-balancer \
     --rule "direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
     --rule "direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
     --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
     --rule "direction=ingress,port=30080,protocol=tcp,v4-cidrs=[198.18.235.0/24,198.18.248.0/24]" \
     --network-name ddos-network
   ```

   To create a security group for your VM, run the command:

   ```bash
   yc vpc security-group create \
     --name ddos-sg-vms \
     --rule "direction=ingress,port=22,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
     --rule "direction=ingress,port=80,protocol=tcp,security-group-id=<ddos-sg-balancer security group ID>" \
     --network-name ddos-network
   ```

   For more information about the `yc vpc security-group create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

{% endlist %}

## Create an instance group {#create-vms}

Backends of your application are deployed on the VM instance of the [target group](../../application-load-balancer/concepts/target-group.md). The target group will be connected to the load balancer so that requests can be sent to the backend endpoints of your application. In this scenario, creating an instance group with the minimum configuration is enough.

To create an instance group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
   1. Open the **Instance groups** tab and click **Create group**.
   1. Under **Basic parameters**:

      * **Name** the instance group: `ddos-group`.
      * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account.  All operations in {{ ig-name }} are performed on behalf of the service account.

   1. Under **Allocation**, select multiple availability zones to ensure fault tolerance of your hosting.
   1. Under **Instance template**, click **Define** and set up the configuration for a basic instance:

      * Under **Basic parameters**, enter the template **Description**:
      * Under **Image/boot disk selection**, open the **{{ marketplace-name }}** tab and click **Show more**. Select [LEMP](/marketplace/products/yc/lemp) and click **Use**.
      * Under **Disks**, specify:
         * **Disk type**: HDD.
         * Disk **size**: 3 GB.
      * Under **Computing resources**, specify:
         * **Platform**: Intel Cascade Lake.
         * **vCPU**: 2.
         * **Guaranteed vCPU share**: 5%.
         * **RAM**: 1 GB.
      * Under **Network settings**:
         * Choose the `ddos-network` network and its subnets.
         * In the **Public address** field, select **Auto**.
         * Choose the `ddos-sg-vms` security group.
      * Under **Access**, specify the data required to access the VM:
         * Enter the username in the **Login** field.
         * In the **SSH key** field, paste the contents of the public key file.

         To establish an SSH connection, you need to create a key pair. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

      * Click **Save**.

   1. Under **Scaling**, enter the **Size** of the instance group: 2.
   1. Under **Integration with Application Load Balancer**, select **Create target group** and specify `tg-ddos` as the group name. [Read more about target groups](../../application-load-balancer/concepts/target-group.md).
   1. Click **Create**.

- CLI

   1. Get the resource IDs required to create an instance group using the commands:

      * [yc iam service-account get <service account name>](../../cli/cli-ref/managed-services/iam/service-account/get.md): For a service account.
      * [yc vpc network get ddos-network](../../cli/cli-ref/managed-services/vpc/network/get.md): For the `ddos-network` network.
      * [yc vpc subnet get <subnet name>](../../cli/cli-ref/managed-services/vpc/subnet/get.md): For the `ddos-network-ru-a`, `ddos-network-ru-b`, and `ddos-network-ru-c` subnets.
      * [yc compute image get-latest-by-family lemp --folder-id standard-images](../../cli/cli-ref/managed-services/compute/image/get-latest-from-family.md): For the boot disk image.
      * [yc vpc security-group get ddos-sg-vms](../../cli/cli-ref/managed-services/vpc/security-group/get.md): For the `ddos-sg-vms` security group.

   1. Create a YAML file named `specification.yaml`.
   1. Add the description of the base instance configuration to it:

      ```yaml
      name: ddos-group
      service_account_id: <service account ID>
      description: "DDoS alb scenario"
      instance_template:
          platform_id: standard-v2
          resources_spec:
              memory: 1g
              cores: 2
              core_fraction: 5
          boot_disk_spec:
              mode: READ_WRITE
              disk_spec:
                  image_id: <image ID>
                  type_id: network-hdd
                  size: 3g
          network_interface_specs:
              - network_id: <cloud network ID>
                subnet_ids:
                  - <subnet ID in the {{ region-id }}-a zone>
                  - <subnet ID in the {{ region-id }}-b zone>
                  - <subnet ID in the {{ region-id }}-c zone>
                primary_v4_address_spec: {}
                security_group_ids: 
                  - <ddos-sg-vms security group ID>
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
              - zone_id: {{ region-id }}-c
      application_load_balancer_spec:
          target_group_spec:
              name: tg-ddos
      ```

   1. Create an instance group in the default folder:

      ```bash
      yc compute instance-group create \
         --file specification.yaml
      ```

      Result:

      ```bash
      done (25s)
      id: cl1qjhlcdofg6rujs29d
      folder_id: b1g86q4m5vej8lkljme5
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
            image_id: fd8r6kq84o7be9tm50ms
        network_interface_specs:
        - network_id: enp3srbi9u49pjvcejnb
          subnet_ids:
          - e9b17pi15695qc0mngl2
          - e2lt87g1rligsso4ketj
          - b0c7kl8riq244aq2mfc1
          primary_v4_address_spec: {}
          security_group_ids:
          - enpi08rif04dcugga5e3
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
        - zone_id: {{ region-id }}-c
      load_balancer_state: {}
      managed_instances_state:
        target_size: "2"
      service_account_id: aje2stn6id9k43qk7n7l
      status: ACTIVE
      application_load_balancer_spec:
        target_group_spec:
          name: first-target-group
      application_load_balancer_state:
        target_group_id: ds78imh0ds2eluau7ojp
      ```

      For more information about the `yc compute instance-group create` command, see the [CLI reference](../../cli/cli-ref/managed-services/compute/instance-group/create.md).

{% endlist %}

## Reserve a static public IP address {#reserve-ip}

{% note info %}

You can't do this using the [CLI](../../cli/).

{% endnote %}

To protect a load balancer against DDoS attacks, you need to reserve a static public IP address with the **DDoS protection** option:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **IP addresses** tab and click **Reserve address**.
   1. Select the availability zone where you want to reserve the address.
   1. Enable the **DDoS protection** option.
   1. Click **Reserve address**.

{% endlist %}

## Create a backend group {#create-backend-group}

You must link the target group created with the VM group to the [backend group](../../application-load-balancer/concepts/backend-group.md) that defines traffic allocation settings.

For the backends, groups will implement [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks): the load balancer will periodically send health check requests to the VMs and expect a response after a certain delay.

To create a backend group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Open the **Backend groups** tab. Click **Create backend group**.
   1. **Name** the backend group: `ddos-backend-group`.
   1. Under **Backends**, click **Add**.
   1. **Name** the backend: `backend-1`.
   1. In the **Target group** field, select the `tg-ddos` group.
   1. Specify the **Port** that the backend VMs will use to receive incoming traffic from the load balancer: `80`.
   1. Click **Add health check**.
   1. Enter the **Port** that the backend VMs will use to accept health check connections from the load balancer: `80`.
   1. Enter the **Path** to be accessed by the load balancer's health checks: `/`.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a backend group:

      ```bash
      yc alb backend-group create ddos-backend-group
      ```

      Result:

      ```bash
      id: a5dg2cv4ngne8575fb1p
      name: ddos-backend-group
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-08-08T20:46:21.688940670Z"
      ```

      For more information about the `yc alb backend-group create` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/backend-group/create.md).

   1. Add a backend and health check to the group:

      ```bash
      yc alb backend-group add-http-backend \
        --backend-group-name ddos-backend-group \
        --name backend-1 \
        --weight 1 \
        --port 80 \
        --target-group-id=<target group ID> \
        --http-healthcheck timeout=1s,interval=1s,port=80,path=/
      ```

      Where:

      * `--backend-group-name`: Name of the backend group.
      * `--name`: Backend name.
      * `--weight`: Backend weight.
      * `--port`: The port.
      * `--target-group-id`: Target group ID.
      * `--http-healthcheck`: Parameters for checking the resource status:
         * `port`: The port.
         * `timeout`: The timeout.
         * `interval`: The interval.
         * `host`: The host address.
         * `path`: The path.

      Result:

      ```bash
      done (21s)
      id: ds7fea2pggr2e2vlncd5
      name: ddos-backend-group
      folder_id: b1g86q4m5vej8lkljme5
      http:
      backends:
      - name: backend-1
        backend_weight: "1"
        port: "80"
        target_groups:
          target_group_ids:
          - ds78ate00f8e7c0p1rem
        healthchecks:
        - timeout: 1s
          interval: 1s
          healthcheck_port: "80"
          http:
            path: /
      created_at: "2021-08-08T07:59:22.922603189Z"
      ```

      For more information about the `yc alb backend-group add-http-backend` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/backend-group/add-http-backend.md).

{% endlist %}

## Create an HTTP router {#create-http-routers-sites}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines HTTP routing rules.

To create an HTTP router and add a route to it:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Open the **HTTP routers** tab. Click **Create HTTP router**.
   1. **Name** the HTTP router: `ddos-router`.
   1. Click **Add virtual host**.
   1. **Name** the virtual host: `ddos-host`.
   1. Specify the Authority value: `alb-with-ddos.com`.
   1. Click **Add route**.
   1. **Name** it: `route-1`.
   1. In the **Path** field, select `Starts with` and specify the path `/`.
   1. In the **Action** field, leave the `Routing` value.
   1. In the **Backend group** list, select the group you created earlier.
   1. Leave the other settings as they are and click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Run the command:

      ```bash
      yc alb http-router create ddos-router
      ```

      Result:

      ```bash
      id: a5dcsselagj4o2v4a6e7
      name: ddos-router
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-08-08T21:04:59.438292069Z"
      ```

      For more information about the `yc alb http-router create` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/http-router/create.md).

   1. Create a virtual host by specifying the name of the HTTP router:

      ```bash
      yc alb virtual-host create ddos-host \
        --http-router-name ddos-router
        --authority alb-with-ddos.com
      ```

      For more information about the `yc alb virtual-host create` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/create.md).

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

      ```bash
      done (1s)
       name: ddos-host
       routes:
       - name: route-1
         http:
           match:
             path:
               prefix_match: /
           route:
             backend_group_id: ds7fea2pggr2e2vlncd5
             timeout: 60s
      ```

      For more information about the `yc alb virtual-host append-http-route` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

{% endlist %}

## Create a load balancer {#create-balancer}

To create a load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. In the menu on the left, select **Load balancers**.
   1. Click **Create L7 load balancer**.
   1. Name the load balancer: `ddos-protect-alb`.
   1. Under **Network settings**, select the `ddos-network` network and the `ddos-sg-balancer` security group.
   1. Under **Allocation**, select the subnets for the load balancer's nodes in each availability zone and enable traffic.
   1. Click **Add listener** under **Listeners**. Set the listener settings:

      1. Name the listener: `ddos-listener`.
      1. Under **Public IP address settings**, enable traffic.
      1. Set the port to `80`.
      1. Select the **List** type and specify the [previously reserved](#reserve-ip) IP address with DDoS protection.

   1. In the **HTTP router** field, select `ddos-router`.
   1. Click **Create**.

- CLI

   1. Create a load balancer with nodes in the cloud network subnets:

      ```bash
      yc alb load-balancer create ddos-protect-alb \
        --network-name ddos-network \
        --location subnet-name=ddos-network-ru-a,zone={{ region-id }}-a \
        --location subnet-name=ddos-network-ru-b,zone={{ region-id }}-b \
        --location subnet-name=ddos-network-ru-c,zone={{ region-id }}-c
      ```

      For more information about the `yc alb load-balancer create` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/create.md).

   1. Add a listener:

      ```bash
      yc alb load-balancer add-listener ddos-protect-alb \
        --listener-name ddos-listener \
        --http-router-id <HTTP router ID> \
        --external-ipv4-endpoint port=80, address=<IP address with DDoS protection>
      ```

      For more information about the `yc alb load-balancer add-listener` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md).

{% endlist %}

## Test the load balancer {#test-work}

Check that the service is available on the `alb-with-ddos.com` host. To do this, run the command:

```bash
curl -H "Host: alb-with-ddos.com" http://<L7 load balancer IP address>
```

Result:

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

## Delete the resources you created {#delete-resources}

To shut down the hosting and stop paying for the created resources:

1. Delete the non-billable resources that block the deletion of billable resources:

   1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `ddos-protect-alb` L7 load balancer.
   1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the `ddos-router` HTTP router.
   1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the `ddos-backend-group` backend group.

1. [Delete](../../compute/operations/instance-groups/delete.md) the `ddos-group` instance group.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address that you reserved.
