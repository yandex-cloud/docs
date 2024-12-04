---
title: Deleting a network interface from a virtual machine
description: Follow this guide to delete a network interface from a virtual machine.
---

# Deleting a network interface from a virtual machine


A virtual machine can have one to eight [network interfaces](../../concepts/network.md) attached. You can delete network interfaces you no longer need on both stopped and running VMs.

{% note info %}

Still, you cannot delete a VM's network interface if it is the only one it has.

{% endnote %}

To delete a network interface from a virtual machine:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for deleting a network interface from a virtual machine:

      ```bash
      yc compute instance detach-network-interface --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

      Save the ID of the VM from which you want to delete a network interface.

  1. Stop the selected VM if needed by specifying its ID:

      {% note info %}

      {% include [add-network-interface-hotplug-preview-note](../../../_includes/compute/add-network-interface-hotplug-preview-note.md) %}

      {% endnote %}

      ```bash
      yc compute instance stop <VM_ID>
      ```

  1. Get a list of network interfaces for the selected VM by specifying its ID:

      ```bash
      yc compute instance get <VM_ID>
      ```

      Result:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:1a:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.17
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      Save the number (`index` field value) of the network interface you want to delete.

  1. Delete the network interface:

      ```bash
      yc compute instance detach-network-interface \
        --id <VM_ID> \
        --network-interface-index <network_interface_number>
      ```

      Where:
      * `--id`: ID of the selected VM. Instead of an ID, you can use the `--name` parameter to specify the VM name.
      * `--network-interface-index`: Previously saved number of the VM's network interface you need to delete.

      Result:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

- API {#api}

  Use the [detachNetworkInterface](../../api-ref/Instance/detachNetworkInterface.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/DetachNetworkInterface](../../api-ref/grpc/Instance/detachNetworkInterface.md) gRPC API call.

{% endlist %}