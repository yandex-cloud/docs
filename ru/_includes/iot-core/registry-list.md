{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите получить список реестров.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. На странице **{{ ui-key.yacloud.iot.label_registries }}** отобразится список реестров.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}
  
  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка реестров:
	
      ```bash
      yc iot registry list --help
      ```

  1. Получите список реестров в каталоге по умолчанию:

      ```bash
      yc iot registry list
      ```

      Результат:

      ```text
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | b91ki3851hab******** | my-registry |
      +----------------------+-------------+
      ```

- API {#api}

  Чтобы получить список реестров, воспользуйтесь методом REST API [list](../../iot-core/api-ref/Registry/list.md) для ресурса [Registry](../../iot-core/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/List](../../iot-core/api-ref/grpc/registry_service.md#List).

{% endlist %}