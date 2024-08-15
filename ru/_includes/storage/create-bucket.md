

Чтобы создать [бакет](../../storage/concepts/bucket.md), у вас должна быть _минимальная_ [роль](../../storage/security/#storage-editor) `storage.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. На странице создания бакета:
      1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

                   
          По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите собственный сертификат безопасности](../../storage/operations/hosting/certificate.md) в {{ objstorage-name }}.
 

      1. При необходимости ограничьте максимальный размер бакета.

          {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Задайте параметры [публичного доступа](../../storage/security/public-access.md) на чтение [объектов](../../storage/concepts/object.md) в бакете, получение списка объектов и чтение настроек бакета:
          * `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}` — доступ только для авторизованных пользователей {{ yandex-cloud }}.
          * `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}` — доступ для любых пользователей.

          {% include [public-access-warning](./security/public-access-warning.md) %}

      1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию:
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`.
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_cold }}`.
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_ice }}`.

          Более <q>холодные</q> классы предназначены для длительного хранения объектов, работать с которыми планируется реже. Чем <q>холоднее</q> хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать.

      1. При необходимости добавьте [метки](../../storage/concepts/tags.md):
          1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.

      1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания бакета:

      ```bash
      yc storage bucket create --help
      ```

  1. Создайте бакет в каталоге по умолчанию:

      ```bash
      yc storage bucket create --name <имя_бакета>
      ```

      Где `--name` — имя бакета. Обязательный параметр. Подробнее см. [Правила именования бакетов](../../storage/concepts/bucket.md#naming).
 
      
      По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите](../../storage/operations/hosting/certificate.md) собственный сертификат безопасности в {{ objstorage-name }}.
        

      Результат:

      ```text
      name: example
      folder_id: b1gmit33ngp6********
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T14:05:12.196007Z"
      ```

      {% cut "Опциональные параметры" %}

      * `--default-storage-class` — [класс хранилища](../../storage/concepts/storage-class.md). Доступные значения:
        * `standard` — стандартное хранилище. Устанавливается по умолчанию.
        * `cold` — холодное хранилище.
        * `ice` — ледяное хранилище.

        Более <q>холодные</q> классы предназначены для длительного хранения [объектов](../../storage/concepts/object.md), работать с которыми планируется реже. Чем <q>холоднее</q> хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать.

      * `--max-size` — максимальный размер бакета в байтах. Значение по умолчанию — `0` (без ограничений).
      * Параметры для включения [публичного доступа](../../storage/security/public-access.md) к бакету:
        * `--public-read` — включить публичный доступ на чтение объектов в бакете.
        * `--public-list` — включить публичный доступ на просмотр списка объектов в бакете.
        * `--public-config-read` — включить публичный доступ на чтение настроек в бакете.

        По умолчанию публичный доступ к бакету выключен.

        {% include [public-access-warning](./security/public-access-warning.md) %}

      * Параметры для настройки [ACL](../../storage/concepts/acl.md) бакета:
        * `--acl` — предопределенный ACL. Список возможных значений см. в разделе [Предопределенные ACL](../../storage/concepts/acl.md#predefined-acls). Нельзя использовать одновременно с параметром `--grants`.
        * `--grants` — настройки разрешений для отдельных пользователей, [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md), [групп пользователей](../../organization/concepts/groups.md) и [публичных групп](../../storage/concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Нельзя использовать одновременно с параметром `--acl`. Значение параметра указывается в формате: `grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=<тип_разрешения>`, где:
          * `grant-type` — тип получателя разрешения. Возможные значения:
            * `grant-type-account` — пользователь, [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или [группа пользователей](../../organization/concepts/groups.md);
            * `grant-type-all-authenticated-users` — [публичная группа](../../storage/concepts/acl.md#public-groups) всех аутентифицированных пользователей {{ yandex-cloud }};
            * `grant-type-all-users` — публичная группа всех пользователей интернета.
          * `grantee-id` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение. Указывается, только если `grant-type=grant-type-account`.
          * `permission` — тип разрешения ACL. Возможные значения: `permission-full-control`, `permission-write`, `permission-read`. Подробнее о разрешениях см. в разделе [Виды разрешений](../../storage/concepts/acl.md#permissions-types).

          Чтобы настроить несколько разрешений, укажите параметр `--grants` несколько раз.

        По умолчанию для каждого нового бакета создается пустой ACL.

      {% endcut %}

      Подробнее о команде `yc storage bucket create` см. в [Справочнике YC CLI](../../cli/cli-ref/managed-services/storage/bucket/create.md).

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).

  Чтобы создать бакет, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту, через который работает AWS CLI, [роль](../../storage/security/#storage-editor) `storage.editor`.

  В терминале выполните команду:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <имя_бакета>
  ```

  Где:

  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
  * `--bucket` — имя бакета.

  
  {% note info %}

  По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите](../../storage/operations/hosting/certificate.md) собственный сертификат безопасности в {{ objstorage-name }}. Подробнее см. [Правила именования бакетов](../../storage/concepts/bucket.md#naming).

  {% endnote %}


  Результат:

  ```text
  {
    "Location": "/<имя_бакета>"
  }
  ```

  Будет создан бакет со следующими параметрами:
  * без ограничения максимального размера;
  * с ограниченным [доступом](../../storage/concepts/bucket.md#bucket-access) на чтение объектов, к списку объектов и на чтение настроек;
  * с [классом хранилища](../../storage/concepts/storage-class.md) `Стандартное`.

  {% cut "Опциональные параметры" %}

  Вы можете применить к бакету [предопределенный ACL](../../storage/concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md), [групп пользователей](../../organization/concepts/groups.md) и [публичных групп](../../storage/concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Эти настройки несовместимы: у бакета должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  {% note info %}

  Чтобы управлять настройками [ACL](../../storage/concepts/acl.md) бакета, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту, через который работает AWS CLI, [роль](../../storage/security/index.md#storage-admin) `storage.admin`.

  {% endnote %}

  **Предопределенный ACL**

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <имя_бакета> \
    --acl <предопределенный_ACL>
  ```

  Где `--acl` — предопределенный ACL. Список значений см. в разделе [{#T}](../../storage/concepts/acl.md#predefined-acls).

  **Отдельные разрешения**

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <имя_бакета> \
    <тип_разрешения> <получатель_разрешения>
  ```

  Где:
  * Возможные типы разрешений ACL:
    * `--grant-read` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
    * `--grant-write` — доступ к записи, перезаписи и удалению объектов в бакете. Используется  только совместно с `--grant-read`.
    * `--grant-full-control` — полный доступ к бакету и объектам в нем.
          
    Вы можете задать несколько разрешений в одной команде.
  * Возможные получатели разрешений:
    * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
    * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [публичная группа](../../storage/concepts/acl.md#public-groups) всех аутентифицированных пользователей {{ yandex-cloud }}.
    * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — публичная группа всех пользователей интернета.

  По умолчанию для каждого нового бакета создается пустой ACL.

  {% endcut %}

  Подробнее о команде `aws s3api create-bucket` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/create-bucket.html).

- {{ TF }} {#tf}

  {% include [terraform-role](terraform-role.md) %}
  
  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../_includes/terraform-install.md) %}


  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
        required_version = ">= 0.13"
      }

      // Настройка провайдера
      provider "yandex" {
        token     = "<IAM-_или_OAuth-токен>"
        cloud_id  = "<идентификатор_облака>"
        folder_id = "<идентификатор_каталога>"
        zone      = "{{ region-id }}-a"
      }

      // Создание сервисного аккаунта
      resource "yandex_iam_service_account" "sa" {
        name = "<имя_сервисного_аккаунта>"
      }

      // Назначение роли сервисному аккаунту
      resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
        folder_id = "<идентификатор_каталога>"
        role      = "storage.admin"
        member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
      }

      // Создание статического ключа доступа
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = yandex_iam_service_account.sa.id
        description        = "static access key for object storage"
      }

      // Создание бакета с использованием ключа
      resource "yandex_storage_bucket" "test" {
        access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket                = "<имя_бакета>"
        max_size              = <максимальный_размер_бакета>
        default_storage_class = "<класс_хранилища>"
        anonymous_access_flags {
          read        = <true|false>
          list        = <true|false>
          config_read = <true|false>
        }
        tags = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
      }
      ```

      Где:
      * `yandex_iam_service_account` — описание [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), который создаст [бакет](../../storage/concepts/bucket.md) и будет работать с ним:

        * `name` — имя сервисного аккаунта.
        * `bucket` — имя бакета.

                   
          По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите собственный сертификат безопасности](../../storage/operations/hosting/certificate.md) в {{ objstorage-name }}.
 

        * `max_size` — максимальный размер бакета в байтах.
        * `default_storage_class` — [класс хранилища](../../storage/concepts/storage-class.md). Доступные значения:

          * `standard` — стандартное хранилище.
          * `cold` — холодное хранилище.
          * `ice` — ледяное хранилище.

          Более <q>холодные</q> классы предназначены для длительного хранения объектов, работать с которыми планируется реже. Чем <q>холоднее</q> хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать.

        * `anonymous_access_flags` — настройки [доступа](../../storage/concepts/bucket.md#bucket-access):

          * `read` — публичный доступ на чтение объектов в бакете.
          * `list` — публичный доступ на просмотр списка объектов в бакете.
          * `config_read` — публичный доступ на чтение настроек в бакете.

        * `tags` — [метки](../../storage/concepts/tags.md) бакета в формате `ключ = "значение"`.

      `name` — обязательный параметр. Остальные параметры необязательны. По умолчанию значение параметра `max-size` — `0`, публичный доступ к бакету выключен, класс хранилища — `standard`.

      Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).

  1. Создайте ресурсы:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}
