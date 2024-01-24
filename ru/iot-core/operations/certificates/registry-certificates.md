# Управление сертификатами реестра

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять сертификатами реестра для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Посмотреть список сертификатов реестра](registry-certificates.md#list-cert)
- [Добавить сертификат реестру](registry-certificates.md#add-cert)
- [Удалить сертификат реестра](registry-certificates.md#delete-cert)

Для обращения к [реестру](../../concepts/index.md#registry) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя реестра, читайте в разделе [{#T}](../registry/registry-list.md).

## Получить список сертификатов реестра {#registry-certificates-list}

{% include [registry-certificates-list](../../../_includes/iot-core/registry-certificates-list.md) %}

## Добавить сертификат {#add-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить сертификат реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который вы хотите добавить сертификат реестра.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
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

  Добавьте сертификат реестру:

  ```
  yc iot registry certificate add \
    --registry-name my-registry \ # Имя реестра.
    --certificate-file registry-cert.pem # Путь к публичной части сертификата.
  ```
  
  Результат:
  ```
  registry_id: b91ki3851hab********
  fingerprint: 589ce1605...
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAw...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T16:40:48.230Z"
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы добавить сертификат реестру, созданному с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_registry` — параметры реестра:
       * `name` — имя реестра.
       * `description` — описание реестра.
       * `certificates` — список сертификатов реестра для авторизации с помощью [сертификатов](../../concepts/authorization.md#certs).

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
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

      Проверить сертификаты реестра можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry certificate list --registry-name <имя_реестра>
      ```

- API {#api}

  Чтобы добавить сертификат реестру, воспользуйтесь методом REST API [addCertificate](../../api-ref/Registry/addCertificate.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/AddCertificate](../../api-ref/grpc/registry_service.md#AddCertificate).

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить сертификат реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить сертификат реестра.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_certificates }}**.
   1. В строке с нужным сертификатом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.delete }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите сертификат реестра:

      ```
      yc iot registry certificate delete --registry-name my-registry --fingerprint 0f...
      ```

  1. Проверьте, что сертификат действительно удален:

      ```
      yc iot registry certificate list --registry-name my-registry
	    ```
	  
	    Результат:
	  
	    ```
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить сертификат реестра, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите значение сертификата в блоке `certificates`, во фрагменте с описанием реестра. Чтобы удалить все сертификаты, удалите блок `certificates` целиком.

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
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

      Проверить сертификаты реестра можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry certificate list --registry-name <имя_реестра>
      ```

- API {#api}

  Чтобы удалить сертификат реестра, воспользуйтесь методом REST API [deleteCertificate](../../api-ref/Registry/deleteCertificate.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/DeleteCertificate](../../api-ref/grpc/registry_service.md#DeleteCertificate).

{% endlist %}