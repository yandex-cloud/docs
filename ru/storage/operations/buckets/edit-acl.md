---
title: Редактирование ACL бакета в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете редактировать список управления доступом (ACL) бакета в {{ objstorage-name }}.
---

# Редактирование ACL бакета

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

{% note info %}

Если ранее для [бакета](../../concepts/bucket.md) уже был задан [ACL](../../concepts/acl.md), то после применения изменений ACL будет полностью перезаписан.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите нужный бакет и нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.
  1. В окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}** выдайте или отзовите необходимые разрешения.

      {% note info %}

      {% include [console-sa-acl-note](../../../_includes/storage/console-sa-acl-note.md) %}

      {% endnote %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Перед настройкой ACL посмотрите описание команды CLI для редактирования бакета:

  ```bash
  yc storage bucket update --help
  ```

  Чтобы посмотреть текущий ACL бакета, выполните команду:

  ```bash
  yc storage bucket get <имя_бакета> --with-acl
  ```

  Вы можете применить к бакету [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Эти настройки несовместимы: у бакета должен быть либо предопределенный ACL, либо набор отдельных разрешений.


  Предопределенный ACL

  : Выполните команду:

    ```bash
    yc storage bucket update --name <имя_бакета> --acl <предопределенный_ACL>
    ```

    Где:
    * `--name` — имя бакета.
    * `--acl` — предопределенный ACL. Список значений см. в разделе [{#T}](../../concepts/acl.md#predefined-acls).

    Результат:

    ```text
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

  : 1. Чтобы выдать разрешения ACL для пользователя {{ yandex-cloud }}, сервисного аккаунта или группы пользователей, получите их идентификатор:

        
        * [Пользователь](../../../iam/operations/users/get.md).
        * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
        * Группа пользователей — перейдите на вкладку [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-cloud-center }}/groups) в интерфейсе {{ cloud-center }}.


    1. Выполните команду:

       ```bash
       yc storage bucket update --name <имя_бакета> \
         --grants grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=<тип_разрешения>
       ```

       Где:
       * `grant-type` — тип получателя разрешения. Возможные значения:
         * `grant-type-account` — пользователь, [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) или [группа пользователей](../../../organization/concepts/groups.md);
         * `grant-type-all-authenticated-users` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей {{ yandex-cloud }};
         * `grant-type-all-users` — публичная группа всех пользователей интернета.
       * `grantee-id` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение. Указывается, только если `grant-type=grant-type-account`.
       * `permission` — тип разрешения ACL. Возможные значения:
         * `permission-read` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
         * `permission-write` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `permission-read`.
         * `permission-full-control` — полный доступ к бакету и объектам в нем.
         Подробнее о разрешениях см. в разделе [{#T}](../../concepts/acl.md#permissions-types).

       Чтобы настроить несколько разрешений, укажите параметр `--grants` несколько раз. Например, чтобы выдать разрешение на запись в бакет, выполните команду:

       ```bash
       yc storage bucket update --name <имя_бакета> \
         --grants grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=permission-read \
         --grants grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=permission-write
       ```

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  {% note info %}

  Чтобы управлять ACL бакета, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../../security/index.md#storage-admin) `storage.admin`.

  {% endnote %}


  Посмотрите текущий ACL бакета:

  ```bash
  aws s3api get-bucket-acl \
    --endpoint https://{{ s3-storage-host }} \
    --bucket <имя_бакета>
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--endpoint` — эндпоинт {{ objstorage-name }}.

  Вы можете применить к бакету [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Эти настройки несовместимы: у бакета должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  Предопределенный ACL

  : Выполните команду:

    ```bash
      aws s3api put-bucket-acl \
        --endpoint https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --acl <предопределенный_ACL>
    ```

    Где:

    * `--endpoint` — эндпоинт {{ objstorage-name }}.
    * `--bucket` — имя бакета.
    * `--acl` — предопределенный ACL. Список значений см. в разделе [{#T}](../../concepts/acl.md#predefined-acls).

  Настройка отдельных разрешений

  : 1. Чтобы выдать разрешения ACL для пользователя {{ yandex-cloud }}, сервисного аккаунта или группы пользователей, получите их идентификатор:

        
        * [Пользователь](../../../iam/operations/users/get.md).
        * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
        * Группа пользователей — перейдите на вкладку [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-cloud-center }}/groups) в интерфейсе {{ cloud-center }}.


    1. Выполните команду:

        ```bash
        aws s3api put-bucket-acl \
          --endpoint https://{{ s3-storage-host }} \
          --bucket <имя_бакета> \
          <тип_разрешения> <получатель_разрешения>
        ```

        Где:
        * `--bucket` — имя бакета.
        * `--endpoint` — эндпоинт {{ objstorage-name }}.
        * Возможные типы разрешений ACL:
          * `--grant-read` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
          * `--grant-write` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `--grant-read`.
          * `--grant-full-control` — полный доступ к бакету и объектам в нем.

          Подробнее о разрешениях см. в разделе [{#T}](../../concepts/acl.md#permissions-types).

        * Возможные получатели разрешений:
          * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
          * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей {{ yandex-cloud }}.
          * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — публичная группа всех пользователей интернета.

        Чтобы настроить несколько разрешений, укажите параметры, тип разрешения и получателя разрешения несколько раз. Например, чтобы выдать разрешение на запись в бакет, выполните команду:

        ```bash
        aws s3api put-bucket-acl \
          --endpoint https://storage.yandexcloud.net \
          --bucket <имя_бакета> \
          --grant-read id=<идентификатор_получателя> \
          --grant-write id=<идентификатор_получателя>
        ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}


  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Перед началом работы, получите [статические ключи доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket = "<имя_бакета>"
       grant {
         id          = "<идентификатор_пользователя>"
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
     * `grant` — настройки [ACL](../../concepts/acl.md). Необязательный параметр. Чтобы управлять этим параметром, у сервисного аккаунта, на который получены статические ключи доступа, должна быть [роль](../../security/index.md#roles-list) `storage.admin` на бакет или каталог.
       * `type` — тип получателя разрешений. Возможные значения:
         * `CanonicalUser` — для пользователя, [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) или [группы пользователей](../../../organization/concepts/groups.md).
         * `Group` — для [публичной группы](../../concepts/acl.md#public-groups).
       * `permissions` — тип [разрешений](../../concepts/acl.md#permissions-types) ACL, возможные значения:
         * `READ` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
         * `WRITE` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `READ`, например `permissions = ["READ", "WRITE"]`.
         * `FULL_CONTROL` — полный доступ к бакету и объектам в нем.

         Подробнее о разрешениях см. в разделе [{#T}](../../concepts/acl.md#permissions-types).

       * `id` — идентификатор пользователя, сервисного аккаунта или группы пользователей. Используется с типом получателя разрешений `CanonicalUser`.

         
         Идентификаторы можно получить следующими способами:
         * [Пользователь](../../../iam/operations/users/get.md).
         * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
         * Группа пользователей — перейдите на вкладку [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-cloud-center }}/groups) в интерфейсе {{ cloud-center }}.


       * `uri` — идентификатор публичной группы. Используется с типом получателя разрешений `Group`. Возможные значения:
         * `http://acs.amazonaws.com/groups/global/AllUsers` — все пользователи интернета.
         * `http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — все аутентифицированные пользователи {{ yandex-cloud }}.

     Вместо параметра `grant` вы можете указать параметр `acl` — [предопределенный ACL](../../../storage/concepts/acl.md#predefined-acls) бакета. Значение по умолчанию — `private`: пользователи {{ yandex-cloud }} получают разрешения в соответствии со своими ролями в {{ iam-short-name }}.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы редактировать ACL бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md) или методом S3 API [bucketPutAcl](../../s3/api-ref/acl/bucketput.md).

{% endlist %}
