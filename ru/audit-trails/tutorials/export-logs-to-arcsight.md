# Загрузка аудитных логов в SIEM ArcSight

Создайте трейл, который будет загружать аудитные логи уровня конфигурации (Control Plane) ресурсов отдельного каталога в бакет {{ objstorage-full-name }} с включенным шифрованием. Затем настройте непрерывную доставку логов в SIEM ArcSight.

Для успешного прохождения руководства у вас должен быть установлен экземпляр ArcSight.

Решение, которое описано в руководстве, работает по следующей схеме:
1. [Трейл](../concepts/trail.md) загружает логи в бакет {{ objstorage-name }}.
1. [Бакет](../../storage/concepts/bucket.md) монтируется через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра))-интерфейс к папке на промежуточной [ВМ](../../glossary/vm.md).
1. [SmartConnector](https://www.microfocus.com/documentation/arcsight/arcsight-smartconnectors/AS_SmartConn_getstart_HTML/) забирает логи из папки и передает их в ArcSight для анализа.

Подробнее о сценариях загрузки аудитных логов в ArcSight смотрите в [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight#two-log-shipping-scenarios).

{% include [Yc-security-solutions-library](../../_includes/security-solution-library.md) %}

Чтобы настроить доставку файлов аудитных логов в ArcSight:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare-environment).
1. [Назначьте роли сервисным аккаунтам](#add-roles).
1. [Создайте трейл](#create-trail).
1. [Смонтируйте бакет](#mount-bucket).
1. [Подключите ArcSight SmartConnector](#configure-arcsight).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* использование виртуальных машин (см. [тарифы {{ compute-short-name }}](../../compute/pricing.md));
* плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-operations));
* плата за использование ключей {{ kms-short-name }} (см. [тарифы {{ kms-name }}](../../kms/pricing.md#prices)).

## Подготовьте окружение {#prepare-environment}

### Подготовьте промежуточную ВМ {#setup-vm}

Вы можете использовать готовую ВМ, у которой есть доступ к экземпляру ArcSight, или создать новую:

1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из образа Linux с операционной системой [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по [SSH](../../glossary/ssh-keygen.md).

### Создайте бакет для аудитных логов {#create-backet}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать бакет, например, `example-folder`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. На странице создания бакета:
      1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
      1. При необходимости ограничьте максимальный размер бакета.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access) `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
      1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию.
      1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Создайте ключ шифрования в сервисе {{ kms-name }} {#create-key}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `example-folder`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. Нажмите **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** и укажите:
     * **{{ ui-key.yacloud.common.name }}** — `arcsight-kms`.
     * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** — `AES-256`.
     * Для остальных параметров оставьте значения по умолчанию.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Включите шифрование бакета {#backet-encoding}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, созданный ранее.
  1. На панели слева выберите **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите ключ `arcsight-kms`.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

{% endlist %}

### Создайте сервисные аккаунты {#create-sa}

Необходимо создать два аккаунта — отдельно для трейла и бакета.

Создайте сервисный аккаунт `sa-arcsight`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `example-folder`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта в соответствии с правилами именования:
  
       {% include [name-format](../../_includes/name-format.md) %}

       Например, `sa-arcsight`.
  
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  
{% endlist %}

Аналогично создайте сервисный аккаунт с именем `sa-arcsight-bucket`.

### Создайте статический ключ {#create-access-key}

Идентификатор ключа и секретный ключ понадобятся вам на этапе монтирования бакета.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `example-folder`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт `sa-arcsight-bucket` и нажмите на строку с его именем.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI

  1. Создайте ключ доступа для сервисного аккаунта `sa-arcsight-bucket`:

      ```bash
      yc iam access-key create --service-account-name sa-arcsight-bucket
      ```

      Результат:

      ```
      access_key:
        id: aje*******k2u
        service_account_id: aje*******usm
        created_at: "2022-09-22T14:37:51Z"
        key_id: 0n8*******0YQ
      secret: JyT*******zMP1
      ```

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

{% endlist %}

## Назначьте роли сервисным аккаунтам {#add-roles}

Назначьте сервисному аккаунту `sa-arcsight` роли `audit-trails.viewer`, `storage.uploader` и `kms.keys.encrypterDecrypter`:

{% list tabs %}

- CLI 

  1. [Роль](../../audit-trails/security/#roles) `audit-trails.viewer` на каталог:
     
      ```
      yc resource-manager folder add-access-binding \
      --role audit-trails.viewer \
      --id <идентификатор_каталога> \
      --service-account-id <идентификатор_сервисного_аккаунта>
      ```
      
      Где:
  
      * `--role` — назначаемая роль;
      * `--id` — идентификатор каталога `example-folder`;
      * `--service-account-id` — идентификатор сервисного аккаунта `sa-arcsight`.

      Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).
  
  1. [Роль](../../storage/security/#storage-uploader) `storage.uploader` на каталог с бакетом:
     
      ```
      yc resource-manager folder add-access-binding \
      --role storage.uploader \
      --id <идентификатор_каталога> \
      --service-account-id <идентификатор_сервисного_аккаунта>
      ```
  
      Где:
  
      * `--role` — назначаемая роль;
      * `--id` — идентификатор каталога `example-folder`;
      * `--service-account-id` — идентификатор сервисного аккаунта `sa-arcsight`.

  1. [Роль](../../kms/security/#service) `kms.keys.encrypterDecrypter` на ключ шифрования `arcsight-kms`:
  
      ```
      yc kms symmetric-key add-access-binding \
      --role kms.keys.encrypterDecrypter \
      --id <идентификатор_ключа> \
      --service-account-id <идентификатор_сервисного_аккаунта>
      ```
  
      Где:
  
      * `--role` — назначаемая роль;
      * `--id` — идентификатор {{ kms-short-name }}-ключа `arcsight-kms`;
      * `--service-account-id` — идентификатор сервисного аккаунта `sa-arcsight`.

{% endlist %}

Назначьте сервисному аккаунту `sa-arcsight-bucket` роли `storage.viewer` и `kms.keys.encrypterDecrypter`:

{% list tabs %}

- CLI

  1. Роль `storage.viewer` на каталог:
     
      ```
      yc resource-manager folder add-access-binding \
      --id <идентификатор_каталога> \
      --role storage.viewer \
      --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:
  
      * `--id` — идентификатор каталога `example-folder`;
      * `--role` — назначаемая роль;
      * `--service-account-id` — идентификатор сервисного аккаунта `sa-arcsight-bucket`.
  
  1. Роль `kms.keys.encrypterDecrypter` на ключ шифрования `arcsight-kms`:
  
      ```
      yc kms symmetric-key add-access-binding \
      --role kms.keys.encrypterDecrypter \
      --id <идентификатор_ключа> \
      --service-account-id <идентификатор_сервисного_аккаунта>
      ```
  
      Где:
  
      * `--role` — назначаемая роль;
      * `--id` — идентификатор {{ kms-short-name }}-ключа `arcsight-kms`;
      * `--service-account-id` — идентификатор сервисного аккаунта `sa-arcsight-bucket`.
  
{% endlist %}

## Создайте трейл {#create-trail}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `example-folder`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите **{{ ui-key.yacloud.audit-trails.button_create-trail }}** и укажите:

     * **{{ ui-key.yacloud.common.name }}** — имя создаваемого трейла, например, `arcsight-trail`.
     * **{{ ui-key.yacloud.common.description }}** — описание трейла, необязательный параметр.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:

     * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
     * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — имя бакета.
     * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.
  
     {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — укажите ключ шифрования `arcsight-kms`, которым [зашифрован](../../storage/concepts/encryption.md) бакет.
  
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите `sa-arcsight`.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:

     * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
     * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
     * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — не требует заполнения, содержит имя текущего каталога.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** в поле **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** выберите `{{ ui-key.yacloud.common.disabled }}`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  {% note warning %}
  
  Решение будет удалять логи из бакета после экспорта в ArcSight. Если вам нужно хранить логи в бакете, создайте отдельные бакет и трейл.
  
  {% endnote %}

{% endlist %}

## Смонтируйте бакет {#mount-bucket}

Бакет монтируется на промежуточной ВМ, на нее же устанавливается ArcSight SmartConnector.
Чтобы смонтировать бакет, создайте файл со статическим ключом доступа сервисного аккаунта `sa-arcsight-bucket`.

1. На промежуточной ВМ создайте файл со статическим ключом доступа:

   ```bash
   echo <идентификатор_ключа_доступа>:<секретный_ключ_доступа> > ${HOME}/.passwd-s3fs
   chmod 600 ${HOME}/.passwd-s3fs
   ```

1. Установите [s3fs](https://github.com/s3fs-fuse/s3fs-fuse):

   ```bash
   sudo apt install s3fs
   ```

1. Создайте директорию, к которой будет монтироваться бакет, например, `mybucket` в домашней директории:

   ```bash
   sudo mkdir ${HOME}/mybucket
   ```

1. Смонтируйте бакет:

   ```bash
   s3fs <имя_бакета> ${HOME}/mybucket -o passwd_file=${HOME}/.passwd-s3fs -o url=https://{{ s3-storage-host }} -o use_path_request_style
   ```

1. Проверьте, что бакет смонтирован:

   ```bash
   ls ${HOME}/mybucket
   ```

## Установите и настройте ArcSight SmartConnector {#configure-arcsight}

{% note info %}

Для выполнения этого этапа руководства вам нужен дистрибутив ArcSight SmartConnector и доступ к экземпляру ArcSight.

{% endnote %}

1. На промежуточной ВМ [установите](https://www.microfocus.com/documentation/arcsight/arcsight-smartconnectors/AS_smartconn_install/) `ArcSight SmartConnector`:
    1. При установке выберите **ArcSight FlexConnector JSON Folder Follower** и укажите путь к папке `mybucket`.
    1. Укажите **JSON configuration filename prefix**: `yc`.
1. [Скачайте](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight/tree/main/arcsight_content) файлы `arcsight_content`.
1. Скопируйте файл `yc.jsonparser.properties` из папки `flex` в папку с адресом `<папка_установки_агента>/current/user/agent/flexagent`.
1. Скопируйте файл `map.0.properties` из папки `flex` в папку с адресом `<папка_установки_агента>/current/user/agent/map`.
1. Отредактируйте файл `<папка_установки_агента>/current/user/agent/agent.properties`:

    ```bash
    agents[0].mode=DeleteFile
    agents[0].proccessfoldersrecursively=true
    ```

1. Запустите коннектор и убедитесь, что события поступают в ArcSight:

   ![image](../../_assets/audit-trails/tutorials/arcsight-events.png)

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите](../../storage/operations/buckets/delete.md) бакет {{ objstorage-name }}.
1. [Удалите](../../kms/operations/key.md#delete) ключ {{ kms-name }}.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) промежуточную ВМ, если вы создали ее в {{ compute-short-name }}.
