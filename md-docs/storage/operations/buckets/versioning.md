# Управление версионированием бакета

[Версионирование](../../concepts/versioning.md) бакета — это возможность хранить историю объекта с помощью версий.

{% note warning %}

Операция включения необратима: отключить версионирование нельзя, можно только приостановить создание новых версий. После приостановки версионирования новые объекты будут сохраняться с версией `null`.

{% endnote %}

{% note info %}

При включенной [блокировке версии объекта](../../concepts/object-lock.md) версионирование нельзя приостановить.

{% endnote %}

Чтобы включить версионирование бакета:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя нужного бакета.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_versioning }}**.
  1. Чтобы включить или приостановить версионирование, используйте опцию **{{ ui-key.yacloud.storage.form.BucketVersioningFormSection.label_versioning-disabled_ngMWc }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для редактирования ACL бакета:

     ```bash
     yc storage bucket update --help
     ```  

  1. Выполните следующую команду:

     ```bash
     yc storage bucket update --name <имя_бакета> --versioning versioning-enabled
     ```

     Результат:

     ```text
     name: my-bucket
     folder_id: csgeoelk7fl15********
     default_storage_class: STANDARD
     versioning: VERSIONING_ENABLED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Выполните следующую команду:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} \
    s3api put-bucket-versioning \
    --bucket <имя_бакета> \
    --versioning-configuration 'Status=Enabled'
  ```

- {{ TF }} {#tf}

  {% note info %}
  
  Если вы работаете с {{ objstorage-name }} через {{ TF }} от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Получите [статические ключи доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  {% note info %}
  
  Кроме статических ключей доступа для аутентификации в {{ objstorage-name }} можно использовать IAM-токен. Подробнее смотрите в разделе [{#T}](create.md) и в [документации провайдера]({{ tf-provider-resources-link }}/storage_object). 
  
  {% endnote %}


  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
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

     resource "yandex_storage_bucket" "b" {
       bucket     = "<имя_бакета>"
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       acl        = "private"

       versioning {
         enabled = true
       }
     }
     ```

     Где:

     * `bucket` — имя бакета. Обязательный параметр.
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `acl` — применяемая политика ACL. Значение по умолчанию `private`. Необязательный параметр.
     * `versioning` — управление версионированием бакета:
       * `enabled` — включает версионирование бакета. Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).

  1. Примените изменения:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы управлять версионированием бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md) или методом S3 API [putBucketVersioning](../../s3/api-ref/bucket/putBucketVersioning.md).

{% endlist %}