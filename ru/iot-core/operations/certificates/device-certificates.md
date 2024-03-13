# Управление сертификатами устройства

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять сертификатами устройства для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Посмотреть список сертификатов устройства](device-certificates.md#list-cert)
* [Добавить сертификат устройству](device-certificates.md#add-cert)
* [Удалить сертификат устройства](device-certificates.md#delete-cert)

Для обращения к [устройству](../../concepts/index.md#device) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [{#T}](../device/device-list.md).

## Получить список сертификатов {#device-certificates-list}

{% include [device-certificates-list](../../../_includes/iot-core/device-certificates-list.md) %}

## Добавить сертификат {#add-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить сертификат устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который вы хотите добавить сертификат устройства.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Нажмите на имя нужного реестра.
   1. Перейдите в раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите в списке нужное устройство.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_certificates }}** и нажмите кнопку **{{ ui-key.yacloud.component.certificates.button_empty-add }}**.

      - Чтобы добавить файл:

         1. Выберите способ `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
         1. Нажмите **Прикрепить файл**.
         1. Укажите файл сертификата на вашем компьютере, нажмите **Открыть**.
         1. Нажмите **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      - Чтобы добавить текст:

         1. Выберите способ `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
         1. Вставьте тело сертификата в поле **{{ ui-key.yacloud.component.file-content-dialog.field_content }}**.
         1. Нажмите **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте сертификат устройству:

  ```
  yc iot device certificate add \
    --device-name my-device \ # Имя устройства.
    --certificate-file device-cert.pem # Путь к публичной части сертификата.
  ```
  
  Результат:
  ```
  device_id: b9135goeh1uc********
  fingerprint: 65e5b050069da5ca5996a4a8a9251409********
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAwI...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T17:14:18.804Z"
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы добавить сертификат устройству, созданному с помощью {{ TF }}:
  
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_device` — параметры устройства:
       * `registry_id` — [идентификатор реестра](../registry/registry-list.md#registry-list), в котором создается устройство.
       * `name` — [имя устройства](../device/device-list.md#device-list).
       * `description` — описание устройства.
       * `certificates` — список сертификатов для авторизации с помощью [сертификатов](../../concepts/authorization.md#certs).

      Пример описания устройства в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_файлу_c_сертификатом>")
        ]
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

      Проверить сертификаты устройства можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device certificate list --device-name <имя_устройства>
      ```

- API {#api}

  Чтобы добавить сертификат устройству, воспользуйтесь методом REST API [addCertificate](../../api-ref/Device/addCertificate.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/AddCertificate](../../api-ref/grpc/device_service.md#AddCertificate).

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить сертификат устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить сертификат устройства.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Нажмите на имя нужного реестра.
   1. Перейдите в раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите в списке нужное устройство.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_certificates }}**.
   1. В строке с нужным сертификатом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.delete }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите сертификат устройства:

      ```
      yc iot device certificate delete --device-name my-device --fingerprint 65...
      ```

  1. Проверьте, что сертификат действительно удален:

      ```
      yc iot device certificate list --device-name my-device
	    ```
	  
	    Результат:
	  
	    ```
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить сертификат устройства, созданного с помощью {{ TF }}:
  
  1. Откройте файл конфигурации {{ TF }} и удалите значение нужного сертификата в блоке `certificates`, во фрагменте с описанием устройства. Чтобы удалить все сертификаты, удалите блок `certificates` целиком.

      Пример описания устройства в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_файлу_c_сертификатом>")
        ]
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

      Проверить сертификаты устройства можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device certificate list --device-name <имя_устройства>
      ```

- API {#api}

  Чтобы удалить сертификат устройства, воспользуйтесь методом REST API [deleteCertificate](../../api-ref/Device/deleteCertificate.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/DeleteCertificate](../../api-ref/grpc/device_service.md#DeleteCertificate).

{% endlist %}