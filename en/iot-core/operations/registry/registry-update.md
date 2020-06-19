# Updating a registry

You can update the [name](registry-update.md#update-name) and [description](registry-update.md#update-description) of a registry and [manage registry labels](registry-update.md#manage-label).

To access a registry, use its ID or name. For information about how to get the ID or name of a registry, see [{#T}](registry-list.md).

## Updating the name of a registry {#update-name}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change the registry name:

  ```
  $ yc iot registry update my-registry --new-name test-registry

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: test-registry
  ```

{% endlist %}

## Updating the description of a registry {#update-description}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change the registry description:

  ```
  $ yc iot registry update my-registry --description "My test registry."

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  description: My test registry.
  labels:
    test_label: my_registry_label
  ```

{% endlist %}

## Managing registry labels {#manage-label}

You can perform the following actions related to registry labels:

- [Add](registry-update.md#add-label)
- [Update](registry-update.md#update-label)
- [Delete](registry-update.md#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a label to a registry:

  ```
  $ yc iot registry add-labels my-registry --labels new_label=test_label

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    new_label: test_label
  ```

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change a registry label:

  {% note warning %}


  The existing set of `labels` is completely replaced by the set provided.

  {% endnote %}

  ```
  $ yc iot registry update my-registry --labels test_label=my_registry_label

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    test_label: my_registry_label
  ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Delete a registry label:

  ```
  $ yc iot registry remove-labels my-registry --labels new_label

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

{% endlist %}

