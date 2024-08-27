# Изменение устройства

Вы можете изменить [имя](device-update.md#update-name) или [описание](device-update.md#update-description) устройства.

Для обращения к устройству используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [{#T}](device-list.md).

## Изменить имя устройства {#update-name}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить имя устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить имя устройства.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Справа от имени нужного устройства нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Измените поле **{{ ui-key.yacloud.common.name }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените имя устройства:

  ```bash
  yc iot device update my-device --new-name test-device
  ```

  Результат:
  ```text
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: test-device
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить имя устройства, созданного с помощью {{ TF }}:
  
  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `name` во фрагменте с описанием устройства:

      Пример описания устройства в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
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

      Проверить измененное имя устройства можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device list --registry-id <идентификатор_реестра>
      ```

- API {#api}

  Чтобы изменить имя устройства, воспользуйтесь методом REST API [update](../../api-ref/Device/update.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Update](../../api-ref/grpc/device_service.md#Update).

{% endlist %}

## Изменить описание устройства {#update-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить описание устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить описание устройства.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Справа от имени нужного устройства нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Измените поле **{{ ui-key.yacloud.common.description }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените описание устройства:

  ```bash
  yc iot device update my-device --description "My first device."
  ```

  Результат:
  
  ```bash
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  description: My first device.
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить описание устройства, созданного с помощью {{ TF }}:
  
  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `description` во фрагменте с описанием устройства.

      Пример описания устройства в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
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

      Проверить измененное описание устройства можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device get <имя_устройства>
      ```

- API {#api}

  Чтобы изменить описание устройства, воспользуйтесь методом REST API [update](../../api-ref/Device/update.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Update](../../api-ref/grpc/device_service.md#Update).

{% endlist %}