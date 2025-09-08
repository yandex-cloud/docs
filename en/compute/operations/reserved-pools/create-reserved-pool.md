---
title: Creating a reserved instance pool
description: In this tutorial, you will learn how to create a properly configured {{ compute-full-name }} reserved instance pool in the availability zone of your choice.
---

# Creating a reserved instance pool

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

To create a [reserved instance pool](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) command for creating a reserved instance pool:

      ```bash
      yc compute reserved-instance-pool create --help
      ```
  1. Create a reserved instance pool in the default folder:

      ```bash
      yc compute reserved-instance-pool create \
        --name <pool_name> \
        --description <pool_description> \
        --zone-id <availability_zone_ID> \
        --size <pool_size> \
        --platform <platform_ID> \
        --cores <number_of_vCPUs> \
        --memory <RAM_size> \
        --gpus <number_of_GPUs> \
        --gpu-cluster-id <GPU_cluster_ID> \
        --allow-oversubscription
      ```

      Where:
      * `--name`: Name of the new pool. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--description`: Description of the new pool. This is an optional parameter.
      * `--zone-id`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) to reserve [computing resources](../../concepts/vm.md#types) in.
      * `--size`: Number of slots per pool. This is an optional parameter. The default value is `0`.
      * `--platform`: [Platform](../../concepts/vm-platforms.md) where the computing resources are reserved. This is an optional parameter. The default value is `standard-v2` (`Intel Cascade Lake`).
      * `--cores`: Number of vCPUs for VMs in the new pool. This is an optional parameter. The default value is `2`.
      * `--memory`: Amount of RAM for VMs in the new pool. This is an optional parameter. The default value is `2 GB`.
      * `--gpus`: Number of [GPUs](../../concepts/gpus.md) for VMs in the new pool. This is an optional parameter. This parameter is only available if you select a platform with [GPU support](../../concepts/gpus.md#config).
      * `--gpu-cluster-id`: GPU [cluster](../../concepts/gpus.md#gpu-clusters) ID. This is an optional parameter.
      * `--allow-oversubscription`: Parameter enabling the [oversubscription mode](../../concepts/reserved-pools.md#oversubscription) for the pool. In this mode, you can attach VMs beyond the pool capacity. This is an optional parameter. The oversubscription mode is off by default.

      Result:

      ```text
      done (8s)
      id: fv4vnl1ncbja********
      zone_id: {{ region-id }}-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: test-pool
      description: sample description
      created_at: "2025-08-12T07:58:57Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "2"
      committed_size: "2"
      slot_stats:
        total: "2"
        unavailable: "2"
      instance_stats: {}
      ```

      For more information about the `yc compute reserved-instance-pool create` command, see the [{{ yandex-cloud }} CLI reference](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/create.md).

- API {#api}

  Use the [create](../../api-ref/ReservedInstancePool/create.md) REST API method for the [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) resource or the [ReservedInstancePoolService/Create](../../api-ref/grpc/ReservedInstancePool/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](./manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)