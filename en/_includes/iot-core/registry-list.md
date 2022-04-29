{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of registries.
  1. Select the **{{ iot-short-name }}**.
  1. The **Registries** page shows the list of registries.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get a list of registries in the folder:

  ```
  yc iot registry list
  ```

  Result:

  ```
  +----------------------+-------------+
  |          ID          |    NAME     |
  +----------------------+-------------+
  | b91ki3851hab9m0l68je | my-registry |
  +----------------------+-------------+
  ```

- API

  You can get a list of registries using the [list](../../iot-core/api-ref/Registry/list.md) API method.

{% endlist %}