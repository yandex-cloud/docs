1. [Prepare your cloud](#before-you-begin).
1. [Set up a cloud site](#cloud-setup).
1. [Set up a remote site](#remote-setup).
1. [Test an IPsec connection and connectivity between remote and cloud resources](#ipsec-test).

If you no longer need the infrastructure, [delete](#clear-out) the created resources.

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure deployment cost for this solution based on IPsec gateways includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* Fee for using a static external IP address (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


### Create an SSH key pair {#create-ssh-keys}

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

## Set up a cloud site {#cloud-setup}

At this stage, you will reserve two static IP addresses for IPsec gateways and create and set up an infrastructure for your cloud site in {{ yandex-cloud }}. It will include an IPsec gateway, two VMs, a network, and two subnets.

### Create and set up a cloud network {#setup-cloud-net}

#### Reserve public IP addresses for gateways {#reserve-public-ip}

[Reserve](../../../vpc/operations/get-static-ip.md) two static [public IP addresses](../../../vpc/concepts/address.md#public-addresses) in the `{{ region-id }}-b` availability zone:

* For the main IPsec gateway named `cloud-gw`. Further on, we will refer to this address as `<x1.x1.x1.x1>`.
* For the remote IPsec gateway named `remote-gw`. Further on, we will refer to this address as `<x2.x2.x2.x2>`.

#### Create a network and subnets on the cloud site {#cloud-net}

1. [Create a network](../../../vpc/operations/network-create.md) named `cloud-net`. When creating your network, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
1. In the `cloud-net` network, [create subnets](../../../vpc/operations/subnet-create.md) with the following parameters:

   1. To connect the `cloud-gw` main IPsec gateway:
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `ipsec-subnet`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `172.16.0.0/24`

   1. To connect the `vm-a` VM:
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-a`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `172.16.1.0/24`

   1. To connect the `vm-b` VM:
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-b`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `172.16.2.0/24`

#### Create and set up a security group for the main IPsec gateway {#cloud-sg}

1. In the `cloud-net` network, [create a security group](../../../vpc/operations/security-group-create.md) named `cloud-net-sg`.
1. In the `cloud-net-sg` security group, [create rules](../../../vpc/operations/security-group-add-rule.md) based on the table below:

   | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
   | --- | --- | --- | --- | --- | --- |
   | Outgoing | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
   | Incoming | `icmp` | `All` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
   | Incoming | `ssh` | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
   | Incoming | `ipsec-udp-500` | `500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x2.x2.x2.x2>/32` |
   | Incoming | `ipsec-udp-4500` | `4500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x2.x2.x2.x2>/32` |
   | Incoming | `subnet-a` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.1.0/24` |
   | Incoming | `subnet-b` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.2.0/24` |

#### Set up static routing for the main IPsec gateway {#cloud-static}

1. In the [management console]({{ link-console-main }}), go to the folder where you created the `cloud-net` network.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Select `cloud-net`.
1. Go to the **{{ ui-key.yacloud.vpc.network.switch_route-table }}** tab and click **{{ ui-key.yacloud.common.create }}**.
1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, specify `cloud-net-rt`.
1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.

   1. In the window that opens, set `10.10.0.0/16` in the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field.
   1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** field, enter the internal IP address of the main IPSec gateway: `172.16.0.10`.
   1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.

1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
1. Link the `cloud-net-rt` route table to `subnet-a` and `subnet-b`:

   1. Go to the **{{ ui-key.yacloud.vpc.network.switch_overview }}** tab.
   1. In the line of `subnet-a`, click ![image](../../../_assets/options.svg) and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the `cloud-net-rt` route table and click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
   1. Repeat the previous two steps for `subnet-b` to link the `cloud-net-rt` route table to it.

### Create and configure VMs on the cloud site {#setup-cloud-vms}

#### Create a VM with the main IPsec gateway on the cloud site {#create-cloud-gw}

1. In the [management console]({{ link-console-main }}), go to the folder where you need to create the main IPsec gateway.
1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![image](../../../_assets/create-resource-vm.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. In the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field, specify `cloud-gw`.
1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the `{{ region-id }}-b` availability zone where the subnet to connect the main IPsec gateway to is located.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab, click **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}**, and select the [IPSec instance](/marketplace/products/yc/ipsec-instance-ubuntu) image.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `ipsec-subnet`.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_address }}** field that opens, select the `<x1.x1.x1.x1>` public IP address you previously [reserved](#reserve-public-ip).

      To ensure the IP address does not change after a restart, [convert](../../../vpc/operations/set-static-ip.md) it to static.

   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` and set `172.16.0.10` in the field that opens.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the [previously created](#cloud-sg) `cloud-net-sg` security group.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

   * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify `ipsec`.
   * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, enter the [previously created](#create-ssh-keys) public SSH key to access the VM.

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Wait for the VM status to change to `Running`.

#### Set up the main IPsec gateway {#config-cloud-gw}

To set up the gateway, use the IP addresses, username, and SSH key that you specified when creating the `cloud-gw` VM.

{% note warning %}

For strongSwan setup, we [recommend using](https://docs.strongswan.org/docs/5.9/howtos/introduction.html#_configuration_files) the [swanctl.conf](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html) file format. To learn how to set up the gateway in the legacy configuration format, see the `ipsec.conf` tab.

{% endnote %}

{% list tabs %}

- swanctl.conf

   1. Connect to the VM over SSH:

      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

   1. Set the date and time parameters for the VM:

      ```bash
      sudo timedatectl set-timezone Europe/Moscow
      sudo timedatectl set-ntp True
      timedatectl
      ```

   1. To ensure optimal ICMP performance, disable the `ICMP Redirects` feature on the IPsec gateway:

      ```bash
      sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
      sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
      ```

      For more information, see the [strongSwan documentation](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

   1. Create a backup of the `swanctl.conf` file:

      ```bash
      sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
      ```

   1. Create a configuration for the main IPsec gateway in the `/etc/swanctl/swanctl.conf` file:

      ```bash
      sudo nano /etc/swanctl/swanctl.conf
      ```

      In the file that opens, specify:

      ```bash
      connections {
        cloud-ipsec {
          local_addrs = 172.16.0.10
          remote_addrs = <x2.x2.x2.x2>
          local {
            auth = psk
          }
          remote {
            auth = psk
          }
          version = 2 # IKEv2
          mobike = no
          proposals = aes128gcm16-prfsha256-ecp256, default
          dpd_delay = 10s
          children {
            cloud-ipsec {
              # List of local IPv4 subnets
              local_ts = 172.16.1.0/24, 172.16.2.0/24

              # List of remote IPv4 subnets
              remote_ts = 10.10.0.0/16

              start_action = trap
              esp_proposals = aes128gcm16
              dpd_action = clear
            }
          }
        }
      }

      # Pre-shared key (PSK) for IPsec connection
      secrets {
        ike-cloud-ipsec {
          secret = <ipsec_password>
        }
      }
      ```

      Where:

      * `cloud-ipsec`: IPsec connection name.
      * `remote_addrs`: Public IP address of the remote IPsec gateway (`<x2.x2.x2.x2>`).
      * `proposals`: [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). A list of ciphers that can be used for encrypting the IPsec connection control channel.
      * `esp_proposals`: [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). A list of ciphers that can be used for encrypting the transmitted data.
      * `secret`: [Pre-Shared Key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). The `<ipsec_password>` key (password) to use to establish an IPsec connection.

      {% note info %}

      You can set additional parameters in the `swanctl.conf` file based on the [strongSwan documentation](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

      For example, to transfer data via an IPsec connection faster, use [optimized encryption algorithms](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) in [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2) mode. These algorithms should be supported on the remote IPsec gateway platform if it is different from strongSwan.

      {% endnote %}

   1. Upload the configuration to strongSwan:

      ```bash
      sudo swanctl --load-all
      ```

   1. Restart strongSwan:

      ```bash
      sudo systemctl restart strongswan
      ```

   1. Check the strongSwan status:

      ```bash
      sudo swanctl -L
      ```

   1. (Optional) View the strongSwan logs:

      ```bash
      sudo journalctl -u strongswan --no-pager
      sudo journalctl -u strongswan -n 20
      sudo journalctl -u strongswan -f
      ```

   1. Terminate the `cloud-gw` connection:

      ```bash
      exit
      ```

- ipsec.conf

   1. Connect to the VM over SSH:

      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

   1. Create a configuration for the main IPsec gateway in the `/etc/swanctl/ipsec.conf` file:

      ```bash
      sudo nano /etc/ipsec.conf
      ```

      In the `/etc/ipsec.conf` file that opens, specify the required parameters for the main IPsec gateway's setup:

      ```bash
      config setup
        charondebug="all"
        uniqueids=yes
        strictcrlpolicy=no

      conn cloud-to-remote-site
        authby=secret
        left=%defaultroute
        leftid=<x1.x1.x1.x1>
        leftsubnet=172.16.1.0/24
        right=<x2.x2.x2.x2>
        rightsubnet=10.10.0.0/16
        ike=aes256-sha2_256-modp1024!
        esp=aes256-sha2_256!
        keyingtries=0
        ikelifetime=1h
        lifetime=8h
        dpddelay=30
        dpdtimeout=120
        dpdaction=restart
        auto=start
      ```

      Where:

      * `conn`: Name of the connection to the remote IPsec gateway.
      * `leftid`: Public IP address of the main IPsec gateway on the {{ yandex-cloud }} side ( `<x1.x1.x1.x1>`).
      * `leftsubnet`: List of prefixes for subnets located behind the IPsec gateway on the {{ yandex-cloud }} side.
      * `right`: Public IP address of the remote IPsec gateway (`<x2.x2.x2.x2>`).
      * `rightsubnet`: List of prefixes for subnets located behind the remote IPsec gateway.
      * `ike`, `esp`: Encryption algorithms to use to set up an IPsec connection between the IPsec gateways. For the list of encryption algorithms that can be used for [IKEv2](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html) and [IKEv1](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv1CipherSuites) modes, see the strongSwan documentation. `IKEv1` mode is considered obsolete and is not recommended for use.

   1. Create a configuration for the main IPsec gateway in the `/etc/swanctl/ipsec.secrets` file:

      ```bash
      sudo nano /etc/ipsec.secrets
      ```

      In the `/etc/ipsec.secrets` configuration file that opens, specify the IP addresses of your IPsec gateways and set a password (Pre-Shared Key) for an IPsec connection to the remote gateway:

      ```bash
      <x1.x1.x1.x1> <x2.x2.x2.x2> : PSK "<ipsec_password>"
      ```

      Where:

      * `<ipsec_password>`: Key/password used by the gateways to establish an IPsec connection.
      * `<x1.x1.x1.x1>`: Public IP address of the main IPsec gateway on the {{ yandex-cloud }} side.
      * `<x2.x2.x2.x2>`: Public IP address of the remote IPsec gateway.

      You can set additional parameters in the configuration file based on the [strongSwan documentation](https://wiki.strongswan.org/projects/strongswan/wiki).

      {% cut "If you need to deploy an IPsec gateway and resources behind it in one subnet" %}

      In the IPsec gateway configuration file, add exclusive rules for the default gateway's IP address and the IPsec gateway's own (private) IP address:

      ```bash
      conn passthrough-1
        left=%defaultroute
        leftsubnet=<IP_address_of_default_subnet_gateway>
        rightsubnet=10.10.0.0/8
        type=passthrough
        auto=route
      conn passthrough-2
        left=%defaultroute
        leftsubnet=<internal_IP_address_of_IPsec_instance>
        rightsubnet=10.0.0.0/8
        type=passthrough
        auto=route
      ```

      Where:

      * `<IP_address_of_default_subnet_gateway>`: Prefix of the subnet hosting the IPsec gateway and resources behind it.
      * `<internal_IP_address_of_IPsec_instance>`: IPsec gateway's private IP address.

      The IPsec gateway will be available for diagnostics and will respond via [ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol).

      {% endcut %}


   1. Restart strongSwan:

      ```bash
      sudo systemctl restart strongswan-starter
      ```

   1. Terminate the `cloud-gw` connection:

      ```bash
      exit
      ```

{% endlist %}

#### Deploy test VMs on the cloud site {#cloud-test-vm}

1. [Create a test VM](../../../compute/operations/vm-create/create-linux-vm.md) named `vm-a` with the following parameters:

   * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}**: `vm-a`
   * **{{ ui-key.yacloud.compute.instances.create.field_zone }}**: `{{ region-id }}-a`
   * **Operating system**: [Ubuntu 22.04 LTS](/marketplace/products/yc/ipsec-instance-ubuntu)
   * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `subnet-a`
   * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
   * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `172.16.1.5`
   * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ipsec`
   * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Public SSH key for VM access

1. [Create a test VM](../../../compute/operations/vm-create/create-linux-vm.md) named `vm-b` with the following parameters:

   * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}**: `vm-b`
   * **{{ ui-key.yacloud.compute.instances.create.field_zone }}**: `{{ region-id }}-b`
   * **Operating system**: `Ubuntu 22.04 LTS`
   * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `subnet-b`
   * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
   * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `172.16.2.5`
   * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ipsec`
   * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Public SSH key for VM access

## Set up a remote site {#remote-setup}

At this stage, you will create and set up an infrastructure for a remote site of a typical corporate data center. It will include an IPsec gateway, a VM, a network, and a subnet.

### Create and set up a remote network {#setup-remote-net}

#### Create a network and subnet on the remote site {#remote-net}

1. [Create a network](../../../vpc/operations/network-create.md) named `remote-net`. When creating your network, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
1. In the `remote-net` network, [create a subnet](../../../vpc/operations/subnet-create.md) to connect the `remote-gw` remote IPsec gateway and a VM named `vm-1` with the following parameters:

   * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-1`
   * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`
   * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `10.10.0.0/16`

#### Create and set up a security group for the remote IPsec gateway {#remote-sg}

1. In the `remote-net` network, [create a security group](../../../vpc/operations/security-group-create.md) named `remote-net-sg`.
1. In the `remote-net-sg` security group, [create rules](../../../vpc/operations/security-group-add-rule.md) based on the table below:

   | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
   | --- | --- | --- | --- | --- | --- |
   | Outgoing | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
   | Incoming | `icmp` | `All` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
   | Incoming | `ssh` | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
   | Incoming | `ipsec-udp-500` | `500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x1.x1.x1.x1>/32` |
   | Incoming | `ipsec-udp-4500` | `4500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x1.x1.x1.x1>/32` |
   | Incoming | `subnet-1` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.10.0.0/16` |

#### Set up static routing for the remote IPsec gateway {#remote-static}

1. In the [management console]({{ link-console-main }}), go to the folder where you created the `remote-net` network.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Select `remote-net`.
1. Go to the **{{ ui-key.yacloud.vpc.network.switch_route-table }}** tab and click **{{ ui-key.yacloud.common.create }}**.
1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, specify `remote-net-rt`.
1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.

   1. In the window that opens, set `172.16.1.0/24` in the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field.
   1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** field, enter the internal IP address of the main IPSec gateway: `10.10.20.20`.
   1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.

1. Repeat the previous step to add a second rule with the following parameters:

   * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}**: `172.16.2.0/24`
   * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}**: `10.10.20.20`

1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
1. Link the `remote-net-rt` route table to `subnet-1`:

   1. Go to the **{{ ui-key.yacloud.vpc.network.switch_overview }}** tab.
   1. In the line of `subnet-1`, click ![image](../../../_assets/options.svg) and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the `remote-net-rt` route table and click **ui-key.yacloud.vpc.subnet.add-route-table.button_add**.

### Create and configure VMs on the remote site {#setup-remote-vms}

#### Create a VM with a remote IPsec gateway {#create-remote-gw}

Create a VM to act as a remote IPsec gateway.

1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a remote IPsec gateway.
1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![image](../../../_assets/create-resource-vm.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. In the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field, specify `remote-gw`.
1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the `{{ region-id }}-b` availability zone where the subnet to connect the remote IPsec gateway to is located.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab, click **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}**, and select the `IPSec instance` image.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `subnet-1`.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_address }}** field that opens, select the `<x2.x2.x2.x2>` public IP address that you [previously reserved](#reserve-public-ip).

      To ensure the IP address does not change after a restart, [convert](../../../vpc/operations/set-static-ip.md) it to static.

   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` and set `10.10.20.20` in the field that opens.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the [previously created](#cloud-sg) `remote-net-sg` security group.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

   * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify `ipsec`.
   * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, enter the [previously created](#create-ssh-keys) public SSH key to access the VM.

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Wait for the VM status to change to `Running`.

#### Set up the remote IPsec gateway {#config-remote-gw}

To set up the gateway, use the IP addresses, username, and SSH key that you specified when creating the `remote-gw` VM.

{% note warning %}

For strongSwan setup, we [recommend using](https://docs.strongswan.org/docs/5.9/howtos/introduction.html#_configuration_files) the [swanctl.conf](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html) file format. To learn how to set up the gateway in the legacy configuration format, see the `ipsec.conf` tab.

{% endnote %}

{% list tabs %}

- swanctl.conf

   1. Connect to the VM over SSH:

      ```bash
      ssh ipsec@<x2.x2.x2.x2>
      ```

   1. Set the date and time parameters for the VM:

      ```bash
      sudo timedatectl set-timezone Europe/Moscow
      sudo timedatectl set-ntp True
      timedatectl
      ```

   1. To ensure optimal ICMP performance, disable the `ICMP Redirects` feature on the IPsec gateway:

      ```bash
      sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
      sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
      ```

      For more information, see the [strongSwan documentation](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

   1. Create a backup of the `swanctl.conf` file:

      ```bash
      sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
      ```

   1. Create a configuration for the remote IPsec gateway in the `/etc/swanctl/swanctl.conf` file:

      ```bash
      sudo nano /etc/swanctl/swanctl.conf
      ```

      In the file that opens, specify:

      ```bash
      connections {
        cloud-ipsec {
          local_addrs = 10.10.20.20
          remote_addrs = <x1.x1.x1.x1>
          local {
            auth = psk
          }
          remote {
            auth = psk
          }
          version = 2 # IKEv2
          mobike = no
          proposals = aes128gcm16-prfsha256-ecp256, default
          dpd_delay = 10s
          children {
            cloud-ipsec {
              # List of local IPv4 subnets
              local_ts = 10.10.0.0/16

              # List of remote IPv4 subnets
              remote_ts = 172.16.1.0/24, 172.16.2.0/24

              start_action = trap
              esp_proposals = aes128gcm16
              dpd_action = clear
            }
          }
        }
      }

      # Pre-shared key (PSK) for IPsec connection
      secrets {
        ike-cloud-ipsec {
          secret = <ipsec_password>
        }
      }
      ```

      Where:

      * `cloud-ipsec`: IPsec connection name.
      * `remote_addrs`: Public IP address of the main IPsec gateway (`<x1.x1.x1.x1>` ).
      * `proposals`: [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). A list of ciphers that can be used for encrypting the IPsec connection control channel.
      * `esp_proposals`: [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). A list of ciphers that can be used for encrypting the transmitted data.
      * `secret`: [Pre-Shared Key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). The `<ipsec_password>` key (password) to use to establish an IPsec connection.

      {% note info %}

      You can set additional parameters in the `swanctl.conf` file based on the [strongSwan documentation](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

      For example, to transfer data via an IPsec connection faster, use [optimized encryption algorithms](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) in [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2) mode. These algorithms should be supported on the remote IPsec gateway platform if it is different from strongSwan.

      {% endnote %}

   1. Upload the configuration to strongSwan:

      ```bash
      sudo swanctl --load-all
      ```

   1. Restart strongSwan:

      ```bash
      sudo systemctl restart strongswan
      ```

   1. Check the strongSwan status:

      ```bash
      sudo swanctl -L
      ```

   1. (Optional) View the strongSwan logs:

      ```bash
      sudo journalctl -u strongswan --no-pager
      sudo journalctl -u strongswan -n 20
      sudo journalctl -u strongswan -f
      ```

   1. Terminate the `remote-gw` connection:

      ```bash
      exit
      ```

- ipsec.conf

   1. Connect to the VM over SSH:

      ```bash
      ssh ipsec@<x2.x2.x2.x2>
      ```

   1. Create a configuration for the remote IPsec gateway in the `/etc/swanctl/ipsec.conf` file:

      ```bash
      sudo nano /etc/ipsec.conf
      ```

      In the `/etc/ipsec.conf` file that opens, specify the required parameters for the remote IPsec gateway's setup. These parameter values will mirror the main IPsec gateway's parameter values.

      ```bash
      config setup
        charondebug="all"
        uniqueids=yes
        strictcrlpolicy=no

      conn remote-site-to-cloud
        authby=secret
        left=%defaultroute
        leftid=<x2.x2.x2.x2>
        leftsubnet=10.10.0.0/16
        right=<x1.x1.x1.x1>
        rightsubnet=172.16.1.0/24
        ike=aes256-sha2_256-modp1024!
        esp=aes256-sha2_256!
        keyingtries=0
        ikelifetime=1h
        lifetime=8h
        dpddelay=30
        dpdtimeout=120
        dpdaction=restart
        auto=start
      ```

      Where:

      * `conn`: Name of the connection to the IPsec gateway on the {{ yandex-cloud }} side.
      * `leftid`: Public IP address of the remote IPsec gateway (`<x2.x2.x2.x2>`).
      * `leftsubnet`: List of prefixes for subnets located behind the remote IPsec gateway.
      * `right`: Public IP address of the IPsec gateway on the {{ yandex-cloud }} side (`<x1.x1.x1.x1>`).
      * `rightsubnet`: List of prefixes for subnets located behind the IPsec gateway on the {{ yandex-cloud }} side.
      * `ike`, `esp`: Encryption algorithms to use to set up an IPsec connection between the IPsec gateways. For the list of encryption algorithms that can be used for [IKEv2](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html) and [IKEv1](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv1CipherSuites) modes, see the strongSwan documentation. `IKEv1` mode is considered obsolete and is not recommended for use.

   1. Create a configuration for the main IPsec gateway in the `/etc/swanctl/ipsec.secrets` file:

      ```bash
      sudo nano /etc/ipsec.secrets
      ```

      In the `/etc/ipsec.secrets` configuration file that opens, specify the IP addresses of your IPsec gateways and set a password (pre-shared key) for an IPsec connection to the main gateway:

      ```bash
      <x2.x2.x2.x2> <x1.x1.x1.x1> : PSK "<ipsec_password>"
      ```

      Where:

      * `<ipsec_password>`: Key/password used by the gateways to establish an IPsec connection.
      * `<x1.x1.x1.x1>`: Public IP address of the main IPsec gateway on the {{ yandex-cloud }} side.
      * `<x2.x2.x2.x2>`: Public IP address of the remote IPsec gateway.

   1. Restart strongSwan:

      ```bash
      sudo systemctl restart strongswan-starter
      ```

   1. Terminate the `cloud-gw` connection:

      ```bash
      exit
      ```

{% endlist %}

#### Deploy a test VM on the remote site {#remote-test-vm}

[Create a test VM](../../../compute/operations/vm-create/create-linux-vm.md) with the following parameters:

* **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}**: `vm-1`
* **{{ ui-key.yacloud.compute.instances.create.field_zone }}**: `{{ region-id }}-b`
* **Operating system**: `Ubuntu 22.04 LTS`
* **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `subnet-1`
* **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
* **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `10.10.10.10`
* **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ipsec`
* **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Public SSH key for VM access

## Test an IPsec connection and connectivity between remote and cloud resources {#ipsec-test}

### Establish an IPsec connection between the gateways and test it {#ipsec-bringup}

The IPsec gateways on the main and remote sites are set up to establish an IPsec connection between each other when one of them receives traffic aimed for the subnet on the other side of the IPsec connection (behind the other gateway).

{% note info %}

Creating a tunnel between the gateways may take some time. If, when activating an IPsec connection, the `ping` command does not return the result you are looking for, try again in a few minutes.

{% endnote %}

To activate an IPsec connection between the gateways:

1. Send a number of ICMP packets on the side of the remote site, e.g., from `vm-1` to `vm-a`, using the `ping` command:

   ```bash
   ssh -J ipsec@<x2.x2.x2.x2> ipsec@10.10.10.10 ping -c4 172.16.1.5
   ```

   Result:

   ```bash
   PING 172.16.1.5 (172.16.1.5) 56(84) bytes of data.
   64 bytes from 172.16.1.5: icmp_seq=1 ttl=58 time=4.92 ms
   64 bytes from 172.16.1.5: icmp_seq=2 ttl=58 time=4.33 ms
   64 bytes from 172.16.1.5: icmp_seq=3 ttl=58 time=4.31 ms
   64 bytes from 172.16.1.5: icmp_seq=4 ttl=58 time=4.38 ms

   --- 172.16.1.5 ping statistics ---
   4 packets transmitted, 4 received, 0% packet loss, time 3005ms
   rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
   ```

1. Activate an IPsec connection on the side of the cloud site by sending ICMP packets from `vm-b` to `vm-1`:

   ```bash
   ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.2.5 ping -c4 10.10.10.10
   ```

   Result:

   ```bash
   PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
   64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
   64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
   64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
   64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

   --- 10.10.10.10 ping statistics ---
   4 packets transmitted, 4 received, 0% packet loss, time 3005ms
   rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
   ```

### Test connectivity between the VMs {#ipsec-test-vm}

{% note warning %}

The commands to test an IPsec connection will differ depending on the strongSwan configuration file format.

{% endnote %}

{% list tabs %}

- swanctl.conf

   1. Connect to the `cloud-gw` main IPsec gateway:

      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

      1. Check the strongSwan status:

         ```bash
         sudo swanctl -L
         ```

         Result:

         ```bash
         cloud-to-remote-site: IKEv1/2, reauthentication every 3060s, no rekeying, dpd delay 30s
           local:  %any
           remote: <x2.x2.x2.x2>
           local pre-shared key authentication:
             id: <x1.x1.x1.x1>
           remote pre-shared key authentication:
             id: <x2.x2.x2.x2>
           cloud-to-remote-site: TUNNEL, rekeying every 28260s, dpd action is restart
             local:  172.16.1.0/24
             remote: 10.10.0.0/16
         cloud-ipsec: IKEv2, no reauthentication, rekeying every 14400s, dpd delay 10s
           local:  172.16.0.10
           remote: <x2.x2.x2.x2>
           local pre-shared key authentication:
           remote pre-shared key authentication:
           cloud-ipsec: TUNNEL, rekeying every 3600s, dpd action is clear
             local:  172.16.1.0/24 172.16.2.0/24
             remote: 10.10.0.0/16
         ```

      1. Check active IPsec connections:

         ```bash
         sudo swanctl -l
         ```

         Result:

         ```bash
         cloud-ipsec: #6, ESTABLISHED, IKEv2, 80e6fa659b4f6307_i* 9f63a85191df1e48_r
           local  '172.16.0.10' @ 172.16.0.10[4500]
           remote '10.10.20.20' @ <x2.x2.x2.x2>[4500]
           AES_GCM_16-128/PRF_HMAC_SHA2_256/ECP_256
           established 9716s ago, rekeying in 4107s
           cloud-ipsec: #19, reqid 1, INSTALLED, TUNNEL-in-UDP, ESP:AES_GCM_16-128
             installed 682s ago, rekeying in 2735s, expires in 3278s
             in  cf9668bb,      0 bytes,     0 packets
             out c3a00b2c,      0 bytes,     0 packets
             local  172.16.1.0/24 172.16.2.0/24
             remote 10.10.0.0/16
         ```

         If the connection status is `ESTABLISHED`, the IPsec connection is established and active.

      1. Terminate the `cloud-gw` connection:

         ```bash
         exit
         ```

   1. Connect to the `remote-gw` remote IPsec gateway:

      ```bash
      ssh ipsec@<x2.x2.x2.x2>
      ```

      1. Check the strongSwan status:

         ```bash
         sudo swanctl -L
         ```

         Result:

         ```bash
         remote-site-to-cloud: IKEv1/2, reauthentication every 3060s, no rekeying, dpd delay 30s
           local:  %any
           remote: <x1.x1.x1.x1>
           local pre-shared key authentication:
             id: <x2.x2.x2.x2>
           remote pre-shared key authentication:
             id: <x1.x1.x1.x1>
           remote-site-to-cloud: TUNNEL, rekeying every 28260s, dpd action is restart
             local:  10.10.0.0/16
             remote: 172.16.1.0/24
         cloud-ipsec: IKEv2, no reauthentication, rekeying every 14400s, dpd delay 10s
           local:  10.10.20.20
           remote: <x1.x1.x1.x1>
           local pre-shared key authentication:
           remote pre-shared key authentication:
           cloud-ipsec: TUNNEL, rekeying every 3600s, dpd action is clear
             local:  10.10.0.0/16
             remote: 172.16.1.0/24 172.16.2.0/24
         ```

      1. Check active IPsec connections:

         ```bash
         sudo swanctl -l
         ```

         Result:

         ```bash
         cloud-ipsec: #6, ESTABLISHED, IKEv2, 80e6fa659b4f6307_i 9f63a85191df1e48_r*
           local  '10.10.20.20' @ 10.10.20.20[4500]
           remote '172.16.0.10' @ <x1.x1.x1.x1>[4500]
           AES_GCM_16-128/PRF_HMAC_SHA2_256/ECP_256
           established 9833s ago, rekeying in 3346s
           cloud-ipsec: #19, reqid 1, INSTALLED, TUNNEL-in-UDP, ESP:AES_GCM_16-128
             installed 799s ago, rekeying in 2620s, expires in 3161s
             in  c3a00b2c,      0 bytes,     0 packets
             out cf9668bb,      0 bytes,     0 packets
             local  10.10.0.0/16
             remote 172.16.1.0/24 172.16.2.0/24
         ```

         If the connection status is `ESTABLISHED`, the IPsec connection is established and active.

      1. Terminate the `remote-gw` connection:

         ```bash
         exit
         ```

   1. Connect to `vm-a`:

      ```bash
      ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.1.5
      ```

      1. Set the date and time parameters for the VM:

         ```bash
         sudo timedatectl set-timezone Europe/Moscow
         sudo timedatectl set-ntp True
         timedatectl
         ```

      1. Test IP connectivity between `vm-a` and `vm-1`:

         ```bash
         ping -c4 10.10.10.10
         ```

         Result:

         ```bash
         PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
         64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
         64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
         64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
         64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

         --- 10.10.10.10 ping statistics ---
         4 packets transmitted, 4 received, 0% packet loss, time 3005ms
         rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
         ```

      1. Terminate the `vm-a` connection:

         ```bash
         exit
         ```

   1. Connect to `vm-b`:

      ```bash
      ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.2.5
      ```

      1. Set the date and time parameters for the VM:

         ```bash
         sudo timedatectl set-timezone Europe/Moscow
         sudo timedatectl set-ntp True
         timedatectl
         ```

      1. Test IP connectivity between `vm-b` and `vm-1`:

         ```bash
         ping -c4 10.10.10.10
         ```

         Result:

         ```bash
         PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
         64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
         64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
         64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
         64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

         --- 10.10.10.10 ping statistics ---
         4 packets transmitted, 4 received, 0% packet loss, time 3005ms
         rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
         ```

      1. Terminate the `vm-b` connection:

         ```bash
         exit
         ```

   1. Connect to `vm-1`:

      ```bash
      ssh -J ipsec@<x2.x2.x2.x2> ipsec@10.10.10.10
      ```

      1. Set the date and time parameters for the VM:

         ```bash
         sudo timedatectl set-timezone Europe/Moscow
         sudo timedatectl set-ntp True
         timedatectl
         ```

      1. Test IP connectivity between `vm-1` and `vm-a`:

         ```bash
         ping -c4 172.16.1.5
         ```

         Result:

         ```bash
         PING 172.16.1.5 (172.16.1.5) 56(84) bytes of data.
         64 bytes from 172.16.1.5: icmp_seq=1 ttl=58 time=4.92 ms
         64 bytes from 172.16.1.5: icmp_seq=2 ttl=58 time=4.33 ms
         64 bytes from 172.16.1.5: icmp_seq=3 ttl=58 time=4.31 ms
         64 bytes from 172.16.1.5: icmp_seq=4 ttl=58 time=4.38 ms

         --- 172.16.1.5 ping statistics ---
         4 packets transmitted, 4 received, 0% packet loss, time 3005ms
         rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
         ```

      1. Test IP connectivity between `vm-1` and `vm-b`:

         ```bash
         ping -c4 172.16.2.5
         ```

         Result:

         ```bash
         PING 172.16.2.5 (172.16.2.5) 56(84) bytes of data.
         64 bytes from 172.16.2.5: icmp_seq=1 ttl=58 time=4.92 ms
         64 bytes from 172.16.2.5: icmp_seq=2 ttl=58 time=4.33 ms
         64 bytes from 172.16.2.5: icmp_seq=3 ttl=58 time=4.31 ms
         64 bytes from 172.16.2.5: icmp_seq=4 ttl=58 time=4.38 ms

         --- 172.16.2.5 ping statistics ---
         4 packets transmitted, 4 received, 0% packet loss, time 3005ms
         rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
         ```

      1. Terminate the `vm-1` connection:

         ```bash
         exit
         ```

- ipsec.conf

   1. Connect to the `cloud-gw` main IPsec gateway:

      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

   1. Make sure the connection between the gateways has been established:

      ```bash
      sudo ipsec status
      ```

      Result:

      ```bash
      Routed Connections:
      cloud-ipsec{2}:  ROUTED, TUNNEL, reqid 1
      cloud-ipsec{2}:   172.16.1.0/24 172.16.2.0/24 === 10.10.0.0/16
      Security Associations (1 up, 0 connecting):
      cloud-ipsec[6]: ESTABLISHED 2 hours ago, 172.16.0.10[172.16.0.10]...<x2.x2.x2.x2>[10.10.20.20]
      cloud-ipsec{19}:  INSTALLED, TUNNEL, reqid 1, ESP in UDP SPIs: cf9668bb_i c3a00b2c_o
      cloud-ipsec{19}:   172.16.1.0/24 172.16.2.0/24 === 10.10.0.0/16
      ```

      The `ESTABLISHED` status means that a tunnel between gateways was created.

   1. Check the strongSwan daemon status:

      ```bash
      systemctl status strongswan-starter
      ```

      Result:

      ```bash
      ● strongswan-starter.service - strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf
          Loaded: loaded (/lib/systemd/system/strongswan-starter.service; enabled; vendor preset: enabled)
          Active: active (running) since Sun 2023-05-28 21:54:02 MSK; 1h ago
        Main PID: 738 (starter)
            Tasks: 18 (limit: 1028)
          Memory: 8.1M
              CPU: 8.246s
          CGroup: /system.slice/strongswan-starter.service
                  ├─738 /usr/lib/ipsec/starter --daemon charon --nofork
                  └─798 /usr/lib/ipsec/charon
      ```

   1. In addition, you can get detailed information about IPsec connections and strongSwan performance:

      ```bash
      journalctl -u strongswan-starter
      ```

   1. Terminate the connection to the `cloud-gw` main IPsec gateway:

      ```bash
      exit
      ```

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [{#T}](../../../compute/operations/vm-control/vm-delete.md)
* [{#T}](../../../vpc/operations/address-delete.md)
* [{#T}](../../../vpc/operations/subnet-delete.md)
* [{#T}](../../../vpc/operations/network-delete.md)