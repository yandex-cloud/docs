# Отключение и включение реестра

Вы можете отключить и включить [реестр](../../concepts/index.md#registry). При отключении реестр переводится в статус `DISABLED`, и реестр, и все [устройства](../../concepts/index.md#device) внутри него перестают принимать входящие соединения.

{% include [registry-get-id-name](../../../_includes/iot-core/registry-get-id-name.md) %}


## Отключить реестр {#disable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список реестров в каталоге:

      ```bash
      yc iot registry list
      ```

      Результат:

      ```text
      +----------------------+-------------------+--------+
      |          ID          |       NAME        | STATUS |
      +----------------------+-------------------+--------+
      | arenou2oj4********** | my-registry       | ACTIVE |
      +----------------------+-------------------+--------+
      ```

  1. Отключите реестр:

      ```bash
      yc iot registry disable <имя_или_идентификатор_реестра>
      ```

      Результат:

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

  Чтобы отключить реестр, воспользуйтесь методом REST API [disable](../../api-ref/Registry/disable.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Disable](../../api-ref/grpc/Registry/disable.md).

{% endlist %}


## Включить реестр {#enable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список реестров в каталоге:

      ```bash
      yc iot registry list
      ```

      Результат:

      ```text
      +----------------------+-------------------+----------+
      |          ID          |       NAME        |  STATUS  |
      +----------------------+-------------------+----------+
      | arenou2oj4********** | my-registry       | DISABLED |
      +----------------------+-------------------+----------+
      ```

  1. Включите реестр:

      ```bash
      yc iot registry enable <имя_или_идентификатор_реестра>
      ```

      Результат:

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

  Чтобы включить реестр, воспользуйтесь методом REST API [enable](../../api-ref/Registry/enable.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Enable](../../api-ref/grpc/Registry/enable.md).

{% endlist %}