---
title: "Редактирование ACL объекта в {{ objstorage-full-name }}"
description: "Для управления доступом к объекту в бакете {{ objstorage-name }} можно использовать список управления доступом (ACL)."
---

# Редактирование ACL объекта

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

Для управления доступом к объекту в бакете {{ objstorage-name }} можно воспользоваться [ACL](../../concepts/acl.md).

{% list tabs group=instructions %}

- Консоль управления {#console}
  
    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ objstorage-name }}**.
    1. Нажмите на имя бакета.
    1. Чтобы отредактировать ACL, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) справа от имени объекта и выберите **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.
      
        Также можно нажать на имя объекта, на открывшейся странице нажать ![image](../../../_assets/console-icons/ellipsis.svg) и выбрать **{{ ui-key.yacloud.storage.file.button_permissions }}**.

    1. В появившемся окне **{{ ui-key.yacloud.storage.permissions-dialog.label_title }}** выдайте или отзовите необходимые разрешения.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  Чтобы отредактировать ACL объекта:

  1. Откройте файл конфигурации {{ TF }} и добавьте параметр `acl` в описание объекта.

     ```hcl
     ...
     resource "yandex_storage_object" "cute-cat-picture" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "cat-pictures"
       key        = "cute-cat"
       source     = "/images/cats/cute-cat.jpg"
       acl        = "public-read"
     }
     ...
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `acl` — [предопределенный ACL](../../../storage/concepts/acl.md#predefined-acls) объекта. Значение по умолчанию — `private`: пользователи {{ yandex-cloud }} получают разрешения в соответствии со своими ролями в {{ iam-short-name }}.

     Более подробную информацию о параметрах ресурса `yandex_storage_object` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_object).

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение группы безопасности можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы отредактировать ACL объекта, воспользуйтесь методом S3 API [objectPutAcl](../../s3/api-ref/acl/objectput.md).

  Чтобы загрузить объект с установкой ACL, воспользуйтесь методом S3 API [upload](../../s3/api-ref/object/upload.md) с заголовками `X-Amz-Acl`, `X-Amz-Grant-Read`, `X-Amz-Grant-Read-Acp`, `X-Amz-Grant-Write-Acp` и `X-Amz-Grant-Full-Control`.

{% endlist %}
