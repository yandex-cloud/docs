# Creating and configuring a UserGate gateway in firewall mode

[UserGate](https://www.usergate.com/products/enterprise-firewall) is a next-generation firewall created by a Russia-based company Usergate.

You will create a UserGate virtual machine in {{ yandex-cloud }} and set up the gateway for firewall mode. To learn about advanced UserGate features, take the free course [UserGate Getting Started](https://university.tssolution.ru/usergate-getting-started-v6).

To deploy a UserGate gateway and check its health:

1. [Before you start](#before-you-begin).
1. [Create a cloud network and subnet](#create-network).
1. [Reserve a static public IP address](#get-static-ip).
1. [Create a UserGate VM](#create-vm).
1. [Set up the UserGate NGFW via the administrative console](#admin-console).
1. [Set up routing in the subnet](#subnet-routing).
1. [Test the firewall](#test-firewall).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The price for the UserGate gateway includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* [UserGate NGFW](/marketplace/products/usergate/ngfw) usage.
* A fee for using a public static IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a cloud network and subnet {#create-network}

Create a cloud [network](../../vpc/concepts/network.md#network) with [subnets](../../vpc/concepts/network.md#subnet) in the [availability zones](../../overview/concepts/geo-scope.md) that will host your VM.

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Network**.
   1. Enter the network name: `usergate-network`.
   1. Enable the **Create subnets** option.
   1. Click **Create network**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a network named `usergate-network`:

      ```bash
      yc vpc network create usergate-network
      ```

      Result:

      ```
      id: enptrcle5q3d3ktd33hj
      folder_id: b1g9hv2loamqfnbul7d9
      created_at: "2022-06-08T09:25:03Z"
      name: usergate-network
      default_security_group_id: enpbsnnop4akg7ng70ll
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/create.md).

   1. Create the `usergate-subnet-{{ region-id }}-a` network in the `{{ region-id }}-a` availability zone:

      ```
      yc vpc subnet create usergate-subnet-{{ region-id }}-a \
        --zone {{ region-id }}-a \
        --network-name usergate-network \
        --range 10.1.0.0/16
      ```

      Result:

      ```
      id: e9bnnssj8sc8mjhat9qk
      folder_id: b1g9hv2loamqfnbul7d9
      created_at: "2022-06-08T09:27:00Z"
      name: usergate-subnet-{{ region-id }}-a
      network_id: enptrcle5q3d3ktd33hj
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 10.1.0.0/16
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/create.md).



- {{ TF }}

   1. In the configuration file, describe the network parameters for `usergate-network` and its subnets:

      ```
      resource "yandex_vpc_network" "usergate-network" {
        name = "usergate-network"
      }

      resource "yandex_vpc_subnet" {
        name           = "usergate-subnet-{{ region-id }}-a"
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.usergate-network.id}"
        v4_cidr_blocks = ["10.1.0.0/16"]
      }
      ```

      Learn more in the description of the [yandex_vpc_network]({{ tf-provider-link }}/vpc_network) and [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet) resources in the {{ TF }} provider documentation.

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

- API

   1. Create a network named `usergate-network` using the gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create) call or the REST API [create](../../vpc/api-ref/Network/create.md) method for the Network resource.
   1. Create a subnet named `usergate-subnet-{{ region-id }}-a` using the [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create) gRPC API call or the REST API [create](../../vpc/api-ref/Subnet/create.md) method for the Subnet resource.

{% endlist %}

## Reserve a static public IP address {#get-static-ip}

The gateway will need a static [public IP address](../../vpc/concepts/address.md#public-addresses).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the page of the folder where you want to reserve an IP address.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
   1. Click **Reserve address**.
   1. In the window that opens, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
   1. Click **Reserve address**.

- CLI

   Run the command:

   ```bash
   yc vpc address create --external-ipv4 zone={{ region-id }}-a
   ```

   Result:

   ```bash
   id: e9b6un9gkso6stdh6b3p
   folder_id: b1g7gvsi89m34pipa3ke
   created_at: "2022-06-08T17:52:42Z"
   external_ipv4_address:
     address: 178.154.253.52
     zone_id: {{ region-id }}-a
     requirements: {}
   reserved: true
   ```

   For more information about the `yc vpc address create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/address/create.md).

- {{ TF }}

   In the configuration file, describe the parameters of the public IP address `yandex_vpc_address`:

   ```hcl
   resource "yandex_vpc_address" "usergate-addr" {
   name = "usergate-addr"
   external_ipv4_address {
     zone_id = "{{ region-id }}-b"
     }
   }
   ```

   To learn more, see the [vpc_address]({{ tf-provider-link }}/vpc_address) resource description in the {{ TF }} provider documentation.

{% endlist %}

## Create a UserGate VM {#create-vm}

{% list tabs %}

- Management console

   1. On the [management console]({{ link-console-main }}) folder page, click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter the VM name as `usergate-firewall`.
   1. Select an availability zone `{{ region-id }}-a`.
   1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, then select the [UserGate NGFW](/marketplace/products/usergate/ngfw) image.
   1. Under **Computing resources**:

      * Select the [platform](../../compute/concepts/vm-platforms.md): Intel Ice Lake.
      * Specify the number of vCPUs and amount of RAM:

         * **vCPU**: 4.
         * **Guaranteed vCPU share**: 100%
         * **RAM**: 8 GB.

         {% note info %}

         These parameters are good for functional testing of the gateway. To calculate the parameters for the production workload, read the [official recommendations](https://www.usergate.com/products/usergate-vm) from UserGate.

         {% endnote %}

   1. Under **Network settings**:

      * Select the `usergate-network` network and the `usergate-subnet-{{ region-id }}-a` subnet.
      * In the **Public address** field, select from a list of reserved IPs.

   1. Under **Access**, specify the information required to access the instance:

      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

   1. Click **Create VM**.

- CLI

   1. [Create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair.

   1. Run the command:

      ```bash
      yc compute instance create \
        --name usergate-firewall \
        --memory 8 \
        --cores 4 \
        --zone {{ region-id }}-a \
        --create-boot-disk image-folder-id=standard-images,image-family=usergate-ngfw \
        --ssh-key <path_to_public_part_of_SSH_hey> \
        --public-address=<reserved_ID_address>
      ```

      Result:

      ```bash
      id: fhm2na1siftpfhrfc03l
      folder_id: b1g86q4m5vej8lkljme5
      created_at: "2022-06-09T11:15:52Z"
      name: usergate-firewall
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "8589934592"
        cores: "4"
        core_fraction: "100"
      status: RUNNING
      boot_disk:
        mode: READ_WRITE
        device_name: fhmiq60rni2tqvjdiq3l
        auto_delete: true
        disk_id: fhmiq60rni2tqvjdiq3l
      network_interfaces:
      - index: "0"
        mac_address: d0:0d:2b:a8:3c:93
        subnet_id: e9bqlr188as7rgsgh4kn
        primary_v4_address:
          address: 10.1.0.27
          one_to_one_nat:
            address: 51.250.72.1
            ip_version: IPV4
      fqdn: fhm2na1siftpfhrfc03l.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

      For more information about the `yc compute instance create` command, see the [CLI reference](../../cli/cli-ref/managed-services/compute/instance/create.md).

- {{ TF }}

   1. [Get](../../compute/operations/images-with-pre-installed-software/get-list.md) an ID of the latest version of the UserGate NGFW gateway from the list of public images.
   1. In the configuration file, describe the parameters of the `usergate-firewall` VM:

      ```
      resource "yandex_compute_instance" "usergate-firewall" {
        name        = "usergate-firewall"
        platform_id = "standard-v3"
        zone        = "{{ region-id }}-a"
        hostname    = "usergate"
        resources {
          cores         = 4
          core_fraction = 100
          memory        = 8
        }

        boot_disk {
          initialize_params {
            image_id = "<UserGate_NGFW_image_ID>"
            size     = 110
          }
        }

        network_interface {
          subnet_id          = "${yandex_vpc_subnet.usergate-subnet.id}"
          nat                = true
          nat_ip_address     = <reserved_IP_address>
        }
      ```

      To learn more, see the [yandex_compute_instance]({{ tf-provider-link }}/compute_instance) resource description in the {{ TF }} provider documentation.

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory with the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

- API

   Create the `usergate-proxy` VM using the REST API [create](../../compute/api-ref/Instance/create.md) method for the Instance resource.

{% endlist %}

## Set up the UserGate NGFW via the administrative console {#admin-console}

To set up the gateway, go to the UserGate NGFW administrative console at `https://<public_IP_address_of_the_UserGate_VM>:8001` and log in with the default credentials: username: `Admin`, password: `utm`.

When you're logged in, the system prompts you to change the default password and update the OS.

### Set up the gateway to run in firewall mode {#gateway-setup}

Configure UserGate NGFW:

1. In the top menu, select **Settings**.
1. In the menu on the left, go to **Network** ⟶ **Zones**.
1. Click on the `Trusted` zone name.
1. Click **Access control**, then enable **Administration console**. Click **Save**.
1. In the menu on the left, go to **Network** ⟶ **Interfaces**.
1. Click the `port0` network interface name.
1. In the **General** tab, in the **Zone** field, select the `Trusted` zone from the list. Click **Save**.
1. In the menu on the left, click **Network policies** ⟶ **Firewall**.
1. Click the preset rule: `Allow trusted to untrusted`.
1. Click **Destination** and disable the `Untrusted` zone. Click **Save**.
1. Enable the rule: `Allow trusted to untrusted`. To do this, select the line with the rule and click **Enable** at the top of the screen.
1. In the menu on the left, click **Network policies** ⟶ **NAT and routing**.
1. Click the preset rule: `NAT from trusted to untrusted`.
1. Click **Destination** and change the destination zone from `Untrusted` to `Trusted`. Click **Save**.
1. Enable the rule: `NAT from Trusted to Untrusted`. To do this, select the line with the rule and click **Enable** at the top of the screen.

Now the gateway has been set up.

### Set up the traffic filtering rules {#traffic-rules}

We recommend that you use the following default policies: `Block to botnets`, `Block from botnets`, and `Example block RU RKN by IP list`. First change several parameters in them:

1. Click **Network policies** ⟶ **Firewall**.
1. Click the name of the preset rule.
1. Click **Source** and change the source zone from `Untrusted` to `Trusted`.
1. Click **Destination** and disable the `Untrusted` zone.
1. Click **Save**.
1. Enable the selected rule. To do this, select the line with the rule and click **Enable** at the top of the screen.

For higher security, set up more traffic filtering rules:

1. Click **Network policies** ⟶ **Firewall**.
1. Add the first blocking rule:

   1. At the top of the screen, click **Add**.
   1. Specify the rule parameters:

      * **Name**: `Block QUIC protocol`.
      * **Action**: Deny.

   1. Click **Source** and select `Trusted`.
   1. Click **Service**.
   1. Click **Add**.
   1. Select the service `Quick UDP Internet Connections`, then click **Add**. After that, click **Close**.
   1. Click **Save**.

1. Add the second blocking rule:

   1. At the top of the screen, click **Add**.
   1. Specify the rule parameters:

      * **Name**: `Block Windows updates`.
      * **Action**: Deny.

   1. Click **Source** and select `Trusted`.
   1. Click **Applications**.
   1. Click **Add** ⟶ **Add applications**.
   1. Select the `Microsoft Update` application, then click **Add**.
   1. Select the `WinUpdate` application, then click **Add**. After that, click **Close**.
   1. Click **Save**.

You can also add other traffic filtering rules. We don't recommend combining services and applications in the same rule. The rule might not trigger in this case.


## Set up routing for the subnet {#subnet-routing}.

Create a [static route](../../vpc/concepts/static-routes.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a static route.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/route-tables.svg) **Route tables**.
   1. Click **Create**.
   1. Enter a name for the route table.

      {% include [name-format](../../_includes/name-format.md) %}

   1. (optional) Add a description of a route table.
   1. Select the `usergate-network` network.
   1. Click **Add route**.
   1. In the window that opens, enter the prefix for the target subnet (`0.0.0.0`) and select `0` from the dropdown list.
   1. Specify **next hop**, that is, the internal IP address of the UserGate `usergate-firewall` VM.
   1. Click **Add**.
   1. Click **Create route table**.

   To use static routes, link the route table to a subnet:

   1. On the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **Subnets**.
   1. In the `usergate-subnet-{{ region-id }}-a` line, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **Link route table**.
   1. In the window that opens, select the created table from the list.
   1. Click **Link**.

- CLI

   To create a route table and add [static routes](../../vpc/concepts/static-routes.md):
   1. View a description of the CLI command for creating routing tables:

      ```bash
      yc vpc route-table create --help
      ```

   1. Get the IDs of cloud networks in your cloud:

      ```bash
      yc vpc network list
      ```

      Result:
      ```
      +----------------------+--------------------+
      |          ID          |      NAME          |
      +----------------------+--------------------+
      | enp846vf5fus0nt3lu83 | usergate-network   |
      +----------------------+--------------------+
      ```

   1. Create a routing table in the `usergate-network` network:

      ```bash
      yc vpc route-table create \
        --name=test-route-table \
        --network-id=enp846vf5fus0nt3lu83 \
        --route destination=0.0.0.0/0,next-hop=10.129.0.24
      ```

      Where:

      * `name`: The name of the route table.
      * `network-id`: The ID of the network where the table will be created.
      * `route`: The route settings with two parameters:
         * `destination`: The destination subnet prefix in CIDR notation.
         * Specify `next hop`, that is, the internal IP address of the UserGate `usergate-firewall` VM.

      Result:
      ```
      ...done
      id: enpsi6b08q2vfdmppsnb
      folder_id: b1gqs1teo2q2a4vnmi2t
      created_at: "2019-06-24T09:57:54Z"
      name: test-route-table
      network_id: enp846vf5fus0nt3lu83
      static_routes:
      - destination_prefix: 0.0.0.0/0
        next_hop_address: 10.129.0.24
      ```

   To use static routes, link the route table to a subnet:

   1. Get a list of subnets in your cloud:

      ```
      yc vpc subnet list
      ```

      Result:
      ```
      +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
      |          ID          |               NAME            |      NETWORK ID      |    ROUTE TABLE ID    |       ZONE    |      RANGE      |
      +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
      | b0c4l3v9jrgdqve43902 | usergate-subnet-{{ region-id }}-a | enpjsdf771h0c0fs7g5a |                      | {{ region-id }}-a | [10.130.0.0/24] |
      +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
      ```

   1. Assign the routing table to the subnet where the web service will run: for example, to the `usergate-subnet-{{ region-id }}-a` subnet:

      ```bash
      yc vpc subnet update b0c4l3v9jrgdqve43902 --route-table-id e2l5345dlgr1ugidhmov
      ```

      Result:
      ```
      ..done
      id: b0c4l3v9jrgdqve43902
      folder_id: b1gqs1teo2q2a4vnmi2t
      created_at: "2019-03-12T13:27:22Z"
      name: subnet-1
      network_id: enp846vf5fus0nt3lu83
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.0.0/24
      route_table_id: e2l5345dlgr1ugidhmov
      ```

- {{ TF }}

   To create a route table and add [static routes](../../vpc/concepts/static-routes.md):

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `name`: The name of the route table. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `network-id`: The ID of the network where the table will be created.
      * `static_route`: Static route description:
         * `destination_prefix`: The destination subnet prefix in CIDR notation.
         * `next_hop_address`: The internal IP address of the VM from the [allowed ranges](../../vpc/concepts/network.md#subnet) that traffic is sent through.

      Example configuration file structure:

      ```hcl
      resource "yandex_vpc_route_table" "usergate-rt-a" {
        name       = "<routing_table_name>"
        network_id = "<network_ID>"
        static_route {
          destination_prefix = "0.0.0.0/0"
          next_hop_address   = "10.129.0.24"
        }
      }
      ```

      To add, update, or delete a route table, use the `yandex_vpc_route_table` resource and specify the network in the `netword id` field (such as `network_id = "${yandex_vpc_network.lab-net.id}"`).

      For more information about the `yandex_vpc_route_table` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/vpc_route_table).

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```hcl
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```hcl
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```bash
         yc vpc route-table list
         ```

{% endlist %}


## Test the firewall {#test-firewall}

To test your firewall, create a test web service and make sure that you can access it from the internet.


### Set up a test VM {#test-vm-prepare}

1. [Create](../../compute/operations/vm-create/create-linux-vm) a VM from a public Linux image in the `usergate-subnet-{{ region-id }}-a` subnet. In the VM settings, enable the [serial console](../../compute/operations/serial-console/index.md).
1. To connect to the VM via the [CLI](../../compute/operations/serial-console/connect-cli.md), run the command:

   ```
   yc compute connect-to-serial-port --instance-name <VM_name>
   ```

   Where
   `--instance-name` is the name of the test VM.

1. Start the test web service:

   ```bash
   sudo python3 -m http.server 80
   ```

   The web server will listen to requests on port 80 and return a list of directories and files from the folder.


### Use the firewall to set up a reverse proxy to the web service {#setup-access}

1. In the UserGate administrator web console, in the top menu, select **Settings**.
1. On the left in the **Global portal** section, select **Web portal**, and set up access by an HTTP address:
   1. Click **Add** to open the portal adding dialog.
   1. Tick the **Enabled** option on.
   1. In the **Name** field, enter `Test web portal`.
   1. In the **URL** field, enter `http://<IP_address_of_UserGate_VM>`.
   1. Leave **SSL profile** at default.
   1. In the **Certificate** field, select `CA (Default)`.
   1. Click **Save**.
1. Select **Reverse proxy servers** and add a new server:
   1. Click **Add** to open the server adding dialog.
   1. In the **Name** field, enter `Local server`.
   1. In the **Server address** field, enter the `<internal_IP_of_test_VM>`, for example, `10.129.0.24`.
   1. In the **Port field**, enter `80`.
   1. Click **Save**.
1. Select **Reverse proxy rules** and add a new rule:
   1. Click **Add** to open the rule adding dialog.
   1. Tick the **Enabled** option on.
   1. In the **Name** field, enter `Access to local server`.
   1. In the **Reverse proxy server** field, select `Local server`.
   1. In the **Ports** field, enter `5550`.
   1. Click **Save**.

   This completes setting up access to a local server. The firewall will accept requests on port 5550 and forward them to port 80 on the test VM IP address.

### Test that the web server is available from the internet {#service-access}

1. Make sure that you can execute a request against the web service at the URL:

   ```text
   http://<IP_address_of_UserGate_VM>:5550
   ```

   This should return a list of directories and files in the folder.

1. In the UserGate administrator web console, in the top menu, select **Logs and reports**.
1. On the left side of the **Logs** section, select **Web access log** and make sure that you can see an entry about executing the `Access to local server` rule.

## How to delete created resources {#clear-out}

To stop paying for the resources created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `usergate-firewall` and `local-service` VMs.
1. [Delete the static public IP address](../../vpc/operations/address-delete.md).
