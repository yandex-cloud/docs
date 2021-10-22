# Integration with {{ compute-name }}

You can immediately assign domain names to VMs when creating them in {{ compute-name }}.

To add a VM to a zone when creating it, select the desired zone and set a domain name under **Network settings**. You can connect VM interfaces to different subnets and get domain names in different zones. If you don't specify a zone, the VM will get a domain name in the standard zone of the subnet that it will be connected to. For instructions on how to create VMs, see [{#T}](../../compute/operations/vm-create/create-linux-vm.md).

For a VM with a public IP address, you can add a record [manually](../operations/resource-record-create.md) after creating the VM.

## Using {{ dns-name }} for instance groups

When assigning an FQDN to a VM instance from a group, the name specified in the [instance template](../../compute/concepts/instance-groups/instance-template.md) is used for all instances in the group: a set of records with the same names but different IPs in the values is created.

You can use [variables](../../compute/concepts/instance-groups/variables-in-the-template.md) from instance templates when creating records. For example, if you specify a record name like `web_server_{instance.index}`, you can create records with unique names of instances from a group. If you set a name like `web_server_{instance.zone_id}`, you can create records for all instances within a single availability zone.

