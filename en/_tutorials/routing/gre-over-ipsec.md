# Configuring a secure GRE tunnel over IPsec


To enable secure communication between remote resources and data transmission via public communication channels, e.g., the internet, one uses technologies for setting up secure connections, such as the [IPsec](https://www.ietf.org/rfc/rfc2401.txt) protocol. However, IPsec has a number of significant limitations: it is only designed for IP packet transmission, does not support [multicast delivery](https://en.wikipedia.org/wiki/IP_multicast), and cannot be combined with other protocols within a single request.

To extend the IPsec features, it is handy to use the [GRE](https://en.wikipedia.org/wiki/Generic_Routing_Encapsulation) protocol in the GRE over IPsec configuration. GRE encapsulates network packets in IP packets, which enables you to transmit any traffic over IPsec.

In this example, you will create a secure GRE over IPsec tunnel between two [Cisco CSR 1000v](https://yandex.cloud/en/marketplace/products/yc/cisco-csr) virtual routers hosted in different [virtual networks](../../vpc/concepts/network.md) and [availability zones](../../overview/concepts/geo-scope.md) in {{ yandex-cloud }}.

IPsec settings are provided for NAT-T ([NAT Traversal](https://ru.wikipedia.org/wiki/NAT_traversal)) mode, since {{ yandex-cloud }} uses [NAT](https://ru.wikipedia.org/wiki/NAT), while GRE does not support using ports. This mode enables router IP address translation with NAT when using a GRE over IPsec tunnel. This makes the tunnel configuration described in our example suitable for both the cloud infrastructure in {{ yandex-cloud }} and remote resources placed behind the device providing the NAT functionality.

To configure a secure tunnel between two virtual routers:

1. [Prepare your cloud](#before-you-begin).
1. [Create an SSH key pair](#create-ssh-keys).
1. [Create folders](#create-folders).
1. [Create two VMs with a Cisco Cloud Services Router](#create-routers).
1. [Configure IPSec protocols](#ipsec-setup).
1. [Create tunnel interfaces](#create-interfaces).
1. [Configure routing](#setup-routers).
1. [Test the tunnel](#check-tunnel).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% note alert %}

If using a Cisco CSR 1000v image without a license, the router throughput is limited to 100 kbps. To remove this limit, [install a license](https://www.cisco.com/c/en/us/td/docs/routers/csr1000/software/configuration/b_CSR1000v_Configuration_Guide/b_CSR1000v_Configuration_Guide_chapter_01000.html).

{% endnote %}

The infrastructure support cost includes:

* Fee for disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using an external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).

## Create an SSH key pair {#create-ssh-keys}

{% include [vm-ssh-rsa-key](../../_includes/vm-ssh-rsa-key.md) %}

{% note warning %}

Save the private key in a secure location, as you will not be able to connect to the VM without it.

{% endnote %}

## Create folders {#create-folders}

To test tunneling between two different virtual networks, place {{ yandex-cloud }} resources in different folders. To create a new folder:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and click ![image](../../_assets/create.png) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}** at the top right.
   1. Enter the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) name: `site-a`.
   1. Add a folder description, if required.
   1. Select **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   Create a folder:
   ```bash
   yc resource-manager folder create \
   --name site-a \
   --description "Folder for site-a"
   ```

- API {#api}

   To create a folder, use the [create](../../resource-manager/api-ref/Folder/create.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/Create](../../resource-manager/api-ref/grpc/folder_service.md#Create) gRPC API call.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_resourcemanager_folder" "folder1" {
         cloud_id    = "<cloud ID>"
         name        = "site-a"
         description = "Folder for site-a"
      }
      ```

      For more information about the parameters of the `yandex_resourcemanager_folder` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_folder).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.

      1. Check the configuration using this command:

         ```
         terraform validate
         ```

         If the configuration is correct, you will get this message:

         ```
         Success! The configuration is valid.
         ```

      1. Run this command:

         ```
         terraform plan
         ```

         If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      The folder will be created in the specified cloud. You can check the new folder and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc resource-manager cloud list
      ```

{% endlist %}

Repeat the steps to create a second folder named `site-b`.

## Create two VMs with a Cisco Cloud Services Router {#create-routers}

### Create your first VM with a Cisco Cloud Services Router

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select `site-a`.
   1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select the **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}** option.
   1. Enter a name for the VM, e.g., `cisco-router-a`.
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** list, select **{{ region-id }}-a**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [Cisco CSR](/marketplace/products/yc/cisco-csr) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Choose a VM [platform](../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM:
         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
         * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the network and subnet to connect the VM to.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [previously generated](#create-ssh-keys) public key file.
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}** field, select **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   It may take a few minutes to create the VM. When the VM status changes to `RUNNING`, you can use the serial console.

{% endlist %}

### Set the host name for the router {#hostname}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your VM.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Select `cisco-router-a` from the VM list.
   1. Go to the ![image](../../_assets/compute/serial-console.svg) **{{ ui-key.yacloud.compute.instance.switch_console }}** tab and click **{{ ui-key.yacloud.compute.instance.console.connect }}**.
   1. Wait for the operating system to start up completely.
   1. To switch to privileged mode, run the following command in the serial console:

      ```bash
      enable
      ```

   1. Enter the configuration mode and set the host name for the router:

      ```bash
      conf t
      hostname cisco-router
      ```

      The router name at the beginning of the command line should change to `cisco-router`.

{% endlist %}

### Create a user with the administrative rights {#create-user}

Create a user with the administrative rights and password authentication disabled:

{% list tabs group=instructions %}

- Management console {#console}

   In the serial console, run this command:

   ```bash
   username test-user privilege 15
   ```

{% endlist %}

### Prepare a key {#split-ssh}

If your public SSH key is longer than 72 characters, split it into chunks of 72 characters each:

1. In your computer terminal, run this command:

   ```bash
   fold -bw 72 <path_to_file_with_public key>
   ```

   This will output your public SSH key split into chunks, 72 characters in each.

1. Save the key hash:

   ```bash
   ssh-keygen -E md5 -lf <path_to_file_with_public_key>
   ```


### Configure authentication using SSH keys {#enable-ssh}


{% list tabs group=instructions %}

- Management console {#console}

   1. In the serial console, enable access to the VM over SSH:

      ```bash
      conf t
      aaa new-model
         ip ssh server algorithm authentication publickey
         ip ssh pubkey-chain
      ```

   1. Create a user named `test-user` and provide your public SSH key in chunks that you split it into in the previous step:

      ```bash
         username test-user
            key-string
               <public_key_string>
               ...
               <public_key_string>
               exit
            exit
         exit
      exit
      ```

   1. Make sure that the key is added:

      ```bash
      show run | beg ip ssh
      ```
      Result:

      ```bash
      ip ssh pubkey-chain
        username test-user
         key-hash ssh-rsa <key_hash> <username_associated_with_this_key>
      !
      !
      ...
      ```

      Compare the SSH key hash on the router with the key hash on your computer.

   1. In the serial console, enter the password that enables the privileged mode:

      ```bash
      cisco-router#configure terminal
      cisco-router(config)#enable secret <password>
      ```

{% endlist %}


### Check the SSH connection to the router {#test-ssh}

1. Log in to the router via SSH by running this command in your computer terminal:

   ```bash
   ssh -i <path_to_file_with_private_key> test-user@<router_public_IP_address>
   ```

   If everything is configured correctly, you will log in to the router under `test-user`. If the connection is not established, make sure that the router is configured correctly in the serial console: the `aaa new-model` command was run, the key hashes are the same on your computer and the router, and password authorization for the test user is disabled. If still unable to locate the issue, repeat the previous steps.
1. Switch to privileged mode. Enter the `enable` command and password. If everything is configured correctly, you can configure the router.

### Create and set up a second VM with a Cisco Cloud Services Router {#test-ssh}

1. In the `site-b` folder, create a VM named `cisco-router-b` by following the above steps. Select **{{ region-id }}-b** as its availability zone.
1. Set up the VM in the same way as the `cisco-router-a` VM.

## Configure IPSec protocols {#ipsec-setup}

{% note warning %}

* The settings are the same on both VMs, except the specifically mentioned parameters.
* The setup is performed in the terminal connected to the VM over SSH in privileged mode.

{% endnote %}

1. Configure global parameters for [IKEv2](https://ru.wikipedia.org/wiki/IKE):

   ```bash
   conf t
   crypto logging ikev2
   crypto ikev2 nat keepalive 900
   crypto ikev2 dpd 10 2 periodic  
   ```

1. Configure an IKEv2 `proposal`:

   ```bash
   crypto ikev2 proposal MY_IKEV2_PROPOSAL
      encryption aes-cbc-256
      integrity sha256
      group 2
      exit
   ```

1. Configure an IKEv2 `policy`:

   ```bash
   crypto ikev2 policy MY_IKEV2_POLICY
      proposal MY_IKEV2_PROPOSAL
      exit
   ```

1. Set a secret key:

   {% list tabs %}

   - Cisco-router-a VM

      ```bash
      crypto ikev2 keyring MY_IKEV2_KEYRING
         peer SiteB
         address cisco-router-b
         pre-shared-key <secret_key>
         exit
      ```

   - Cisco-router-b VM

      ```bash
      crypto ikev2 keyring MY_IKEV2_KEYRING
         peer SiteA
         address cisco-router-a
         pre-shared-key <secret_key>
         exit
      ```

   {% endlist %}

   Where:
   * `<secret_key>`: Encryption key that is at least 16 characters long, e.g., `MySecretKey12345`. Use the same key on both VMs.

1. Create an IKEv2 profile:

   {% list tabs %}

   - Cisco-router-a VM

      ```bash
      crypto ikev2 profile MY_IKEV2_PROFILE
         match address local interface GigabitEthernet1
         match identity remote address cisco-router-b
         authentication remote pre-share
         authentication local pre-share
         keyring local MY_IKEV2_KEYRING
         lifetime 28800
         dpd 20 2 periodic
         exit
      ```

   - Cisco-router-b VM

      ```bash
      crypto ikev2 profile MY_IKEV2_PROFILE
         match address local interface GigabitEthernet1
         match identity remote address cisco-router-a
         authentication remote pre-share
         authentication local pre-share
         keyring local MY_IKEV2_KEYRING
         lifetime 28800
         dpd 20 2 periodic
         exit
      ```

   {% endlist %}

   {% note info %}

   For testing purposes, you can use the `0.0.0.0` template instead of IP addresses to provide access to any IP.
   You can also set up separate profiles for different peers.

   {% endnote %}

1. Add the IKEv2 profile to the IPsec profile:

   ```bash
   crypto ipsec transform-set ESP_AES128_SHA256 esp-aes esp-sha-hmac
      mode tunnel
      exit
   crypto ipsec profile MY_IPSEC_PROFILE
      set transform-set ESP_AES128_SHA256
      set ikev2-profile MY_IKEV2_PROFILE
      exit
   exit
   ```

## Create tunnel interfaces {#create-interfaces}

{% note warning %}

* The settings are the same on both VMs, except the specifically mentioned parameters.
* The setup is performed in the terminal connected to the VM over SSH in privileged mode.

{% endnote %}

1. Configure the GRE tunnel:

   {% list tabs %}

   - Cisco-router-a VM

      ```bash
      conf t
      int tu192
         ip address 192.168.0.1 255.255.255.0
         no ip redirects
         no ip proxy-arp
         ip mtu 1400
         ip tcp adjust-mss 1360
         tunnel source GigabitEthernet1
         tunnel destination cisco-router-b
         tunnel mode ipsec ipv4
         tunnel protection ipsec profile MY_IPSEC_PROFILE
      ```

   - Cisco-router-b VM

      ```bash
      conf t
      int tu192
         ip address 192.168.0.2 255.255.255.0
         no ip redirects
         no ip proxy-arp
         ip mtu 1400
         ip tcp adjust-mss 1360
         tunnel source GigabitEthernet1
         tunnel destination cisco-router-a
         tunnel mode ipsec ipv4
         tunnel protection ipsec profile MY_IPSEC_PROFILE
      ```

   {% endlist %}

1. Check whether the tunnel is there:

   {% list tabs %}

   -Cisco-router-a VM

      ```bash
      show crypto ikev2 sa remote cisco-router-b
      ```

   - Cisco-router-b VM

      ```bash
      show crypto ikev2 sa remote cisco-router-a
      ```

   {% endlist %}

   Result:

   ```bash
   Tunnel-id Local                 Remote                fvrf/ivrf            Status
   4         10.128.0.32/4500      51.250.***.***/4500   none/none            READY
         Encr: AES-CBC, keysize: 256, PRF: SHA256, Hash: SHA256, DH Grp:2, Auth sign: PSK, Auth verify: PSK
         Life/Active Time: 28800/23528 sec
   ```

   You can also view tunnel logs by running these commands:

   ```bash
   debug crypto ikev2
   conf t
   do sh log
   ```

## Configure routing {#setup-routers}

{% note warning %}

* The settings are the same on both VMs, except the specifically mentioned parameters.
* The setup is performed in the terminal connected to the VM over SSH in privileged mode.

{% endnote %}

1. To make sure the requests are responded to, configure a [Loopback](https://ru.wikipedia.org/wiki/Loopback) interface:

   {% list tabs %}

   - Cisco-router-a VM

      ```bash
      conf t
      int lo10
         ip address 10.1.1.1 255.255.255.255
         exit
      ```

   - Cisco-router-b VM

      ```bash
      conf t
      int lo10
         ip address 10.1.1.2 255.255.255.255
         exit
      ```

   {% endlist %}

1. To enable dynamic routing, configure the Border Gateway Protocol (BGP):

   {% list tabs %}

   - Cisco-router-a VM

      ```bash
      router bgp 65001
         bgp log-neighbor-changes
         neighbor 192.168.0.2 remote-as 65002
         address-family ipv4
            network 10.1.1.1 mask 255.255.255.255
            neighbor 192.168.0.2 activate
            exit
         exit
      exit
      ```

   - Cisco-router-b VM

      ```bash
      router bgp 65002
         bgp log-neighbor-changes
         neighbor 192.168.0.1 remote-as 65001
         address-family ipv4
            network 10.1.1.2 mask 255.255.255.255
            neighbor 192.168.0.1 activate
            exit
         exit
      exit
      ```

   {% endlist %}

## Test the GRE tunnel {#check-tunnel}

Make sure the packets are sent and returned. To check this on the `cisco-router-a` VM, run:

```bash
ping 10.1.1.2 source lo10
```

Result:

```bash
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.1.1.2, timeout is 2 seconds:
Packet sent with a source address of 10.1.1.1
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 10/10/11 ms
```

For the GRE tunnel performance diagnostics, you can also run the following commands:

```bash
show ip int brief
show ip bgp summary
show ip bgp
show ip route bgp
```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
