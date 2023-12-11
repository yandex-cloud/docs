If you have your own corporate networks connected to internal [networks](../../vpc/concepts/network.md#network) in your {{ yandex-cloud }} [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) via [{{ interconnect-full-name }}](../../interconnect/index.yaml), you can integrate your corporate DNS with [{{ dns-name }}](../../dns). This will allow you to access resources and services by name, regardless of their location, both in corporate and cloud networks.

You cannot delegate DNS record management in [private zones](../../dns/concepts/dns-zone.md#private-zones) in {{ yandex-cloud }} to your DNS servers in the corporate network, because NS records are ignored for private DNS zones. To ensure domain name recognition for cloud network services and resources in private zones, configure separate DNS forwarders in your cloud subnets. _DNS forwarders_ are DNS servers that redirect requests differently depending on the name specified in the request.

{% note info %}

As examples of such servers, we use [CoreDNS](https://coredns.io/) and [Unbound](https://www.nlnetlabs.nl/projects/unbound/). You can use any other DNS forwarder.

{% endnote %}

To set up name recognition for corporate services and resources in {{ yandex-cloud }} cloud networks:

1. [Read an integration example description](#network-desc).
1. [Set up cloud DNS](#setup-cloud-dns).
1. [Set up corporate DNS servers](#setup-on-prem-dns).
1. [Run a health check for the service](#check-dns-service).

If you no longer need the resources you created, [delete them](#clear-out).

## Integration example {#network-desc}

![DNS integration example](../../_assets/dns/dns-integration.svg "DNS integration example")

1. The corporate network consists of two [subnets](../../vpc/concepts/network.md#subnet): `172.16.1.0/24` and `172.16.2.0/24`.

1. Each subnet has one DNS server:

   * `172.16.1.5`: ns1.corp.example.net
   * `172.16.2.5`: ns2.corp.example.net

   These servers serve the `corp.example.net` DNS zone.

1. The {{ yandex-cloud }} cloud network also consists of two subnets:

   * `172.16.3.0/24`: subnet3, in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
   * `172.16.4.0/24`: subnet4, in the `{{ region-id }}-b` availability zone.

   These subnets host the {{ yandex-cloud }} DNS servers, `172.16.3.2` and `172.16.4.2`.

   These servers serve the cloud network's [private DNS zones](../../dns/concepts/dns-zone.md#private-zones).

1. The corporate and cloud networks are interconnected so that all subnets of one network are accessible from subnets of the other network, and vice versa.

Next, you need to set up two DNS forwarders in the cloud network:

* `172.16.3.5`: forwarder1.internal
* `172.16.4.5`: forwarder2.internal

They will redirect DNS requests as follows:

* Requests to the `corp.example.net` zone: Via corporate DNS servers, `172.16.1.5` and `172.16.2.5`.
* All other requests (to the `.` zone): Via internal {{ yandex-cloud }} DNS servers to the corresponding subnets, `172.16.3.2` and `172.16.4.2`.

To ensure fault tolerance for DNS forwarders, they will be placed behind the [internal network load balancer](../../network-load-balancer/concepts/nlb-types.md){{ network-load-balancer-full-name }}. All requests to DNS forwarders (both from the cloud network and from the corporate network) will pass through this load balancer.

## Getting started {#before-you-begin}

1. To install DNS forwarders in each cloud subnet (`subnet3` and `subnet4`), [create a VM](../../compute/operations/vm-create/create-linux-vm.md) from the [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) public image with the following parameters:

   * **{{ ui-key.yacloud.compute.instances.create.field_name }}**:
      * `forwarder1`: For the VM in `subnet3`.
      * `forwarder2`: For the VM in `subnet4`.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
      * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: Select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` and specify:
         * 172.16.3.5: For the `forwarder1` VM.
         * 172.16.4.5: For the `forwarder2` VM.

1. To connect from the internet and check the service in `subnet4`, create other VM instance from the [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) public image with the following parameters:

   * **{{ ui-key.yacloud.compute.instances.create.field_name }}**: `test1`.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`
      * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`

1. To be able to install software from the internet in `subnet3` and `subnet4`, set up a [NAT gateway](../../vpc/operations/create-nat-gateway.md).

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or a static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using a network load balancer (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).

## Set up cloud DNS {#setup-cloud-dns}

1. [Set up DNS forwarders](#setup-dns-forwarders).
1. [Set up the network load balancer](#setup-cloud-balancer).
1. [Set up DHCP](#setup-cloud-dhcp).

### Set up DNS forwarders {#setup-dns-forwarders}

{% list tabs %}

- CoreDNS

   1. [Connect to the VM](../../compute/operations/vm-connect/ssh) to install a DNS forwarder via the `test1` intermediate VM instance.

   1. Download the current `CoreDNS` version from the [developer page](https://github.com/coredns/coredns/releases/latest) and install it:

      ```bash
      cd /var/tmp && wget <URL пакета> -O - | tar -zxvf
      sudo mv coredns /usr/local/sbin
      ```

   1. Create the `CoreDNS` configuration file:

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

   1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md) of DNS forwarder via the `test1` intermediate VM instance.
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

* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}**: `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_internal }}`

* Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**:
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-subnet-id }}**: Select `subnet3` from the list.
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`.
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**: `53`.
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**: `53`.

* Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**:
   * Create a group with the `forwarder1` and `forwarder2` hosts.
   * Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, specify the parameters:

      {% list tabs %}

      * CoreDNS
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_http }}`
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}**: `/health`
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `8080`

      * Unbound
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `53`

      {% endlist %}

When you create a load balancer, it is automatically assigned an IP address from `subnet3`.

{% note info %}

The internal network load balancer will not respond to DNS requests from forwarders that make up its target group: `forwarder1` and `forwarder2`. This is due to its implementation. For more information, see [{#T}](../../network-load-balancer/concepts/nlb-types.md).

{% endnote %}

### Set up DHCP {#setup-cloud-dhcp}

To make sure that hosts in the cloud network automatically use the corporate DNS service, [in the DHCP settings](../../vpc/concepts/dhcp-options.md) for `subnet3` and `subnet4`, specify:

1. **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name-servers }}**: IP address that was [assigned to the load balancer](#setup-cloud-balancer).
1. (Optional) **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name }}**: `corp.example.net`.

To update the network settings on the `forwarder1`, `forwarder2`, and `test1` hosts, run the following command:

```bash
sudo netplan apply
```

Once the network settings are updated, the hosts in the cloud network will use the load balancer instead of the {{ yandex-cloud }} DNS server.

## Set up corporate DNS servers {#setup-on-prem-dns}

Configure the corporate servers so that DNS queries to the [{{ yandex-cloud }} private zones](../../dns/concepts/dns-zone.md#private-zones) are forwarded to the IP address that was [assigned to the load balancer](#setup-cloud-balancer).

## Run a health check for the service {#check-dns-service}

1. Check that on the `forwarder1`, `forwarder2`, and `test1` cloud hosts, domain names are resolved in the `corp.example.net` private zone:

   ```bash
   host ns1.corp.example.net
   ns1.corp.example.net has address 172.16.1.5
   ```

1. Check that on the `forwarder1`, `forwarder2`, and `test1` cloud hosts, domain names are resolved in public zones, for example:

   ```bash
   host cisco.com
   cisco.com has address 72.163.4.185
   ...
   ```
1. Check that on the `ns1` and `ns2` corporate DNS servers, internal {{ yandex-cloud }} names are resolved, for example:

   ```bash
   host ns.internal
   ns.internal has address 10.130.0.2
   ```

1. To make sure that the services start up automatically, restart the `forwarder1`, `forwarder2`, and `test1` VM instances and then re-run the health checks.

## How to delete the resources you created {#clear-out}

To stop paying for the resources:

* [Delete](../../compute/operations/vm-control/vm-delete) the VM.
* [Delete](../../vpc/operations/address-delete) the static public IPs if you reserved them specifically for your VMs.
* [Delete](../../network-load-balancer/operations/target-group-delete.md) the target groups.
* [Delete](../../network-load-balancer/operations/listener-remove.md) the listeners.
* [Delete](../../network-load-balancer/operations/load-balancer-delete.md) the network load balancer.
* [Delete](../../vpc/operations/subnet-delete.md) the subnets.
* [Delete](../../vpc/operations/network-delete.md) the networks.
