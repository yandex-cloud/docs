---
title: Загрузка объекта в бакет в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете загрузить объект в бакет в {{ objstorage-name }}.
---

# Загрузка объекта

Пользователь может создавать внутри бакета папки и загружать туда объекты. При этом необходимо помнить, что в SDK и HTTP API ключом объекта будет весь путь к объекту от корня бакета. Читайте подробнее в разделе [{#T}](../../concepts/object.md).

{% note info %}

Через консоль управления нельзя загрузить объекты размером более 5 ГБ (см. [{#T}](../../concepts/limits.md)). Также при загрузке через консоль нельзя указать `content-type` и другие заголовки. Для загрузки больших объектов или указания заголовков объекта используйте другие [инструменты](../../tools/index.md).

{% endnote %}

Для загрузки объектов в бакет вы можете использовать [инструменты](../../tools/index.md), поддерживающие работу с {{ objstorage-name }}, а также [подписанные URL-ссылки](../../concepts/pre-signed-urls.md).

## Простая загрузка {#simple}


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, в который нужно загрузить объект.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Если вы хотите загрузить объект в бакет впервые, нажмите **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
  1. Если вы хотите загрузить объект в конкретную папку, перейдите в нее, нажав на имя. Если вам нужно создать новую папку, нажмите **{{ ui-key.yacloud.storage.bucket.button_create }}**.
  1. Оказавшись в нужной папке, на верхней панели нажмите ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. В появившемся окне выберите необходимые файлы и нажмите **Открыть**.
  1. Консоль управления отобразит все объекты, выбранные для загрузки и предложит для каждого из них выбрать [класс хранилища](../../concepts/storage-class.md). Класс хранилища по умолчанию определяется [настройкой бакета](../../concepts/bucket.md#bucket-settings).
  1. Нажмите **{{ ui-key.yacloud.storage.button_upload }}**.
  1. Обновите страницу.

  В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [upload-object-via-cli](../../../_includes/storage/upload-obect-via-cli.md) %}

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Чтобы загрузить один объект, выполните команду:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3 cp <путь_к_локальному_файлу> s3://<имя_бакета>/<ключ_объекта>
     ```

     Где:

     * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
     * `s3 cp` — команда для загрузки объекта. Чтобы загрузить объект, в первой части команды укажите путь к локальному файлу, который нужно загрузить, а во второй — имя вашего бакета и [ключ](../../concepts/object.md#key), по которому объект будет храниться в бакете.

     Чтобы загрузить все объекты из локальной директории, используйте команду:
   
     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3 cp --recursive <путь_к_локальной_директории>/ s3://<имя_бакета>/<префикс>/
     ```
   
     Где:
   
     * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
     * `s3 cp --recursive` — команда для загрузки всех объектов из локальной директории, включая вложенные. Чтобы загрузить объекты, в первой части команды укажите путь к папке, из которой нужно скопировать файлы в бакет, а во второй — имя вашего бакета и [идентификатор папки](../../concepts/object.md#folder) в хранилище.

  Команда `aws s3 cp` — высокоуровневая, ее функциональность ограничена. Подробнее см. в [справочнике AWS CLI](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html). Все возможности загрузки, которые поддерживаются в {{ objstorage-name }}, можно использовать при выполнении команды [aws s3api put-object](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/put-object.html) (см. [ниже](#w-object-lock) примеры работы с [блокировками](../../concepts/object-lock.md)).

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Перед началом работы получите [статические ключи доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

  Чтобы создать объект в существующем бакете:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать.

     ```hcl
     # Создание сервисного аккаунта

     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }

     # Назначение роли сервисному аккаунту

     resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     # Создание статического ключа доступа
     
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     # Создание объекта

     resource "yandex_storage_object" "test-object" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
       key        = "<имя_объекта>"
       source     = "<путь_к_файлу>"
     }
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета для добавления объекта. Обязательный параметр.
     * `key` — имя объекта в бакете. Обязательный параметр. Формат имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `source` — относительный или абсолютный путь к файлу, который нужно загрузить в бакет.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_object).

1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы загрузить объект, воспользуйтесь методом S3 API [upload](../../s3/api-ref/object/upload.md).

{% endlist %}

## Загрузка версии объекта с блокировкой (object lock) {#w-object-lock}

Если в бакете включены [версионирование](../buckets/versioning.md) и [блокировки версий объектов](../buckets/configure-object-lock.md), вы можете указать настройки блокировки (запрета на удаление или перезапись) при загрузке версии объекта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, в который нужно загрузить объект.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Если вы хотите загрузить объект в бакет впервые, нажмите **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
  1. Если вы хотите загрузить объект в конкретную папку, перейдите в нее, нажав на имя. Если хотите создать новую папку, создайте ее, нажав на панели сверху **{{ ui-key.yacloud.storage.bucket.button_create }}**.
  1. Оказавшись в нужной папке, нажмите на верхней панели ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. В появившемся окне выберите необходимые файлы и нажмите **Открыть**.
  1. Консоль управления отобразит все объекты, выбранные для загрузки и предложит для каждого из них выбрать [класс хранилища](../../concepts/storage-class.md). Класс хранилища по умолчанию определяется [настройкой бакета](../../concepts/bucket.md#bucket-settings).
  1. Чтобы настроить блокировку загружаемых объектов, в выпадающем списке **{{ ui-key.yacloud.storage.title_object-lock }}** выберите вид блокировки:
     * **{{ ui-key.yacloud.storage.field_perm-object-lock-enabled }}** — блокировка бессрочно запрещает удаление или перезапись версии объекта, но при этом не запрещает загружать новые версии объекта. Пользователь с ролью `storage.uploader` может установить и снять блокировку. Обойти блокировку нельзя. В сочетании с временной блокировкой имеет приоритет.
     * **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}** — блокировка запрещает удаление или перезапись версии объекта на определенный срок, но при этом не запрещает загружать новые версии объекта. Пользователь с ролью `storage.uploader` может установить блокировку. В сочетании с бессрочной блокировкой не имеет приоритета.
  1. Если вы выбрали вид **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**, укажите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_mode_61kxf }}**:
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-governance }}** — пользователь с ролью `storage.admin` может обойти блокировку, изменить ее срок или снять ее.
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}** — пользователь с ролью `storage.admin` может только продлить блокировку. Обойти, сократить или снять блокировку до ее окончания нельзя.
  1. Установите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_retention-period_jJYhy }}** в днях или годах. Отсчитывается от момента, когда версия объекта загружена в бакет.
  1. Нажмите **{{ ui-key.yacloud.storage.button_upload }}** и обновите страницу.

  В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для загрузки файла в бакет:

      ```bash
      yc storage s3api put-object --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Выполните команду:

      ```bash
      yc storage s3api put-object \
       --body <путь_к_локальному_файлу> \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --object-lock-mode <тип_временной_блокировки> \
       --object-lock-retain-until-date <дата_и_время_окончания_временной_блокировки> \
       --object-lock-legal-hold-status <статус_бессрочной_блокировки>
      ```

     Где:

     * `--body` — путь к файлу, который нужно загрузить в бакет.
     * `--bucket` — имя вашего бакета.
     * `--key` — [ключ](../../concepts/object.md#key), по которому объект будет храниться в бакете.
     * `--object-lock-mode` — [тип](../../concepts/object-lock.md#types) временной блокировки:

       * `GOVERNANCE` — временная управляемая блокировка.
       * `COMPLIANCE` — временная строгая блокировка.
  
     * `--object-lock-retain-until-date` — дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `2025-01-02T15:04:05Z`. Указывается только вместе с параметром `--object-lock-mode`.
  
     * `--object-lock-legal-hold-status` — статус [бессрочной блокировки](../../concepts/object-lock.md#types):
  
       * `ON` — блокировка установлена.
       * `OFF` — блокировка не установлена.

     Вы можете установить на версию объекта только временную блокировку (параметры `object-lock-mode` и `object-lock-retain-until-date`), только бессрочную блокировку (`object-lock-legal-hold-status`) или обе сразу. Подробнее об их совместной работе см. в разделе [{#T}](../../concepts/object-lock.md#types).

     Результат:

     ```bash
     etag: '"d41d8cd98f00b204e9800998********"'
     request_id: e19afe50********
     version_id: 0006241E********
     ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object \
       --body <путь_к_локальному_файлу> \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --object-lock-mode <тип_временной_блокировки> \
       --object-lock-retain-until-date <дата_и_время_окончания_временной_блокировки> \
       --object-lock-legal-hold-status <статус_бессрочной_блокировки>
     ```
     
     Где:
   
     * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
     * `s3api put-object` — команда для загрузки версии объекта. Чтобы загрузить версии объекта с блокировкой, укажите следующие параметры:
       * `--body` — путь к файлу, который нужно загрузить в бакет.
       * `--bucket` — имя вашего бакета.
       * `--key` — [ключ](../../concepts/object.md#key), по которому объект будет храниться в бакете.
       * `--object-lock-mode` — [тип](../../concepts/object-lock.md#types) временной блокировки:
   
         * `GOVERNANCE` — временная управляемая блокировка.
         * `COMPLIANCE` — временная строгая блокировка.
    
       * `--object-lock-retain-until-date` — дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`. Указывается только вместе с параметром `--object-lock-mode`.
    
       * `--object-lock-legal-hold-status` — статус [бессрочной блокировки](../../concepts/object-lock.md#types):
    
         * `ON` — блокировка установлена.
         * `OFF` — блокировка не установлена.
    
     Вы можете установить на версию объекта только временную блокировку (параметры `object-lock-mode` и `object-lock-retain-until-date`), только бессрочную блокировку (`object-lock-legal-hold-status`) или обе сразу. Подробнее об их совместной работе см. в разделе [{#T}](../../concepts/object-lock.md#types).

- API {#api}

  Чтобы загрузить версию объекта с блокировкой, воспользуйтесь методом S3 API [upload](../../s3/api-ref/object/upload.md) с заголовками `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date` для временной блокировки и `X-Amz-Object-Lock-Legal-Hold` для бессрочной.

{% endlist %}

Если для бакета также настроены [временные блокировки по умолчанию](../../concepts/object-lock.md#default), все объекты в него нужно загружать с указанием их [MD5-хешей](https://{{ lang }}.wikipedia.org/wiki/MD5):

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Вычислите MD5-хэш файла и закодируйте его по схеме [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

     ```bash
     md5=($(md5sum <путь_к_локальному_файлу>))
     md5_base64=$(echo $md5 | base64)
     ```

  1. Посмотрите описание команды CLI для загрузки файла в бакет:

     ```bash
     yc storage s3api put-object --help
     ```

  1. Получите список бакетов в каталоге по умолчанию:

     ```bash
     yc storage bucket list
     ```

     Результат:

     ```text
     +------------------+----------------------+-------------+-----------------------+---------------------+
     |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     ```

  1. Загрузите объект в бакет:

     ```bash
      yc storage s3api put-object \
       --body <путь_к_локальному_файлу> \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --content-md5 $md5_base64
     ```

     Где:

     * `--body` — путь к файлу, который нужно загрузить в бакет.
     * `--bucket` — имя вашего бакета.
     * `--key` — [ключ](../../concepts/object.md#key), по которому объект будет храниться в бакете.
     * `--content-md5` — закодированный MD5-хеш объекта.

     Также вы можете добавить к команде параметры:

     * `--object-lock-mode` и `--object-lock-retain-until-date`, чтобы установить на версию объекта временную блокировку, отличную от настроек бакета по умолчанию;
     * `--object-lock-legal-hold-status`, чтобы установить на версию объекта бессрочную блокировку.

     Подробнее об этих параметрах см. в инструкции выше.

- AWS CLI {#aws-cli}

  1. Вычислите MD5-хэш файла и закодируйте его по схеме [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

     ```bash
     md5=($(md5sum <путь_к_локальному_файлу>))
     md5_base64=$(echo $md5 | base64)
     ```

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Загрузите объект в бакет:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object \
       --body <путь_к_локальному_файлу> \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --content-md5 $md5_base64
     ```
   
     Где:
   
     * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
     * `s3api put-object` — команда для загрузки версии объекта. Чтобы загрузить версии объекта, укажите следующие параметры:
       * `--body` — путь к файлу, который нужно загрузить в бакет.
       * `--bucket` — имя вашего бакета.
       * `--key` — [ключ](../../concepts/object.md#key), по которому объект будет храниться в бакете.
       * `--content-md5` — закодированный MD5-хеш объекта.
     
     Также вы можете добавить к команде параметры:
     
     * `--object-lock-mode` и `--object-lock-retain-until-date`, чтобы установить на версию объекта временную блокировку, отличную от настроек бакета по умолчанию;
     * `--object-lock-legal-hold-status`, чтобы установить на версию объекта бессрочную блокировку.
 
     Подробнее об этих параметрах см. в инструкции выше.

- API {#api}

  Чтобы загрузить версию объекта с временной блокировкой по умолчанию, воспользуйтесь методом S3 API [upload](../../s3/api-ref/object/upload.md) с заголовком `Content-MD5`.

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../tutorials/storage-vpc-access.md)

