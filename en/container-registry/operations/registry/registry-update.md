# Updating a registry

Find out how to change:
* [A registry's name](#update-name).
* [A registry's label](#update-label).

To access a [registry](../../concepts/registry.md), use its ID or name. For information on how to find the registry ID or name, see [Getting information about existing registries](registry-list.md).

## Updating the name of a registry {#update-name}

{% list tabs %}

- Management console

   To update the name of a [registry](../../concepts/registry.md):
   1. Open **{{ container-registry-name }}** in the folder where you wish to update the registry.
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

   Change the registry label (don't confuse this with Docker image tags):

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