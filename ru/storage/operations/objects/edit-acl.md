---
title: "Редактирование ACL объекта в {{ objstorage-full-name }}"
description: "Для управления доступом к объекту в бакете {{ objstorage-name }} можно использовать список управления доступом (ACL)."
---

# Редактирование ACL объекта

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

Для управления доступом к объекту в бакете {{ objstorage-name }} можно воспользоваться [ACL](../../concepts/acl.md).

{% note info %}

Если ранее для объекта уже был задан [ACL](../../concepts/acl.md), то после применения изменений ACL будет полностью перезаписан.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ objstorage-name }}**.
    1. Нажмите на имя бакета.
    1. Чтобы отредактировать ACL, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) справа от имени объекта и выберите **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.
      
        Также можно нажать на имя объекта, на открывшейся странице нажать ![image](../../../_assets/console-icons/ellipsis.svg) и выбрать **{{ ui-key.yacloud.storage.file.button_permissions }}**.

    1. В появившемся окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}** выдайте или отзовите необходимые разрешения.

        {% note info %}
  
        {% include [console-sa-acl-note](../../../_includes/storage/console-sa-acl-note.md) %}
  
        {% endnote %}

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  {% note info %}

  Чтобы управлять ACL объекта, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../../security/index.md#storage-admin) `storage.admin`.

  {% endnote %}

  Посмотрите текущий ACL объекта:

  ```bash
  aws s3api get-object-acl \
    --endpoint https://{{ s3-storage-host }} \
    --bucket <имя_бакета> \
    --key <ключ_объекта>
  ```

  Где:
  * `--endpoint` — эндпоинт {{ objstorage-name }}.
  * `--bucket` — имя бакета.
  * `--key` — ключ объекта.

  Вы можете применить к объекта [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [системных групп](../../concepts/acl.md#system-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Эти настройки несовместимы: у объекта должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  **Предопределенный ACL**

  Выполните команду:

  ```bash
  aws s3api put-object-acl \
    --endpoint https://{{ s3-storage-host }} \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --acl <предопределенный_ACL>
  ```

  Где:

  * `--endpoint` — эндпоинт {{ objstorage-name }}.
  * `--bucket` — имя бакета.
  * `--key` — ключ объекта.
  * `--acl` — предопределенный ACL. Список значений см. в разделе [{#T}](../../concepts/acl.md#predefined-acls).
  
  **Настройка отдельных разрешений**

  1. Чтобы выдать разрешения ACL для пользователя {{ yandex-cloud }}, сервисного аккаунта или группы пользователей, получите их идентификатор:
  
      
      * [Пользователь](../../../iam/operations/users/get.md).
      * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
      * Группа пользователей — перейдите на вкладку [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-main }}groups) в интерфейсе {{ org-name }}.
  

  1. Выполните команду:

      ```bash
      aws s3api put-object-acl \
        --endpoint https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        <тип_разрешения> <получатель_разрешения>
      ```

        Где:
        * `--endpoint` — эндпоинт {{ objstorage-name }}.
        * `--bucket` — имя бакета.
        * `--key` — ключ объекта.
        * Возможные типы разрешений ACL:
          * `--grant-read` — доступ к чтению объекта.
          * `--grant-full-control` — полный доступ к объекту.
          * `--grant-read-acp` — доступ к чтению ACL объекта.
          * `--grant-write-acp` — доступ к редактированию ACL объекта.
          
          Вы можете задать несколько разрешений в одной команде.
        * Возможные получатели разрешений:
          * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
          * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [системная группа](../../concepts/acl.md#system-groups) всех аутентифицированных пользователей {{ yandex-cloud }}.
          * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — системная группа всех пользователей интернета.

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

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
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение группы безопасности можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы отредактировать ACL объекта, воспользуйтесь методом S3 API [objectPutAcl](../../s3/api-ref/acl/objectput.md).

  Чтобы загрузить объект с установкой ACL, воспользуйтесь методом S3 API [upload](../../s3/api-ref/object/upload.md) с заголовками `X-Amz-Acl`, `X-Amz-Grant-Read`, `X-Amz-Grant-Read-Acp`, `X-Amz-Grant-Write-Acp` и `X-Amz-Grant-Full-Control`.

{% endlist %}
