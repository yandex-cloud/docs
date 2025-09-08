---
title: Updating a reserved instance pool
description: In this tutorial, you will learn how to update a {{ compute-full-name }} reserved instance pool.
---

# Updating a reserved instance pool

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

To update a [reserved instance pool](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) command for updating a reserved instance pool:

      ```bash
      yc compute reserved-instance-pool update --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Get detailed information about a reserved instance pool in the default folder by specifying pool name or ID:

      ```bash
      yc compute reserved-instance-pool get <pool_name_or_ID>
      ```

      Result:

      ```text
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
        used: "1"
        available: "1"
      instance_stats:
        total: "1"
      ```
  1. Update a reserved instance pool in the default folder by specifying pool name or ID:

      {% note info %}

      You cannot reconfigure the pool's VMs.

      {% endnote %}

      ```bash
      yc compute reserved-instance-pool update <pool_name_or_ID> \
        --new-name <new_pool_name> \
        --description <pool_description> \
        --size <pool_size> \
        --allow-oversubscription \
        --allow-pending-slots
      ```

      Where:
      * `--new-name`: New pool name. This is an optional parameter. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--description`: Pool description. This is an optional parameter.
      * `--size`: New number of slots per pool. This is an optional parameter.
      * `--allow-oversubscription`: Parameter enabling or disabling the [oversubscription mode](../../concepts/reserved-pools.md#oversubscription) for the pool. In this mode, you can attach VMs beyond the pool capacity. This is an optional parameter.

          To enable the overcommitment mode, provide the `--allow-oversubscription` parameter in the command.

          To disable overcommitment where previously enabled, provide the `--allow-oversubscription=false` parameter in the command.
      * `--allow-pending-slots`: Parameter to enable [pending slots](../../concepts/reserved-pools.md#pending-slots) when modifying pool size. This is an optional parameter. By default, when you change a pool’s size, the pending slots setting is disabled.

      Result:

      ```text
      done (8s)
      id: fv4vnl1ncbja********
      zone_id: {{ region-id }}-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: new-pool
      description: the new description
      created_at: "2025-08-12T07:58:57Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "3"
      committed_size: "3"
      slot_stats:
        total: "3"
        used: "1"
        available: "2"
      instance_stats:
        total: "1"
      ```

      For more information about the `yc compute reserved-instance-pool update` command, see the [{{ yandex-cloud }} CLI reference](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/update.md).

- API {#api}

  Use the [update](../../api-ref/ReservedInstancePool/update.md) REST API method for the [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) resource or the [ReservedInstancePoolService/Update](../../api-ref/grpc/ReservedInstancePool/update.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](./manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)