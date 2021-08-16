# Updating a registry

Find out how to change:

- [The name of a registry](#update-name)
- [The label of a registry](#update-label)

To access a [registry](../../concepts/registry.md), use its ID or name. For information on how to find the registry ID or name, see [Getting information about existing registries](registry-list.md).

## Updating the name of a registry {#update-name}

{% list tabs %}

- Management console

  To change the name of the [registry](../../concepts/registry.md):
  1. Open the **Container Registry** section in the folder where you want to change the registry.
  1. Click ![image](../../../_assets/vertical-ellipsis.svg) in the line of the registry to change.
  1. In the window that opens, click **Edit**.
  1. In the window that opens, enter the desired registry name.
  1. Click **Edit**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change the registry name:

  ```
  $ yc container registry update my-reg --new-name new-reg
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  ```

- API

  To change the registry name, use the [update](../../api-ref/Registry/update.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}

## Updating the label of a registry {#update-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change the registry label (don't confuse this with Docker image tags):

  ```
  $ yc container registry update new-reg --labels new_label=test_label
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  labels:
    new_label: test_label
  ```

- API

  To change the registry label, use the [update](../../api-ref/Registry/update.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}