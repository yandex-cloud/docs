---
title: Configuring DNS connectivity between {{ baremetal-full-name }} and {{ vpc-full-name }} to access {{ mpg-name }} via FQDN
description: Follow this guide to configure a Bind9-based DNS forwarder to resolve {{ mpg-name }} FQDNs from a private {{ baremetal-name }} segment.
canonical: '{{ link-docs }}/tutorials/routing/bm-vpc-dns-forwarder'
---

# Configuring DNS connectivity between {{ baremetal-full-name }} and {{ vpc-full-name }} to access {{ mpg-name }} via FQDN

Using fully qualified domain names (FQDNs) to connect to cloud services such as {{ mpg-full-name }} is a best practice which helps to achive infrastructure abstraction and process automation. FQDNs remain constant, while IP addresses may change when you scale, restore, or migrate services.

However, if a server in the {{ baremetal-name }} segment is connected to the cloud via {{ interconnect-full-name }}, you will have an issue resolving FQDNs of cloud services, since direct DNS queries from an external subnet get blocked.

To resolve this issue, we recommend deploying an intermediate VM in the same subnet as the {{ mpg-name }} cluster to act as a Bind9-based DNS forwarder. This server will accept DNS requests from the {{ baremetal-name }} server, forward them to {{ dns-full-name }}, and return responses to the client, ensuring correct resolution of the cloud service FQDNs.

To configure DNS connectivity:

