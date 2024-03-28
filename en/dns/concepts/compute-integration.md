---
title: "Integrating {{ dns-full-name }} with {{ compute-full-name }}"
description: "In this tutorial, you will learn how {{ dns-full-name }} is related to {{ compute-full-name }} resources."
---

# Integration with {{ compute-name }}

You can assign domain names ([FQDNs](../../compute/concepts/network.md#hostname)) to VMs as soon as you create them in {{ compute-name }}.

To add a VM to a zone when creating it, select the zone you need and set a domain name under **DNS settings for internal addresses** of **Network settings**. You can add multiple records, including in different zones. If you do not specify a zone, the VM will get a domain name in the standard zone of the subnet it will be connected to. For instructions on how to create VMs, see [{#T}](../../compute/operations/vm-create/create-linux-vm.md).

For a VM's public IP address, integration with {{ compute-name }} is currently not supported. You can add an [A record](resource-record.md#a) to a [public zone](dns-zone.md#public-zones) manually after creating a VM. Learn more about how to [create a record](../operations/resource-record-create.md).

## Automatic zone selection {#zone-selection}

If no zone is specified explicitly for a VM's additional DNS record, it will be selected automatically. To enable this, specify an FQDN with a dot at the end. In the management console, the dot is added automatically.

A DNS record is added to one of the [private zones](dns-zone.md#private-zones) that are accessible from the VM's virtual network and are FQDN suffixes. The most specific private zone is selected based on the suitable suffix. If there are multiple suitable zones with the same domain name, one of them is selected.

> For example, you specified an FQDN like `hello.world.private.` in the network settings and the following four private DNS zones are accessible from the virtual network:
>
> * Service `.`.
> * Custom: `staging.` and `private.`. And `world.private.`.
>
> The `staging.` zone is not suitable, since the `staging.` domain name is not a suffix of the `hello.world.private.` FQDN.
>
> The zones that have the appropriate suffix are `.`, `private.`, and `world.private.`. As a result, `world.private.` is selected as the most specific zone.

## Using {{ dns-name }} for instance groups

When creating a VM group, the name specified in the [VM template](../../compute/concepts/instance-groups/instance-template.md) will apply to all the VMs in the group. As a result, the created records will have the same FQDNs but different IPs.

To generate unique names, you can use [variables](../../compute/concepts/instance-groups/variables-in-the-template.md) in the template. For example, if you specify a record name like `web_server_{instance.index}`, you can create records with unique names of instances from a group. If you set a name like `web_server_{instance.zone_id}`, you can create records for all instances within a single availability zone.

#### See also {#see-also}

* [Creating a VM](../../compute/operations/index.md)
* [Assigning a domain name to a VM with a web server](../tutorials/bind-domain-vm.md)
