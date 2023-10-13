---
title: "Как создать брокер"
description: "Следуя данной инструкции, вы сможете создать брокер."
---

# Создание брокера

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать брокер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.iot.label_brokers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_create-broker }}**.
  1. В блоке **{{ ui-key.yacloud.common.section-base }}** укажите:

      * **{{ ui-key.yacloud.common.name }}** брокера. Например, `my-broker`.
      * (Опционально) **{{ ui-key.yacloud.common.description }}** — дополнительную информацию о брокере.
      * (Опционально) **{{ ui-key.yacloud.common.password }}**, если будете использовать его вместо сертификата для доступа к брокеру. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

          {% note info %}

          Сохраните пароль, он вам понадобится для [аутентификации](../../concepts/authorization.md).

          {% endnote %}

      * (Опционально) Для присвоения брокеру метки заполните поля **{{ ui-key.yacloud.component.key-values-input.label_key }}** и **{{ ui-key.yacloud.component.key-values-input.label_value }}** и нажмите кнопку **{{ ui-key.yacloud.iot.button_add-label }}**.

  1. (Опционально) Добавьте [сертификат](../certificates/create-certificates.md):

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

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте брокер:

      ```bash
      yc iot broker create --name <название брокера>
      ```

      Требования к названию брокера:

      {% include [name-format](../../../_includes/name-format.md) %}

      Результат:

      ```text
      id: b91ki3851h**********
      folder_id: aoek49ghmk*********
      created_at: "2022-05-28T11:29:42.420Z"
      name: <название брокера>
      status: ACTIVE
      ```

  1. (Опционально) Присвойте брокеру пароль для аутентификации с помощью [логина и пароля](../../concepts/authorization.md#log-pass):

      ```bash
      yc iot broker password add --broker-name <название брокера>
      ```

      Команда предложит ввести пароль. Требования к нему:

      * пароль должен содержать цифры, буквы в верхнем и нижнем регистре, специальные символы;
      * длина пароля — не менее 14 символов.

      Результат:

      ```text
      broker_id: b91ki3851h**********
      id: aoek49ghmk*********
      created_at: "2022-05-28T11:32:42.420Z"
      ```

  1. (Опционально) Добавьте брокеру сертификат для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs):

      ```bash
      yc iot broker certificate add \
         --broker-name <название брокера> \
         --certificate-file <сертификат>
      ```

      Где:

      * `--broker-name` — имя брокера;
      * `--certificate-file` — путь к публичному ключу сертификата, например `cert.pem`.

      Результат:

      ```text
      broker_id: b91ki3851h**********
      fingerprint: 1f21cf6d0183d****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIEpDCCAow...
         -----END CERTIFICATE-----
      created_at: "2023-07-11T16:20:53.466370019Z"
      ```

- {{ TF }} 

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
   
  {% note info %}

  Чтобы добавить сертификаты брокеру, [подготовьте](../certificates/create-certificates.md) их заранее.

  {% endnote %}

  Чтобы создать брокер: 
     
  1. Опишите в конфигурационном файле параметры ресурса, который необходимо создать:

     * `yandex_iot_core_broker` — параметры брокера:
       * `name` — имя брокера;
       * `description` — описание брокера;
       * `labels` — метки брокера в формате `ключ:значение`;
       * `certificates` — список сертификатов брокера для аутентификации с помощью [сертификатов](../certificates/create-certificates.md).

      Пример структуры ресурса в конфигурационном файле:
      
      ```
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          test-label = "label-test"
        }

        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      }

      output "yandex_iot_core_broker_my_broker" {
        value = "${yandex_iot_core_broker.my_broker.id}"
      }
      ```

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_broker).

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
      
          После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

          ```bash
          yc iot broker list
          ```

- API

  Чтобы создать брокер, воспользуйтесь методом REST API [create](../../broker/api-ref/Broker/create.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Create](../../broker/api-ref/grpc/broker_service.md#Create).

{% endlist %}