1. [Set up your infrastructure](#prepare-infra).
1. [Configure a DNS forwarder on a VM](#configure-forwarder).
1. [Configure a DNS client on the {{ baremetal-name }} server](#configure-baremetal).
1. [Test FQDN access to the {{ mpg-name }} cluster](#check-postgresql).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Set up your infrastructure {#prepare-infra}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The solution support costs include:

* Fee for using a VM and disk (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a {{ mpg-name }} cluster (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for renting the {{ baremetal-name }} servers (see [{{ baremetal-full-name }} pricing](../../baremetal/pricing.md)).
* Fee for {{ interconnect-full-name }} resource usage (see [{{ interconnect-full-name }} pricing](../../interconnect/pricing.md)).

### Create a {{ mpg-name }} cluster {#create-postgresql-cluster}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Configure the cluster:
   * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: Specify the cluster name.
   * **{{ ui-key.yacloud.mdb.forms.section_database }}**: Specify the database name, username, and password.
   * **{{ ui-key.yacloud.mdb.forms.section_network }}**: Select the availability zones and subnets.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

   {% note info %}

   Creating a {{ mpg-name }} cluster automatically creates a private DNS zone, `{{ dns-zone }}`, where DNS records for cluster hosts are generated. Host FQDNs have the `c-<cluster_ID>-<host_number>.mdb.yandexcloud.net` format. Inside the zone, DNS records for the database are automatically created as well, e.g., `10.129.0.29` for the master and `10.130.0.15` for the replica.

   {% endnote %}

For more information on creating a cluster, see [this guide](../../managed-postgresql/operations/cluster-create.md).

### Create a VM for a DNS forwarder {#create-dns-forwarder-vm}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter the VM name.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the **Ubuntu 22.04 LTS** image.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the subnet where the {{ mpg-name }} cluster hosts are located, e.g., `10.129.0.0/24`.
   * Enter the VM internal IP address, e.g., `10.129.0.10`.
   * Make sure the availability zone matches the zone hosting the {{ mpg-name }} cluster, e.g., `ru-central1-b`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

For more information on creating a VM, see [this guide](../../compute/operations/vm-create/create-linux-vm.md).

### Rent a {{ baremetal-name }} server {#lease-baremetal-server}

1. In the [management console]({{ link-console-main }}), select the folder for the server you want to rent.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
1. Click **{{ ui-key.yacloud.baremetal.label_create-server }}**.
1. Set up the server:
   * Select the appropriate server [configuration](../../baremetal/concepts/server-configurations.md).
   * Assign or get a private IP address over DHCP, e.g., `172.16.2.2`.
1. Click **{{ ui-key.yacloud.baremetal.label_create-server }}**.

For more information on renting a server, see [this guide](../../baremetal/operations/servers/server-lease.md).

### Configure network connectivity {#configure-network-connectivity}

Configure connectivity between the {{ baremetal-name }} and {{ vpc-name }} subnets via {{ interconnect-full-name }}:

1. Create a {{ vpc-name }} network with subnets in the availability zones you need.
1. Create a {{ baremetal-name }} private subnet.
1. Configure a connection via {{ interconnect-full-name }} between the {{ baremetal-name }} subnet and the {{ vpc-name }} subnet hosting the {{ mpg-name }} cluster.

For more information on setting up network connectivity, see [this guide](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md).

The examples below use the following parameters:

* {{ baremetal-name }} subnet: `172.16.2.0/24`
* {{ baremetal-name }} server IP address: `172.16.2.2`
* {{ vpc-name }} subnet with {{ mpg-name }} hosts: `10.129.0.0/24`
* Bind9 VM IP address: `10.129.0.10`
* {{ vpc-name }} DNS resolvers: `10.129.0.2` and `10.130.0.2`

   {% note info %}

   {{ vpc-name }} DNS resolvers have addresses of the `10.X.0.2` type, where `X` is the subnet number. Each subnet in {{ vpc-name }} has its own DNS resolver available.

   {% endnote %}

### Create a security group for the DNS forwarder {#configure-sg}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}** and click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify `dns-forwarder-sg`.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the network the Bind9 VM resides in.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
      | --- | --- | --- | --- | --- | --- |
      | Inbound | `dns-udp` | `53` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.2.0/24` |
      | Inbound | `dns-tcp` | `53` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.2.0/24` |
      | Outbound | `dns-udp-forward` | `53` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.129.0.0/24` |
      | Outbound | `dns-tcp-forward` | `53` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.129.0.0/24` |
      | Outbound | `dns-udp-forward` | `53` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.130.0.0/24` |
      | Outbound | `dns-tcp-forward` | `53` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.130.0.0/24` |

      {% note info %}

      This example uses the `10.129.0.0/24` and `10.130.0.0/24` subnets hosting the `10.129.0.2` and `10.130.0.2` DNS resolvers. Replace them with the subnets of your {{ vpc-name }} subnet DNS resolvers. {{ vpc-name }} DNS resolvers have addresses of the `10.X.0.2` type, where `X` is the subnet number.

      {% endnote %}

  1. If required, add a rule for SSH access to the VM:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
      | --- | --- | --- | --- | --- | --- |
      | Ingress | `ssh` | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<administrative_subnet_CIDR>` |

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Configure a DNS forwarder on a VM {#configure-forwarder}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Install Bind9:

   ```bash
   sudo apt update
   sudo apt install -y bind9 bind9-utils dnsutils
   ```

1. Open the `/etc/bind/named.conf.options` file and specify the forwarding options:

   ```bash
   sudo nano /etc/bind/named.conf.options
   ```

   Configuration example:

   ```text
   options {
     directory "/var/cache/bind";

     recursion yes;
     allow-recursion {
       172.16.2.0/24;
       localhost;
     };
     allow-query {
       172.16.2.0/24;
       localhost;
     };

     forwarders {
       10.129.0.2;
       10.130.0.2;
     };

     dnssec-validation auto;
     listen-on { any; };
     listen-on-v6 { any; };
   };
   ```

1. Check the configuration and restart the service:

   ```bash
   sudo named-checkconf
   sudo systemctl restart bind9
   sudo systemctl enable bind9
   ```

1. Make sure the service is running:

   ```bash
   sudo systemctl status bind9 --no-pager
   ```

1. If your VM is running the `systemd-resolved` local resolver which overwrites `/etc/resolv.conf`, configure it to work with Bind9:

   ```bash
   sudo systemctl stop systemd-resolved
   sudo systemctl disable systemd-resolved
   sudo mv /etc/resolv.conf /etc/resolv.conf.backup
   ```

   Create a static `/etc/resolv.conf` file:

   ```bash
   sudo nano /etc/resolv.conf
   ```

   Add a record:

   ```text
   nameserver 127.0.0.1
   ```

1. Set up a nameserver in Ubuntu. Edit the `/run/systemd/resolve/stub-resolv.conf` file:

   ```bash
   sudo nano /run/systemd/resolve/stub-resolv.conf
   ```

   Set `nameserver` to `127.0.0.1`.

1. Test the forwarder locally:

   ```bash
   dig @127.0.0.1 NS {{ dns-zone }} +short
   ```

   The response should include the zone's DNS server addresses.

   Alternative check:

   ```bash
   dig @127.0.0.1 yandex.ru +short
   ```

   If forwarding is configured correctly, this command will return the domain's IP address.

## Configure a DNS client on the {{ baremetal-name }} server {#configure-baremetal}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the {{ baremetal-name }} server over SSH.

1. Set the Bind9 VM's IP address as the DNS server:

   ```bash
   sudo nano /etc/resolv.conf
   ```

   Here is an example:

   ```text
   nameserver 10.129.0.10
   ```

1. If `/etc/resolv.conf` is managed by a system service, set DNS persistently.

   **Option 1:** Use the `systemd-resolve` command for a specific interface:

   ```bash
   sudo systemd-resolve --interface ethXX --set-dns 10.129.0.10
   ```

   Where `ethXX` is the private network interface.

   **Option 2:** Edit the `/etc/systemd/resolved.conf` file:

   ```bash
   sudo nano /etc/systemd/resolved.conf
   ```

   Specify the following:

   ```text
   [Resolve]
   DNS=10.129.0.10
   Domains=~.
   ```

   Apply the settings:

   ```bash
   sudo systemctl restart systemd-resolved
   ```

1. Test DNS resolution:

   ```bash
   dig {{ dns-zone }} +short
   ```

   Test resolution of the {{ mpg-name }} cluster host FQDN:

   ```bash
   dig c-<cluster_ID>-<host_number>.mdb.yandexcloud.net +short
   ```

   The commands should return cluster host IP addresses from the {{ vpc-name }} subnet, e.g., `10.129.0.29` for the master and `10.130.0.15` for the replica.

## Test FQDN access to the {{ mpg-name }} cluster {#check-postgresql}

1. Install the CA certificate:

   ```bash
   mkdir -p ~/.postgresql && \
   wget "{{ crt-web-path }}" \
     --output-document ~/.postgresql/root.crt && \
   chmod 0600 ~/.postgresql/root.crt
   ```

1. Install the PostgreSQL client:

   ```bash
   sudo apt update && sudo apt install -y postgresql-client
   ```

1. Connect to the database using FQDNs:

   ```bash
   psql "host=<master_FQDN>,<replica_FQDN> port={{ port-mpg }} sslmode=verify-full dbname=<DB_name> user=<user_name> target_session_attrs=read-write"
   ```

   You can find the connection parameters for your cluster in the management console on the {{ mpg-name }} cluster page.

## Check the result {#check-result}

After you complete the setup:

1. The server in the {{ baremetal-name }} segment successfully resolves domain names in the `{{ dns-zone }}` zone.
1. {{ mpg-name }} сluster host FQDNs are resolved to {{ vpc-name }} IP addresses.
1. PostgreSQL connection is established using the FQDNs, so you do not need to manually specify IP addresses.

{% note warning %}

* Use static IP addresses for the DNS forwarder VM and the {{ baremetal-name }} server to avoid DNS resolution issues upon restart.
* Regularly check Bind9 logs to detect issues with DNS requests:

  ```bash
  sudo journalctl -u bind9 -f
  ```

* If you change the subnet hosting the {{ mpg-name }} cluster, update the DNS resolver addresses in the `forwarders` Bind9 configuration parameter.

{% endnote %}

## How to delete the resources you created {#clear-out}

To stop using resources and avoid additional costs:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM with the DNS forwarder.
1. [Delete](../../vpc/operations/security-group-delete.md) the security group created for the DNS forwarder.
1. If you no longer need the test cluster, [delete](../../managed-postgresql/operations/cluster-delete.md) the {{ mpg-name }} cluster.
1. If you used {{ interconnect-full-name }} to set up connectivity for testing purposes only, delete the associated network settings and {{ interconnect-name }} resources.
