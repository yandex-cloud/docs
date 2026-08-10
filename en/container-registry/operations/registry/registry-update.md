---
title: How to update a registry in {{ container-registry-full-name }}
description: Follow this guide to update a registry.
---

# Updating a registry

Find out how to update:
* [Registry name](#update-name).
* [Registry label](#update-label).
* [Access for IP addresses](#access-ip).

To access a [registry](../../concepts/registry.md), use its ID or name. To learn how to get a registry ID or name, see [{#T}](registry-list.md).

## Updating a registry name {#update-name}

{% list tabs group=instructions %}

- Management console {#console}

  To update the name of a [registry](../../concepts/registry.md):

  1. In the [management console]({{ link-console-main }}), select the folder containing the registry.
  1. [Navigate]({{ link-console-main }}/link/container-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis-vertical.svg) next to the registry you want to update.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
  1. In the window that opens, enter the registry name.
  1. Optionally, update labels.
  1. Click **{{ ui-key.yacloud.cr.overview.popup-update_button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Update the registry name:

  ```bash
  yc container registry update my-reg --new-name new-reg
  ```

  Result:

  ```text
  id: crp3qleutgks********
  folder_id: b1g88tflru0e********
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  ```

- API {#api}

  To update a registry name, use the [update](../../api-ref/Registry/update.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}

## Updating a registry label {#update-label}

{% list tabs group=instructions %}

- CLI {#cli}

  Update the registry label (do not confuse it with [Docker image](../../concepts/docker-image.md) tags):

  ```bash
  yc container registry update new-reg --labels new_label=test_label
  ```

  Result:

  ```text
  id: crp3qleutgks********
  folder_id: b1g88tflru0e********
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  labels:
    new_label: test_label
  ```

- API {#api}

  To update a registry label, use the [update](../../api-ref/Registry/update.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}

## Configuring access for IP addresses {#access-ip}

{% list tabs group=instructions %}

- Management console {#console}

  To add or delete an [IP address](../../../vpc/concepts/address.md) and configure registry access:

  1. In the [management console]({{ link-console-main }}), select the folder containing the registry.
  1. [Navigate]({{ link-console-main }}/link/container-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Click the registry name, select ![ip-address.svg](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.cr.registry.label_ip-permissions }}**, and click **{{ ui-key.yacloud.cr.registry.button_update-ip-permissions }}**.
  1. Click **{{ ui-key.yacloud.common.add }}** and specify the IP address and its permission for the registry: `PULL` to pull Docker images from the registry or `PUSH` to push them to the registry.
  1. Click ![image](../../../_assets/console-icons/xmark.svg) next to the IP address whose access permissions you want to remove.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add the IP address to grant access:

  ```bash
  yc container registry add-ip-permissions \
    --name my-reg \
    --pull <IP_address_with_PULL_access> \
    --push <IP_address_with_PUSH_access>
  ```

  Remove the IP address permission:

  ```bash
  yc container registry remove-ip-permissions \
    --name my-reg \
    --pull <IP_address_with_PULL_access> \
    --push <IP_address_with_PUSH_access>
  ```

- API {#api}

  To add, update, or delete an IP address and configure its [registry](../../concepts/registry.md) access permissions, use the [updateIpPermission](../../api-ref/Registry/updateIpPermission.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}
