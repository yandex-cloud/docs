# Редактирование ACL бакета

В Object Storage реализовано несколько механизмов для управления доступом к ресурсам. Алгоритм взаимодействия этих механизмов смотрите в [Обзор способов управления доступом в Object Storage](../../security/overview.md).

{% note info %}

Если ранее для [бакета](../../concepts/bucket.md) уже был задан [ACL](../../concepts/acl.md), то после применения изменений ACL будет полностью перезаписан.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. В строке с нужным бакетом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Настроить ACL**.

      Также можно нажать на имя бакета, на открывшейся странице справа сверху нажать ![image](../../../_assets/console-icons/ellipsis.svg) и выбрать **Настроить ACL**.

      В открывшемся окне **Редактирование ACL** выдайте или отзовите необходимые разрешения:
      
      1. Выберите нужных [субъектов](../../../iam/concepts/access-control/index.md#subject) из списка. Для этого поместите курсор в поле для ввода данных субъекта и в появившейся форме выберите нужного [пользователя](../../../overview/roles-and-resources.md#users), [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), [группу пользователей](../../../organization/concepts/groups.md), [системную группу](../../../iam/concepts/access-control/system-group.md) или [публичную группу](../../../iam/concepts/access-control/public-group.md). При необходимости воспользуйтесь соответствующими вкладками формы или строкой поиска по имени или электронному адресу субъекта.
      
          Задать разрешение вы можете одновременно для нескольких субъектов, для этого выбирайте их поочередно.
      
      1. Задайте для выбранных субъектов необходимый [вид разрешений](../../concepts/acl.md#permissions-types) и нажмите **Добавить**.
      
      1. Если требуется задать субъектам другие виды разрешений, повторите два предыдущих шага.
      
      1. Чтобы отозвать выданное субъекту разрешение, нажмите **Отменить** в строке с этим разрешением.
      
      1. Нажмите кнопку **Сохранить**.

      {% note info %}
  
      В консоли управления разрешения можно выдать только тем сервисным аккаунтам, которые созданы в том же каталоге, что и сам бакет. Выдать разрешения для сервисных аккаунтов, относящихся к другим каталогам, можно с помощью Yandex Cloud CLI (только для ACL бакета), AWS CLI, Terraform или API.
  
      {% endnote %}

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.


  К бакету можно применить [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей Yandex Cloud). Эти настройки несовместимы: у бакета должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  Вы можете редактировать ACL бакета с помощью следующих команд:
  * [yc storage bucket update](#yc-storage-bucket-update)
  * [yc storage s3api put-bucket-acl](#yc-storage-s3api-put-bucket-acl)

  **yc storage bucket update** {#yc-storage-bucket-update}

  Перед настройкой ACL посмотрите описание команды CLI для редактирования бакета:

  ```bash
  yc storage bucket update --help
  ```

  Чтобы посмотреть текущий ACL бакета, выполните команду:

  ```bash
  yc storage bucket get <имя_бакета> --with-acl
  ```

  _Предопределенный ACL_

  Выполните команду:

  ```bash
  yc storage bucket update \
    --name <имя_бакета> \
    --acl <предопределенный_ACL>
  ```

  Где:
  * `--name` — имя бакета.
  * `--acl` — предопределенный ACL. Список значений см. в разделе [Предопределенные ACL](../../concepts/acl.md#predefined-acls).

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

  _Настройка отдельных разрешений_

  1. Чтобы выдать разрешения ACL для пользователя Yandex Cloud, сервисного аккаунта или группы пользователей, получите их идентификатор:

      * [Пользователь](../../../organization/operations/users-get.md).
      * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
      * Группа пользователей — перейдите на вкладку [**Группы**](https://center.yandex.cloud/organization/groups) в интерфейсе Cloud Center.

  1. Выполните команду:

      ```bash
      yc storage bucket update --name <имя_бакета> \
        --grants grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=<тип_разрешения>
      ```

      Где:
      * `grant-type` — тип получателя разрешения. Возможные значения:
        * `grant-type-account` — пользователь, [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) или [группа пользователей](../../../organization/concepts/groups.md);
        * `grant-type-all-authenticated-users` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей Yandex Cloud;
        * `grant-type-all-users` — публичная группа всех пользователей интернета.
      * `grantee-id` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение. Указывается, только если `grant-type=grant-type-account`.
      * `permission` — тип разрешения ACL. Возможные значения:
        * `permission-read` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
        * `permission-write` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `permission-read`.
        * `permission-full-control` — полный доступ к бакету и объектам в нем.
      
        Подробнее о разрешениях см. в разделе [Виды разрешений](../../concepts/acl.md#permissions-types).

      Чтобы настроить несколько разрешений, укажите параметр `--grants` несколько раз. Например, чтобы выдать разрешение на запись в бакет, выполните команду:

      ```bash
      yc storage bucket update --name <имя_бакета> \
        --grants grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=permission-read \
        --grants grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=permission-write
      ```

  **yc storage s3api put-bucket-acl** {#yc-storage-s3api-put-bucket-acl}

  Посмотрите текущий ACL бакета:

  ```bash
  yc storage s3api get-bucket-acl \
    --bucket <имя_бакета>
  ```

  Где `--bucket` — имя бакета.

  _Предопределенный ACL_

  Выполните команду:

  ```bash
  yc storage s3api put-bucket-acl \
    --bucket <имя_бакета> \
    --acl <предопределенный_ACL>
  ```

  Где:
  * `--name` — имя бакета.
  * `--acl` — предопределенный ACL. Список значений см. в разделе [Предопределенные ACL](../../concepts/acl.md#predefined-acls).

  _Настройка отдельных разрешений_

  1. Чтобы выдать разрешения ACL для пользователя Yandex Cloud, сервисного аккаунта или группы пользователей, получите их идентификатор:

      * [Пользователь](../../../organization/operations/users-get.md).
      * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
      * Группа пользователей — перейдите на вкладку [**Группы**](https://center.yandex.cloud/organization/groups) в интерфейсе Cloud Center.

  1. Выполните команду:

      ```bash
      yc storage s3api put-bucket-acl \
        --bucket <имя_бакета> \
        <тип_разрешения> <получатель_разрешения>
      ```

      Где:
      * `--bucket` — имя бакета.
      * Возможные типы разрешений ACL:

        * `--grant-read` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
        * `--grant-write` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `--grant-read`.
        * `--grant-full-control` — полный доступ к бакету и объектам в нем.

        Подробнее о разрешениях см. в разделе [Виды разрешений](../../concepts/acl.md#permissions-types).

      * Возможные получатели разрешений:

        * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
        * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей Yandex Cloud.
        * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — публичная группа всех пользователей интернета.

      Чтобы настроить несколько разрешений, укажите параметры, тип разрешения и получателя разрешения несколько раз. Например, чтобы выдать разрешение на запись в бакет, выполните команду:

      ```bash
      yc storage s3api put-bucket-acl \
        --bucket <имя_бакета> \
        --grant-read id=<идентификатор_получателя> \
        --grant-write id=<идентификатор_получателя>
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  {% note info %}

  Чтобы управлять ACL бакета, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../../security/index.md#storage-admin) `storage.admin`.

  {% endnote %}


  Посмотрите текущий ACL бакета:

  ```bash
  aws s3api get-bucket-acl \
    --endpoint https://storage.yandexcloud.net \
    --bucket <имя_бакета>
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--endpoint` — эндпоинт Object Storage.

  К бакету можно применить [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей Yandex Cloud). Эти настройки несовместимы: у бакета должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  Предопределенный ACL

  : Выполните команду:

    ```bash
      aws s3api put-bucket-acl \
        --endpoint https://storage.yandexcloud.net \
        --bucket <имя_бакета> \
        --acl <предопределенный_ACL>
    ```

    Где:

    * `--endpoint` — эндпоинт Object Storage.
    * `--bucket` — имя бакета.
    * `--acl` — предопределенный ACL. Список значений см. в разделе [Предопределенные ACL](../../concepts/acl.md#predefined-acls).

  Настройка отдельных разрешений

  : 1. Чтобы выдать разрешения ACL для пользователя Yandex Cloud, сервисного аккаунта или группы пользователей, получите их идентификатор:

        * [Пользователь](../../../organization/operations/users-get.md).
        * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
        * Группа пользователей — перейдите на вкладку [**Группы**](https://center.yandex.cloud/organization/groups) в интерфейсе Cloud Center.

    1. Выполните команду:

        ```bash
        aws s3api put-bucket-acl \
          --endpoint https://storage.yandexcloud.net \
          --bucket <имя_бакета> \
          <тип_разрешения> <получатель_разрешения>
        ```

        Где:
        * `--bucket` — имя бакета.
        * `--endpoint` — эндпоинт Object Storage.
        * Возможные типы разрешений ACL:
          * `--grant-read` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
          * `--grant-write` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `--grant-read`.
          * `--grant-full-control` — полный доступ к бакету и объектам в нем.

          Подробнее о разрешениях см. в разделе [Виды разрешений](../../concepts/acl.md#permissions-types).

        * Возможные получатели разрешений:
          * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
          * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей Yandex Cloud.
          * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — публичная группа всех пользователей интернета.

        Чтобы настроить несколько разрешений, укажите параметры, тип разрешения и получателя разрешения несколько раз. Например, чтобы выдать разрешение на запись в бакет, выполните команду:

        ```bash
        aws s3api put-bucket-acl \
          --endpoint https://storage.yandexcloud.net \
          --bucket <имя_бакета> \
          --grant-read id=<идентификатор_получателя> \
          --grant-write id=<идентификатор_получателя>
        ```

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}


  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.


  Перед началом работы, получите [статические ключи доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) — секретный ключ и идентификатор ключа, используемые для аутентификации в Object Storage.

  {% note info %}
  
  Кроме статических ключей доступа для аутентификации в Object Storage можно использовать IAM-токен. Подробнее смотрите в разделе [Создание бакета](create.md) и в [документации провайдера](../../../terraform/resources/storage_object.md). 
  
  {% endnote %}

  Для редактирования ACL бакета вы можете использовать ресурсы:
  * [yandex_storage_bucket_grant](#tf-storage-bucket-grant);
  * [yandex_storage_bucket](#tf-yandex_storage_bucket) (устаревший способ).

  {% note warning %}
  
  Ресурс [yandex_storage_bucket_grant](../../../terraform/resources/storage_bucket_grant.md) нельзя использовать, если одновременно используется ресурс [yandex_storage_bucket_iam_binding](../../../terraform/resources/storage_bucket_iam_binding.md) для назначения [примитивных ролей](../../security/index.md#primitive-roles) (`viewer`, `editor` и `admin`) на бакет, или если одновременно используются параметры `acl` или `grant` ресурса [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md).
  
  {% endnote %}

  Одному бакету `yandex_storage_bucket` может соответствовать только один ресурс `yandex_storage_bucket_grant`. Использование нескольких ресурсов для одного бакета может привести к ошибкам в конфигурации.

  **yandex_storage_bucket_grant** {#tf-storage-bucket-grant}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_storage_bucket_grant" "my_bucket_grant" {
       bucket = "<имя_существующего_бакета>"
       grant {
         id          = "<идентификатор_пользователя_1>"
         permissions = ["READ", "WRITE"]
         type        = "CanonicalUser"
       }
       grant {
         id          = "<идентификатор_пользователя_2>"
         permissions = ["FULL_CONTROL"]
         type        = "CanonicalUser"
       }
       grant {
         uri         = "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
         permissions = ["READ"]
         type        = "Group"
       }
     }
     ```

     Где:

     * `bucket` — имя существующего бакета.
     * `grant` — настройки [ACL](../../concepts/acl.md). Чтобы управлять этим параметром, у сервисного аккаунта, на который получены статические ключи доступа, должна быть [роль](../../security/index.md#roles-list) `storage.admin` на бакет или каталог.
       * `type` — тип получателя разрешений. Возможные значения:
         * `CanonicalUser` — для пользователя, [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) или [группы пользователей](../../../organization/concepts/groups.md).
         * `Group` — для [публичной группы](../../concepts/acl.md#public-groups).
       * `permissions` — тип [разрешений](../../concepts/acl.md#permissions-types) ACL, возможные значения:
         * `READ` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
         * `WRITE` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `READ`, например `permissions = ["READ", "WRITE"]`.
         * `FULL_CONTROL` — полный доступ к бакету и объектам в нем.

         Подробнее о разрешениях см. в разделе [Виды разрешений](../../concepts/acl.md#permissions-types).

       * `id` — идентификатор пользователя, сервисного аккаунта или группы пользователей:

         * [Пользователь](../../../organization/operations/users-get.md).
         * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
         * Группа пользователей — перейдите на вкладку [**Группы**](https://center.yandex.cloud/organization/groups) в интерфейсе Cloud Center.

         Используется с типом получателя разрешений `CanonicalUser`.

       * `uri` — идентификатор публичной группы. Используется с типом получателя разрешений `Group`. Возможные значения:
         * `http://acs.amazonaws.com/groups/global/AllUsers` — все пользователи интернета.
         * `http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — все аутентифицированные пользователи Yandex Cloud.

     Вместо параметра `grant` вы можете указать параметр `acl` — [предопределенный ACL](../../concepts/acl.md#predefined-acls) бакета. Значение по умолчанию — `private`: пользователи Yandex Cloud получают разрешения в соответствии со своими ролями в IAM.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket_grant` см. в [документации провайдера](../../../terraform/resources/storage_bucket_grant.md).

  1. Если вы совместно с ресурсом [yandex_storage_bucket_grant](../../../terraform/resources/storage_bucket_grant.md) планируете использовать ресурс [yandex_storage_bucket_iam_binding](../../../terraform/resources/storage_bucket_iam_binding.md) для одного и того же бакета, рекомендуем выполнять создание ресурсов последовательно. Для этого добавьте в блок `yandex_storage_bucket_iam_binding` зависимость от наличия ресурса `yandex_storage_bucket_grant`:

      ```hcl
      resource "yandex_storage_bucket_iam_binding" "mybucket-viewers" {
        ...
      
        depends_on = [
          yandex_storage_bucket_grant.my_bucket_grant
        ]
      }
      ```

  1. Примените конфигурацию:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc storage bucket get <имя_бакета> --full
     ```

  **yandex_storage_bucket (устаревший способ)** {#tf-yandex_storage_bucket}

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

         Подробнее о разрешениях см. в разделе [Виды разрешений](../../concepts/acl.md#permissions-types).

       * `id` — идентификатор пользователя, сервисного аккаунта или группы пользователей:

         * [Пользователь](../../../organization/operations/users-get.md).
         * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
         * Группа пользователей — перейдите на вкладку [**Группы**](https://center.yandex.cloud/organization/groups) в интерфейсе Cloud Center.

         Используется с типом получателя разрешений `CanonicalUser`.

       * `uri` — идентификатор публичной группы. Используется с типом получателя разрешений `Group`. Возможные значения:
         * `http://acs.amazonaws.com/groups/global/AllUsers` — все пользователи интернета.
         * `http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — все аутентифицированные пользователи Yandex Cloud.

     Вместо параметра `grant` вы можете указать параметр `acl` — [предопределенный ACL](../../concepts/acl.md#predefined-acls) бакета. Значение по умолчанию — `private`: пользователи Yandex Cloud получают разрешения в соответствии со своими ролями в IAM.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` см. в [документации провайдера](../../../terraform/resources/storage_bucket.md).

  1. Примените конфигурацию:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc storage bucket get <имя_бакета> --full
     ```

- API {#api}

  Чтобы редактировать ACL бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md) или методом S3 API [bucketPutAcl](../../s3/api-ref/acl/bucketput.md).

{% endlist %}