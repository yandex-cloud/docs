# Защита резервных копий от удаления и перезаписи с помощью блокировок версий объектов

Резервные копии в [{{ objstorage-full-name }}](../../storage/) позволяют восстановить данные при сбоях оборудования, ошибках администрирования и атаках. Однако злоумышленник, получивший доступ к хранилищу, например через [скомпрометированный статический ключ доступа](../../iam/operations/compromised-credentials.md), может удалить или перезаписать сами копии.

[Версионирование](../../storage/concepts/versioning.md) бакета сохраняет предыдущие версии объектов, но пользователь с достаточными правами может удалить их. Чтобы запретить удаление версий, используйте механизм [блокировки версий объектов](../../storage/concepts/object-lock.md) (object lock). Заблокированную версию нельзя удалить или перезаписать до окончания срока блокировки, а при строгой блокировке (compliance-mode) это не может сделать даже пользователь с ролью `storage.admin`. Такая схема хранения соответствует модели WORM (Write Once Read Many): данные записываются один раз и доступны только для чтения.

В этом руководстве вы настроите блокировку версий резервных копий и проверите защиту от удаления. При загрузке объекта с тем же ключом создается новая версия, а заблокированная версия сохраняется.

Чтобы защитить резервные копии с помощью блокировок версий объектов:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Включите версионирование и блокировки версий объектов](#enable-object-lock).
1. [Настройте блокировку по умолчанию](#default-lock).
1. [Создайте сервисный аккаунт с минимальными правами](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Загрузите резервную копию и проверьте блокировку](#upload-backup).
1. [Проверьте защиту от удаления](#test-protection).
1. [Настройте жизненный цикл для устаревших версий](#lifecycle).
1. [Усильте защиту в рабочей среде](#recommendations).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Для выполнения шагов руководства вам понадобятся [роли](../../storage/security/index.md):

* `storage.admin` — чтобы создать бакет, включить версионирование и настроить блокировки;
* `iam.serviceAccounts.admin` — чтобы создать сервисный аккаунт и статический ключ доступа;
* `resource-manager.admin` — чтобы назначить сервисному аккаунту роль на каталог.

Для команд AWS CLI по настройке бакета и проверке удаления используйте [профиль](../../storage/tools/aws-cli.md) `backup-admin` со статическим ключом сервисного аккаунта с ролью `storage.admin`. Для загрузки копий вы создадите отдельный сервисный аккаунт и профиль `backup-uploader`.


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за хранение данных, операции с ними и исходящий трафик в {{ objstorage-name }} ([тарифы](../../storage/pricing.md)).

Если вы выполните [рекомендации для рабочей среды](#recommendations), дополнительно оплачиваются:

* хранение версий секретов и операции чтения секретов в {{ lockbox-name }} ([тарифы](../../lockbox/pricing.md));
* доставка событий уровня сервисов в {{ at-name }} ([тарифы](../../audit-trails/pricing.md));
* хранение логов и операции с ними в отдельном бакете {{ objstorage-name }} ([тарифы](../../storage/pricing.md)).

{% note info %}

При включенном версионировании в бакете хранятся все версии объектов, в том числе неактуальные. Плата взимается за суммарный объем всех версий, поэтому настройте [жизненный цикл](#lifecycle) для удаления неактуальных версий после окончания блокировки.

{% endnote %}


## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Укажите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания бакета:

     ```bash
     yc storage bucket create --help
     ```

  1. Создайте бакет с закрытым доступом:

     ```bash
     yc storage bucket create --name <имя_бакета>
     ```

     Укажите имя в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming):

      ```bash
      aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
        s3 mb s3://<имя_бакета>
      ```

      Результат:

      ```text
      make_bucket: backup-bucket
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите бакет в конфигурационном файле:

     ```hcl
     resource "yandex_storage_bucket" "backup" {
       bucket    = "<имя_бакета>"
       folder_id = "<идентификатор_каталога>"

       anonymous_access_flags {
         read        = false
         list        = false
         config_read = false
       }
     }
     ```

     Где `bucket` — имя бакета, а `folder_id` — идентификатор каталога. Блок `anonymous_access_flags` запрещает публичный доступ к объектам, их списку и настройкам бакета. Подробнее о параметрах ресурса `yandex_storage_bucket` в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

  В следующих шагах дополняйте этот же ресурс. Если бакет создан другим способом, сначала [импортируйте]({{ tf-provider-resources-link }}/storage_bucket#import) его в состояние {{ TF }}.

- API {#api}

    Воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).


{% endlist %}


## Включите версионирование и блокировки версий объектов {#enable-object-lock}

Блокировки версий объектов работают только в [версионируемых](../../storage/concepts/versioning.md) бакетах, поэтому сначала включите версионирование, а затем — механизм блокировок.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя созданного бакета.
  1. Включите версионирование:

     1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
     1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_versioning }}**.
     1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketVersioningFormSection.label_versioning-disabled_ngMWc }}**.
     1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

  1. Включите возможность блокировок:

     1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
     1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}**.
     1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_temp-object-lock-enabled_v3heA }}**.
     1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).

  1. Включите версионирование бакета:

     ```bash
     aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-bucket-versioning \
       --bucket <имя_бакета> \
       --versioning-configuration 'Status=Enabled'
     ```

  1. Включите механизм блокировок:

     ```bash
     aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-object-lock-configuration \
       --bucket <имя_бакета> \
       --object-lock-configuration ObjectLockEnabled=Enabled
     ```

- {{ TF }} {#tf}

  1. Добавьте в ресурс `yandex_storage_bucket.backup` блоки:

     ```hcl
     versioning {
       enabled = true
     }

     object_lock_configuration {
       object_lock_enabled = "Enabled"
     }
     ```

     Блок `versioning` включает версионирование, а `object_lock_configuration` — возможность блокировать версии объектов.

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md). Включите версионирование и возможность блокировок: задайте `versioning` = `VERSIONING_ENABLED`, а в `objectLock` — `status` = `OBJECT_LOCK_STATUS_ENABLED`. В `updateMask` укажите `versioning,object_lock`.

    Параметры выше указаны в формате REST API. Для S3 API сначала включите версионирование методом [putBucketVersioning](../../storage/s3/api-ref/bucket/putBucketVersioning.md), затем механизм блокировок методом [putObjectLockConfiguration](../../storage/s3/api-ref/bucket/putobjectlockconfiguration.md).

{% endlist %}

Версионирование также можно включить с помощью {{ yandex-cloud }} CLI: `yc storage bucket update --name <имя_бакета> --versioning versioning-enabled`. Для включения блокировок используйте один из способов выше.

Включение механизма блокировок не устанавливает блокировки на уже загруженные версии объектов, а только позволяет их устанавливать.


## Настройте блокировку по умолчанию {#default-lock}

Чтобы каждая загружаемая резервная копия была защищена автоматически, настройте [блокировку по умолчанию](../../storage/concepts/object-lock.md#default): она будет устанавливаться на все новые версии объектов в бакете. Если при загрузке не указаны отдельные настройки блокировки, будут применены настройки по умолчанию.

Выберите [тип блокировки](../../storage/concepts/object-lock.md#types):

* временная управляемая (`GOVERNANCE`) — пользователь с ролью `storage.admin` может обойти, сократить или снять блокировку, явно подтвердив действие;
* временная строгая (`COMPLIANCE`) — обойти, сократить или снять блокировку до ее окончания не может никто, в том числе пользователь с ролью `storage.admin`. В этом руководстве используется этот тип блокировки.

Срок блокировки выберите равным сроку хранения резервных копий, например 14 дней.

{% note alert %}

Строгую блокировку (`COMPLIANCE`) невозможно снять до окончания ее срока. Версии объектов будут храниться и тарифицироваться весь срок блокировки, а удалить бакет получится только после удаления всех версий. Если вы выполняете руководство в тестовых целях, укажите минимальный срок — 1 день — или используйте управляемую блокировку (`GOVERNANCE`).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}**.
  1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_default-rules-enabled_qtmC8 }}**.
  1. Выберите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_mode_61kxf }}**:

     * **{{ ui-key.yacloud.storage.file.value_object-lock-mode-governance }}** — временная управляемая блокировка;
     * **{{ ui-key.yacloud.storage.file.value_object-lock-mode-compliance }}** — временная строгая блокировка.

  1. Установите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_retention-period_jJYhy }}** в днях или годах.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. Создайте файл `default-object-lock.json` с конфигурацией блокировок по умолчанию:

     ```json
     {
       "ObjectLockEnabled": "Enabled",
       "Rule": {
         "DefaultRetention": {
           "Mode": "COMPLIANCE",
           "Days": 14
         }
       }
     }
     ```

     Где:

     * `Mode` — [тип](../../storage/concepts/object-lock.md#types) блокировки: `GOVERNANCE` или `COMPLIANCE`;
     * `Days` — срок блокировки в днях от момента загрузки версии объекта. Вместо него можно указать срок в годах в параметре `Years`.

  1. Загрузите конфигурацию в бакет:

     ```bash
     aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-object-lock-configuration \
       --bucket <имя_бакета> \
       --object-lock-configuration file://default-object-lock.json
     ```

- {{ TF }} {#tf}

  1. В ресурсе `yandex_storage_bucket.backup` дополните блок `object_lock_configuration`:

     ```hcl
     object_lock_configuration {
       object_lock_enabled = "Enabled"
       rule {
         default_retention {
           mode = "COMPLIANCE"
           days = 14
         }
       }
     }
     ```

     Где `mode` — тип блокировки, а `days` — ее срок в днях. Сохраните включенное версионирование в блоке `versioning`.

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Воспользуйтесь методом S3 API [putObjectLockConfiguration](../../storage/s3/api-ref/bucket/putobjectlockconfiguration.md). В `ObjectLockConfiguration` укажите `ObjectLockEnabled` = `Enabled`, в `Rule.DefaultRetention` — `Mode` = `COMPLIANCE` и `Days` = `14`.

    Также можно воспользоваться методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md). В `objectLock` задайте `status` = `OBJECT_LOCK_STATUS_ENABLED`, в `defaultRetention` — `mode` = `MODE_COMPLIANCE` и `days` = `14`. В `updateMask` укажите `object_lock`. Имена полей приведены для REST API.

{% endlist %}

{% note info %}

Если для бакета настроены блокировки по умолчанию, при загрузке каждой версии объекта в запросе должен передаваться заголовок `Content-MD5`. Если ваш инструмент резервного копирования обращается к [REST API](../../glossary/rest-api.md) напрямую, вычислите [MD5-хеш](https://ru.wikipedia.org/wiki/MD5) загружаемых данных, закодируйте его по схеме [Base64](https://ru.wikipedia.org/wiki/Base64) и передайте в этом заголовке.

{% endnote %}


## Создайте сервисный аккаунт с минимальными правами {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого скрипт или система резервного копирования будет загружать копии в бакет. Назначьте ему [роль](../../storage/security/index.md#storage-uploader) `storage.uploader`: она позволяет читать и загружать объекты, а также устанавливать блокировки, но не позволяет удалять объекты и изменять настройки бакета.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `sa-backup-uploader`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `storage.uploader`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд:

     ```bash
     yc iam service-account create --help
     yc resource-manager folder add-access-binding --help
     ```

  1. Создайте сервисный аккаунт:

     ```bash
     yc iam service-account create --name sa-backup-uploader
     ```

     Результат:

     ```yaml
     id: ajeab0cnib1p********
     folder_id: b0g12ga82bcv********
     created_at: "2026-06-11T09:44:35.989446Z"
     name: sa-backup-uploader
     ```

  1. Назначьте сервисному аккаунту роль `storage.uploader` на каталог:

     ```bash
     yc resource-manager folder add-access-binding <имя_каталога> \
       --service-account-name sa-backup-uploader \
       --role storage.uploader
     ```

- {{ TF }} {#tf}

  1. Добавьте в конфигурационный файл сервисный аккаунт и назначение роли на каталог:

     ```hcl
     resource "yandex_iam_service_account" "backup_uploader" {
       name      = "sa-backup-uploader"
       folder_id = "<идентификатор_каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "backup_uploader" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.uploader"
       member    = "serviceAccount:${yandex_iam_service_account.backup_uploader.id}"
     }
     ```

     В обоих ресурсах укажите идентификатор каталога с бакетом. Подробнее о ресурсах [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account) и [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) в документации провайдера.

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    1. Создайте сервисный аккаунт `sa-backup-uploader`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
    1. Назначьте сервисному аккаунту в текущем каталоге роль `storage.uploader`. Для этого воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md). Добавьте привязку с действием `ADD`, ролью `storage.uploader` и субъектом типа `serviceAccount`.


{% endlist %}

{% note tip %}

Не используйте для загрузки резервных копий сервисные аккаунты с ролями `storage.editor`, `storage.admin` или примитивными ролями `editor` и `admin`. Чем меньше прав у ключа, который хранится на сервере резервного копирования, тем меньше ущерб от его компрометации.

{% endnote %}


## Создайте статический ключ доступа {#create-static-key}

Чтобы система резервного копирования могла обращаться к бакету по протоколу S3, создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог и [перейдите]({{ link-console-main }}/link/iam) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите сервисный аккаунт `sa-backup-uploader`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Укажите описание ключа и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ. После закрытия диалога секретный ключ будет недоступен.

- CLI {#cli}

  1. Посмотрите описание команды:

     ```bash
     yc iam access-key create --help
     ```

  1. Создайте ключ:

     ```bash
     yc iam access-key create \
       --service-account-name sa-backup-uploader
     ```

     Результат:

     ```yaml
     access_key:
       id: aje726ab18go********
       service_account_id: ajecikmc374i********
       created_at: "2026-06-11T14:16:44.936656476Z"
       key_id: YCAJEOmgIxyYa54LY********
     secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
     ```

     Сохраните идентификатор `key_id` и секретный ключ `secret`: повторно получить значение `secret` будет невозможно.

- {{ TF }} {#tf}

  1. Добавьте в конфигурационный файл ресурс и выходные переменные:

     ```hcl
     resource "yandex_iam_service_account_static_access_key" "backup_uploader" {
       service_account_id = yandex_iam_service_account.backup_uploader.id
       description        = "Backup upload key"
     }

     output "backup_access_key" {
       value     = yandex_iam_service_account_static_access_key.backup_uploader.access_key
       sensitive = true
     }

     output "backup_secret_key" {
       value     = yandex_iam_service_account_static_access_key.backup_uploader.secret_key
       sensitive = true
     }
     ```

     Если сервисный аккаунт создан другим способом, в `service_account_id` укажите его идентификатор. Подробнее о ресурсе `yandex_iam_service_account_static_access_key` в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Получите идентификатор ключа и секретный ключ:

     ```bash
     terraform output -raw backup_access_key
     terraform output -raw backup_secret_key
     ```

     Ключ сохраняется в файле состояния {{ TF }}. Ограничьте доступ к этому файлу. Для сохранения ключа непосредственно в {{ lockbox-name }} используйте параметр `output_to_lockbox`, описанный в [инструкции](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

- API {#api}

    Воспользуйтесь методом REST API [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md). Укажите идентификатор сервисного аккаунта `sa-backup-uploader` и сохраните идентификатор ключа и секретный ключ из ответа.


{% endlist %}

Укажите полученный ключ в отдельном [профиле AWS CLI](../../storage/tools/aws-cli.md):

```bash
aws configure --profile backup-uploader
```

В качестве `AWS Access Key ID` используйте идентификатор ключа, а `AWS Secret Access Key` — секретный ключ. Укажите регион `{{ region-id }}` и формат вывода `json`.

Храните ключ в защищенном хранилище секретов, например в {{ lockbox-name }}. Подробнее в руководстве [{#T}](../../tutorials/security/static-key-in-lockbox/index.md).


## Загрузите резервную копию и проверьте блокировку {#upload-backup}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. [Настройте профиль CLI](../../cli/operations/authentication/service-account.md) `backup-uploader` для работы от имени сервисного аккаунта `sa-backup-uploader`.
  1. Посмотрите описание команд:

     ```bash
     yc storage s3api put-object --help
     yc storage s3api head-object --help
     ```

  1. Загрузите файл с заголовком `Content-MD5`:

     ```bash
     yc storage s3api put-object \
       --profile backup-uploader \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --body "@<путь_к_файлу_резервной_копии>" \
       --content-md5 "$(openssl dgst -md5 -binary "<путь_к_файлу_резервной_копии>" | openssl base64 -A)"
     ```

     Используйте файл размером не более 5 ГБ. Символ `@` в `--body` указывает, что данные нужно прочитать из файла. Для расчета `Content-MD5` используется OpenSSL.

  1. Получите идентификатор загруженной версии в консоли управления или командой `aws s3api list-object-versions` из шага [загрузки резервной копии](#upload-backup). Проверьте блокировку:

     ```bash
     yc storage s3api head-object \
       --profile backup-uploader \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии>
     ```

     В результате проверьте тип блокировки `COMPLIANCE` и дату ее окончания.

- AWS CLI {#aws-cli}

  1. Загрузите файл резервной копии в бакет от имени сервисного аккаунта `sa-backup-uploader`:

     ```bash
     aws --profile backup-uploader --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --body "<путь_к_файлу_резервной_копии>" \
       --content-md5 "$(openssl dgst -md5 -binary "<путь_к_файлу_резервной_копии>" | openssl base64 -A)"
     ```

     Результат:

     ```json
     {
       "ETag": "\"d41d8cd98f00b204e9800998ecf8427e\"",
       "VersionId": "<идентификатор_версии>"
     }
     ```

     Команда использует OpenSSL для расчета `Content-MD5`. Для загрузки одним запросом используйте файл размером не более 5 ГБ. Для файлов большего размера используйте [составную загрузку](../../storage/concepts/multipart.md).

     Блокировка по умолчанию установится на загруженную версию автоматически.

     Чтобы автоматизировать регулярную загрузку копий, используйте одно из руководств серии [Резервное копирование в {{ objstorage-full-name }}](../../tutorials/archive/storage-backup-overview.md).

  1. Получите идентификатор загруженной версии объекта:

     ```bash
     aws --profile backup-uploader --endpoint-url=https://{{ s3-storage-host }} \
       s3api list-object-versions \
       --bucket <имя_бакета> \
       --prefix <ключ_объекта>
     ```

     Сохраните значение поля `VersionId` для нужного ключа `Key` с признаком `IsLatest: true`.

  1. Убедитесь, что на версию установлена блокировка:

     ```bash
     aws --profile backup-uploader --endpoint-url=https://{{ s3-storage-host }} \
       s3api head-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии>
     ```

     В результате должны присутствовать поля с настройками блокировки:

     ```json
     {
       "ObjectLockMode": "COMPLIANCE",
       "ObjectLockRetainUntilDate": "2026-06-25T00:00:00+00:00"
     }
     ```

- Консоль управления {#console}

  1. [Загрузите файл](../../storage/operations/objects/upload.md) в созданный бакет. Блокировка по умолчанию установится автоматически.
  1. Откройте список версий объекта и [проверьте блокировку](../../storage/operations/objects/edit-object-lock.md): тип — временная строгая, срок — 14 дней с момента загрузки.

  Для проверки загрузки именно от имени `sa-backup-uploader` используйте его статический ключ через AWS CLI, {{ TF }} или S3 API.

- {{ TF }} {#tf}

  [Загрузите файл](../../storage/operations/objects/upload.md) с помощью ресурса [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object). В `bucket` укажите имя созданного бакета, в `key` — ключ объекта, в `source` — путь к файлу. В `access_key` и `secret_key` передайте ключ сервисного аккаунта `sa-backup-uploader`. Блокировка по умолчанию установится автоматически.

  Проверьте ее параметры в консоли управления, через AWS CLI или S3 API, как описано в соседних вкладках.

- API {#api}

    1. Загрузите резервную копию методом S3 API [upload](../../storage/s3/api-ref/object/upload.md), подписав запрос ключом `sa-backup-uploader`. Передайте заголовок `Content-MD5`.
    1. Получите идентификатор версии из заголовка `x-amz-version-id` ответа или методом [listObjectVersions](../../storage/s3/api-ref/bucket/listObjectVersions.md).
    1. Вызовите метод [getObjectMeta](../../storage/s3/api-ref/object/getobjectmeta.md) с параметром `versionId`. Проверьте заголовки `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date`.


{% endlist %}


## Проверьте защиту от удаления {#test-protection}

Выполните проверку с ролью `storage.admin`. В командах AWS CLI используйте профиль `backup-admin`: у `sa-backup-uploader` нет права удаления, поэтому ошибка при работе с его ключом сама по себе не подтверждает действие блокировки.

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. Используйте [профиль CLI](../../cli/operations/profile/profile-create.md) `backup-admin` с ролью `storage.admin`. Посмотрите описание команды:

     ```bash
     yc storage s3api delete-object --help
     ```

  1. Попробуйте удалить заблокированную версию:

     ```bash
     yc storage s3api delete-object \
       --profile backup-admin \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии>
     ```

     Команда завершится ошибкой `AccessDenied`.

  1. Повторите команду без `--version-id`, чтобы создать маркер удаления. Получите идентификатор маркера в консоли управления или командой `aws s3api list-object-versions` из шага [загрузки резервной копии](#upload-backup).
  1. Чтобы восстановить объект, выполните команду еще раз, указав в `--version-id` идентификатор маркера удаления.

- AWS CLI {#aws-cli}

  1. Попробуйте удалить версию объекта:

     ```bash
     aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
       s3api delete-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии>
     ```

     Команда завершится ошибкой `AccessDenied`: версия защищена блокировкой. При строгой блокировке (`COMPLIANCE`) удалить версию не сможет даже пользователь с ролью `storage.admin`. При управляемой блокировке (`GOVERNANCE`) пользователь с ролью `storage.admin` может удалить версию, только явно подтвердив обход блокировки параметром `--bypass-governance-retention`.

  1. Попробуйте удалить объект без указания версии:

     ```bash
     aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
       s3api delete-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта>
     ```

     Команда выполнится успешно, и объект перестанет отображаться в списке объектов бакета. При этом данные не удалены: в бакете создан [маркер удаления](../../storage/concepts/versioning.md), а все версии объекта сохранились.

  1. Восстановите объект, удалив маркер удаления. Получите идентификатор маркера в поле `DeleteMarkers` результата команды `list-object-versions`, затем выполните:

     ```bash
     aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
       s3api delete-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_маркера_удаления>
     ```

     Объект снова появится в списке объектов бакета. Подробнее в [{#T}](../../storage/operations/objects/restore-object-version.md).

- Консоль управления {#console}

  1. Убедитесь, что [удалить заблокированную версию](../../storage/operations/objects/delete.md#w-object-lock) нельзя.
  1. Выключите опцию **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** и [удалите объект](../../storage/operations/objects/delete.md). В бакете появится маркер удаления, а заблокированная версия сохранится.
  1. [Восстановите объект](../../storage/operations/objects/restore-object-version.md), удалив маркер удаления.

- API {#api}

    1. Вызовите метод S3 API [delete](../../storage/s3/api-ref/object/delete.md), указав идентификатор заблокированной версии в `versionId`. Ожидаемый результат — ошибка `AccessDenied`.
    1. Вызовите тот же метод без `versionId`: будет создан маркер удаления.
    1. Получите идентификатор маркера методом [listObjectVersions](../../storage/s3/api-ref/bucket/listObjectVersions.md) и удалите его методом [delete](../../storage/s3/api-ref/object/delete.md), указав этот идентификатор в `versionId`.


{% endlist %}

Пока действует блокировка, сохраненную версию резервной копии можно восстановить.


## Настройте жизненный цикл для устаревших версий {#lifecycle}

Настройте [жизненный цикл](../../storage/concepts/lifecycles.md), чтобы автоматически удалять неактуальные версии резервных копий. Правило ниже удаляет версии через 14 дней после того, как они стали неактуальными, но не раньше окончания блокировки. Оно не удаляет текущие версии: если каждую копию загружать с уникальным ключом, такие копии останутся в бакете.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте бакет в [консоли управления]({{ link-console-main }}), перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_settings }}**, затем на вкладку **{{ ui-key.yacloud.storage.bucket.switch_lifecycle }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.lifecycle.button_lifecycle_empty-create }}**, включите правило и оставьте префикс пустым.
  1. Для действия **{{ ui-key.yacloud.storage.bucket.lifecycle.label_version-expiration-type }}** укажите срок `14` дней.
  1. Для действия **{{ ui-key.yacloud.storage.bucket.lifecycle.label_expiration-type }}** выберите **{{ ui-key.yacloud.storage.bucket.lifecycle.value_expired-object-delete-marker }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.lifecycle.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Посмотрите описание команды:

     ```bash
     yc storage bucket update --help
     ```

  1. Создайте файл `lifecycle-backup-yc.json`:

     ```json
     {
       "lifecycleRules": [
         {
           "id": "delete-expired-backup-versions",
           "enabled": true,
           "noncurrent_expiration": {"noncurrent_days": 14},
           "expiration": {"expired_object_delete_marker": true}
         }
       ]
     }
     ```

     Параметр `noncurrent_days` задает срок удаления неактуальных версий, а `expired_object_delete_marker` включает удаление маркеров, у которых не осталось версий.

  1. Примените конфигурацию:

     ```bash
     yc storage bucket update \
       --name <имя_бакета> \
       --lifecycle-rules-from-file lifecycle-backup-yc.json
     ```

- AWS CLI {#aws-cli}

  1. Создайте файл `lifecycle-backup.json` с конфигурацией:

     ```json
     {
       "Rules": [
         {
           "ID": "delete-expired-backup-versions",
           "Filter": {
             "Prefix": ""
           },
           "Status": "Enabled",
           "NoncurrentVersionExpiration": {
             "NoncurrentDays": 14
           },
           "Expiration": {
             "ExpiredObjectDeleteMarker": true
           }
         }
       ]
     }
     ```

     Где:

     * `NoncurrentDays` — количество дней с момента, когда версия стала неактуальной, до ее удаления;
     * `ExpiredObjectDeleteMarker` — удаление маркеров, для которых не осталось неактуальных версий объекта.

  1. Загрузите конфигурацию в бакет:

     ```bash
     aws --profile backup-admin --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-bucket-lifecycle-configuration \
       --bucket <имя_бакета> \
       --lifecycle-configuration file://lifecycle-backup.json
     ```

- {{ TF }} {#tf}

  1. Добавьте в ресурс `yandex_storage_bucket.backup` правило:

     ```hcl
     lifecycle_rule {
       id      = "delete-expired-backup-versions"
       enabled = true

       noncurrent_version_expiration {
         days = 14
       }

       expiration {
         expired_object_delete_marker = true
       }
     }
     ```

     Правило удаляет неактуальные версии через 14 дней и маркеры удаления, у которых не осталось версий. Сохраните настройки версионирования и блокировки, добавленные в предыдущих шагах.

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Воспользуйтесь методом S3 API [upload](../../storage/s3/api-ref/lifecycles/upload.md) и передайте правило в [формате XML](../../storage/s3/api-ref/lifecycles/xml-config.md): `NoncurrentVersionExpiration.NoncurrentDays` = `14`, `Expiration.ExpiredObjectDeleteMarker` = `true`.

    Также можно воспользоваться методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md). Передайте правило в `lifecycleRules`, а в `updateMask` укажите `lifecycle_rules`.


{% endlist %}

Подробнее о настройке жизненных циклов в [инструкции](../../storage/operations/buckets/lifecycles.md).


## Усильте защиту в рабочей среде {#recommendations}

В рабочей среде дополните блокировки следующими мерами:

* Разместите бакет с резервными копиями в отдельном [каталоге](../../resource-manager/operations/folder/create.md) или облаке, доступ к которому есть только у администраторов резервного копирования. Так компрометация учетных записей основной инфраструктуры не даст доступа к настройкам бакета с копиями.
* Назначайте роли на бакет, а не на весь каталог,. Подробнее в [{#T}](../../storage/operations/buckets/iam-access.md).
* Используйте строгую блокировку (`COMPLIANCE`) и выберите срок, достаточный для обнаружения инцидента и восстановления данных.
* Храните статические ключи доступа в {{ lockbox-name }} или другом защищенном хранилище секретов, а порядок действий на случай утечки ключа подготовьте заранее. Подробнее в [{#T}](../../iam/operations/compromised-credentials.md).
* Включите [логирование действий с бакетом](../../storage/operations/buckets/enable-logging.md) и настройте [трейл](../../audit-trails/operations/create-trail.md) {{ at-full-name }} с событиями уровня конфигурации и уровня сервисов {{ objstorage-name }} и назначением в отдельный бакет, чтобы вовремя заметить массовое удаление объектов или изменение настроек бакета.
* Регулярно проверяйте восстановление данных из резервных копий.


## Как удалить созданные ресурсы {#clear-out}

{% note alert %}

Версии объектов с действующей блокировкой удалить нельзя. Если вы настроили строгую блокировку (`COMPLIANCE`), дождитесь окончания ее срока. Версии с управляемой блокировкой (`GOVERNANCE`) пользователь с ролью `storage.admin` может удалить досрочно, подтвердив обход блокировки,. Подробнее в [{#T}](../../storage/operations/objects/delete.md#w-object-lock).

{% endnote %}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите объекты](../../storage/operations/objects/delete-all.md) из бакета, включая все версии.
1. [Удалите бакет](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md) `sa-backup-uploader`.

Если вы создавали дополнительные ресурсы по рекомендациям для рабочей среды:

1. [Удалите трейл](../../audit-trails/operations/manage-trail.md#delete-trail).
1. Удалите объекты из бакета с логами, а затем сам бакет.
1. [Удалите секрет](../../lockbox/operations/secret-delete.md) со статическим ключом.
