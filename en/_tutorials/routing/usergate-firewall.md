# Creating and configuring a UserGate gateway in firewall mode


[UserGate](https://www.usergate.com/products/enterprise-firewall) is a next-generation firewall created by a Russia-based company of the same name.

You will create a UserGate virtual machine in {{ yandex-cloud }} and set up the gateway for firewall mode. To learn about advanced UserGate features, take the free course [UserGate Getting Started](https://university.tssolution.ru/usergate-getting-started-v6).

To deploy a UserGate gateway and check its health:

1. [Prepare your cloud](#before-you-begin).
1. [Create a cloud network and subnet](#create-network).
1. [Reserve a static public IP address](#get-static-ip).
1. [Create a UserGate VM](#create-vm).
1. [Set up the UserGate NGFW via the admin console](#admin-console).
1. [Set up routing in the subnet](#subnet-routing).
1. [Test the firewall](#test-firewall).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The price for the UserGate gateway includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using [UserGate NGFW](/marketplace/products/usergate/ngfw).
* Fee for using a public static IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a cloud network and subnet {#create-network}

Create a cloud [network](../../vpc/concepts/network.md#network) with [subnets](../../vpc/concepts/network.md#subnet) in the [availability zones](../../overview/concepts/geo-scope.md) that will host your VM.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Network**.
  1. Enter a name for the network: `usergate-network`.
  1. Enable the **Create subnets** option.
  1. Click **Create network**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a network named `usergate-network`:
  
     ```bash
     yc vpc network create usergate-network
     ```

     Result:

     ```text
     id: enptrcle5q3d********
     folder_id: b1g9hv2loamq********
     created_at: "2022-06-08T09:25:03Z"
     name: usergate-network
     default_security_group_id: enpbsnnop4ak********
     ```

     For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create a subnet named `usergate-subnet-{{ region-id }}-a` in the `{{ region-id }}-a` availability zone:

     ```bash
     yc vpc subnet create usergate-subnet-{{ region-id }}-a \
       --zone {{ region-id }}-a \
       --network-name usergate-network \
       --range 10.1.0.0/16
     ```

     Result:
    
     ```yaml
     id: e9bnnssj8sc8********
     folder_id: b1g9hv2loamq********
     created_at: "2022-06-08T09:27:00Z"
     name: usergate-subnet-{{ region-id }}-a
     network_id: enptrcle5q3d********
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 10.1.0.0/16
     ```

     For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).



- {{ TF }} {#tf}

  1. In the configuration file, describe the network parameters for `usergate-network` and its subnets:

     ```hcl
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

     For more information, see the descriptions of the [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network) and [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet) resources in the {{ TF }} provider documentation.
     
  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy cloud resources.
  
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

  1. Create a network named `usergate-network` using the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call or the [create](../../vpc/api-ref/Network/create.md) REST API method for the Network resource.
  1. Create a subnet named `usergate-subnet-{{ region-id }}-a` using the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call or the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the Subnet resource.

{% endlist %}

## Reserve a static public IP address {#get-static-ip}

The gateway will need a static [public IP address](../../vpc/concepts/address.md#public-addresses).

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), go to the page of the folder you want to reserve an IP address in.
  1. In the list of services, select **{{ vpc-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
  1. Click **Reserve address**.
  1. In the window that opens, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
  1. Click **Reserve address**.
  
- CLI {#cli}

  Run this command:

  ```bash
  yc vpc address create --external-ipv4 zone={{ region-id }}-a
  ```

  Result:

  ```text
  id: e9b6un9gkso6********
  folder_id: b1g7gvsi89m3********
  created_at: "2022-06-08T17:52:42Z"
  external_ipv4_address:
    address: 178.154.253.52
    zone_id: {{ region-id }}-a
    requirements: {}
  reserved: true
  ```

  For more information about the `yc vpc address create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/address/create.md).

- {{ TF }} {#tf}

  In the configuration file, describe the parameters of the `yandex_vpc_address` public IP address:

  ```hcl
  resource "yandex_vpc_address" "usergate-addr" {
  name = "usergate-addr"
  external_ipv4_address {
    zone_id = "{{ region-id }}-b"
    }
  }
  ```

  For more information, see the [vpc_address]({{ tf-provider-resources-link }}/vpc_address) resource description in the {{ TF }} provider documentation.

{% endlist %}

## Create a UserGate VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder page](../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.  
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, specify `UserGate NGFW` and select the [UserGate NGFW](/marketplace/products/usergate/ngfw) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`

      {% note info %}

      These parameters are appropriate for functional testing of the gateway. To calculate the parameters for the production workload, read the UserGate [official recommendations](https://www.usergate.com/products/usergate-vm).

      {% endnote %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network named `usergate-network` and the subnet named `usergate-subnet-{{ region-id }}-a`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, click `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` and select the IP address [reserved earlier](#get-static-ip).

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access data:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other names reserved by the OS. To perform operations requiring superuser permissions, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `usergate-firewall`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
   
- CLI {#cli}
  
  1. [Create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair.
  
  1. Run this command:

     ```bash
     yc compute instance create \
       --name usergate-firewall \
       --memory 8 \
       --cores 4 \
       --zone {{ region-id }}-a \
       --create-boot-disk image-folder-id=standard-images,image-family=usergate-ngfw \
       --ssh-key <path_to_public_part_of_SSH_key> \
       --public-address=<reserved_IP_address>
     ```

     Result:

     ```text
     id: fhm2na1siftp********
     folder_id: b1g86q4m5vej********
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
       device_name: fhmiq60rni2t********
       auto_delete: true
       disk_id: fhmiq60rni2t********
     network_interfaces:
     - index: "0"
       mac_address: d0:0d:2b:a8:3c:93
       subnet_id: e9bqlr188as7********
       primary_v4_address:
         address: 10.1.0.27
         one_to_one_nat:
           address: 51.250.72.1
           ip_version: IPV4
     fqdn: fhm2na1siftp********.auto.internal
     scheduling_policy: {}
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

     For more information about the `yc compute instance create` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- {{ TF }} {#tf}

  1. [Get](../../compute/operations/images-with-pre-installed-software/get-list.md) an ID of the latest version of the UserGate NGFW gateway from the list of public images.
  1. In the configuration file, describe the parameters of the `usergate-firewall` VM:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "boot-disk"
       type     = "network-hdd"
       zone     = "{{ region-id }}-a"
       size     = "110"
       image_id = "<UserGate_NGFW_image_ID>"
     }

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
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id          = "${yandex_vpc_subnet.usergate-subnet.id}"
         nat                = true
         nat_ip_address     = <reserved_IP_address>
       }
     ```

     For more information, see the [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance) resource description in the {{ TF }} provider documentation.
     
  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder with the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy cloud resources.
  
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

  Create the `usergate-firewall` VM using the [create](../../compute/api-ref/Instance/create.md) REST API method for the Instance resource.

{% endlist %}

## Set up the UserGate NGFW via the admin console {#admin-console}

To set up the gateway, go to the UserGate NGFW admin console at `https://<UserGate_VM_public_IP_address>:8001` and log in with the default credentials: `Admin` for username and `utm` for password.

When you are logged in, the system prompts you to change the default password and update the OS.

### Set up the gateway to run in firewall mode {#gateway-setup}

Configure UserGate NGFW:

1. In the top menu, select **Settings**.
1. In the menu on the left, go to **Network** ⟶ **Zones**.
1. Click the `Trusted` zone name.
1. Click **Access control**, then enable **Administration console**. Click **Save**.
1. In the menu on the left, go to **Network** ⟶ **Interfaces**.
1. Click the `port0` network interface name.
1. On the **General** tab, select the `Trusted` zone from the list in the **Zone** field. Click **Save**.
1. In the menu on the left, click **Network policies** ⟶ **Firewall**.
1. Click the name of the `Allow trusted to untrusted` preset rule.
1. Go to the **Destination** tab and disable the `Untrusted` zone. Click **Save**.
1. Enable the `Allow trusted to untrusted` rule. To do this, select the line with the rule and click **Enable** at the top of the screen.
1. In the menu on the left, click **Network policies** ⟶ **NAT and routing**.
1. Click the name of the `NAT from Trusted to Untrusted` preset rule.
1. Go to the **Destination** tab and change the destination zone from `Untrusted` to `Trusted`. Click **Save**.
1. Enable the `NAT from Trusted to Untrusted` rule. To do this, select the line with the rule and click **Enable** at the top of the screen.
 
Now the gateway has been set up. 

### Set up the traffic filtering rules {#traffic-rules}

We recommend using the following default policies: `Block to botnets`, `Block from botnets`, and `Example block RU RKN by IP list`. First change several parameters in them:

1. Click **Network policies** ⟶ **Firewall**.
1. Click the name of the preset rule.
1. Go to the **Source** tab and change the source zone from `Untrusted` to `Trusted`. 
1. Go to the **Destination** tab and disable the `Untrusted` zone.
1. Click **Save**.
1. Enable the selected rule. To do this, select the line with the rule and click **Enable** at the top of the screen.

For higher security, set up more traffic filtering rules:

1. Click **Network policies** ⟶ **Firewall**.
1. Add the first blocking rule:
   
   1. At the top of the screen, click **Add**.
   1. Specify the rule parameters:
      
      * **Name**: `Block QUIC protocol`.
      * **Action**: Deny.

   1. Go to the **Source** tab and select `Trusted`.
   1. Click **Service**.
   1. Click **Add**.
   1. Select `Quick UDP Internet Connections` and click **Add**. After that, click **Close**.
   1. Click **Save**.

1. Add the second blocking rule:
   
   1. At the top of the screen, click **Add**.
   1. Specify the rule parameters:

      * **Name**: `Block Windows updates`.
      * **Action**: Deny.
   
   1. Go to the **Source** tab and select `Trusted`.
   1. Click **Applications**.
   1. Click **Add** ⟶ **Add applications**.
   1. Select the `Microsoft Update` app and click **Add**.
   1. Select the `WinUpdate` app and click **Add**. After that, click **Close**.
   1. Click **Save**.

You can also add other traffic filtering rules. We don't recommend combining services and applications in the same rule. The rule might not trigger in this case.


## Set up subnet routing {#subnet-routing}

Create a [static route](../../vpc/concepts/routing.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you need to create a static route in.
  1. In the list of services, select **{{ vpc-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/vpc/route-tables.svg) **Route tables**.
  1. Click **Create**.
  1. Enter a name for the route table. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. (Optional) Add a description of a route table.
  1. Select the `usergate-network` network.
  1. Click **Add route**.
  1. In the window that opens, enter the prefix for the target subnet (`0.0.0.0`) and select `0` from the drop-down list.
  1. Specify **next hop**, i.e., the internal IP address of the UserGate VM named `usergate-firewall`.
  1. Click **Add**.
  1. Click **Create route table**.

  To use static routes, link the route table to a subnet:

  1. In the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **Subnets**.
  1. In the `usergate-subnet-{{ region-id }}-a` row, click ![image](../../_assets/options.svg).
  1. In the menu that opens, select **Link route table**.
  1. In the window that opens, select the created table from the list.
  1. Click **Link**.

- CLI {#cli}

  To create a route table and add [static routes](../../vpc/concepts/routing.md): 
  1. View the description of the CLI command for creating route tables:

     ```bash
     yc vpc route-table create --help
     ```

  1. Get the IDs of cloud networks in your cloud:

     ```bash
     yc vpc network list
     ```

     Result:
     ```text
     +----------------------+--------------------+
     |          ID          |      NAME          |
     +----------------------+--------------------+
     | enp846vf5fus******** | usergate-network   |
     +----------------------+--------------------+
     ```

  1. Create a route table in the `usergate-network` network:

     ```bash
     yc vpc route-table create \
       --name=test-route-table \
       --network-id=enp846vf5fus******** \
       --route destination=0.0.0.0/0,next-hop=10.129.0.24
     ```

     Where:

     * `name`: Name of the route table.
     * `network-id`: ID of the network where the table will be created.
     * `route`: Route settings, which include these two parameters:
        * `destination`: Destination subnet prefix in CIDR notation.
        * `next-hop`: Internal IP address of the UserGate VM named `usergate-firewall`.

     Result:
     ```text
     ...done
     id: enpsi6b08q2v********
     folder_id: b1gqs1teo2q2********
     created_at: "2019-06-24T09:57:54Z"
     name: test-route-table
     network_id: enp846vf5fus********
     static_routes:
     - destination_prefix: 0.0.0.0/0
       next_hop_address: 10.129.0.24
     ```

  To use static routes, link the route table to a subnet:

  1. Get a list of subnets in your cloud:

     ```bash
     yc vpc subnet list
     ```

     Result:
     ```text
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     |          ID          |               NAME            |      NETWORK ID      |    ROUTE TABLE ID    |       ZONE    |      RANGE      |
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     | b0c4l3v9jrgd******** | usergate-subnet-{{ region-id }}-a | enpjsdf771h0******** |                      | {{ region-id }}-a | [10.130.0.0/24] |
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     ```

  1. Assign the routing table to the subnet the web service will run in, e.g., `usergate-subnet-{{ region-id }}-a`:

     ```bash
     yc vpc subnet update b0c4l3v9jrgd******** --route-table-id e2l5345dlgr1********
     ```

     Result:
     ```text
     ..done
     id: b0c4l3v9jrgd********
     folder_id: b1gqs1teo2q2********
     created_at: "2019-03-12T13:27:22Z"
     name: subnet-1
     network_id: enp846vf5fus********
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 192.168.0.0/24
     route_table_id: e2l5345dlgr1********
     ```

- {{ TF }} {#tf}

  To create a route table and add [static routes](../../vpc/concepts/routing.md):

  1. In the configuration file, describe the parameters of the resources you want to create:

     * `name`: Name of the route table. The name format is as follows:

          {% include [name-format](../../_includes/name-format.md) %}

     * `network_id`: ID of the network the table will be created in.
     * `static_route`: Static route description:
        * `destination_prefix`: Destination subnet prefix in CIDR notation.
        * `next_hop_address`: Internal IP address of the VM from the [allowed ranges](../../vpc/concepts/network.md#subnet) the traffic will be routed through.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_vpc_route_table" "usergate-rt-a" {
	   name       = "<route_table_name>"
       network_id = "<network_ID>"
       static_route {
         destination_prefix = "0.0.0.0/0"
         next_hop_address   = "10.129.0.24"
       }
     }
     ```

     To add, update, or delete a route table, use the `yandex_vpc_route_table` resource indicating the network in the `netword id` field, e.g. `network_id = "${yandex_vpc_network.lab-net.id}"`.

     For more information about the `yandex_vpc_route_table` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_route_table).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:

        ```hcl
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```hcl
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

        ```bash
        yc vpc route-table list
        ```

{% endlist %}


## Test the firewall {#test-firewall}

To test your firewall, create a test web service and make sure that you can access it from the internet.


### Set up a test VM {#test-vm-prepare}

1. [Create](../../compute/operations/vm-create/create-linux-vm) a VM from a public Linux image in the `usergate-subnet-{{ region-id }}-a` subnet. In the VM settings, enable the [serial console](../../compute/operations/serial-console/index.md).
1. To connect to the VM via the [CLI](../../compute/operations/serial-console/connect-cli.md), run the command:

   ```bash
   yc compute connect-to-serial-port --instance-name <VM_name>
   ```

   Where:
   `--instance-name`: Test VM name.

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
   1. In the **URL** field, enter `http://<UserGate_VM_IP_address>`.
   1. Leave **SSL profile** at default.
   1. In the **Certificate** field, select `CA (Default)`.
   1. Click **Save**.
1. Select **Reverse proxy servers** and add a new server:
   1. Click **Add** to open the server adding dialog.
   1. In the **Name** field, enter `Local server`.
   1. In the **Server address** field, enter `<test_VM_internal_IP>`, e.g., `10.129.0.24`.
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

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `usergate-firewall` and `local-service` VMs.
1. [Delete the static public IP address](../../vpc/operations/address-delete.md).
