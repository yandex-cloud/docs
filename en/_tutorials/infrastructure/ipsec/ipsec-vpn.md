1. [Get your cloud ready](#before-you-begin).
1. [Set up a cloud site](#cloud-setup).
1. [Set up a remote site](#remote-setup).
1. [Test an IPsec connection and connectivity between remote and cloud resources](#ipsec-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure deployment cost for this IPsec gateways-based solution includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* Fee for a static external IP address (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


### Create an SSH keypair {#create-ssh-keys}

To connect to a [VM](../../../compute/concepts/vm.md) over SSH, you need a keypair with the public key located on the VM, and the private key kept by the user. This method is more secure than password authentication.

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

To create a keypair:

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

## Set up a cloud site {#cloud-setup}

In this step, you will reserve two static IP addresses for IPsec gateways and set up your {{ yandex-cloud }} infrastructure, including IPsec gateways, two VMs, and a network with two subnets.

### Set up a cloud network {#setup-cloud-net}

#### Reserve public IP addresses for gateways {#reserve-public-ip}

[Reserve](../../../vpc/operations/get-static-ip.md) two static [public IP addresses](../../../vpc/concepts/address.md#public-addresses) in the `{{ region-id }}-b` availability zone:

* `cloud-gw`: Main IPsec gateway address, further referred to as `<x1.x1.x1.x1>`.
* `remote-gw`: Remote IPsec gateway address, further referred to as `<x2.x2.x2.x2>`.

#### Create your cloud network with subnets {#cloud-net}

1. [Create](../../../vpc/operations/network-create.md) the `cloud-net` network with the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option disabled.
1. In the `cloud-net` network, [create subnets](../../../vpc/operations/subnet-create.md) with the following parameters:

    1. To connect the `cloud-gw` main IPsec gateway:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `ipsec-subnet`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `172.16.0.0/24`

    1. To connect the `vm-d` VM:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-d`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-d`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `172.16.1.0/24`

    1. To connect the `vm-b` VM:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-b`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `172.16.2.0/24`

#### Set up the main IPsec gateway security group {#cloud-sg}

1. In `cloud-net`, create the `cloud-net-sg` [security group](../../../vpc/operations/security-group-create.md).
1. In the `cloud-net-sg` security group, [create rules](../../../vpc/operations/security-group-add-rule.md) based on the table below:

    | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
    | --- | --- | --- | --- | --- | --- |
    | Outbound | `any`           | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Inbound | `icmp`           | `All` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Inbound | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Inbound | `ipsec-udp-500`  | `500`  | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x2.x2.x2.x2>/32` |
    | Inbound | `ipsec-udp-4500` | `4500` | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x2.x2.x2.x2>/32` |
    | Inbound | `subnet-d`       | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.1.0/24` |
    | Inbound | `subnet-b`       | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.2.0/24` |

#### Set up static routing for the main IPsec gateway {#cloud-static}

1. In the [management console]({{ link-console-main }}), navigate to the `cloud-net` network folder.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Select the `cloud-net` network.
1. Navigate to the **{{ ui-key.yacloud.vpc.network.switch_route-table }}** tab and click **{{ ui-key.yacloud.common.create }}**.
1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, specify `cloud-net-rt`.
1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.

    1. In the window that opens, specify `10.10.0.0/16` in the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field.
    1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** field, specify the gateway private IP address: `172.16.0.10`.
    1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.

1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
1. Link the `cloud-net-rt` route table to `subnet-d` and `subnet-b`:

    1. Navigate to the **{{ ui-key.yacloud.vpc.network.switch_overview }}** tab.
    1. In the `subnet-d` row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
    1. In the window that opens, select the `cloud-net-rt` route table and click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
    1. Repeat the previous two steps for `subnet-b`.

### Create and configure your cloud VMs {#setup-cloud-vms}

#### Create the main IPsec gateway VM {#create-cloud-gw}

1. On the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, type `IPsec instance` and select a public [IPsec instance](/marketplace/products/yc/ipsec-instance-ubuntu) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../../overview/concepts/geo-scope.md) where the main IPsec gateway will reside.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `ipsec-subnet`.
    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.
    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_address }}** field that appears, select the previously [reserved](#reserve-public-ip) `<x1.x1.x1.x1>` public IP address.
    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the [previously created](#cloud-sg) `cloud-net-sg` security group.
    1. Expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section:

        * In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.
        * In the input field that appears, specify `172.16.0.10`.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify `ipsec`.
    * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field:

        * Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
        * Specify the SSH key name.
        * Upload the [previously created](#create-ssh-keys) public SSH key or paste its contents into the appropriate field.
        * Click **{{ ui-key.yacloud.common.add }}**.

        This will add the SSH key to your organization user profile.

        If adding SSH keys by users to their profiles is disabled in the organization, the public SSH key will be saved only to the new VM's user profile.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `cloud-gw`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Wait until the VM status changes to `Running`.

#### Set up the main IPsec gateway {#config-cloud-gw}

To set up the gateway, use the IP addresses, username, and SSH key of the `cloud-gw` VM.

1. Connect to the VM over SSH:

    ```bash
    ssh ipsec@<x1.x1.x1.x1>
    ```

1. Change the VM date and time settings:

    ```bash
    sudo timedatectl set-timezone Europe/Moscow
    sudo timedatectl set-ntp True
    timedatectl
    ```

1. To optimize ICMP performance, disable `ICMP Redirects`:

    ```bash
	  sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
	  sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
    ```

    For more information, see the [strongSwan how-tos](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

1. Create a backup copy of the `swanctl.conf` file:

    ```bash
    sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
    ```

1. Create the main IPsec gateway configuration in the `/etc/swanctl/swanctl.conf` file:

    ```bash
    sudo nano /etc/swanctl/swanctl.conf
    ```

    In the file that opens, add the following code:

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
    * `remote_addrs`: Remote IPsec gateway public IP address (`<x2.x2.x2.x2>`).
    * `proposals`: [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). A list of ciphers the system can use to encrypt the IPsec connection control channel.
    * `esp_proposals`: [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). A list of ciphers the system can use to encrypt the transmitted data.
    * `secret`: [Pre-shared key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). The `<ipsec_password>` the system will use for IPsec handshake.

    {% note info %}

    You can add more options in `swanctl.conf` based on these [strongSwan guides](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

    For example, for faster data transfers, you can use [optimized encryption algorithms](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) in [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2) mode. However, if you use a different software from strongSwan on the remote IPsec gateway, first make sure it supports these algorithms.

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

1. Optionally, check the strongSwan logs:

    ```bash
    sudo journalctl -u strongswan --no-pager
    sudo journalctl -u strongswan -n 20
    sudo journalctl -u strongswan -f
    ```

1. Close the `cloud-gw` connection:

    ```bash
    exit
    ```


#### Create your test cloud VMs {#cloud-test-vm}

1. [Create](../../../compute/operations/vm-create/create-linux-vm.md) the `vm-d` VM with the following settings:

    * **Operating system**: [Ubuntu 22.04 LTS](/marketplace/products/yc/ipsec-instance-ubuntu)
    * **{{ ui-key.yacloud.compute.instances.create.field_zone }}**: `{{ region-id }}-d`
    * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `subnet-d`
    * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
    * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `172.16.1.5`
    * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ipsec`
    * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Public SSH key for VM access
    * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}**: `vm-d`

1. [Create](../../../compute/operations/vm-create/create-linux-vm.md) the `vm-b` VM with the following settings:

    * **Operating system**: `Ubuntu 22.04 LTS`
    * **{{ ui-key.yacloud.compute.instances.create.field_zone }}**: `{{ region-id }}-b`
    * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `subnet-b`
    * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
    * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `172.16.2.5`
    * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ipsec`
    * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Public SSH key for VM access
    * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}**: `vm-b`

## Set up a remote site {#remote-setup}

In this step, you will set up a remote data center infrastructure,. including an IPsec gateway, a VM, a network, and a subnet.

### Set up a remote network {#setup-remote-net}

#### Create a network with a subnet {#remote-net}

1. Create the `remote-net` [network](../../../vpc/operations/network-create.md) with the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option disabled.
1. In the `remote-net` network, [create a subnet](../../../vpc/operations/subnet-create.md) for the `remote-gw` IPsec gateway and `vm-1` VM with the following settings:

    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-1`
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `10.10.0.0/16`

#### Create the remote IPsec gateway security group {#remote-sg}

1. In the `remote-net` network, create the `remote-net-sg` [security group](../../../vpc/operations/security-group-create.md).
1. In the `remote-net-sg` security group, [create rules](../../../vpc/operations/security-group-add-rule.md) based on the table below:

    | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
    | --- | --- | --- | --- | --- | --- |
    | Outbound | `any`           | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Inbound | `icmp`           | `All` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Inbound | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Inbound | `ipsec-udp-500`  | `500`  | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x1.x1.x1.x1>/32` |
    | Inbound | `ipsec-udp-4500` | `4500` | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x1.x1.x1.x1>/32` |
    | Inbound | `subnet-1`       | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.10.0.0/16` |

#### Set up remote IPsec gateway static routing {#remote-static}

1. In the [management console]({{ link-console-main }}), navigate to the `remote-net` network folder.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Select the `remote-net` network.
1. Navigate to the **{{ ui-key.yacloud.vpc.network.switch_route-table }}** tab and click **{{ ui-key.yacloud.common.create }}**.
1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, specify `remote-net-rt`.
1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.

    1. In the window that opens, specify `172.16.1.0/24` in the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field.
    1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** field, specify the main IPSec gateway private IP address: `10.10.20.20`.
    1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.

1. Repeat the previous step to add the second rule with the following parameters:

    * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}**: `172.16.2.0/24`
    * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}**: `10.10.20.20`

1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
1. Associate the `remote-net-rt` route table with `subnet-1`:

    1. Navigate to the **{{ ui-key.yacloud.vpc.network.switch_overview }}** tab.
    1. In the `subnet-1` row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
    1. In the window that opens, select the `remote-net-rt` table and click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

### Create and configure VMs on the remote site {#setup-remote-vms}

#### Create a remote IPsec gateway VM {#create-remote-gw}

Create a VM you will use as a remote IPsec gateway.

1. On the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, type `IPsec instance` and select a public [IPsec instance](/marketplace/products/yc/ipsec-instance-ubuntu) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../../overview/concepts/geo-scope.md) where the remote IPsec gateway will reside.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `subnet-1`.
    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.
    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_address }}** field that appears, select the [previously reserved](#reserve-public-ip) `<x2.x2.x2.x2>` public IP address.
    1. In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the [previously created](#cloud-sg) `remote-net-sg` security group.
    1. Expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section:

        * In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.
        * In the input field that appears, specify `10.10.20.20`.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify `ipsec`.
    * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, select the SSH key that you saved in your [organization user](../../../organization/concepts/membership.md) profile when [creating](#create-cloud-gw) the main IPsec gateway VM.

        If there are no saved SSH keys in your profile, or you want to add a new key:

        * Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
        * Specify the SSH key name.
        * Upload the [previously created](#create-ssh-keys) public SSH key or paste its contents into the appropriate field.
        * Click **{{ ui-key.yacloud.common.add }}**.

        This will add the SSH key to your organization user profile.

        If adding SSH keys by users to their profiles is disabled in the organization, the public SSH key will be saved only to the new VM's user profile.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `remote-gw`. The name should meet the following requirements:

    {% include [name-format](../../../_includes/name-format.md) %}

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Wait until the VM status changes to `Running`.

#### Set up the remote IPsec gateway {#config-remote-gw}

To set up the gateway, use the IP addresses, username, and SSH key of the `remote-gw` VM.

1. Connect to the VM over SSH:

    ```bash
    ssh ipsec@<x2.x2.x2.x2>
    ```

1. Change the VM date and time settings:

    ```bash
    sudo timedatectl set-timezone Europe/Moscow
    sudo timedatectl set-ntp True
    timedatectl
    ```

1. To optimize ICMP performance, disable `ICMP Redirects`:

    ```bash
	  sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
	  sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
    ```

    For more information, see the [strongSwan how-tos](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

1. Create a backup copy of the `swanctl.conf` file:

    ```bash
    sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
    ```

1. Create the remote IPsec gateway configuration in the `/etc/swanctl/swanctl.conf` file:

    ```bash
    sudo nano /etc/swanctl/swanctl.conf
    ```

    In the file that opens, add the following code:

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
    * `remote_addrs`: Main IPsec gateway public IP address (`<x1.x1.x1.x1>`).
    * `proposals`: [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). A list of ciphers the system can use to encrypt the IPsec connection control channel.
    * `esp_proposals`: [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). A list of ciphers the system can use to encrypt the transmitted data.
    * `secret`: [Pre-shared key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). The `<ipsec_password>` the system will use for IPsec handshake.

    {% note info %}

    You can add more options in `swanctl.conf` based on these [strongSwan guides](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

    For example, for faster data transfers, you can use [optimized encryption algorithms](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) in [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2) mode. However, if you use a different software from strongSwan on the remote IPsec gateway, first make sure it supports these algorithms.

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

1. Optionally, check the strongSwan logs:

    ```bash
    sudo journalctl -u strongswan --no-pager
    sudo journalctl -u strongswan -n 20
    sudo journalctl -u strongswan -f
    ```

1. Terminate the `remote-gw` connection:

    ```bash
    exit
    ```


#### Set up a test VM on the remote site {#remote-test-vm}

[Create a test VM](../../../compute/operations/vm-create/create-linux-vm.md) with the following settings:

  * **Operating system**: `Ubuntu 22.04 LTS`
  * **{{ ui-key.yacloud.compute.instances.create.field_zone }}**: `{{ region-id }}-b`
  * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `subnet-1`
  * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
  * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `10.10.10.10`
  * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ipsec`
  * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Public SSH key for VM access
  * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}**: `vm-1`

## Test an IPsec connection and connectivity between remote and cloud resources {#ipsec-test}

### Establish an IPsec connection between the gateways and make sure it works correctly {#ipsec-bringup}

The main and remote gateways will establish an IPsec connection when one of them receives traffic directed to the other’s subnet.

{% note info %}

After you activated an IPsec connection, it may take a while for the gateways to establish a tunnel. If you test the connection with `ping` and it fails, try again in a few minutes.

{% endnote %}

To activate an IPsec connection between the gateways:

1. Send `ping` ICMP packets from `vm-1` on the remote site to `vm-d`:

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

1. Activate an IPsec connection on the cloud side by sending ICMP packets from `vm-b` to `vm-1`:

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

        If the connection status is `ESTABLISHED`, the IPsec connection is active.

    1. Close the `cloud-gw` connection:

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

        If the connection status is `ESTABLISHED`, the IPsec connection is active.

    1. Terminate the `remote-gw` connection:

        ```bash
        exit
        ```

1. Connect to `vm-d`:

    ```bash
    ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.1.5
    ```

    1. Change the VM date and time settings:

        ```bash
        sudo timedatectl set-timezone Europe/Moscow
        sudo timedatectl set-ntp True
        timedatectl
        ```

    1. Test IP connectivity between `vm-d` and `vm-1`:

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

    1. Terminate the `vm-d` connection:

        ```bash
        exit
        ```

1. Connect to `vm-b`:

    ```bash
    ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.2.5
    ```

    1. Change the VM date and time settings:

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

    1. Change the VM date and time settings:

        ```bash
        sudo timedatectl set-timezone Europe/Moscow
        sudo timedatectl set-ntp True
        timedatectl
        ```

    1. Test IP connectivity between `vm-1` and `vm-d`:

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


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the VM](../../../compute/operations/vm-control/vm-delete.md).
* [Delete the static public IP address](../../../vpc/operations/address-delete.md).
* [Delete the subnet](../../../vpc/operations/subnet-delete.md).
* [Delete the cloud network](../../../vpc/operations/network-delete.md).