---
title: Configuring DNS name resolution from a private {{ baremetal-full-name }} network
description: In this tutorial, you will learn how to configure DNS name resolution of cloud resources on a {{ baremetal-name }} server using an inbound DNS connection.
canonical: '{{ link-docs }}/tutorials/routing/bm-vpc-dns-forwarder'
---

# Configuring DNS name resolution from a private {{ baremetal-full-name }} network

A {{ baremetal-name }} server connected to a {{ vpc-name }} cloud network via {{ interconnect-full-name }} is outside {{ vpc-name }} and cannot directly access the cloud network's [DNS resolver](../../dns/concepts/dns-resolver.md).

To resolve domain names from [internal {{ yandex-cloud }} DNS zones](../../dns/concepts/dns-zone.md#private-zones) on a {{ baremetal-name }} server, create an [inbound DNS connection](../../dns/concepts/dns-connection.md#dns-inbound) and specify its IP address as the DNS server on your {{ baremetal-name }} server. You do not need to deploy a separate VM with a DNS forwarder.

In out example, you will configure resolving of a {{ mpg-full-name }} cluster host's FQDN from a private {{ baremetal-name }} network.

To configure DNS name resolution:

1. [Set up your infrastructure](#prepare-infrastructure).
1. [Create an inbound DNS connection](#create-inbound-endpoint).
1. [Configure DNS on the {{ baremetal-name }} server](#configure-baremetal).
1. [Check DNS name resolution](#check-dns).

If you no longer need the resources you created, [delete them](#clear-out).

## Set up your infrastructure {#prepare-infrastructure}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for renting a {{ baremetal-name }} server (see [{{ baremetal-full-name }} pricing](../pricing.md)).
* Fee for a {{ mpg-name }} cluster's resources (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)) if you are using the cluster to check DNS name resolution.

### Configure network connectivity {#configure-connectivity}

If there is no network connectivity between your private {{ baremetal-name }} subnet and {{ vpc-name }} cloud network, [configure it](./bm-vrf-and-vpc-interconnect.md) using {{ interconnect-name }}.

Make sure the virtual router announces the prefix of the {{ vpc-name }} subnet where the inbound DNS connection IP address will reside. The {{ baremetal-name }} server must have a route to this prefix.

The examples below use the following parameters:

* Private {{ baremetal-name }} subnet's CIDR: `172.16.2.0/24`.
* {{ baremetal-name }} server IP address: `172.16.2.2`.
* {{ vpc-name }} subnet CIDR: `192.168.1.0/24`.
* Inbound DNS connection's IP address: `192.168.1.200`.

### Create a {{ mpg-name }} cluster {#create-postgresql-cluster}

If you do not have a cloud resource with an FQDN in the internal DNS zone yet, create a [{{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) in the cloud network connected to the private {{ baremetal-name }} subnet for testing.

Save the FQDN of one of the cluster hosts. You will need it to check DNS name resolution.

## Create an inbound DNS connection {#create-inbound-endpoint}

[Create an inbound DNS connection](../../dns/operations/connection-inbound-create.md) in the cloud network connected to the private {{ baremetal-name }} subnet.

When creating a connection:

1. Select the cloud network connected to the virtual router.
1. Reserve an internal IP address for the connection in the subnet whose prefix is announced by the virtual router, e.g., `192.168.1.200`.
1. Wait for the inbound connection to switch its status to `AVAILABLE`.
1. Save the connection IP address. You will need it to configure the {{ baremetal-name }} server.

{% note info %}

You can only create one inbound DNS connection per cloud network. If the selected network already has such a connection, use it IP address.

{% endnote %}

## Configure DNS on the {{ baremetal-name }} server {#configure-baremetal}

In our example, we use a server running Ubuntu 24.04 and the [Netplan](https://netplan.io/) network configuration.

1. [Connect](../operations/servers/server-kvm.md) to the {{ baremetal-name }} server via its KVM console or over SSH.
1. Find out the name of the Netplan configuration file:

    ```bash
    ls /etc/netplan/
    ```

    Result:

    ```text
    50-cloud-init.yaml
    ```

1. Open the configuration file:

    ```bash
    sudo nano /etc/netplan/50-cloud-init.yaml
    ```

1. In the private network interface settings, disable using DNS servers received via DHCP and add the IP address of the inbound DNS connection:

    ```yaml
    network:
      version: 2
      ethernets:
        etx1:
          match:
            macaddress: "90:e2:ba:a2:30:de"
          dhcp4: true
          dhcp4-overrides:
            use-dns: false
          set-name: "etx1"
          nameservers:
            addresses:
              - 192.168.1.200
            search:
              - "~."
    ```

    Save the rest of the network interface settings unchanged. In the configuration, specify the following:

    * Instead of `etx1`: Name of the private server network interface.
    * Instead of `90:e2:ba:a2:30:de`: MAC address of the private network interface.
    * Instead of `192.168.1.200`: Inbound DNS connection's IP address.

    The `~.` value in the `nameservers.search` parameter routes all DNS queries through the inbound DNS connection.

1. Make sure the configuration is correct:

    ```bash
    sudo netplan try
    ```

    If there are no errors, confirm the changes.

1. Apply the configuration:

    ```bash
    sudo netplan apply
    ```

1. Make sure the private interface uses the IP address of the inbound DNS connection:

    ```bash
    resolvectl status etx1
    ```

    The output should contain the connection IP address:

    ```text
    Link 2 (etx1)
        Current DNS Server: 192.168.1.200
               DNS Servers: 192.168.1.200
                DNS Domain: ~.
    ```

{% note warning %}

Do not edit the `/etc/resolv.conf` file manually: `systemd-resolved` can overwrite your changes.

{% endnote %}

## Check DNS name resolution {#check-dns}

1. Test the accessibility of the inbound DNS connection by sending a query for the cloud resource FQDN to its IP address:

    ```bash
    dig @192.168.1.200 <cloud_resource_FQDN>
    ```

    The internal IP address of the cloud resource should appear in the `ANSWER` section.

1. Test the resolution of the same FQDN using the system DNS settings:

    ```bash
    resolvectl query <cloud_resource_FQDN>
    ```

1. If you created a {{ mpg-name }} cluster for testing, [connect to it](../../managed-postgresql/operations/connect/clients.md) from the {{ baremetal-name }} server using its FQDN.

## How to delete the resources you created {#clear-out}

To suspend your use of resources:

1. Delete the inbound DNS connection's internal IP address from the Netplan configuration on the {{ baremetal-name }} server and apply the changes.
1. [Delete the inbound DNS connection](../../dns/operations/connection-inbound-delete.md).
1. [Delete the reserved internal IP address](../../vpc/operations/private-ip-delete.md).
1. If you created a {{ mpg-name }} cluster for testing, [delete it](../../managed-postgresql/operations/cluster-delete.md).
