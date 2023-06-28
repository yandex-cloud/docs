---
title: "Редактирование ACL бакета в {{ objstorage-full-name }}"
description: "Для управления доступом к бакету {{ objstorage-name }}, помимо {{ iam-short-name }}, можно использовать список управления доступом (ACL)."
---

# Редактирование ACL бакета

Для управления доступом к бакету {{ objstorage-name }}, помимо [{{ iam-short-name }}](../../../iam/), можно воспользоваться [ACL](../../concepts/acl.md).

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Чтобы отредактировать ACL, нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) справа от имени бакета и выберите **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
    
     Также можно нажать на имя бакета и на открывшейся странице нажать кнопку **{{ ui-key.yacloud.storage.bucket.button_permissions }}**.

  1. В появившемся окне **{{ ui-key.yacloud.storage.permissions-dialog.label_title }}** выдайте или отзовите необходимые разрешения.

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Перед настройкой ACL посмотрите описание команды CLI для редактирования бакета:

  ```bash
  yc storage bucket update --help
  ```
  
  Вы можете применить к бакету [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md) и [системных групп](../../concepts/acl.md#system-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Эти настройки несовместимы: у бакета должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  Применение предопределенного ACL

  : Выполните команду:

    ```bash
    yc storage bucket update --name <имя_бакета> --acl <предопределенный_ACL>
    ```
  
    Где:
    * `--name` — имя бакета.
    * `--acl` — предопределенный ACL. Список значений см. в разделе [{#T}](../../concepts/acl.md#predefined-acls).

    Результат:

    ```bash
    name: my-bucket
    folder_id: csgeoelk7fl1********
    default_storage_class: STANDARD
    versioning: VERSIONING_DISABLED
    max_size: "1073741824"
    acl:
      grants:
        - permission: PERMISSION_READ
          grant_type: GRANT_TYPE_ALL_USERS
    created_at: "2022-12-14T19:10:05.957940Z"
    ```

  Настройка отдельных разрешений

  : 1. Чтобы выдать разрешения с помощью ACL для пользователя {{ yandex-cloud }} или сервисного аккаунта, получите его идентификатор. Подробнее см. в инструкциях [{#T}](../../../iam/operations/users/get.md) и [{#T}](../../../iam/operations/sa/get-id.md).
    1. Выполните команду:

       ```bash
       yc storage bucket update --name <имя_бакета> \
         --grants grant-type=<тип_получателя_разрешения>,grantee-id=<ID_получателя>,permission=<тип_разрешения>
       ```
     
       Где:
       * `grant-type` — тип получателя разрешения. Возможные значения:
         * `grant-type-account` — пользователь или сервисный аккаунт;
         * `grant-type-all-authenticated-users` — [системная группа](../../concepts/acl.md#system-groups) всех аутентифицированных пользователей {{ yandex-cloud }};
         * `grant-type-all-users` — системная группа всех пользователей интернета.
       * `grantee-id` — ID пользователя или сервисного аккаунта, которому нужно дать разрешение. Указывается, только если `grant-type=grant-type-account`.
       * `permission` — тип разрешения ACL. Возможные значения: `permission-full-control`, `permission-write`, `permission-read`. Подробнее о разрешениях см. в разделе [{#T}](../../concepts/acl.md#permissions-types). 

       Чтобы настроить несколько разрешений, укажите параметр `--grants` несколько раз.
     
       Разрешения, указанные в команде, перезаписывают настройки ACL, которые уже есть у бакета, в том числе предопределенный ACL. Получить текущие разрешения можно с помощью команды `yc storage bucket get <имя_бакета> --full`.
    
       Результат:

       ```bash
       name: my-bucket
       folder_id: csgeoelk7fl1********
       default_storage_class: STANDARD
       versioning: VERSIONING_SUSPENDED
       max_size: "10737418240"
       acl:
         grants:
           - permission: PERMISSION_READ
             grant_type: GRANT_TYPE_ACCOUNT
             grantee_id: ajej2th5699n********
       created_at: "2022-12-14T08:42:16.273717Z"
       ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Перед началом работы, получите [статические ключи доступа](../../../iam/operations/sa/create-access-key.md) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```
     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"
       bucket = "<имя бакета>"
       grant {
         id          = "<идентификатор пользователя>"
         type        = "CanonicalUser"
         permissions = ["FULL_CONTROL"]
       }

       grant {
         type        = "Group"
         permissions = ["READ", "WRITE"]
         uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
       }
     }
     ```

     Где:

     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета. Обязательный параметр.
     * `grant` — настройки политики доступа [ACL](../../concepts/acl.md). Необязательный параметр. Для управления следует использовать учетную запись службы с правами администратора.
       * `id` —  идентификатор пользователя.
       * `type` — тип системной группы.
       * `permissions` — типы разрешений согласно [ACL](../../concepts/acl.md#permissions-types).
       * `uri` — идентификатор системной группы.

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

  Чтобы редактировать ACL бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) или методом S3 API [bucketPutAcl](../../s3/api-ref/acl/bucketput.md).

{% endlist %}
