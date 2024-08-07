---
title: "Создание реестра"
description: "Следуя данной инструкции, вы сможете создать реестр."
---

# Создание реестра

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать реестр.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. На панели слева выберите иконку **{{ ui-key.yacloud.iot.label_registries }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_create-registry }}**.
  1. В блоке **{{ ui-key.yacloud.common.section-base }}** добавьте:

      * **{{ ui-key.yacloud.common.name }}** реестра. Например, `my-registry`.
      * (Опционально) **{{ ui-key.yacloud.common.description }}** с дополнительной информацией о реестре.
      * **{{ ui-key.yacloud.common.password }}**, который вы будете использовать для доступа к реестру. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

          {% include [password-save](../../../_includes/iot-core/password-save.md) %}

      * (Опционально) Для присвоения реестру метки заполните поля **{{ ui-key.yacloud.component.key-values-input.label_key }}** и **{{ ui-key.yacloud.component.key-values-input.label_value }}** и нажмите кнопку **{{ ui-key.yacloud.iot.button_add-label }}**.

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

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте реестр:

      ```bash
      yc iot registry create --name <имя_реестра>
      ```

      Требования к названию реестра:

      {% include [name-format](../../../_includes/name-format.md) %}

      Результат:

      ```text
      id: b91hafek85**********
      folder_id: aoek49ghmk*********
      created_at: "2019-05-27T13:40:06.923Z"
      name: <имя_реестра>
      status: ACTIVE
      log_group_id: ckghotead**********
      ```

  1. (Опционально) Присвойте реестру пароль для аутентификации с помощью [логина и пароля](../../concepts/authorization.md#log-pass):

      ```bash
      yc iot registry password add --registry-name <имя_реестра>
      ```

      Команда предложит ввести пароль. Требования к паролю:

      * пароль должен содержать цифры, буквы в верхнем и нижнем регистре, специальные символы;
      * длина пароля — не менее 14 символов.

      Результат:

      ```text
      registry_id: b91hafek85**********
      id: aoek49ghmk*********
      created_at: "2019-05-27T13:44:06.923Z"
      ```

  1. (Опционально) Добавьте реестру сертификат для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs):

      ```bash
      yc iot registry certificate add \
         --registry-name <имя_реестра> \
         --certificate-file <сертификат>
      ```

      Где:

      * `--registry-name` — имя реестра;
      * `--certificate-file` — путь к публичному ключу сертификата, например `cert.pem`.

      Результат:

      ```text
      registry_id: b91hafek85**********
      fingerprint: 589ce16050****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIE/jCCAuagAwIBAgIJAPRA...
         -----END CERTIFICATE-----
      created_at: "2019-05-27T13:41:45.295Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
   
  {% note info %}

  Чтобы добавить сертификаты реестру, [подготовьте](../certificates/create-certificates.md) их заранее.

  {% endnote %}

  Чтобы создать реестр устройств: 
     
  1. Опишите в конфигурационном файле параметры ресурса, который необходимо создать:

     * `yandex_iot_core_registry` — параметры реестра:

        * `name` — имя реестра;
        * `description` — описание реестра;
        * `labels` — метки реестра в формате `ключ:значение`;
        * `passwords` — список паролей реестра для аутентификации с помощью [логина и пароля](../../concepts/authorization.md#log-pass);
        * `certificates` — список сертификатов реестра для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs).

      {% note info %}

      Используйте только один из двух способов аутентификации.

      {% endnote %}

      Пример структуры ресурса в конфигурационном файле:

      ```
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          test-label = "label-test"
        }

        passwords = [
          "<пароль_1>",
          "<пароль_2>"
        ]

        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      }

      output "yandex_iot_core_registry_my_registry" {
        value = "${yandex_iot_core_registry.my_registry.id}"
      }
      ```

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
      
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
          yc iot registry list
          ```

- API {#api}

  Чтобы создать реестр, воспользуйтесь методом REST API [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../api-ref/grpc/registry_service.md#Create).

{% endlist %}