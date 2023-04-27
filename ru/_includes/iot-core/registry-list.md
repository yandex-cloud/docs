{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите получить список реестров.
  1. Выберите сервис **{{ iot-short-name }}**.
  1. На странице **Реестры** отобразится список реестров.

- CLI

  {% include [cli-install](../cli-install.md) %}
  
  {% include [default-catalogue](../default-catalogue.md) %}

  Получите список реестров в каталоге:

  ```
  yc iot registry list
  ```

  Результат:

  ```
  +----------------------+-------------+
  |          ID          |    NAME     |
  +----------------------+-------------+
  | b91ki3851hab9m0l68je | my-registry |
  +----------------------+-------------+
  ```

- API

  Чтобы получить список реестров, воспользуйтесь методом REST API [list](../../iot-core/api-ref/Registry/list.md) для ресурса [Registry](../../iot-core/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/List](../../iot-core/api-ref/grpc/registry_service.md#List).

{% endlist %}