# Загрузка аудитных логов {{ at-full-name }} в SIEM KUMA с помощью консоли управления, CLI или API

Чтобы настроить доставку файлов [аудитных логов](../../audit-trails/concepts/format.md) в [KUMA](https://www.kaspersky.ru/enterprise-security/unified-monitoring-and-analysis-platform):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#setup-environment).
1. [Создайте бакет](#create-bucket).
1. [Создайте трейл](#create-trail).
1. [Создайте сервер](#create-server).
1. [Смонтируйте бакет на сервере](#mount-bucket).
1. [Настройте коллектор KUMA](#setup-collector).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/audit-trails-events-to-kuma/paid-resources.md) %}


## Подготовьте окружение {#setup-environment}

### Создайте сервисные аккаунты {#create-service-accounts}

Для работы создаваемой инфраструктуры создайте два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):

* `kuma-bucket-sa` — для бакета {{ objstorage-name }}.
* `kuma-trail-sa` — для трейла {{ at-short-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта для бакета: `kuma-bucket-sa`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Повторите шаги 3-5, чтобы создать сервисный аккаунт `kuma-trail-sa` для трейла.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Выполните команды:

      ```bash
      yc iam service-account create --name kuma-bucket-sa
      yc iam service-account create --name kuma-trail-sa
      ```

      Где `--name` — имена сервисных аккаунтов.

      Результат:

      ```text
      id: ajecikmc374i********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-28T14:11:42.593107676Z"
      name: kuma-bucket-sa
      
      id: ajedc6uq5o7m********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-28T14:11:45.856807266Z"
      name: kuma-trail-sa
      ```

  1. Сохраните идентификаторы (`id`) созданных сервисных аккаунтов — они понадобятся на следующих шагах.

  Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

{% endlist %}


### Создайте статический ключ доступа {#create-static-key}

Чтобы смонтировать бакет на сервере с установленным коллектором KUMA, создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `kuma-bucket-sa`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `kuma-bucket-sa`.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните полученные идентификатор и секретный ключ — они понадобятся позднее при монтировании бакета на сервере.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI {#cli}

  1. Выполните команду:

      ```bash
      yc iam access-key create --service-account-name kuma-bucket-sa
      ```

      Где `--service-account-name` — имя сервисного аккаунта, для которого создается ключ.

      Результат:

      ```text
      access_key:
        id: aje726ab18go********
        service_account_id: ajecikmc374i********
        created_at: "2024-11-28T14:16:44.936656476Z"
        key_id: YCAJEOmgIxyYa54LY********
      secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
      ```

  1. Сохраните идентификатор (`key_id`) и секретный ключ (`secret`) — они понадобятся позднее при монтировании бакета на сервере.

  Подробнее о команде `yc iam access-key create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

- API {#api}

  Чтобы создать статический ключ доступа, воспользуйтесь методом REST API [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md).

{% endlist %}


### Создайте ключ шифрования {#create-encryption-key}

Для шифрования аудитных логов в бакете создайте [симметричный ключ шифрования](../../kms/concepts/key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Нажмите **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** и задайте атрибуты ключа:

      * **{{ ui-key.yacloud.common.name }}** — `kuma-key`.
      * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** — `AES-256`.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Выполните команду:

      ```bash
      yc kms symmetric-key create \
        --name kuma-key \
        --default-algorithm aes-256
      ```

      Где:

      * `--name` — имя ключа.
      * `--default-algorithm` — [алгоритм шифрования](../../kms/concepts/key.md#parameters).

      Результат:

      ```text
      id: abje8mf3ala0********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-28T14:22:06Z"
      name: kuma-key
      status: ACTIVE
      primary_version:
        id: abjuqbth02kf********
        key_id: abje8mf3ala0********
        status: ACTIVE
        algorithm: AES_256
        created_at: "2024-11-28T14:22:06Z"
        primary: true
      default_algorithm: AES_256
      ```

  1. Сохраните идентификатор симметричного ключа (`id`) — он понадобится позднее при создании бакета.

  Подробнее о команде `yc kms symmetric-key create` читайте в [справочнике CLI](../../cli/cli-ref/kms/cli-ref/symmetric-key/create.md).

- API {#api}

  Чтобы создать симметричный ключ шифрования, воспользуйтесь методом REST API [create](../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../kms/api-ref/grpc/SymmetricKey/create.md).

{% endlist %}


### Назначьте роли сервисным аккаунтам {#assign-roles}

Назначьте сервисным аккаунтам следующие [роли](../../iam/concepts/access-control/roles.md) на каталог и созданный [ранее](#create-encryption-key) ключ шифрования:

* Сервисному аккаунту `kuma-trail-sa`:

    * `audit-trails.viewer` — на каталог.
    * `storage.uploader` — на каталог.
    * `kms.keys.encrypterDecrypter` — на ключ шифрования.

* Сервисному аккаунту `kuma-bucket-sa`:

    * `storage.viewer` — на каталог.
    * `kms.keys.encrypterDecrypter` — на ключ шифрования.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Назначьте роли на каталог:

      1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Нажмите **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
      1. В списке выберите сервисный аккаунт `kuma-trail-sa`, при необходимости воспользуйтесь поиском.
      1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и в появившемся окне выберите [роль](../../audit-trails/security/index.md#at-viewer) `audit-trails.viewer`.

          Повторите этот шаг и добавьте [роль](../../storage/security/index.md#storage-uploader) `storage.uploader`.

      1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

      Таким же образом назначьте сервисному аккаунту `kuma-bucket-sa` [роль](../../storage/security/index.md#storage-viewer) `storage.viewer` на каталог.

  1. Назначьте роли на ключ шифрования:

      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}** и нажмите на строку с ключом `kuma-key`.
      1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. Выберите сервисный аккаунт `kuma-trail-sa`.
      1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter`.
      1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

      Таким же образом назначьте сервисному аккаунту `kuma-bucket-sa` роль `kms.keys.encrypterDecrypter` на ключ шифрования.

- CLI {#cli}

  1. Назначьте сервисному аккаунту `kuma-bucket-sa` роль `storage.viewer` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role storage.viewer \
        --subject serviceAccount:<идентификатор_kuma-bucket-sa>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, на который назначается роль.
      * `--role` — идентификатор роли.
      * `--subject` — тип [субъекта](../../iam/concepts/access-control/index.md#subject) и идентификатор сервисного аккаунта, которому назначается роль.

      Результат:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: storage.viewer
            subject:
              id: ajecikmc374i********
              type: serviceAccount
      ```

      Аналогичным образом назначьте сервисному аккаунту `kuma-trail-sa` роли `audit-trails.viewer` и `storage.uploader` на каталог.

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  2. Назначьте сервисному аккаунту `kuma-bucket-sa` роль `kms.keys.encrypterDecrypter` на ключ шифрования:

      ```bash
      yc kms symmetric-key add-access-binding kuma-key \
        --role kms.keys.encrypterDecrypter \
        --subject serviceAccount:<идентификатор_kuma-bucket-sa>
      ```

      Где:

      * `--role` — идентификатор роли.
      * `--subject` — тип [субъекта](../../iam/concepts/access-control/index.md#subject) и идентификатор сервисного аккаунта, которому назначается роль.

      Результат:

      ```text
      ...1s...done (4s)
      ```

      Аналогичным образом назначьте сервисному аккаунту `kuma-trail-sa` роль `kms.keys.encrypterDecrypter` на ключ шифрования.

      Подробнее о команде `yc kms symmetric-key add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/kms/cli-ref/symmetric-key/add-access-binding.md).

- API {#api}

  Чтобы назначить сервисному аккаунту роль, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}


## Создайте бакет {#create-bucket}

Создайте [бакет](../../storage/concepts/bucket.md), в который трейл будет сохранять аудитные логи, и включите [шифрование](../../storage/concepts/encryption.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета, например `my-audit-logs-for-kuma`.

      {% include [bucket-name-note](../_tutorials_includes/audit-trails-events-to-kuma/bucket-name-note.md) %}

  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** задайте размер создаваемого бакета или включите опцию **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
  1. Значения остальных параметров оставьте без изменения и нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. На открывшейся странице со списком бакетов выберите созданный бакет.
  1. В меню слева выберите ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** и перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите созданный ранее ключ `kuma-key`.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- CLI {#cli}

  1. Создайте бакет:

      ```bash
      yc storage bucket create --name <имя_бакета>
      ```

      Где `--name` — имя бакета, например `my-audit-logs-for-kuma`.

      {% include [bucket-name-note](../_tutorials_includes/audit-trails-events-to-kuma/bucket-name-note.md) %}

      Результат:

      ```text
      name: my-audit-logs-for-kuma
      folder_id: b1g681qpemb4********
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      acl: {}
      created_at: "2024-11-28T15:01:20.816656Z"
      ```

      Подробнее о команде `yc storage bucket create` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

  2. Включите шифрование для созданного бакета:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --encryption key-id=<идентификатор_симметричного_ключа>
      ```

      Где:

      * `--name` — имя бакета.
      * `--encryption` — идентификатор симметричного ключа, полученный при его [создании](#create-encryption-key).

      Результат:

      ```text
      name: my-audit-logs-for-kuma
      folder_id: b1g681qpemb4********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      acl: {}
      created_at: "2024-11-28T15:01:20.816656Z"
      ```

      Подробнее о команде `yc storage bucket update` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/bucket/update.md).

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}


## Создайте трейл {#create-trail}

Для сбора и доставки аудитных логов создайте [трейл](../../audit-trails/concepts/trail.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите **{{ ui-key.yacloud.audit-trails.button_create-trail }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя трейла `kuma-trail`.
      1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:

          * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
          * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — созданный ранее бакет, например `my-audit-logs-for-kuma`.
          * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

          {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

      1. Убедитесь, что в поле **{{ ui-key.yacloud.audit-trails.title_kms-key }}** указан ключ шифрования `kuma-key`. Если ключ шифрования не задан, нажмите **{{ ui-key.yacloud.audit-trails.action_add-bucket-key }}** и выберите этот ключ.

      1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:

          * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — не требует заполнения, содержит имя текущего каталога.

      1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выше выберите сервисный аккаунт `kuma-trail-sa`.
      1. В блоке **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** оставьте значение `{{ ui-key.yacloud.common.disabled }}`.
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc audit-trails trail create \
    --name kuma-trail \
    --destination-bucket <имя_бакета> \
    --destination-bucket-object-prefix <префикс> \
    --service-account-id <идентификатор_kuma-trail-sa> \
    --filter-from-cloud-id <идентификатор_облака> \
    --filter-some-folder-ids <идентификатор_каталога>
  ```

  Где:

  * `--name` — имя трейла.
  * `--destination-bucket` — [имя бакета](../../storage/concepts/bucket.md#naming), созданного [ранее](#create-bucket), в который будут загружаться аудитные логи.
  * `--destination-bucket-object-prefix` — [префикс](../../storage/concepts/object.md#folder), который будет добавлен к именам объектов с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.
  * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `kuma-trail-sa`, полученный [ранее](#create-service-accounts), от имени которого трейл будет загружать файлы аудитного лога в бакет.
  * `--filter-from-cloud-id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, для ресурсов которого трейл будет собирать аудитные логи.
  * `--filter-some-folder-ids` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, для ресурсов которого трейл будет собирать аудитные логи.

  Результат:

  ```text
  id: cnpabi372eer********
  folder_id: b1g681qpemb4********
  created_at: "2024-11-28T15:33:28.057Z"
  updated_at: "2024-11-28T15:33:28.057Z"
  name: kuma-trail
  destination:
    object_storage:
      bucket_id: my-audit-logs-for-kuma
      object_prefix: kuma
  service_account_id: ajedc6uq5o7m********
  status: ACTIVE
  cloud_id: b1gia87mbaom********
  filtering_policy:
    management_events_filter:
      resource_scopes:
        - id: b1g681qpemb4********
          type: resource-manager.folder
  ```

  Подробнее о команде `yc audit-trails trail create` читайте в [справочнике CLI](../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

- API {#api}

  Чтобы создать трейл, воспользуйтесь методом REST API [create](../../audit-trails/api-ref/Trail/create.md) для ресурса [Trail](../../audit-trails/api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../../audit-trails/api-ref/grpc/Trail/create.md).

{% endlist %}


## Создайте сервер {#create-server}

В качестве сервера для установки коллектора KUMA вы можете использовать [виртуальную машину](../../compute/concepts/vm.md) {{ compute-name }} или свое оборудование. В данном руководстве используется ВМ {{ compute-short-name }} в [облачной сети](../../vpc/concepts/network.md#network) {{ vpc-full-name }}.


### Создайте сеть и подсеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Задайте имя сети, например `kuma-network`.
  1. Убедитесь, что опция **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** включена.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

- CLI {#cli}

  1. Создайте облачную сеть:

      ```bash
      yc vpc network create --name kuma-network
      ```

      Где `--name` — имя сети.

      Результат:

      ```text
      id: enpnmb4jvubr********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-27T22:55:55Z"
      name: kuma-network
      default_security_group_id: enpjgspepn8k********
      ```

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  2. Создайте [подсеть](../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet create \
        --name kuma-network-{{ region-id }}-b \
        --network-name kuma-network \
        --zone {{ region-id }}-b \
        --range 10.1.0.0/24
      ```

      Где:

      * `--name` — имя подсети.
      * `--network-name` — имя сети, в которой создается подсеть.
      * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md) подсети.
      * `--range` — [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети.

      Результат:

      ```bash
      id: e2l7b3gpnhqn********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-27T22:57:48Z"
      name: kuma-network-ru-central1-b
      network_id: enpnmb4jvubr********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 10.1.0.0/24
      ```

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать [подсеть](../../vpc/concepts/network.md#subnet), воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


### Создайте виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть `kuma-network-{{ region-id }}-b`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на ВМ, например `yc-user`.

          {% include [name-format-2](../../_includes/name-format-2.md) %}

          {% include [dont-use-root-name](../../_includes/dont-use-root-name.md) %}

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `kuma-server`.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name kuma-server \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=kuma-network-{{ region-id }}-b,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-id=fd8ulbhv5dpakf3io1mf \
    --ssh-key <SSH-ключ>
  ```

  Где:

  * `--name` — имя ВМ.
  * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), которая соответствует подсети `kuma-network-{{ region-id }}-b`.
  * `--network-interface` — сетевые настройки:

      * `subnet-name` — имя подсети.
      * `nat-ip-version` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).

  * `--create-boot-disk` — настройки загрузочного [диска](../../compute/concepts/disk.md), где `image-id` — идентификатор публичного образа [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

  * `--ssh-key` — путь к файлу с открытым SSH-ключом и его имя, например: `~/.ssh/id_ed25519.pub`. Пару SSH-ключей для подключения к ВМ по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

      При создании ВМ в ее операционной системе будет создан пользователь `yc-user` — используйте это имя для подключения к ВМ по SSH.

  Результат:

  ```text
  id: epd4vr5ra728********
  folder_id: b1g681qpemb4********
  created_at: "2024-11-27T23:00:38Z"
  name: kuma-server
  zone_id: ru-central1-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epdk5emph7a4********
    auto_delete: true
    disk_id: epdk5emph7a4********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:4f:ec:bb:51
      subnet_id: e2l7b3gpnhqn********
      primary_v4_address:
        address: 10.1.0.4
        one_to_one_nat:
          address: 84.2**.***.***
          ip_version: IPV4
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  gpu_settings: {}
  fqdn: epd4vr5ra728********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V1
  ```

  Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Чтобы создать ВМ, воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}


## Смонтируйте бакет на сервере {#mount-bucket}

{% include [mount-bucket](../_tutorials_includes/audit-trails-events-to-kuma/mount-bucket.md) %}


## Настройте коллектор KUMA {#setup-collector}

{% include [setup-collector](../_tutorials_includes/audit-trails-events-to-kuma/setup-collector.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсеть.
1. [Удалите](../../vpc/operations/network-delete.md) сеть.
1. Удалите [трейл](../../audit-trails/concepts/trail.md).
1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты в бакете, затем [удалите](../../storage/operations/buckets/delete.md) сам бакет.
1. [Удалите](../../kms/operations/key.md#delete) ключ шифрования {{ kms-short-name }}.
