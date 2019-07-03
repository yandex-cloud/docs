# Getting information about a registry

Get a list of registries in a folder to find the `ID` or `NAME` of a registry, or get detailed information about a registry.

## Getting a list of registries in a folder {#registry-list}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Get the list of [registries](../../concepts/index.md#registry) in the default folder:
  
  ```
  $ yc iot registry list
  +----------------------+-------------+
  |          ID          |    NAME     |
  +----------------------+-------------+
  | b91ki3851hab9m0l68je | my-registry |
  +----------------------+-------------+
  ```
  
{% endlist %}

## Getting detailed information about a registry {#registry-get}

You can access the registry using the `id` or `name` parameters from the [previous](#registry-list) item.

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Get detailed information about the registry:
  
  ```
  $ yc iot registry get my-registry
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```
  
{% endlist %}

