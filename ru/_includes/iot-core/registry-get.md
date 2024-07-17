{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр.
   1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о реестре.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о реестре:
	
      ```bash
      yc iot registry get --help
      ```
  
  1. Получите подробную информацию о реестре, указав его имя или идентификатор:

      ```bash
      yc iot registry get <имя_реестра>
      ```

      Результат:

      ```text
      id: b91ki3851hab********
      folder_id: aoek49ghmknn********
      created_at: "2019-05-28T11:29:42.420Z"
      name: my-registry
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить подробную информацию о реестре с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_iot_core_registry" "my_registry" {
       registry_id = "<идентификатор_реестра>"
     }

     output "registry_params" {
       value = data.yandex_iot_core_registry.my_registry.created_at
     }
     ```

     Где:
     * `data "yandex_iot_core_registry"` — описание реестра в качестве источника данных:
       * `registry_id` — идентификатор реестра.
     * `output "registry_params"` — выходная переменная, которая содержит информацию о временной метке создания реестра:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_iot_core_registry` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_iot_core_registry).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     registry_params = "2024-05-08T06:40:52Z"
     ```

- API {#api}

  Чтобы получить подробную информацию о реестре, воспользуйтесь методом REST API [get](../../iot-core/api-ref/Registry/get.md) для ресурса [Registry](../../iot-core/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Get](../../iot-core/api-ref/grpc/registry_service.md#Get).

{% endlist %}
