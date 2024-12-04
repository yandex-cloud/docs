---
title: '{{ dns-full-name }} integration with {{ compute-full-name }}'
description: In this tutorial, you will learn how {{ dns-full-name }} is connected with {{ compute-full-name }} resources.
---

# Integration with {{ compute-name }}

You can assign domain names ([FQDNs](../../compute/concepts/network.md#hostname)) to VMs as soon as you create them in {{ compute-name }}.

To add a VM to a zone when creating it, select the zone you need and set a domain name under **DNS settings for internal addresses** of **Network settings**. You can add multiple records, including in different zones. If you do not specify a zone, the VM will get a domain name in the standard zone of the subnet it will be connected to. For instructions on how to create a VM, see [{#T}](../../compute/operations/vm-create/create-linux-vm.md).

For a VM's public IP address, integration with {{ compute-name }} is currently not supported. You can add an [A record](resource-record.md#a) to a [public zone](dns-zone.md#public-zones) manually after creating a VM. Learn more about how to [create a record](../operations/resource-record-create.md).

## Automatic zone selection {#zone-selection}

If no zone is specified explicitly for a VM's additional DNS record, it will be selected automatically. For this you need to specify an FQDN ending with a period. In the management console, the period is added automatically.

A DNS record will be added to one of the [private zones](dns-zone.md#private-zones) that can be accessed from the VM's virtual network and are FQDN suffixes. The most specific private zone will be selected from among those with suitable suffixes. If there are several suitable zones with the same domain name, one of them will be selected.

> For example, in the network settings, FQDN is set to `hello.world.private.`, and the following four private DNS zones can be accessed from the virtual network:
>
> * Service zone: `.`.
> * Custom zones: `staging.`, `private.`, and `world.private.`.
>
> The `staging.` zone is out of consideration because the `staging.` domain name is not a suffix of the `hello.world.private.` FQDN.
>
> From among of the zones with suitable suffixes (`.`, `private.`, and `world.private.`), `world.private.` will be selected ans the most specific one.

## Using {{ dns-name }} for instance groups

When creating a VM group, the name specified in the [VM template](../../compute/concepts/instance-groups/instance-template.md) will apply to all the VMs in the group. As a result, the created records will have the same FQDNs but different IPs.

To generate unique names, you can use [variables](../../compute/concepts/instance-groups/variables-in-the-template.md) in the template. For example, if the record name is `web_server_{instance.index}`, you can create records with unique names of the group's VMs. If the name is `web_server_{instance.zone_id}`, you can create records common for all VMs in the same [availability zone](../../overview/concepts/geo-scope.md).

#### See also {#see-also}

* [Creating a VM](../../compute/operations/index.md)
* [Assigning a domain name to a VM with a web server](../tutorials/bind-domain-vm/index.md)
