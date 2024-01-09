{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр.
   1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о реестре.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Получите подробную информацию о реестре:

  ```
  yc iot registry get <имя реестра>
  ```

  Результат:

  ```
  id: b91ki3851hab********
  folder_id: aoek49ghmknn********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

- API {#api}

  Чтобы получить подробную информацию о реестре, воспользуйтесь методом REST API [get](../../iot-core/api-ref/Registry/get.md) для ресурса [Registry](../../iot-core/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Get](../../iot-core/api-ref/grpc/registry_service.md#Get).

{% endlist %}
