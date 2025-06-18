---
title: Managing VMs in a reserved instance pool
description: In this article, you will learn how to create {{ compute-full-name }} VMs in a reserved instance pool and how to attach/detach existing VMs to/from such pools.
---

# Managing VMs in a reserved instance pool

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

You can attach both newly created and existing VMs to your reserved instance pools. For more information, see [{#T}](../../concepts/reserved-pools.md).


## Creating a new VM attached to a reserved instance pool {#attach-new-vm}

To create a new VM in a reserved instance pool:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) command for creating a VM:

      ```bash
      yc compute instance create --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Create a VM in a reserved instance pool:

      ```bash
      yc compute instance create \
        --name <VM_name> \
        --zone <availability_zone_ID> \
        --reserved-instance-pool-id <pool_ID> \
        --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-id=<image_ID> \
        --ssh-key <path_to_SSH_key>
      ```

      Where:
      * `--name`: Name of the new VM. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--zone`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) for the new VM. The VM availability zone must be the same as the pool availability zone.
      * `--reserved-instance-pool-id`: ID of the [pool](../../concepts/reserved-pools.md) you are creating the VM in.

          Instead of ID, you can provide the pool's name in the `--reserved-instance-pool-name` parameter.
      * `--network-interface`: VM [network interface](../../concepts/network.md) settings:

          * `subnet-name`: Name of the [subnet](../../../vpc/concepts/network.md#subnet) in the same availability zone of the VM and the pool.
          * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, omit this parameter.
      * `--create-boot-disk`: VM boot disk settings:

          * `image-id`: VM boot disk image ID, e.g., [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts) image ID. 
      * `--ssh-key`: Path to the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys) file, e.g., `~/.ssh/id_ed25519.pub`. The VM will automatically create a user named `yc-user` for this key.

          {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

      {% cut "Result:" %}

      ```text
      done (34s)
      id: fv4fjf9qbt57********
      folder_id: b1gt6g8ht345********
      created_at: "2025-05-07T07:46:34Z"
      name: the-first-pool-vm
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv4v5k7u3g3n********
        auto_delete: true
        disk_id: fv4v5k7u3g3n********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:f9:bd:3a:5f
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.7.7
            one_to_one_nat:
              address: 158.160.***.**
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4fjf9qbt57********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      reserved_instance_pool_id: fv4k96kv52t7********
      ```

      {% endcut %}

      For more information about the `yc compute instance create` command, see the [{{ yandex-cloud }} CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call, with the pool ID in the `reservedInstancePoolId` field (for gRPC API, `reserved_instance_pool_id`).

{% endlist %}

## Attaching an existing VM to a reserved instance pool {#attach-existing-vm}

To attach an existing VM to a reserved instance pool:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) command for updating a VM:

      ```bash
      yc compute instance update --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  1. Attach the VM of your choice to the reserved instance pool:

      {% note info %}

      You cannot attach a VM to a reserved instance pool if its hardware configuration ([platform](../../concepts/vm-platforms.md), vCPU, or RAM) is different from that specified in the reserved instance pool settings.

      {% endnote %}


      ```bash
      yc compute instance update \
        --id <VM_ID> \
        --reserved-instance-pool-id <pool_ID>
      ```

      Where:
      * `--id`: VM ID.

          Instead of the ID, you can specify the VM name in the `--name` parameter.
      * `--reserved-instance-pool-id`: ID of the [pool](../../concepts/reserved-pools.md) you are attaching the VM to.

          Instead of ID, you can provide the pool's name in the `--reserved-instance-pool-name` parameter.

      {% cut "Result:" %}

      ```text
      done (2s)
      id: fhm0b28lgfp4********
      folder_id: b1gt6g8ht345********
      created_at: "2025-05-07T09:46:04Z"
      name: first-instance
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv45psom2l6o********
        auto_delete: true
        disk_id: fv45psom2l6o********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:cb:b5:9e:bf
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.7.5
            one_to_one_nat:
              address: 158.160.***.**
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4cndcunukt********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      reserved_instance_pool_id: fv48qa9iiq19********
      ```

      {% endcut %}

      For more information about the `yc compute instance update` command, see the [{{ yandex-cloud }} CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call, with the pool ID in the `reservedInstancePoolId` field (for gRPC API, `reserved_instance_pool_id`).

{% endlist %}


## Detaching a VM from a reserved instance pool {#detach-vm}

To detach a VM from a reserved instance pool, proceed as follows:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) command for updating a VM:

      ```bash
      yc compute instance update --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  1. Detach the VM of your choice from the specified reserved instance pool:

      ```bash
      yc compute instance update \
        --id <VM_ID> \
        --reserved-instance-pool-id ""
      ```

      Where:
      * `--id`: VM ID.

          Instead of the ID, you can specify the VM name in the `--name` parameter.

      {% cut "Result:" %}

      ```text
      done (5s)
      id: fv4fjf9qbt57********
      folder_id: b1gt6g8ht345********
      created_at: "2025-05-07T07:46:34Z"
      name: first-instance
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv4v5k7u3g3n********
        auto_delete: true
        disk_id: fv4v5k7u3g3n********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:f9:bd:3a:5f
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.7.7
            one_to_one_nat:
              address: 158.160.***.**
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4fjf9qbt57********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

      {% endcut %}

      For more information about the `yc compute instance update` command, see the [{{ yandex-cloud }} CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call, with an empty string in the `reservedInstancePoolId` field (for gRPC API, `reserved_instance_pool_id`).

{% endlist %}

#### See also {#see-also}

* [{#T}](./create-reserved-pool.md)
* [{#T}](./update-reserved-pool.md)
* [{#T}](../../concepts/reserved-pools.md)