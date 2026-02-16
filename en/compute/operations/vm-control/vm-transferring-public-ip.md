---
title: Reassigning a public IP address from one VM to another
description: To reassign a public IP address from one VM to another, convert the IP address to static, unassign it from the original VM, and assign it to the new one.
---

# Reassigning a public IP address from one VM to another

To reassign a public IP address from one VM to another, convert the IP address to static, unassign it from the original VM, and assign it to the new one.


## Convert the public IP address of the original VM to static

{% include [set-static-ip](../../../_includes/vpc/set-static-ip.md) %}


## Unassign the public IP address from the original VM

{% include [vm-detach-public-ip](../../../_includes/compute/vm-detach-public-ip.md) %}


## Create a new VM without a public IP address

{% list tabs group=instructions %}

- Management console {#console}

  When [creating the VM](../vm-create/create-linux-vm.md), select `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` in the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field under **{{ ui-key.yacloud.compute.instances.create.section_network }}**.

- CLI {#cli}

  When [creating a VM](../vm-create/create-linux-vm.md), exclude the `--network-interface` parameter under `nat-ip-version=ipv4`.

- {{ TF }} {#tf}

  When [creating a VM](../vm-create/create-linux-vm.md), specify `nat = false` under `network_interface`.

- API {#api}

  When [creating a VM](../vm-create/create-linux-vm.md), exclude the `primaryV4AddressSpec` section in the request body.

{% endlist %}


## Assign the IP address to the new VM

{% note info %}

If the new VM resides in a different folder, [move](../../../vpc/operations/address-move.md) the public IP address to that folder.

{% endnote %}

{% include [vm-attach-public-ip](../../../_includes/compute/vm-attach-public-ip.md) %}