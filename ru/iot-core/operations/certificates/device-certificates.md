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

{% list tabs %}

- Консоль управления

   Чтобы добавить сертификат устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который вы хотите добавить сертификат устройства.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Нажмите на имя нужного реестра.
   1. В левом меню выберите **Устройства**.
   1. Выберите в списке нужное устройство.
   1. На странице **Обзор** перейдите к разделу **Сертификаты** и нажмите кнопку **Добавить сертификат**.

      - Чтобы добавить файл:

         1. Выберите способ **Файл**.
         1. Нажмите **Выбрать файл**.
         1. Укажите файл сертификата на вашем компьютере, нажмите **Открыть**.
         1. Нажмите **Добавить**.

      - Чтобы добавить текст:

         1. Выберите способ **Текст**.
         1. Вставьте тело сертификата в поле **Содержимое**.
         1. Нажмите **Добавить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте сертификат устройству:

  ```
  yc iot device certificate add \
    --device-name my-device \ # Имя устройства.
    --certificate-file device-cert.pem # Путь к публичной части сертификата.
  ```
  
  Результат:
  ```
  device_id: b9135goeh1uc1s2i07nm
  fingerprint: 65e5b050069da5ca5996a4a8a92514098b0a5dd1
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAwI...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T17:14:18.804Z"
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_device` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_device).
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

- API

  Добавить сертификат устройству можно с помощью метода API [addCertificate](../../api-ref/Device/addCertificate.md).

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs %}

- Консоль управления

   Чтобы удалить сертификат устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить сертификат устройства.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Нажмите на имя нужного реестра.
   1. В левом меню выберите **Устройства**.
   1. Выберите в списке нужное устройство.
   1. На странице **Обзор** перейдите к разделу **Сертификаты**.
   1. В строке с нужным сертификатом нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

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

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_device` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_device).
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

- API

  Удалить сертификат устройства можно с помощью метода API [deleteCertificate](../../api-ref/Device/deleteCertificate.md).

{% endlist %}