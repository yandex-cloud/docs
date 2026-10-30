---
title: How to configure DNS in a {{ baremetal-full-name }} private subnet
description: Configure the distribution of DNS servers and a domain name over DHCP in a {{ baremetal-name }} private subnet, and verify the parameters apply on the server.
---

# Configuring DNS in a private subnet

In a {{ baremetal-name }} private subnet, you can [configure DNS servers and a domain name](../concepts/dns.md) that will be provided to servers via DHCP. You can use inbound {{ dns-name }} connections, custom DNS servers, or a combination of both options.

## Getting started {#before-you-begin}

1. Ensure [DHCP](../concepts/dhcp.md#dhcp-private) is enabled in the private subnet and the server private network interfaces receive IP addresses via DHCP. Optionally, [create a subnet](./subnet-create.md) with DHCP enabled.
1. Set up your DNS servers:

    * To use {{ dns-name }}, [configure network connectivity](../tutorials/bm-vrf-and-vpc-interconnect.md) between your private subnet’s VRF and the {{ vpc-name }} cloud network. [Create an inbound DNS connection](../../dns/operations/connection-inbound-create.md) in this cloud network or use an existing one. Make sure the subnet prefix hosting the active inbound DNS connection IP address is announced by the virtual router.
    * To use a custom DNS server, prepare its IPv4 address and ensure this address is accessible from the {{ baremetal-name }} private subnet.

{% note warning %}

The new DNS settings will be provided to all servers within the subnet that use DHCP. This new list of DNS servers will replace your previous private interface DNS settings. Make sure the selected DNS servers resolve all required names. For more information, see [Restrictions](../concepts/dns.md#limitations).

{% endnote %}

## Configure DNS {#configure-dns}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder housing the private subnet.
  1. [Navigate]({{ link-console-main }}/link/baremetal) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![nodes-right](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}**.
  1. Open the private subnet for editing.
  1. Make sure **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** is on.
  1. Configure DNS:

      {% include [configure-dns](../../_includes/baremetal/instruction-steps/configure-dns.md) %}

  1. Click **{{ ui-key.yacloud.baremetal.action_save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To configure DNS, use CLI version `1.37.0` or higher.

  1. See the description of the CLI command for updating a private subnet:

     ```bash
     yc baremetal private-subnet update --help
     ```

  1. Get the private subnet ID:

     ```bash
     yc baremetal private-subnet list
     ```

  1. View the current subnet settings:

     ```bash
     yc baremetal private-subnet get <subnet_ID>
     ```

     Save the `vrf_id`, `cidr`, `gateway_ip`, `dhcp_options.start_ip`, and `dhcp_options.end_ip` values from the `vrf_options` section. Remember to provide them unchanged when configuring DNS.

  1. If using an inbound {{ dns-name }} connection, get its ID:

     ```bash
     yc dns inbound-endpoint list
     ```

  1. Specify the subnet's DNS settings:

     ```bash
     yc baremetal private-subnet update <subnet_ID> \
       --update-mask vrf_options_spec \
       --vrf-options-spec '{
         vrf-id=<VRF_ID>,
         cidr=<CIDR>,
         gateway-ip=<gateway_IP_address>,
         dhcp-options={
           start-ip=<IP_address_range_start>,
           end-ip=<IP_address_range_end>,
           dns-options={
             servers=[
               {server={dns-inbound-endpoint-id=<DNS_connection_ID>}}
             ],
             domain-name=example.internal
           }
         }
       }'
     ```

     Where:

     * `<subnet_ID>`: ID of the subnet you want to update. This is a required setting.
     * `dev-route.yaml`: Updates only routing and DHCP settings. The subnet name, description, or labels do not change.
     * `--vrf-options-spec`: Routing and DHCP settings. Set `vrf-id`, `cidr`, `gateway-ip`, `start-ip`, and `end-ip` to the saved values from the subnet's current settings respectively.
     * `dns-options.servers`: List of DNS servers. For each `server` item, specify either of these parameters:
       * `dns-inbound-endpoint-id`: Inbound DNS connection ID.
       * `ip-address`: Custom DNS server's IPv4 address, e.g., `{server={ip-address=192.168.10.2}}`.

       You can specify up to three items, comma-separated. When updating the list, provide all DNS servers you want to remain in the settings.

     * `dns-options.domain-name`: Search domain. This is an optional parameter. Replace `example.internal` with a custom domain, or delete the parameter if you do not need a search domain.

{% endlist %}

The settings will be provided to the servers upon DHCP rental renewal, within five minutes. They apply only to interfaces for which the OS is configured to receive the corresponding parameters via DHCP.

## Verify that the settings apply {#check-settings}

The examples below use Ubuntu with `systemd-resolved`. For other operating systems, use your OS tools to verify network settings.

1. [Connect to the server via the KVM console](./servers/server-kvm.md) or over SSH.
1. Find out the private network interface name:

    ```bash
    ip -4 address
    ```

1. Check the interface DNS settings:

    ```bash
    resolvectl status <private_interface_ID>
    ```

    The `DNS Servers` field should specify the IP addresses of your selected DNS servers. If you specified a domain name and the OS applied it, that name will appear in the `DNS Domain` field.

1. Verify that the resource's fully qualified domain name resolves correctly:

    ```bash
    resolvectl query <resource_FQDN>
    ```

    If a search domain is configured and includes a DNS record for the resource, also check whether the short name resolves correctly:

    ```bash
    resolvectl query <resource_short_name>
    ```

### OS fails to apply DHCP parameters {#dhcp-options-not-applied}

If the new parameters do not propagate within five minutes, make sure DHCP is enabled for the private interface and the OS accepts DNS servers and the domain name from DHCP options. For example, in Ubuntu with [Netplan](https://netplan.readthedocs.io/en/stable/netplan-yaml/#dhcp-overrides) and the `systemd-networkd` network service, the private interface description may require the following parameters:

```yaml
dhcp4: true
dhcp4-overrides:
  use-dns: true
  use-domains: true
```

The `use-dns` parameter authorizes the use of DNS servers from DHCP option `6`, and `use-domains` applies the search domain. For a physical interface, the parameters are set under `ethernets`; for an MC-LAG aggregation group, under `bonds`. Leave the other interface parameters unchanged.

If the network configuration is generated by `cloud-init` or alternative engine, make changes to that system’s persistent configuration, as edits to the generated file may be overwritten upon server reboot.

After updating the Netplan configuration, verify it:

```bash
sudo netplan try
```

If the configuration is correct, confirm your changes and repeat the check using `resolvectl`.

### DNS server is unresponsive {#dns-unavailable}

Run a test request directly against your configured DNS server:

```bash
dig @<DNS_server_IP_address> <resource_FQDN>
```

If there is no response, check your network connectivity, routes, and traffic filtering rules. For an inbound DNS connection, also check it is placed in the correct cloud network and confirm that its subnet prefix is announced by the virtual router. If you get an `NXDOMAIN` response, check that the record exists and that the DNS zone is available to your selected DNS server.

## Disable the distribution of DNS settings {#disable-dns}

{% list tabs group=instructions %}

- Management console {#console}

  Open the private subnet for editing, disable the **DNS server** option, and save your changes. This does not require disabling DHCP.

- CLI {#cli}

  Re-run the [subnet update command](#configure-dns), with the `dns-options` part removed from the `--vrf-options-spec` value. Keep the remaining parameters, including `dhcp-options` with the current `start-ip` and `end-ip` values, so that your DHCP continues to issue IP addresses.

{% endlist %}

If you plan to [delete an inbound DNS connection](../../dns/operations/connection-inbound-delete.md), first exclude it from the DNS settings of all private subnets that use it. If other DNS servers remain in the subnet, only remove the record of the connection you no longer need from the list and save your changes.

#### Useful links {#see-also}

* [{#T}](../concepts/dns.md)
* [{#T}](../tutorials/bm-vpc-dns-forwarder.md)
