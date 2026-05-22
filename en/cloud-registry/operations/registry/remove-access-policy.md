---
title: How to delete a {{ cloud-registry-full-name }} access policy
description: Follow this guide to delete a registry access policy.
---

# Deleting a registry access policy

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.cloud-registry.title_ip-permissions }}** tab.
  1. Click **{{ ui-key.yacloud.cloud-registry.registries.button_update-ip-permissions-full }}**.
  1. In the row with the access policy you want to delete, click ![trash-bin](../../../_assets/console-icons/trash-bin.svg).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Delete the registry access policy:

     ```bash
     yc cloud-registry registry remove-ip-permissions <registry_name_or_ID> \
       --pull <IP_address> \
       --push <IP_address>
     ```

     Where:
     * `--pull`: Flag that allows pulling [artifacts](../../concepts/artifacts/index.md) from the registry.
     * `--push`: Flag that allows pushing artifacts to the registry.

     Result:

     ```text
     done (1s)
     ```

     To delete all configured registry access policies and set new ones right away, use the `yc cloud-registry registry set-ip-permissions` command.

- API {#api}

  To delete a registry access policy, use the [updateIpPermissions](../../api-ref/Registry/updateIpPermissions.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateIpPermissions](../../api-ref/grpc/Registry/updateIpPermissions.md) gRPC API call.

{% endlist %}
