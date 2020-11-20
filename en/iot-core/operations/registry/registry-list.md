# Getting information about registries

To find the `ID` or `NAME` of a registry, get a list of registries in a folder or detailed information about the registry.

## Getting a list of registries in a folder {#registry-list}

{% list tabs %}

- Management console

   To view the list of registries in a folder:
   1. In the [management console](https://{{ link-console-main }}), select the folder to get the list of registries in.
   1. Select **{{ iot-name }}**.

   The **Registries** window shows the list of registries.

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

You can access the registry using the `ID` or `NAME` parameters from the [previous](#registry-list) item.

{% list tabs %}

- Management console

   To get detailed information about a registry:
   1. In the [management console]({{ link-console-main }}), select the folder to get the registry details in.
   1. Select **{{ iot-name }}**.
   1. Select the desired registry from the list.

   The **Overview** window shows the registry details.

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

