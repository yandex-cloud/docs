# Integration with {{ compute-name }}

You can immediately assign domain names to VMs when [creating](../../compute/operations/index.md) them in {{ compute-name }}:

* All VMs are assigned an [internal FQDN](../../compute/concepts/network.md#hostname) using the VM name or the `hostname` parameter.
* In the network interface settings, you can create additional DNS records for a VM. They will be placed in your own private zones. If you don't specify a zone for an additional record explicitly, it's selected automatically. For more detail, please see below.

For a VM's public IP address, integration with {{ compute-name }} is currently not supported. You can add an [A record](resource-record.md#a) to a [public zone](dns-zone.md#public-zones) manually after creating a VM. Learn more about how to [create a record](../operations/resource-record-create.md).

## Automatic zone selection {#zone-selection}

If no zone for a VM's additional DNS record is specified explicitly, it's selected automatically. To enable this, specify the VM's FQDN with a dot at the end. In the management console, the dot is added automatically.

A DNS record is added to one of the [private zones](dns-zone.md#private-zones) that are accessible from the VM's virtual network and are FQDN suffixes. The most specific private zone is selected based on the suitable suffix. If there are multiple suitable zones with the same domain name, one of them is selected.

> For example, you specified an FQDN like `hello.world.private.` in the network settings and the following four private DNS zones are accessible from the virtual network:
>
> * Service `.`.
> * Custom: `staging.` and `private.`. And `world.private.`.
>
> The `staging.` zone is not suitable, since the `staging.` domain name is not a suffix of the `hello.world.private.` FQDN.
>
> The zones that have the appropriate suffix are `.`, `private.`, and `world.private.`. As a result, `world.private.` is selected as the most specific zone.

## Using {{ dns-name}} for instance groups

When assigning an FQDN to a VM instance from a group, the name specified in the [instance template](../../compute/concepts/instance-groups/instance-template.md) is used for all instances in the group: a set of records with the same names but different IPs in the values is created.

You can use [variables](../../compute/concepts/instance-groups/variables-in-the-template.md) from instance templates when creating records. For example, if you specify a record name like `web_server_{instance.index}`, you can create records with unique names of instances from a group. If you set a name like `web_server_{instance.zone_id}`, you can create records for all instances within a single availability zone.

#### See also {#see-also}

* [Creating a VM](../../compute/operations/index.md)
