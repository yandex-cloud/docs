---
title: How to enable deletion protection for an instance group
description: Follow this guide to enable deletion protection for an instance group.
---

# Enabling deletion protection for a {{ compute-name }} instance group

Deletion protection prevents accidental deletion of an [instance group](../../concepts/instance-groups/index.md). You cannot delete a group while the value is `true`. To delete a group with protection on, you must turn it off first.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group in question.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select a group to enable deletion protection for.
  1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
  1. Enable **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an instance group:

     ```bash
     {{ yc-compute-ig }} update --help
     ```

  1. Get a list of instance groups in the default folder:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select `ID` of the instance group in question.
  1. In the YAML file that was used to create the group, set `deletion_protection: true`. If this YAML file was not saved, get the instance group [info](get-info.md) and create a new one, e.g., `specification.yaml`. For more information, see [{#T}](create-fixed-group.md).
  1. Update the instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} update \
        --id <instance_group_ID> \
        --file specification.yaml
      ```

     {{ ig-name }} will initiate an instance group update.

     Result:

      ```yaml
      done (4m55s)
      id: cl15b3mrkk88********
      folder_id: b1g07hj5r6i4********
      created_at: "2025-12-10T10:51:35.963Z"
      name: vm-grup
      description: This instance group was created using a YAML configuration file.
      instance_template:
        platform_id: standard-v3
        resources_spec:
          memory: "2147483648"
          cores: "2"
        boot_disk_spec:
          mode: READ_WRITE
          disk_spec:
            type_id: network-ssd
            size: "21474836480"
            image_id: fd8fhpd6j1ea********
        network_interface_specs:
          - network_id: enp1djcrd94k********
            primary_v4_address_spec: {}
        scheduling_policy: {}
      scale_policy:
        fixed_scale:
          size: "3"
      deploy_policy:
        max_unavailable: "1"
        strategy: PROACTIVE
      allocation_policy:
        zones:
          - zone_id: ru-central1-b
      load_balancer_state: {}
      managed_instances_state:
        target_size: "3"
      service_account_id: ajeb9l33h6mu********
      status: ACTIVE
      deletion_protection: true
      application_load_balancer_state: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `deletion_protection` property to the instance group description:

     ```hcl
     ...
     resource "yandex_compute_instance_group" "ig-1" {
       name                = "fixed-ig"
       folder_id           = "<folder_ID>"
       service_account_id  = "<service_account_ID>"
       deletion_protection = true
       depends_on          = [yandex_resourcemanager_folder_iam_member.compute_editor]
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = 2
           cores  = 2
         }
         ...
       }
     }
     ```

     Where `deletion_protection` is instance group deletion protection: `true` or `false`. You cannot delete a group while the value is `true`. The default value is `false`.

     For more information about `yandex_compute_instance_group` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/compute_instance_group).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Check the instance group update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc compute instance-group get <instance_group_name>
     ```


- API {#api}

  Use the [update](../../instancegroup/api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}

## Disable deletion protection {#disable}

To disable instance group deletion protection:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group in question.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select the group to disable deletion protection for.
  1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
  1. Disable **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an instance group:

     ```bash
     {{ yc-compute-ig }} update --help
     ```

  1. Get a list of instance groups in the default folder:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select `ID` of the instance group in question.
  1. In the YAML file that was used to create the group, set `deletion_protection: false`. If this YAML file was not saved, get the instance group [info](get-info.md) and create a new one, e.g., `specification.yaml`. For more information, see [{#T}](create-fixed-group.md).
  1. Disable deletion protection:

     ```bash
      {{ yc-compute-ig }} update \
        --id <instance_group_ID> \
        --file specification.yaml
     ```

     {{ ig-name }} will initiate an instance group update.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and set `deletion_protection` to `false` in the instance group description:

     ```hcl
     ...
     resource "yandex_compute_instance_group" "ig-1" {
       name                = "fixed-ig"
       folder_id           = "<folder_ID>"
       service_account_id  = "<service_account_ID>"
       deletion_protection = false
       depends_on          = [yandex_resourcemanager_folder_iam_member.compute_editor]
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = 2
           cores  = 2
         }
         ...
       }
     }
     ```

     For more information about `yandex_compute_instance_group` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/compute_instance_group).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Check the instance group update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc compute instance-group get <instance_group_name>
     ```

- API {#api}

  Use the [update](../../instancegroup/api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](delete.md)