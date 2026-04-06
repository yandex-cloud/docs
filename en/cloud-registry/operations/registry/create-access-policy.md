---
title: How to configure a {{ cloud-registry-full-name }} access policy
description: Follow this guide to configure a registry access policy.
---

# Configuring a registry access policy

You can set up policies for accessing a [registry](../../concepts/registry.md) from specific [IP addresses](../../../vpc/concepts/address.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.cloud-registry.title_ip-permissions }}** tab.
  1. Click **{{ ui-key.yacloud.cloud-registry.registries.button_update-ip-permissions-full }}**.
  1. Enter the IP address and specify an action:
     * `PULL`: Permission to pull [artifacts](../../concepts/artifacts/index.md) from the registry.
     * `PUSH`: Permission to push artifacts to the registry.
  1. To configure access for multiple IPs, click **{{ ui-key.yacloud.common.add }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Set the registry access policy:

     ```bash
     yc cloud-registry registry add-ip-permissions <registry_name_or_ID> \
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

  1. Check the current permissions:

     ```bash
     yc cloud-registry registry list-ip-permissions <registry_name_or_ID>
     ```

     Result:

     ```text
     +--------+-----------+
     | ACTION |    IP     |
     +--------+-----------+
     | PULL   | 10.1.2.11 |
     | PUSH   | 10.1.2.11 |
     +--------+-----------+
     ```
- API {#api}

  To configure a registry access policy, use the [updateIpPermissions](../../api-ref/Registry/updateIpPermissions.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/UpdateIpPermissions](../../api-ref/grpc/Registry/updateIpPermissions.md) gRPC API call.

{% endlist %}
