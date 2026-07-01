# Загрузка аудитных логов Yandex Audit Trails в SIEM KUMA с помощью консоли управления, CLI или API


Чтобы настроить доставку файлов [аудитных логов](../../../audit-trails/concepts/format.md) в [KUMA](https://www.kaspersky.ru/enterprise-security/unified-monitoring-and-analysis-platform):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#setup-environment).
1. [Создайте бакет](#create-bucket).
1. [Создайте трейл](#create-trail).
1. [Создайте сервер](#create-server).
1. [Смонтируйте бакет на сервере](#mount-bucket).
1. [Настройте коллектор KUMA](#setup-collector).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры Yandex Cloud входят:

* плата за хранение данных, операции с данными, а также исходящий трафик ([тарифы Yandex Object Storage](../../../storage/pricing.md));
* плата за использование симметричного ключа шифрования и выполнение криптографических операций ([тарифы Yandex Key Management Service](../../../kms/pricing.md));
* (опционально) плата за постоянно запущенную виртуальную машину ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* (опционально) плата за использование динамического или статического внешнего IP-адреса ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).

Кроме этого, для прохождения руководства вы должны иметь [лицензию](https://kb.kuma-community.ru/books/kuma-how-to/page/model-licenzirovaniia-kuma) на использование KUMA (не поставляется Yandex Cloud).


## Подготовьте окружение {#setup-environment}

### Создайте сервисные аккаунты {#create-service-accounts}

Для работы создаваемой инфраструктуры создайте два [сервисных аккаунта](../../../iam/concepts/users/service-accounts.md):

* `kuma-bucket-sa` — для бакета Object Storage.
* `kuma-trail-sa` — для трейла Audit Trails.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта для бакета: `kuma-bucket-sa`.
  1. Нажмите **Создать**.
  1. Повторите шаги 3-5, чтобы создать сервисный аккаунт `kuma-trail-sa` для трейла.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

{% endlist %}


### Создайте статический ключ доступа {#create-static-key}

Чтобы смонтировать бакет на сервере с установленным коллектором KUMA, создайте [статический ключ доступа](../../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `kuma-bucket-sa`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт `kuma-bucket-sa`.
  1. На панели сверху нажмите ![image](../../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите **Создать**.
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

  Подробнее о команде `yc iam access-key create` читайте в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/access-key/create.md).

- API {#api}

  Чтобы создать статический ключ доступа, воспользуйтесь методом REST API [create](../../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md).

{% endlist %}


### Создайте ключ шифрования {#create-encryption-key}

Для шифрования аудитных логов в бакете создайте [симметричный ключ шифрования](../../../kms/concepts/key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. Нажмите **Создать ключ** и задайте атрибуты ключа:

      * **Имя** — `kuma-key`.
      * **Алгоритм шифрования** — `AES-256`.

  1. Нажмите **Создать**.

- CLI {#cli}

  1. Выполните команду:

      ```bash
      yc kms symmetric-key create \
        --name kuma-key \
        --default-algorithm aes-256
      ```

      Где:

      * `--name` — имя ключа.
      * `--default-algorithm` — [алгоритм шифрования](../../../kms/concepts/key.md#parameters).

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

  Подробнее о команде `yc kms symmetric-key create` читайте в [справочнике CLI](../../../cli/cli-ref/kms/cli-ref/symmetric-key/create.md).

- API {#api}

  Чтобы создать симметричный ключ шифрования, воспользуйтесь методом REST API [create](../../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md).

{% endlist %}


### Назначьте роли сервисным аккаунтам {#assign-roles}

Назначьте сервисным аккаунтам следующие [роли](../../../iam/concepts/access-control/roles.md) на каталог и созданный [ранее](#create-encryption-key) ключ шифрования:

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

      1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создаете инфраструктуру.
      1. Перейдите на вкладку **Права доступа**.
      1. Нажмите **Настроить доступ**.
      1. В открывшемся окне выберите раздел **Сервисные аккаунты**.
      1. В списке выберите сервисный аккаунт `kuma-trail-sa`, при необходимости воспользуйтесь поиском.
      1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и в появившемся окне выберите [роль](../../../audit-trails/security/index.md#at-viewer) `audit-trails.viewer`.

          Повторите этот шаг и добавьте [роль](../../../storage/security/index.md#storage-uploader) `storage.uploader`.

      1. Нажмите **Сохранить**.

      Таким же образом назначьте сервисному аккаунту `kuma-bucket-sa` [роль](../../../storage/security/index.md#storage-viewer) `storage.viewer` на каталог.

  1. Назначьте роли на ключ шифрования:

      1. Перейдите в сервис **Key Management Service**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/key.svg) **Симметричные ключи** и нажмите на строку с ключом `kuma-key`.
      1. Перейдите в раздел ![image](../../../_assets/console-icons/persons.svg) **Права доступа** и нажмите **Назначить роли**.
      1. Выберите сервисный аккаунт `kuma-trail-sa`.
      1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter`.
      1. Нажмите **Сохранить**.

      Таким же образом назначьте сервисному аккаунту `kuma-bucket-sa` роль `kms.keys.encrypterDecrypter` на ключ шифрования.

- CLI {#cli}

  1. Назначьте сервисному аккаунту `kuma-bucket-sa` роль `storage.viewer` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role storage.viewer \
        --subject serviceAccount:<идентификатор_kuma-bucket-sa>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, на который назначается роль.
      * `--role` — идентификатор роли.
      * `--subject` — тип [субъекта](../../../iam/concepts/access-control/index.md#subject) и идентификатор сервисного аккаунта, которому назначается роль.

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

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  2. Назначьте сервисному аккаунту `kuma-bucket-sa` роль `kms.keys.encrypterDecrypter` на ключ шифрования:

      ```bash
      yc kms symmetric-key add-access-binding kuma-key \
        --role kms.keys.encrypterDecrypter \
        --subject serviceAccount:<идентификатор_kuma-bucket-sa>
      ```

      Где:

      * `--role` — идентификатор роли.
      * `--subject` — тип [субъекта](../../../iam/concepts/access-control/index.md#subject) и идентификатор сервисного аккаунта, которому назначается роль.

      Результат:

      ```text
      ...1s...done (4s)
      ```

      Аналогичным образом назначьте сервисному аккаунту `kuma-trail-sa` роль `kms.keys.encrypterDecrypter` на ключ шифрования.

      Подробнее о команде `yc kms symmetric-key add-access-binding` читайте в [справочнике CLI](../../../cli/cli-ref/kms/cli-ref/symmetric-key/add-access-binding.md).

- API {#api}

  Чтобы назначить сервисному аккаунту роль, воспользуйтесь методом REST API [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}


## Создайте бакет {#create-bucket}

Создайте [бакет](../../../storage/concepts/bucket.md), в который трейл будет сохранять аудитные логи, и включите [шифрование](../../../storage/concepts/encryption.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Object Storage**.
  1. Справа сверху нажмите **Создать бакет**.
  1. В поле **Имя** укажите имя бакета, например `my-audit-logs-for-kuma`.

      {% note info %}
      
      Имя бакета должно быть уникальным для всего Object Storage. Нельзя создать два бакета с одинаковыми именами даже в разных каталогах разных облаков.
      
      {% endnote %}

  1. В поле **Макс. размер** задайте размер создаваемого бакета или включите опцию **Без ограничения**.
  1. Значения остальных параметров оставьте без изменения и нажмите **Создать бакет**.
  1. На открывшейся странице со списком бакетов выберите созданный бакет.
  1. В меню слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **Безопасность** и перейдите на вкладку **Шифрование**.
  1. В поле **Ключ KMS** выберите созданный ранее ключ `kuma-key`.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  1. Создайте бакет:

      ```bash
      yc storage bucket create --name <имя_бакета>
      ```

      Где `--name` — имя бакета, например `my-audit-logs-for-kuma`.

      {% note info %}
      
      Имя бакета должно быть уникальным для всего Object Storage. Нельзя создать два бакета с одинаковыми именами даже в разных каталогах разных облаков.
      
      {% endnote %}

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

      Подробнее о команде `yc storage bucket create` читайте в [справочнике CLI](../../../cli/cli-ref/storage/cli-ref/bucket/create.md).

  1. Включите шифрование для созданного бакета:

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

      Подробнее о команде `yc storage bucket update` читайте в [справочнике CLI](../../../cli/cli-ref/storage/cli-ref/bucket/update.md).

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../../storage/s3/api-ref/bucket/create.md).

{% endlist %}


## Создайте трейл {#create-trail}

Для сбора и доставки аудитных логов создайте [трейл](../../../audit-trails/concepts/trail.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Audit Trails**.
  1. Нажмите **Создать трейл** и в открывшемся окне:

      1. В поле **Имя** задайте имя трейла `kuma-trail`.
      1. В блоке **Назначение** задайте параметры объекта назначения:

          * **Назначение** — `Object Storage`.
          * **Бакет** — созданный ранее бакет, например `my-audit-logs-for-kuma`.
          * **Префикс объекта** — необязательный параметр, участвует в [полном имени](../../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

          {% note info %}
          
          Используйте [префикс](../../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
          
          {% endnote %}

      1. Убедитесь, что в поле **Ключ шифрования** указан ключ шифрования `kuma-key`. Если ключ шифрования не задан, нажмите **Добавить** и выберите этот ключ.

      1. В блоке **Сбор событий c уровня конфигурации** задайте параметры сбора аудитных логов уровня конфигурации:

          * **Сбор событий** — выберите `Включено`.
          * **Ресурс** — выберите `Каталог`.
          * **Каталог** — не требует заполнения, содержит имя текущего каталога.

      1. В блоке **Сервисный аккаунт** выше выберите сервисный аккаунт `kuma-trail-sa`.
      1. В блоке **Сбор событий с уровня сервисов** оставьте значение `Выключено`.
      1. Нажмите **Создать**.

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
  * `--destination-bucket` — [имя бакета](../../../storage/concepts/bucket.md#naming), созданного [ранее](#create-bucket), в который будут загружаться аудитные логи.
  * `--destination-bucket-object-prefix` — [префикс](../../../storage/concepts/object.md#folder), который будет добавлен к именам объектов с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.
  * `--service-account-id` — [идентификатор](../../../iam/operations/sa/get-id.md) сервисного аккаунта `kuma-trail-sa`, полученный [ранее](#create-service-accounts), от имени которого трейл будет загружать файлы аудитного лога в бакет.
  * `--filter-from-cloud-id` — [идентификатор](../../../resource-manager/operations/cloud/get-id.md) облака, для ресурсов которого трейл будет собирать аудитные логи.
  * `--filter-some-folder-ids` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, для ресурсов которого трейл будет собирать аудитные логи.

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

  Подробнее о команде `yc audit-trails trail create` читайте в [справочнике CLI](../../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

- API {#api}

  Чтобы создать трейл, воспользуйтесь методом REST API [create](../../../audit-trails/api-ref/Trail/create.md) для ресурса [Trail](../../../audit-trails/api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../../../audit-trails/api-ref/grpc/Trail/create.md).

{% endlist %}


## Создайте сервер {#create-server}

В качестве сервера для установки коллектора KUMA вы можете использовать [виртуальную машину](../../../compute/concepts/vm.md) Compute Cloud или свое оборудование. В данном руководстве используется ВМ Compute Cloud в [облачной сети](../../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud.


### Создайте сеть и подсеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Нажмите **Создать сеть**.
  1. Задайте имя сети, например `kuma-network`.
  1. Убедитесь, что опция **Создать подсети** включена.
  1. Нажмите **Создать сеть**.

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

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/network/create.md).

  2. Создайте [подсеть](../../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet create \
        --name kuma-network-ru-central1-b \
        --network-name kuma-network \
        --zone ru-central1-b \
        --range 10.1.0.0/24
      ```

      Где:

      * `--name` — имя подсети.
      * `--network-name` — имя сети, в которой создается подсеть.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md) подсети.
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

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать [подсеть](../../../vpc/concepts/network.md#subnet), воспользуйтесь методом REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


### Создайте виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** выберите образ [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md) `ru-central1-b`.
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите подсеть `kuma-network-ru-central1-b`.
      * В поле **Публичный IP-адрес** выберите `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа к ВМ:

      * В поле **Логин** введите имя пользователя, который будет создан на ВМ, например `yc-user`.

          * Длина — от 3 до 63 символов.
          * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
          * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.

          {% note alert %}
          
          Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
          
          {% endnote %}

      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `kuma-server`.
  1. Нажмите **Создать ВМ**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name kuma-server \
    --zone ru-central1-b \
    --network-interface subnet-name=kuma-network-ru-central1-b,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-id=fd8ulbhv5dpakf3io1mf \
    --ssh-key <SSH-ключ>
  ```

  Где:

  * `--name` — имя ВМ.
  * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), которая соответствует подсети `kuma-network-ru-central1-b`.
  * `--network-interface` — сетевые настройки:

      * `subnet-name` — имя подсети.
      * `nat-ip-version` — [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).

  * `--create-boot-disk` — настройки загрузочного [диска](../../../compute/concepts/disk.md), где `image-id` — идентификатор публичного образа [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).

  * `--ssh-key` — путь к файлу с открытым SSH-ключом и его имя, например: `~/.ssh/id_ed25519.pub`. Пару SSH-ключей для подключения к ВМ по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

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

  Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Чтобы создать ВМ, воспользуйтесь методом REST API [create](../../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}


## Смонтируйте бакет на сервере {#mount-bucket}

1. Подключитесь к серверу по [SSH](../../../compute/operations/vm-connect/ssh.md).
1. Создайте нового пользователя `kuma`:

    ```bash
    sudo useradd kuma
    ```

1. Создайте домашнюю директорию пользователя `kuma`:

    ```bash
    sudo mkdir /home/kuma
    ```

1. Создайте файл со статическим ключом доступа и выдайте пользователю `kuma` права на него:

    ```bash
    sudo bash -c 'echo <идентификатор_ключа_доступа>:<секретный_ключ_доступа> > /home/kuma/.passwd-s3fs'
    sudo chmod 600 /home/kuma/.passwd-s3fs
    sudo chown -R kuma:kuma /home/kuma
    ```

    Где `<идентификатор_ключа_доступа>` и `<секретный_ключ_доступа>` — сохраненные ранее значения статического ключа доступа сервисного аккаунта `kuma-bucket-sa`.

1. Установите пакет [s3fs](https://github.com/s3fs-fuse/s3fs-fuse):

    ```bash
    sudo apt install s3fs
    ````

1. Создайте директорию, которая будет служить точкой монтирования для бакета, и выдайте пользователю `kuma` права на эту директорию:

    ```bash
    sudo mkdir /var/log/yandex-cloud/
    sudo chown kuma:kuma /var/log/yandex-cloud/
    ```

1. Смонтируйте созданный ранее бакет, указав его имя:

    ```bash
    sudo s3fs <имя_бакета> /var/log/yandex-cloud \
      -o passwd_file=/home/kuma/.passwd-s3fs \
      -o url=https://storage.yandexcloud.net \
      -o use_path_request_style \
      -o uid=$(id -u kuma) \
      -o gid=$(id -g kuma)
    ```

    Вы можете настроить автоматическое монтирование бакета при запуске операционной системы, для этого откройте файл `/etc/fstab` (команда `sudo nano /etc/fstab`) и добавьте в него строку:

    ```text
    s3fs#<имя_бакета> /var/log/yandex-cloud fuse _netdev,uid=<kuma_uid>,gid=<kuma_gid>,use_path_request_style,url=https://storage.yandexcloud.net,passwd_file=/home/kuma/.passwd-s3fs 0 0
    ```

    Где:

    * `<имя_бакета>` — имя созданного ранее бакета, например: `my-audit-logs-for-kuma`.
    * `<kuma_uid>` — идентификатор пользователя `kuma` в операционной системе ВМ.
    * `<kuma_gid>` — идентификатор группы пользователей `kuma` в операционной системе ВМ.

        Чтобы узнать значения `<kuma_uid>` и `<kuma_gid>`, в терминале выполните команду `id kuma`.

1. Убедитесь, что бакет смонтирован:

    ```bash
    sudo ls /var/log/yandex-cloud/
    ```

    Если все настроено верно, команда вернет текущее содержимое бакета с аудитными событиями.

Настройка передачи событий Yandex Cloud завершена. События будут располагаться в следующих директориях в [JSON](https://ru.wikipedia.org/wiki/JSON)-файлах:

```text
/var/log/yandex-cloud/{audit_trail_id}/{year}/{month}/{day}/*.json
```


## Настройте коллектор KUMA {#setup-collector}

На этом шаге вам понадобятся файлы дистрибутива и лицензии, входящие в комплект поставки KUMA. Используйте их, чтобы установить и настроить коллектор в сетевой инфраструктуре KUMA. Подробнее в [инструкции](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/220708.htm).

После успешного завершения настройки аудитные события начнут поставляться в KUMA. Веб-интерфейс KUMA позволяет выполнять [поиск связанных событий](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/217989.htm).


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
1. [Удалите](../../../vpc/operations/subnet-delete.md) подсеть.
1. [Удалите](../../../vpc/operations/network-delete.md) сеть.
1. Удалите [трейл](../../../audit-trails/concepts/trail.md).
1. [Удалите](../../../storage/operations/objects/delete-all.md) все объекты в бакете, затем [удалите](../../../storage/operations/buckets/delete.md) сам бакет.
1. [Удалите](../../../kms/operations/key.md#delete) ключ шифрования KMS.

#### Полезные ссылки {#see-also}

* [Загрузка аудитных логов Yandex Audit Trails в SIEM KUMA с помощью Terraform](terraform.md)