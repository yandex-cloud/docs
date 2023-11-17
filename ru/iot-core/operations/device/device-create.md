---
title: "Создание устройства"
description: "Следуя данной инструкции, вы сможете создать устройство."
---

# Создание устройства

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать устройство.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-device }}**.
   1. В блоке **{{ ui-key.yacloud.common.section-base }}** добавьте:

      * **{{ ui-key.yacloud.common.name }}** устройства. Например, `my-device`.
      * (Опционально) **{{ ui-key.yacloud.common.description }}** с дополнительной информацией об устройстве.
      * (Опционально) **{{ ui-key.yacloud.common.password }}**, который вы будете использовать для доступа к устройству. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

         {% note info %}

         Сохраните пароль, он вам понадобится для [аутентификации](../../concepts/authorization.md).

         {% endnote %}

   1. (Опционально) Добавьте [алиасы](../../concepts/topic/usage.md#aliases):

      1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Заполните поля: введите алиас (например, `events`) и тип топика после `$devices/<deviceID>` (например, `events`). Вы сможете использовать алиас `events` вместо топика `$devices/<deviceID>/events`.

   1. (Опционально) Добавьте [сертификат](../../operations/certificates/create-certificates.md):

      * Чтобы добавить файл:

         1. Выберите способ `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
         1. Нажмите кнопку **Прикрепить файл**.
         1. Выберите файл с публичным ключом сертификата и нажмите кнопку **Открыть**.
         1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * Чтобы добавить текст:

         1. Выберите способ `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
         1. Вставьте публичный ключ сертификата в поле **{{ ui-key.yacloud.component.file-content-dialog.field_content }}**.
         1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. [Посмотрите список реестров](../registry/registry-list.md#registry-list), в которых можно создать устройство, или [создайте новый реестр](../registry/registry-create.md).

   1. Создайте устройство:

      ```bash
      yc iot device create \
         --registry-name <название реестра> \
         --name <название устройства>
      ```

      Требования к названию устройства:

      {% include [name-format](../../../_includes/name-format.md) %}

      Результат:

      ```text
      id: b9135goeh**********
      registry_id: b91ki3851h**********
      created_at: "2019-05-28T16:08:30.938Z"
      name: <название устройства>
      status: ACTIVE
      ```

   1. (Опционально) Присвойте устройству пароль для аутентификации с помощью [логина и пароля](../../concepts/authorization.md#log-pass):

      ```bash
      yc iot device password add --device-name <название устройства>
      ```

      Команда предложит ввести пароль. Требования к паролю:

      * пароль должен содержать цифры, буквы в верхнем и нижнем регистре, специальные символы;
      * длина пароля — не менее 14 символов.

      Результат:

      ```text
      device_id: b9135goeh**********
      id: aoek49ghmk*********
      created_at: "2019-05-28T16:12:30.938Z"
      ```

   1. (Опционально) Добавьте реестру сертификат для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs):

      ```bash
      yc iot device certificate add \
         --device-name <название устройства> \
         --certificate-file <сертификат>
      ```

      Где:

      * `--device-name` — имя устройства;
      * `--certificate-file` — путь к публичному ключу сертификата, например `cert.pem`.

      Результат:

      ```text
      device_id: b9135goeh**********
      fingerprint: 589ce16050****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIE/jCCAuagAwIBAgIJAPRA...
         -----END CERTIFICATE-----
      created_at: "2019-05-28T16:15:30.938Z"
      ```

   1. (Опционально) Добавьте [алиасы](../../concepts/topic/usage.md#aliases):

      ```bash
      yc iot device add-topic-aliases \
         --name <название устройства> \
         --topic-aliases <алиас>='<топик>'
      ```

      Пример:

      ```bash
      yc iot device add-topic-aliases \
         --name my-device \
         --topic-aliases events='$devices/are0ej5kpik15mulb4do/events'
      ```

      Результат:

      ```text
      id: aoek49ghmk*********
      registry_id: b91ki3851h**********
      created_at: "2019-05-28T16:17:30.938Z"
      name: <название устройства>
      topic_aliases:
        <алиас>: <топик>
      status: ACTIVE
      ```

- {{ TF }} 

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}
   
   {% note info %}

   Чтобы добавить сертификаты устройству, [подготовьте](../certificates/create-certificates.md) их заранее.

   {% endnote %}

   Чтобы создать устройство: 
   
   1. [Посмотрите список реестров](../registry/registry-list.md#registry-list), в которых можно создать устройство, или [создайте новый реестр](../registry/registry-create.md).

   1. Опишите в конфигурационном файле параметры ресурса, который необходимо создать:

      * `yandex_iot_core_device` — параметры устройства:

         * `registry_id` — идентификатор реестра, в котором создается устройство.
         * `name` — имя устройства.
         * `description` — описание устройства.
         * `aliases` — алиасы топиков. Подробнее см. [Создание алиаса](../device/alias/alias-create.md).
         * `passwords` — список паролей для аутентификации с помощью [логина и пароля](../../concepts/authorization.md#log-pass).
         * `certificates` — список сертификатов для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs).

      {% note info %}

      Используйте только один из двух способов аутентификации.

      {% endnote %}

      Пример структуры ресурса в конфигурационном файле:
      
      ```
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор реестра>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
        
        aliases = {
          "some-alias1/subtopic" = "$devices/{id}/events/somesubtopic",
          "some-alias2/subtopic" = "$devices/{id}/events/aaa/bbb",
        }
        
        passwords = [
          "<пароль>",
        ]
        
        certificates = [
          file("<путь к файлу с сертификатом>")
        ]
      }
      ```
      
      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).
      
   1. Проверьте корректность конфигурационных файлов.
      
      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:
         ```
         terraform plan
         ```
      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
         
   1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:
         ```
         terraform apply
         ```
      1. Подтвердите создание ресурсов.
      
      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

  Чтобы создать устройство, воспользуйтесь методом REST API [create](../../api-ref/Device/create.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Create](../../api-ref/grpc/device_service.md#Create).

{% endlist %}
