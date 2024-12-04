

If you have your own corporate networks connected to internal [networks](../../vpc/concepts/network.md#network) in your {{ yandex-cloud }} [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) via [{{ interconnect-full-name }}](../../interconnect/index.yaml), you can integrate your corporate DNS with [{{ dns-name }}](../../dns). This will allow you to access resources and services by name, regardless of their location, both in corporate and cloud networks.

You cannot delegate DNS record management in [private zones](../../dns/concepts/dns-zone.md#private-zones) in {{ yandex-cloud }} to your DNS servers in the corporate network, because NS records are ignored for private DNS zones. To ensure domain name recognition for cloud network services and resources in private zones, configure separate DNS forwarders in your cloud subnets. _DNS forwarders_ are DNS servers that redirect requests differently depending on the name specified in the request. We recommend [CoreDNS](https://coredns.io/) or [Unbound](https://www.nlnetlabs.nl/projects/unbound/).

{% note warning %}

Some DNS forwarders map the location of zones in {{ dns-name }} to their own settings when validating responses. In this case, specify only existing {{ dns-name }} zones in the settings. For example, if records reside in shared zone `.`, configure redirects for that zone.

{% endnote %}

To set up name recognition for corporate services and resources in {{ yandex-cloud }} cloud networks:

1. [Read an integration example description](#network-desc).
1. [Set up cloud DNS](#setup-cloud-dns).
1. [Set up corporate DNS servers](#setup-on-prem-dns).
1. [Test the service](#check-dns-service).

If you no longer need the resources you created, [delete them](#clear-out).

## Integration example {#network-desc}

![DNS integration example](../../_assets/dns/dns-integration.svg "DNS integration example")

1. The corporate network consists of two [subnets](../../vpc/concepts/network.md#subnet): `172.16.1.0/24` and `172.16.2.0/24`.

1. Each subnet has one DNS server:

    * `172.16.1.5`: ns1.corp.example.net
    * `172.16.2.5`: ns2.corp.example.net
   
    These servers serve the `corp.example.net` DNS zone.

1. The {{ yandex-cloud }} cloud network also consists of two subnets:

   * `172.16.3.0/24`: `subnet3`, [availability zone](../../overview/concepts/geo-scope.md) `{{ region-id }}-d`.
   * `172.16.4.0/24`: `subnet4`, availability zone `{{ region-id }}-b`.

    These subnets host {{ yandex-cloud }} DNS servers: `172.16.3.2` and `172.16.4.2`.

    These servers serve the cloud network's [private DNS zones](../../dns/concepts/dns-zone.md#private-zones).

1. The corporate and cloud networks are interconnected so that all subnets of one network are accessible from subnets of the other network, and vice versa.

Next, you need to set up two DNS forwarders in the cloud network:

* `172.16.3.5`: forwarder1.internal
* `172.16.4.5`: forwarder2.internal

They will redirect DNS requests as follows:

* Requests to the `corp.example.net` zone via corporate DNS servers `172.16.1.5` and `172.16.2.5`.
* Other requests (to zone `.`) via internal {{ yandex-cloud }} DNS servers to the corresponding subnets: `172.16.3.2` and `172.16.4.2`.

To ensure fault tolerance for DNS forwarders, they will be placed behind the [internal network load balancer](../../network-load-balancer/concepts/nlb-types.md){{ network-load-balancer-full-name }}. All requests to DNS forwarders (both from the cloud network and from the corporate network) will pass through this load balancer.

## Getting started {#before-you-begin}

1. To install DNS forwarders in each cloud subnet, `subnet3` and `subnet4`, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) public image with the following parameters:

    * **{{ ui-key.yacloud.common.name }}**:
        * `forwarder1` for the VM in `subnet3`.
        * `forwarder2` for the VM in `subnet4`.
    * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: Select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` and specify:
        * `172.16.3.5` for `forwarder1`.
        * `172.16.4.5` for `forwarder2`.

1. To connect from the internet and check the service in `subnet4`, create another VM instance from the [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) public image, with the following parameters:

    * **{{ ui-key.yacloud.common.name }}**: `test1`.
    * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
  
1. To install software from the internet in `subnet3` and `subnet4`, [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using a network load balancer (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).

## Set up cloud DNS {#setup-cloud-dns}

1. [Set up DNS forwarders](#setup-dns-forwarders).
1. [Set up the network load balancer](#setup-cloud-balancer).
1. [Set up DHCP](#setup-cloud-dhcp).

### Set up DNS forwarders {#setup-dns-forwarders}

{% list tabs %}

- CoreDNS

  1. [Connect to the VM](../../compute/operations/vm-connect/ssh) to install a DNS forwarder via the `test1` intermediate VM.

  1. Download the current `CoreDNS` version from the [vendor's page](https://github.com/coredns/coredns/releases/latest) and install it:

      ```bash
      cd /var/tmp && wget <package_URL> -O - | tar -zxvf
      sudo mv coredns /usr/local/sbin
      ```

  1. Create a configuration file for `CoreDNS`: 
     
     * `forwarder1`:

         ```bash
         sudo mkdir /etc/coredns
         sudo tee >> /etc/coredns/Corefile <<EOF
         corp.example.net {
           forward . 172.16.1.5 172.16.2.5
         }
         . {
           forward . 172.16.3.2
           health
         }
         EOF
         ```

     * `forwarder2`:

         ```bash
         sudo mkdir /etc/coredns
         sudo tee >> /etc/coredns/Corefile <<EOF
         corp.example.net {
           forward . 172.16.1.5 172.16.2.5
         }
         . {
           forward . 172.16.4.2
           health
         }
         EOF
         ```

  1. Enable automatic startup for `CoreDNS`:

      ```bash
      sudo tee >> /etc/systemd/system/coredns.service <<EOF
      [Unit]
      Description=CoreDNS
      After=network.target

      [Service]
      User=root
      ExecStart=/usr/local/sbin/coredns -conf /etc/coredns/Corefile
      StandardOutput=append:/var/log/coredns.log
      StandardError=append:/var/log/coredns.log
      RestartSec=5
      Restart=always

      [Install]
      WantedBy=multi-user.target
      EOF
      sudo systemctl enable --now coredns
      ```

  1. Disable the DNS name resolution system service to delegate its function to the local DNS forwarder. In Ubuntu 20.04, this can be done with the commands:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

- Unbound

  1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md) of the DNS forwarder via the `test1` intermediate VM.
  1. Install the `unbound` package:

      ```bash
      sudo apt update && sudo apt install --yes unbound
      ```

  1. Set up and restart the DNS forwarder:

      {% cut "unbound.conf for forwarder1" %}
    
      ```bash
      sudo tee -a /etc/unbound/unbound.conf <<EOF
      server:
        module-config: "iterator"
        interface: 0.0.0.0
        access-control: 127.0.0.0/8   allow
        access-control: 172.16.0.0/21 allow

      forward-zone:
        name: "corp.example.net"
        forward-addr: 172.16.1.5
        forward-addr: 172.16.2.5

      forward-zone:
        name: "."
        forward-addr: 172.16.3.2
      EOF
      ```
      {% endcut %}

      {% cut "unbound.conf for forwarder2" %}

      ```bash
      sudo tee -a /etc/unbound/unbound.conf <<EOF
      server:
        module-config: "iterator"
        interface: 0.0.0.0
        access-control: 127.0.0.0/8   allow
        access-control: 172.16.0.0/21 allow

      forward-zone:
        name: "corp.example.net"
        forward-addr: 172.16.1.5
        forward-addr: 172.16.2.5

      forward-zone:
        name: "."
        forward-addr: 172.16.4.2
      EOF
      ```
      {% endcut %}

  1. Restart Unbound:

      ```bash
      sudo systemctl restart unbound
      ```

  1. Disable the DNS name resolution system service to delegate its function to the local DNS forwarder. In Ubuntu 20.04, this can be done with the commands:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

{% endlist %}

### Set up the {{ network-load-balancer-name }} network load balancer {#setup-cloud-balancer}

Create an [internal network load balancer](../../network-load-balancer/operations/internal-lb-create.md) with the following parameters:

{% note info %}

By default, UDP traffic processing is disabled for the network load balancer. To enable UDP traffic processing on the network load balancer, contact [support](../../support/overview.md). You can learn more [here](../../network-load-balancer/concepts/specifics.md#nlb-udp).

{% endnote %}

* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}**: `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_internal }}`.

* Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**:
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-subnet-id }}**: Select `subnet3` from the list.
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`.
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**: `53`.
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**: `53`.

* Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**:
  * Create a group consisting of hosts `forwarder1` and `forwarder2`.
  * Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, specify the parameters:

    {% list tabs %}

    * CoreDNS
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_http }}`.
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}**: `/health`.
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `8080`.

    * Unbound
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `53`.

    {% endlist %}

When you create a load balancer, it will automatically get an IP address from `subnet3`.

{% note info %}

The internal network load balancer will not respond to DNS requests from forwarders that make up its target group, i.e., `forwarder1` and `forwarder2`. This has to do with its implementation. For more information, see [{#T}](../../network-load-balancer/concepts/nlb-types.md).

{% endnote %}

### Set up DHCP {#setup-cloud-dhcp}

For your cloud network hosts to automatically use the corporate DNS service, specify the following in the [DHCP settings](../../vpc/concepts/dhcp-options.md) for `subnet3` and `subnet4`:

1. **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name-servers }}**: IP address that was [assigned to the load balancer](#setup-cloud-balancer).
1. (Optional) **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name }}**: `corp.example.net`.

To update the network settings on the `forwarder1`, `forwarder2`, and `test1` hosts, run the following command:

```bash
sudo netplan apply
```

Once the network settings are updated, the hosts in the cloud network will use the load balancer instead of the {{ yandex-cloud }} DNS server.

## Set up corporate DNS servers {#setup-on-prem-dns}

Configure the corporate servers so that DNS queries to the [{{ yandex-cloud }} private zones](../../dns/concepts/dns-zone.md#private-zones) private zones are forwarded to the IP address that was [assigned to the load balancer](#setup-cloud-balancer).

## Test the service {#check-dns-service}

1. Check that domain names are resolved in the `corp.example.net` private zone on cloud hosts `forwarder1`, `forwarder2`, and `test1`:

    ```bash
    host ns1.corp.example.net
    ns1.corp.example.net has address 172.16.1.5
    ```

1. Check that domain names are resolved in public zones on cloud hosts `forwarder1`, `forwarder2`, and `test1`, for example:

    ```bash
    host cisco.com
    cisco.com has address 72.163.4.185
    ...
    ```
1. Check that internal {{ yandex-cloud }} names are resolved on corporate DNS servers `ns1` and `ns2`, for example:

    ```bash
    host ns.internal
    ns.internal has address 10.130.0.2
    ```

1. To make sure that the services start up automatically, restart the `forwarder1`, `forwarder2`, and `test1` VMs and repeat the checks.

## How to delete the resources you created {#clear-out}

To stop paying for the resources:

* [Delete the VM](../../compute/operations/vm-control/vm-delete).
* [Delete the static public IP addresses](../../vpc/operations/address-delete) if you reserved them specifically for your VMs.
* [Delete the target groups](../../network-load-balancer/operations/target-group-delete.md).
* [Delete the listeners](../../network-load-balancer/operations/listener-remove.md).
* [Delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md).
* [Delete the subnets](../../vpc/operations/subnet-delete.md).
* [Delete the route table](../../vpc/operations/delete-route-table.md).
* [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
* [Delete the networks](../../vpc/operations/network-delete.md).
