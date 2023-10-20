---
title: "How to create a GPU cluster"
description: "This guide tells you how to create a GPU cluster."
---

# Creating a GPU cluster

{% note info %}

GPU clusters will be [publicly available](../../../overview/concepts/launch-stages.md) and billable starting September 1, 2023.

{% endnote %}

{% note info %}

By default, the cloud has a zero [quota](../../concepts/limits.md#compute-quotas) for creating GPU clusters. To change the [quota]({{ link-console-quotas }}), contact [technical support]({{ link-console-support }}).

{% endnote %}

This section explains how to create GPU clusters. Currently, GPU clusters can only be created in the `ru-central1-a` availability zone.

After creating a cluster, you can [add](gpu-add-to-cluster.md) VMs from the same availability zone to it.

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the create GPU cluster CLI command:

      ```bash
      yc compute gpu-cluster create --help
      ```

      Please note that you can currently create clusters with the `InfiniBand` connection type only.

   1. Create a cluster in the default availability zone:

      ```bash
      yc compute gpu-cluster create --interconnect-type infiniband
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

      
      ```hcl
      provider "yandex" {
        zone = "{{ region-id }}-a"
      }

      resource "yandex_compute_gpu_cluster" "default" {
        name               = "<cluster_name>"
        interconnect_type  = "<connection_type>"
        zone               = "{{ region-id }}-a"
        labels             = {
          <key_of_label_1> = "<value_of_label_1>"
          <key_of_label_2> = "<value_of_label_2>"
        }
      }
      ```



      Where:

      * `name`: Cluster name. This is a required parameter.
      * `interconnect_type`: Type of connection. You can currently create clusters with the `InfiniBand` connection type only. This is a required parameter.
      * `labels`: Resource [label](../../../resource-manager/concepts/labels.md) in `<key> = "<value>"` format. This is an optional parameter.

      For more information about the `yandex_compute_gpu_cluster` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/compute_gpu_cluster).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a GPU cluster in the specified folder. You can check the new cluster and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc compute gpu-cluster get <cluster_name>
   ```

{% endlist %}
