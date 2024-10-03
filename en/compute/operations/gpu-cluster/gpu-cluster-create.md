---
title: How to create a GPU cluster
description: Follow this guide to create a GPU cluster.
---

# Creating a GPU cluster


{% note info %}

By default, the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) has a zero [quota](../../concepts/limits.md#compute-quotas) for creating GPU clusters. To change the [quota]({{ link-console-quotas }}), contact [technical support]({{ link-console-support }}).

{% endnote %}

This section explains how to create GPU clusters. Currently, GPU clusters can only be created in the `{{ region-id }}-a` [availability zone](../../../overview/concepts/geo-scope.md).

After creating a cluster, you can [add](gpu-add-to-cluster.md) [VMs](../../concepts/vm.md) from the same availability zone to it.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the create GPU cluster [CLI](../../../cli/) command:

      ```bash
      yc compute gpu-cluster create --help
      ```

      Note that you can currently create GPU clusters with the `InfiniBand` connection type only.
   1. Create a GPU cluster in the default availability zone:

      ```bash
      yc compute gpu-cluster create --interconnect-type infiniband
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

      ```hcl
      provider "yandex" {
        zone = "{{ region-id }}-a"
      }

      resource "yandex_compute_gpu_cluster" "default" {
        name               = "<GPU_cluster_name>"
        interconnect_type  = "<connection_type>"
        zone               = "{{ region-id }}-a"
        labels             = {
          <key_of_label_1> = "<value_of_label_1>"
          <key_of_label_2> = "<value_of_label_2>"
        }
      }
      ```

      Where:
      * `name`: GPU cluster name. This is a required parameter.
      * `interconnect_type`: Type of connection. You can currently create GPU clusters with the `infiniband` connection type only. This is a required parameter.
      * `labels`: Resource [label](../../../resource-manager/concepts/labels.md) in `<key> = "<value>"` format. This is an optional parameter.

      For more information about the `yandex_compute_gpu_cluster` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/compute_gpu_cluster).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   This will create a GPU cluster in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new GPU cluster and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc compute gpu-cluster get <GPU_cluster_name>
   ```

{% endlist %}