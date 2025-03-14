

If you have your own corporate networks connected to your [{{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md#cloud) internal [networks](../../vpc/concepts/network.md#network) via [{{ interconnect-full-name }}](../../interconnect/index.yaml), you can integrate your corporate DNS with [{{ dns-name }}](../../dns). This will allow you to access resources and services by name both in corporate and cloud networks.

You cannot delegate {{ yandex-cloud }} [private zone](../../dns/concepts/dns-zone.md#private-zones) DNS record management to your corporate DNS servers, because private zone NS records are ignored. To ensure that domain names of private zone services and resources are recognized, configure separate DNS forwarders in your cloud subnets. _DNS forwarder_ is a DNS server forwarding requests that cannot be resolved locally to an external DNS server. We recommend [CoreDNS](https://coredns.io/) or [Unbound](https://www.nlnetlabs.nl/projects/unbound/).

{% note warning %}

Some DNS forwarders use their own settings to determine which DNS requests to resolve. In this case, you should specify only existing {{ dns-name }} zones in their settings. For example, you need to configure redirects for records residing in a shared `.` zone.

{% endnote %}

To set up DNS resolution for your corporate services and {{ yandex-cloud }} resources:

1. [Read an integration example description](#network-desc).
1. [Set up cloud DNS](#setup-cloud-dns).
1. [Set up your corporate DNS servers](#setup-on-prem-dns).
1. [Test the service](#check-dns-service).

If you no longer need the resources you created, [delete them](#clear-out).

## Integration solution example {#network-desc}

![DNS integration example](../../_assets/dns/dns-integration.svg "DNS integration example")

1. The corporate network consists of two [subnets](../../vpc/concepts/network.md#subnet): `172.16.1.0/24` and `172.16.2.0/24`.

1. Each subnet hosts a DNS server:

    * `172.16.1.5`: ns1.corp.example.net
    * `172.16.2.5`: ns2.corp.example.net
   
    These servers manage the `corp.example.net` DNS zone.

1. The {{ yandex-cloud }} network also consists of two subnets:

   * `172.16.3.0/24`: `subnet3` in the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
   * `172.16.4.0/24`: `subnet4` in the `{{ region-id }}-b` availability zone.

    These subnets host `172.16.3.2` and `172.16.4.2` {{ yandex-cloud }} DNS servers.

    These servers manage [private DNS zones](../../dns/concepts/dns-zone.md#private-zones) in your cloud network.

1. All corporate network subnets are accessible from the cloud network subnets, and vice versa.

Next, in your cloud network, you need to set up two DNS forwarders:

* `172.16.3.5`: forwarder1.internal
* `172.16.4.5`: forwarder2.internal

They will redirect DNS requests as follows:

* `corp.example.net` zone requests will go to the `172.16.1.5` and `172.16.2.5` corporate DNS servers.
* The rest, i.e., `.` zone requests, will go to the `172.16.3.2` and `172.16.4.2` {{ yandex-cloud }} internal DNS servers.

To ensure fault tolerance, DNS forwarders will be placed behind an [internal {{ network-load-balancer-full-name }}](../../network-load-balancer/concepts/nlb-types.md) routing DNS requests from both your cloud and your corporate network.

## Getting started {#before-you-begin}

1. To install DNS forwarders in `subnet3` and `subnet4`, [create](../../compute/operations/vm-create/create-linux-vm.md) a VM running an [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) public image with the following settings:

    * **{{ ui-key.yacloud.common.name }}**:
        * `forwarder1`: For the VM in `subnet3`.
        * `forwarder2`: For the VM in `subnet4`.
    * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
      * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: Select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` and specify:
        * `172.16.3.5` for `forwarder1`.
        * `172.16.4.5` for `forwarder2`.

1. To test the `subnet4`-hosted service from the internet, create another [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) VM with the following settings:

    * **{{ ui-key.yacloud.common.name }}**: `test1`
    * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`
      * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`
  
1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) providing internet access to `subnet3` and `subnet4`, so you can download required software on the VMs residing there.

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a dynamic or static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using a network load balancer (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).

## Set up cloud DNS {#setup-cloud-dns}

1. [Set up DNS forwarders](#setup-dns-forwarders).
1. [Set up the network load balancer](#setup-cloud-balancer).
1. [Set up DHCP](#setup-cloud-dhcp).

### Set up DNS forwarders {#setup-dns-forwarders}

{% list tabs %}

- CoreDNS

  1. [Connect to the DNS forwarder VM](../../compute/operations/vm-connect/ssh) from the `test1` VM over SSH.

  1. Download the latest `CoreDNS` version from [GitHub](https://github.com/coredns/coredns/releases/latest) and install it:

      ```bash
      cd /var/tmp && wget <package_URL> -O - | tar -zxvf
      sudo mv coredns /usr/local/sbin
      ```

  1. Create a `CoreDNS` configuration file: 
     
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

  1. Enable running `CoreDNS` at boot:

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

  1. Disable system DNS resolution to delegate it to the local DNS forwarder by running the following commands:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

- Unbound

  1. [Connect to the DNS forwarder VM](../../compute/operations/vm-connect/ssh.md) from the `test1` VM over SSH.
  1. Install the `unbound` package:

      ```bash
      sudo apt update && sudo apt install --yes unbound
      ```

  1. Configure and restart the DNS forwarder:

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

  1. Disable system DNS resolution to delegate it to the local DNS forwarder by running the following commands:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

{% endlist %}

### Set up {{ network-load-balancer-name }} {#setup-cloud-balancer}

Create an [internal network load balancer](../../network-load-balancer/operations/internal-lb-create.md) with the following settings:

{% note info %}

By default, the network load balancer does not process UDP traffic. To enable UDP traffic, contact our [support](../../support/overview.md). You can learn more [here](../../network-load-balancer/concepts/specifics.md#nlb-udp).

{% endnote %}

* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}**: `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_internal }}`

* Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**:
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-subnet-id }}**: Select `subnet3` from the list.
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**: `53`
  * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**: `53`

* Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**:
  * Create a group including `forwarder1` and `forwarder2`.
  * Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, specify the following settings:

    {% list tabs %}

    * CoreDNS
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_http }}`
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}**: `/health`
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `8080`

    * Unbound
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: `53`

    {% endlist %}

Once you create a load balancer, it will automatically receive an IP address within the `subnet3` range.

{% note info %}

The internal network load balancer will not respond to DNS requests from forwarders that make up its target group, i.e., `forwarder1` and `forwarder2`. This is due to its implementation. For more information, see [{#T}](../../network-load-balancer/concepts/nlb-types.md).

{% endnote %}

### Set up DHCP {#setup-cloud-dhcp}

To ensure that your cloud network hosts automatically use your corporate DNS service, specify the following [DHCP settings](../../vpc/concepts/dhcp-options.md) for `subnet3` and `subnet4`:

1. **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name-servers }}**: [Network load balancer](#setup-cloud-balancer) IP address.
1. **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name }}**: `corp.example.net` (optional).

Update `forwarder1`, `forwarder2`, and `test1` network settings by running the following command:

```bash
sudo netplan apply
```

Once the network settings are updated, the cloud network hosts will use the load balancer instead of the {{ yandex-cloud }} DNS server.

## Set up your corporate DNS servers {#setup-on-prem-dns}

Configure your corporate DNS servers to forward [{{ yandex-cloud }} private zone](../../dns/concepts/dns-zone.md#private-zones) DNS queries to the [load balancer](#setup-cloud-balancer) IP address.

## Test the service {#check-dns-service}

1. From `forwarder1`, `forwarder2`, and `test1` cloud hosts, check that `corp.example.net` private zone domain names are resolved:

    ```bash
    host ns1.corp.example.net
    ns1.corp.example.net has address 172.16.1.5
    ```

1. From `forwarder1`, `forwarder2`, and `test1` cloud hosts, check that public domain names are resolved:

    ```bash
    host cisco.com
    cisco.com has address 72.163.4.185
    ...
    ```
1. Check that internal {{ yandex-cloud }} domain names are resolved on your corporate DNS servers, `ns1` and `ns2`:

    ```bash
    host ns.internal
    ns.internal has address 10.130.0.2
    ```

1. To make sure the services run at boot, restart the `forwarder1`, `forwarder2`, and `test1` VMs and repeat the checks.

## How to delete the resources you created {#clear-out}

To stop paying for the resources:

* [Delete the VM](../../compute/operations/vm-control/vm-delete).
* If you reserved [static public IP addresses](../../vpc/operations/address-delete) for this tutorial, delete them.
* [Delete the target groups](../../network-load-balancer/operations/target-group-delete.md).
* [Delete the listeners](../../network-load-balancer/operations/listener-remove.md).
* [Delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md).
* [Delete the subnets](../../vpc/operations/subnet-delete.md).
* [Delete the route table](../../vpc/operations/delete-route-table.md).
* [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
* [Delete the networks](../../vpc/operations/network-delete.md).
