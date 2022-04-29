{% list tabs %}

- Management console
   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select the **{{ iot-short-name }}**.
   1. Select the registry.
   1. The **Overview** page shows the registry details.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get detailed information about the registry:

  ```
  yc iot registry get <registry name>
  ```

  Result:

  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

- API

  You can get detailed information about a registry using the [get](../../iot-core/api-ref/Registry/get) API method.

{% endlist %}