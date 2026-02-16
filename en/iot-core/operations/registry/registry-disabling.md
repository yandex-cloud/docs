# Enabling and disabling a registry

You can disable or enable a [registry](../../concepts/index.md#registry). Once disabled, the registry gets the `DISABLED` status, after which the registry itself and all [devices](../../concepts/index.md#device) in it stop accepting inbound connections.

{% include [registry-get-id-name](../../../_includes/iot-core/registry-get-id-name.md) %}


## Disabling a registry {#disable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of registries in the folder:

      ```bash
      yc iot registry list
      ```

      Result:

      ```text
      +----------------------+-------------------+--------+
      |          ID          |       NAME        | STATUS |
      +----------------------+-------------------+--------+
      | arenou2oj4********** | my-registry       | ACTIVE |
      +----------------------+-------------------+--------+
      ```

  1. Disable a registry:

      ```bash
      yc iot registry disable <registry_name_or_ID>
      ```

      Result:

      ```text
      id: are1dtqd94r7********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-16T11:34:11.623Z"
      name: my-registry
      status: DISABLED
      log_options:
        folder_id: b1g681qpemb4********
      ```

- API {#api}

  To disable a registry, use the [disable](../../api-ref/Registry/disable.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Disable](../../api-ref/grpc/Registry/disable.md) gRPC API call.

{% endlist %}


## Enabling a registry {#enable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of registries in the folder:

      ```bash
      yc iot registry list
      ```

      Result:

      ```text
      +----------------------+-------------------+----------+
      |          ID          |       NAME        |  STATUS  |
      +----------------------+-------------------+----------+
      | arenou2oj4********** | my-registry       | DISABLED |
      +----------------------+-------------------+----------+
      ```

  1. Enable a registry:

      ```bash
      yc iot registry enable <registry_name_or_ID>
      ```

      Result:

      ```text
      id: are1dtqd94r7********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-16T11:34:11.623Z"
      name: my-registry
      status: ACTIVE
      log_options:
        folder_id: b1g681qpemb4********
      ```

- API {#api}

  To enable a registry, use the [enable](../../api-ref/Registry/enable.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Enable](../../api-ref/grpc/Registry/enable.md) gRPC API call.

{% endlist %}