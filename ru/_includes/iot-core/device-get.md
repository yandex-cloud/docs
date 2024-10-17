{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится устройство.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр, в котором находится устройство.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите устройство.
   1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация об устройстве.

- CLI {#cli}
  
  {% include [cli-install](../cli-install.md) %}
  
  {% include [default-catalogue](../default-catalogue.md) %}
  1. Посмотрите описание команды CLI для получения информации об устройстве:
	
      ```bash
      yc iot device get --help
      ```

  1. Получите подробную информацию об устройстве, указав его имя или идентификатор:
  
      ```bash
      yc iot device get <имя_устройства>
      ```

      Результат:

      ```text
      id: b9135goeh1uc********
      registry_id: b91ki3851hab********
      created_at: "2019-05-28T16:08:30.938Z"
      name: my-device
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить подробную информацию об устройстве с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_iot_core_device" "my_device" {
       device_id = "<идентификатор_устройства>"
     }

     output "device_params" {
       value = data.yandex_iot_core_device.my_device.registry_id
     }
     ```

     Где:
     * `data "yandex_iot_core_device"` — описание устройства в качестве источника данных:
       * `device_id` — идентификатор устройства.
     * `output "device_params"` — выходная переменная, которая содержит информацию о реестре, которому принадлежит устройство:
       * `value` — возвращаемое значение.

     Вместо `registry_id` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_iot_core_device` см. в [документации провайдера]({{ tf-provider-datasources-link }}/iot_core_device).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     device_params = "are7ajlrf493********"
     ```
 
- API {#api}

  Чтобы получить подробную информацию об устройстве, воспользуйтесь методом REST API [get](../../iot-core/api-ref/Device/get.md) для ресурса [Device](../../iot-core/api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Get](../../iot-core/api-ref/grpc/Device/get.md).

{% endlist %}