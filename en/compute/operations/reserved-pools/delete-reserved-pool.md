---
title: Deleting a reserved instance pool
description: In this tutorial, you will learn how to delete a {{ compute-full-name }} reserved instance pool.
---

# Deleting a reserved instance pool

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

To delete a [reserved instance pool](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) command for deleting a reserved instance pool:

      ```bash
      yc compute reserved-instance-pool delete --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Delete the reserved instance pool in the default folder by specifying its name or ID:

      ```bash
      yc compute reserved-instance-pool delete <pool_name_or_ID>
      ```

      Result:

      ```text
      done (15s)
      {}
      ```

      For more information about the `yc compute reserved-instance-pool delete` command, see the [{{ yandex-cloud }} CLI reference](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/delete.md).

- API {#api}

  Use the [delete](../../api-ref/ReservedInstancePool/delete.md) REST API method for the [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) resource or the [ReservedInstancePoolService/Delete](../../api-ref/grpc/ReservedInstancePool/delete.md) gRPC API call.

{% endlist %}

{% note info %}

When you delete a reserved instance pool, all VMs attached to it will be detached, and the running ones will continue to operate.

{% endnote %}

#### See also {#see-also}

* [{#T}](./manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)