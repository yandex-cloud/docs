# Setting up a UserGate firewall


[UserGate](https://www.usergate.com/products/enterprise-firewall) is a next-generation firewall created by the Russia-based company UserGate.

In this tutorial, you will create and configure a {{ yandex-cloud }} VM running the UserGate firewall. To learn more about UserGate, sign up to our free course [UserGate Getting Started](https://university.tssolution.ru/usergate-getting-started-v6).

To set up UserGate and test its work:

1. [Get your cloud ready](#before-you-begin).
1. [Create a cloud network with a subnet](#create-network).
1. [Reserve a static public IP address](#get-static-ip).
1. [Create a UserGate VM](#create-vm).
1. [Set up the UserGate NGFW](#admin-console).
1. [Configure subnet routing](#subnet-routing).
1. [Test the firewall](#test-firewall).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the UserGate firewall infrastructure includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using [UserGate NGFW](/marketplace/products/usergate/ngfw).
* Fee for a public static IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a cloud network with a subnet {#create-network}

Create a cloud [network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) in the [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder dashboard in the [management console]({{ link-console-main }}), click **Create resource** and select **Network**.
  1. Specify the network name: `usergate-network`.
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

  1. Create the `usergate-subnet-{{ region-id }}-d` subnet in the `{{ region-id }}-d` availability zone:

     ```bash
     yc vpc subnet create usergate-subnet-{{ region-id }}-d \
       --zone {{ region-id }}-d \
       --network-name usergate-network \
       --range 10.1.0.0/16
     ```

     Result:
    
     ```yaml
     id: e9bnnssj8sc8********
     folder_id: b1g9hv2loamq********
     created_at: "2022-06-08T09:27:00Z"
     name: usergate-subnet-{{ region-id }}-d
     network_id: enptrcle5q3d********
     zone_id: {{ region-id }}-d
     v4_cidr_blocks:
     - 10.1.0.0/16
     ```

     For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).



- {{ TF }} {#tf}

  1. Specify the `usergate-network` and its subnet settings in the terraform configuration file:

     ```hcl
     resource "yandex_vpc_network" "usergate-network" {
       name = "usergate-network"
     }

     resource "yandex_vpc_subnet" {
       name           = "usergate-subnet-{{ region-id }}-d"
       zone           = "{{ region-id }}-d"
       network_id     = "${yandex_vpc_network.usergate-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }
     ```

     For more information, see the [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network) and [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet) descriptions in the {{ TF }} provider documentation.
     
  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.
  
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

  1. To create `usergate-network`, use the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call or the [create](../../vpc/api-ref/Network/create.md) REST API method for the Network resource.
  1. To create the `usergate-subnet-{{ region-id }}-d` subnet, use the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call or the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the Subnet resource.

{% endlist %}

## Reserve a static public IP address {#get-static-ip}

Your gateway will need a static [public IP address](../../vpc/concepts/address.md#public-addresses).

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to reserve your IP address.
  1. In the list of services, select **{{ vpc-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
  1. Click **Reserve address**.
  1. In the window that opens, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
  1. Click **Reserve address**.
  
- CLI {#cli}

  Run this command:

  ```bash
  yc vpc address create --external-ipv4 zone={{ region-id }}-d
  ```

  Result:

  ```text
  id: e9b6un9gkso6********
  folder_id: b1g7gvsi89m3********
  created_at: "2022-06-08T17:52:42Z"
  external_ipv4_address:
    address: 178.154.253.52
    zone_id: {{ region-id }}-d
    requirements: {}
  reserved: true
  ```

  For more information about the `yc vpc address create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/address/create.md).

- {{ TF }} {#tf}

  In the configuration file, specify the `yandex_vpc_address` settings:

  ```hcl
  resource "yandex_vpc_address" "usergate-addr" {
  name = "usergate-addr"
  external_ipv4_address {
    zone_id = "{{ region-id }}-d"
    }
  }
  ```

  For more information, see the [vpc_address]({{ tf-provider-resources-link }}/vpc_address) resource description in the {{ TF }} provider documentation.

{% endlist %}

## Create a UserGate VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, type `UserGate NGFW` and select the [UserGate NGFW](/marketplace/products/usergate/ngfw) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`

      {% note info %}

      These settings will suffice for the gateway functional testing. For the production environment, use the UserGate [official recommendations](https://www.usergate.com/products/usergate-vm).

      {% endnote %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `usergate-network` and the `usergate-subnet-{{ region-id }}-d` subnet.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, click `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` and select the [previously reserved](#get-static-ip) IP address.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select the **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** option, and specify the VM access credentials:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
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
       --zone {{ region-id }}-d \
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
     zone_id: {{ region-id }}-d
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

  1. In the list of public images, select the latest version of the UserGate NGFW and [get](../../compute/operations/images-with-pre-installed-software/get-list.md) its ID.
  1. Describe the `usergate-firewall` VM settings in the terraform configuration file:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "boot-disk"
       type     = "network-hdd"
       zone     = "{{ region-id }}-d"
       size     = "110"
       image_id = "<UserGate_NGFW_image_ID>"
     }

     resource "yandex_compute_instance" "usergate-firewall" {
       name        = "usergate-firewall"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-d"
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
     
  1. Make sure your configuration files are correct.

     1. In the terminal, navigate to the configuration file directory.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.
  
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

  To create the `usergate-firewall` VM, use the [create](../../compute/api-ref/Instance/create.md) REST API method for the Instance resource.

{% endlist %}

## Set up the UserGate NGFW {#admin-console}

Open the UserGate NGFW admin console at `https://<UserGate_VM_public_IP_address>:8001` and log in with the default credentials: `Admin` / `utm`.

Once you log in, the system will prompt you to change the default password and update the OS.

### Set up your gateway to work as firewall {#gateway-setup}

Configure UserGate NGFW:

1. In the top menu, select **Settings**.
1. In the left menu, navigate to **Network** ⟶ **Zones**.
1. Click the `Trusted` zone.
1. Click **Access control**, enable **Administration console**, and click **Save**.
1. In the left menu, navigate to **Network** ⟶ **Interfaces**.
1. Click the `port0` network interface.
1. On the **General** tab, select `Trusted` in the **Zone** field and click **Save**.
1. In the left menu, click **Network policies** ⟶ **Firewall**.
1. Click the `Allow trusted to untrusted` preset rule.
1. Navigate to the **Destination** tab and disable the `Untrusted` zone. Click **Save**.
1. Enable the `Allow trusted to untrusted` rule by selecting it and clicking **Enable** at the top of the screen.
1. In the left menu, click **Network policies** ⟶ **NAT and routing**.
1. Click the `NAT from Trusted to Untrusted` preset rule.
1. Navigate to the **Destination** tab and change the destination zone from `Untrusted` to `Trusted`. Click **Save**.
1. Enable the `NAT from Trusted to Untrusted` rule by selecting it and clicking **Enable** at the top of the screen.
 
Now you configured the gateway. 

### Configure traffic filtering rules {#traffic-rules}

We recommend using the `Block to botnets`, `Block from botnets`, and `Example block RU RKN by IP list` default policies with customized settings:

1. Click **Network policies** ⟶ **Firewall**.
1. Click the name of the preset default policy from the list above.
1. Navigate to the **Source** tab and change the source zone from `Untrusted` to `Trusted`. 
1. Navigate to the **Destination** tab and disable the `Untrusted` zone.
1. Click **Save**.
1. Enable the selected rule by selecting it and clicking **Enable** at the top of the screen.

Add more rules to enhance security:

1. Click **Network policies** ⟶ **Firewall**.
1. Add the first blocking rule:
   
   1. At the top of the screen, click **Add**.
   1. Specify the rule settings:
      
      * **Name**: `Block QUIC protocol`
      * **Action**: Deny

   1. Navigate to the **Source** tab and select `Trusted`.
   1. Click **Service**.
   1. Click **Add**.
   1. Select `Quick UDP Internet Connections`, click **Add**, and then **Close**.
   1. Click **Save**.

1. Add the second blocking rule:
   
   1. At the top of the screen, click **Add**.
   1. Specify the rule settings:

      * **Name**: `Block Windows updates`
      * **Action**: Deny
   
   1. Navigate to the **Source** tab and select `Trusted`.
   1. Click **Applications**.
   1. Click **Add** ⟶ **Add applications**.
   1. Select the `Microsoft Update` app and click **Add**.
   1. Select the `WinUpdate` app, click **Add**, and then **Close**.
   1. Click **Save**.

You can also add more traffic filtering rules. Avoid combining services and applications in the same rule. Doing so may make the rule inoperable.


## Configure subnet routing {#subnet-routing}

Create a [static route](../../vpc/concepts/routing.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to create a static route.
  1. In the list of services, select **{{ vpc-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/vpc/route-tables.svg) **Route tables**.
  1. Click **Create**.
  1. Specify the route table name Follow these naming requirements:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, specify the route table description.
  1. Select `usergate-network`.
  1. Click **Add route**.
  1. In the window that opens, specify the destination subnet prefix (`0.0.0.0`) and select `0` from the drop-down list.
  1. In the **next hop** field, specify the `usergate-firewall` internal IP address.
  1. Click **Add**.
  1. Click **Create route table**.

  Link your route table to a subnet that will use its static routes:

  1. In the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **Subnets**.
  1. Click ![image](../../_assets/options.svg) next to `usergate-subnet-{{ region-id }}-d`.
  1. In the menu that opens, select **Link route table**.
  1. In the window that opens, select your route table from the list.
  1. Click **Link**.

- CLI {#cli}

  To create a route table with [static routes](../../vpc/concepts/routing.md): 
  1. Read the `route-table create` command description:

     ```bash
     yc vpc route-table create --help
     ```

  1. Get your cloud network ID:

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

  1. Create a `usergate-network` route table:

     ```bash
     yc vpc route-table create \
       --name=test-route-table \
       --network-id=enp846vf5fus******** \
       --route destination=0.0.0.0/0,next-hop=10.129.0.24
     ```

     Where:

     * `name`: Route table name.
     * `network-id`: Route table network ID.
     * `route`: Route settings:
        * `destination`: Destination CIDR block.
        * `next-hop`: `usergate-firewall` internal IP address.

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

  Link your route table to a subnet that will use its static routes:

  1. Get a list your cloud subnets:

     ```bash
     yc vpc subnet list
     ```

     Result:
     ```text
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     |          ID          |               NAME            |      NETWORK ID      |    ROUTE TABLE ID    |       ZONE    |      RANGE      |
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     | b0c4l3v9jrgd******** | usergate-subnet-{{ region-id }}-d | enpjsdf771h0******** |                      | {{ region-id }}-d | [10.130.0.0/24] |
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     ```

  1. Link the route table to the `usergate-subnet-{{ region-id }}-d` web service-hosting subnet:

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
     zone_id: {{ region-id }}-d
     v4_cidr_blocks:
     - 192.168.0.0/24
     route_table_id: e2l5345dlgr1********
     ```

- {{ TF }} {#tf}

  To create a route table with [static routes](../../vpc/concepts/routing.md):

  1. In the configuration file, describe the parameters of resources you want to create:

     * `name`: Route table name. Use the following name format:

          {% include [name-format](../../_includes/name-format.md) %}

     * `network_id`: ID of the network to host the table.
     * `static_route`: Static route description:
        * `destination_prefix`: Destination CIDR block.
        * `next_hop_address`: gateway VM internal IP address serving as the next hop for the [allowed](../../vpc/concepts/network.md#subnet) traffic.

     Here is the configuration file example:

     ```hcl
     resource "yandex_vpc_route_table" "usergate-rt-d" {
	   name       = "<route_table_name>"
       network_id = "<network_ID>"
       static_route {
         destination_prefix = "0.0.0.0/0"
         next_hop_address   = "10.129.0.24"
       }
     }
     ```

     To add, update, or delete a route table, use the `yandex_vpc_route_table` resource indicating the network in the `netword id` field, e.g., `network_id = "${yandex_vpc_network.lab-net.id}"`.

     For more information about the `yandex_vpc_route_table` {{ TF }} resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_route_table).

  1. Make sure your configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```hcl
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```hcl
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        This will create all the resources you need in the specified folder. You can see their detailed description using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

        ```bash
        yc vpc route-table list
        ```

{% endlist %}


## Test the firewall {#test-firewall}

To test the firewall, we will create a test web service and check whether we can access it from the internet.


### Set up a test VM {#test-vm-prepare}

1. [Create](../../compute/operations/vm-create/create-linux-vm) a VM from a public Linux image in the `usergate-subnet-{{ region-id }}-d` subnet and enable the [serial console](../../compute/operations/serial-console/index.md) in its settings.
1. Connect to the VM by running the following [CLI](../../compute/operations/serial-console/connect-cli.md) command:

   ```bash
   yc compute connect-to-serial-port --instance-name <VM_name>
   ```

   Where:
   `--instance-name`: Test VM name.

1. Start the test web service:

   ```bash
   sudo python3 -m http.server 80
   ```

   The web server will listen on port 80 and return the contents of the `httpdocs` directory. 


### Set up the web server reverse proxy on your firewall {#setup-access}

1. In the UserGate admin web UI, select **Settings** from the top menu.
1. In the **Global portal** section on the left, select **Web portal**, and set up HTTP access to the gateway:
   1. Click **Add** to open the new portal dialog.
   1. Tick the **Enabled** option.
   1. In the **Name** field, specify `Test web portal`.
   1. In the **URL** field, specify `http://<UserGate_VM_IP_address>`.
   1. In the **SSL profile** field, leave the default value.
   1. In the **Certificate** field, select `CA (Default)`.
   1. Click **Save**.
1. Select **Reverse proxy servers** and add a new server:
   1. Click **Add** to open the new server dialog.
   1. In the **Name** field, specify `Local server`.
   1. In the **Server address** field, specify the test web server VM IP address, e.g., `10.129.0.24`.
   1. In the **Port field**, specify `80`.
   1. Click **Save**.
1. Select **Reverse proxy rules** and add a new rule:
   1. Click **Add** to open the new rule dialog.
   1. Tick the **Enabled** option.
   1. In the **Name** field, specify `Access to local server`.
   1. In the **Reverse proxy server** field, select `Local server`.
   1. In the **Ports** field, specify `5550`.
   1. Click **Save**.

   Now you configured access to your test web server. The firewall will forward requests on port 5550 to the test VM IP address on port 80.

### Check whether your web server is accessible from the internet {#service-access}

1. Make an HTTP request to your server by opening the following address in your browser:

   ```text
   http://<IP_address_of_UserGate_VM>:5550
   ```

   You should see the contents of your `httpdocs` folder.

1. In the top menu of the UserGate admin web UI, select **Logs and reports**.
1. In the **Logs** section on the left, select **Web access log** and find an entry about applying the `Access to local server` rule.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `usergate-firewall` and `local-service` VMs.
1. [Delete the static public IP address](../../vpc/operations/address-delete.md).
