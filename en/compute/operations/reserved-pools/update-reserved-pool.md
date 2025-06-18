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
      id: fv48qa9iiq19********
      zone_id: ru-central1-d
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: test-pool
      created_at: "2025-05-06T19:46:49Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "1"
      ```
  1. Update a reserved instance pool in the default folder by specifying pool name or ID:

      {% note info %}

      You cannot reconfigure the pool's VMs.

      {% endnote %}

      ```bash
      yc compute reserved-instance-pool update <pool_name_or_ID> \
        --new-name <new_pool_name> \
        --description <pool_description> \
        --size <pool_size>
      ```

      Where:
      * `--new-name`: New pool name. This is an optional parameter. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--description`: Pool description. This is an optional parameter.
      * `--size`: New number of slots per pool. This is an optional parameter.

      Result:

      ```text
      done (11s)
      id: fv48qa9iiq19********
      zone_id: {{ region-id }}-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: test-pool-new
      description: pool description
      created_at: "2025-05-06T19:46:49Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "2"
      ```

      For more information about the `yc compute reserved-instance-pool update` command, see the [{{ yandex-cloud }} CLI reference](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/update.md).

- API {#api}

  Use the [update](../../api-ref/ReservedInstancePool/update.md) REST API method for the [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) resource or the [ReservedInstancePoolService/Update](../../api-ref/grpc/ReservedInstancePool/update.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](./manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)