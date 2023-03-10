# Updating a registry

Find out how to change:
* [A registry's name](#update-name).
* [A registry's label](#update-label).
* [Access for IP addresses](#access-ip).

To access a [registry](../../concepts/registry.md), use its ID or name. For information about how to get the registry ID or name, see [{#T}](registry-list.md).

## Updating the name of a registry {#update-name}

{% list tabs %}

- Management console

  To update the name of a [registry](../../concepts/registry.md):
  1. Open **{{ container-registry-name }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you wish to update the registry.
  1. Click ![image](../../../_assets/vertical-ellipsis.svg) next to the registry to update.
  1. In the menu that opens, click **Edit**.
  1. In the window that opens, enter the desired registry name.
  1. Click **Edit**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change the registry name:

  ```bash
  yc container registry update my-reg --new-name new-reg
  ```

  Result:

  ```bash
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  ```

- API

  To edit a registry name, use the [update](../../api-ref/Registry/update.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}

## Updating the label of a registry {#update-label}

{% list tabs %}

- CLI

  Change the registry label (don't confuse this with [Docker image](../../concepts/docker-image.md) tags):

  ```bash
  yc container registry update new-reg --labels new_label=test_label
  ```

  Result:

  ```bash
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  labels:
    new_label: test_label
  ```

- API

  To edit a registry label, use the [update](../../api-ref/Registry/update.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}

## Configuring access for IP addresses {#access-ip}

{% list tabs %}

- Management console

  To add or delete an [IP address](../../../vpc/concepts/address.md) and configure access to a registry:
  1. Open **{{ container-registry-name }}** in the folder where you wish to update the registry.
  1. Click on the name of the registry you need, select ![ip-address.svg](../../../_assets/container-registry/ip-access.svg) **Access for IP addresses**, and click **Configure**.
  1. Click **Add** and specify the IP address and permission to perform an action with the registry: `PULL` (allows pulling Docker images from the registry) or `PUSH` (allows pushing Docker images to the registry).
  1. Click ![image](../../../_assets/cross.svg) in the line of the IP address to delete the permission for.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add the IP address to grant permissions to:

  ```bash
  yc container registry add-ip-permissions \
    --name my-reg \
    --pull <IP with PULL permission> \
    --push <IP with PUSH permission>
  ```

  Remove the IP permission:

  ```bash
  yc container registry remove-ip-permissions \
    --name my-reg \
    --pull <IP with PULL permission> \
    --push <IP with PUSH permission>
  ```

- API

  To add, update, or delete an IP address and configure its [registry](../../concepts/registry.md) permissions, use the [updateIpPermission](../../api-ref/Registry/updateIpPermission.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}