# Удаление устройства

Для обращения к [устройству](../../concepts/index.md#device) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [{#T}](device-list.md).

{% list tabs %}

- Консоль управления

   Чтобы удалить устройство:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить устройство.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Справа от имени удаляемого устройства нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.delete }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите устройство:

      ```
      yc iot device delete my-device
      ```

  1. Проверьте, что устройство действительно удалено:

      ```
      yc iot device list --registry-name my-registry
	  ```
	  
	  Результат:
	  ```
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить устройство, созданное с помощью {{ TF }}:
  
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием устройства.

      Пример описания устройства в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор реестра>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_device` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_device).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device list --registry-id <идентификатор реестра>
      ```

- API

  Чтобы удалить устройство, воспользуйтесь методом REST API [delete](../../api-ref/Device/delete.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Delete](../../api-ref/grpc/device_service.md#Delete).

{% endlist %}