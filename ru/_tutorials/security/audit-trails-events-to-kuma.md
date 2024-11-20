# Загрузка аудитных логов {{ at-full-name }} в SIEM KUMA

В данном руководстве вы создадите [трейл](../../audit-trails/concepts/trail.md) {{ at-short-name }}, который будет передавать аудитные логи в коллектор KUMA. 

[Решение](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/290821.htm), которое описано в руководстве, работает по следующей схеме:

1. Трейл загружает логи в [бакет](../../storage/concepts/bucket.md) {{ objstorage-full-name }} с включенным [шифрованием](../../storage/concepts/encryption.md).
1. Бакет монтируется как часть [файловой системы](https://ru.wikipedia.org/wiki/FUSE_(%D0%BC%D0%BE%D0%B4%D1%83%D0%BB%D1%8C_%D1%8F%D0%B4%D1%80%D0%B0)) на сервере с установленным коллектором KUMA.
1. Коллектор KUMA получает и передает на обработку данные событий из смонтированного бакета.

Чтобы настроить доставку файлов аудитных логов в KUMA:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#setup-environment).
1. [Создайте бакет](#create-bucket).
1. [Создайте трейл](#create-trail).
1. [Смонтируйте бакет на сервере](#mount-bucket).
1. [Настройте коллектор KUMA](#setup-collector).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры {{ yandex-cloud }} входят:
* плата за хранение данных, операции с данными, а также исходящий трафик (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за использование симметричного ключа шифрования и выполнение криптографических операций (см. [тарифы {{ kms-full-name }}](../../kms/pricing.md));
* (опционально) плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* (опционально) плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

Кроме этого, для прохождения руководства вы должны иметь лицензию на использование KUMA (не поставляется {{ yandex-cloud }}).


## Подготовьте окружение {#setup-environment}

### Создайте сервисные аккаунты {#create-service-accounts}

Для работы создаваемой инфраструктуры потребуются два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md): один — для бакета {{ objstorage-name }}, второй — для трейла {{ at-short-name }}.

Чтобы создать сервисные аккаунты:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта для бакета: `kuma-bucket-sa`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Повторите шаги 3-5, чтобы создать сервисный аккаунт `kuma-trail-sa` для трейла.

{% endlist %}

### Создайте статический ключ доступа {#create-static-key}

Чтобы смонтировать бакет на сервере с установленным коллектором KUMA, создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `kuma-bucket-sa`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `kuma-bucket-sa`.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните полученные идентификатор и секретный ключ: они понадобятся позднее при монтировании бакета на сервере.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

{% endlist %}

### Создайте ключ шифрования {#create-encryption-key}

Чтобы создать новый [симметричный ключ шифрования](../../kms/concepts/key.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** и задайте атрибуты ключа:

     * Имя — `kuma-key`.
     * Алгоритм шифрования, например `AES-256`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Назначьте роли сервисным аккаунтам {#assign-roles}

1. Чтобы назначить сервисным аккаунтам роли на каталог:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
      1. В списке выберите сервисный аккаунт `kuma-trail-sa`, при необходимости воспользуйтесь поиском.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и в появившемся окне выберите [роль](../../audit-trails/security/index.md#at-viewer) `audit-trails.viewer`.

          Повторите этот шаг и добавьте [роль](../../storage/security/index.md#storage-uploader) `storage.uploader`.
      1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.
      1. Повторите шаги 3-7, чтобы назначить сервисному аккаунту `kuma-bucket-sa` [роль](../../storage/security/index.md#storage-viewer) `storage.viewer` на каталог.

    {% endlist %}

1. Чтобы назначить сервисным аккаунтам [роль](../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на созданный ранее ключ шифрования:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}** и нажмите на строку с ключом `kuma-key`.
      1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. Выберите сервисный аккаунт `kuma-trail-sa`.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль `kms.keys.encrypterDecrypter`.
      1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.
      1. Повторите шаги 3-7, чтобы назначить сервисному аккаунту `kuma-bucket-sa` роль `kms.keys.encrypterDecrypter` на ключ шифрования.

    {% endlist %}


## Создайте бакет {#create-bucket}

Чтобы создать бакет, в который трейл будет сохранять аудитные логи:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета, например: `my-audit-logs-for-kuma`.

      {% note info %}

      Имена бакетов должны быть уникальны для всего {{ objstorage-short-name }}, то есть нельзя создать два бакета с одинаковыми именами даже в разных каталогах разных облаков.

      {% endnote %}

  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** задайте размер создаваемого бакета или включите опцию **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
  1. Значения остальных параметров оставьте без изменения и нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. На открывшейся странице со списком бакетов выберите созданный бакет.
  1. В меню слева выберите ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** и перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите созданный ранее ключ `kuma-key`.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

{% endlist %}


## Создайте трейл {#create-trail}

Чтобы создать трейл:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя трейла `kuma-trail`.
      1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:

          * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
          * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — созданный ранее бакет, например: `my-audit-logs-for-kuma`.
          * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.
      
          {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}
      1. Убедитесь, что в поле **{{ ui-key.yacloud.audit-trails.title_kms-key }}** указан ключ шифрования `kuma-key`. Если ключ шифрования не задан, нажмите кнопку **{{ ui-key.yacloud.audit-trails.action_add-bucket-key }}** и выберите этот ключ.

      1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:

          * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — не требует заполнения, содержит имя текущего каталога.

      1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выше выберите сервисный аккаунт `kuma-trail-sa`.

      1. В блоке **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** оставьте значение `{{ ui-key.yacloud.common.disabled }}`.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  {% endlist %}


## Смонтируйте бакет на сервере {#mount-bucket}

Это действие выполняется на сервере, на котором будет установлен коллектор KUMA. В качестве сервера вы можете использовать виртуальную машину в {{ compute-full-name }} или свое оборудование. В данном руководстве будет использоваться ВМ {{ compute-short-name }}.

Чтобы смонтировать бакет на сервере:

1. [Создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину из публичного образа [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).
1. Подключитесь к ВМ [по SSH](../../compute/operations/vm-connect/ssh.md) или [по {{ oslogin }}](../../compute/operations/vm-connect/os-login.md).
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
      -o url=https://{{ s3-storage-host }} \
      -o use_path_request_style \
      -o uid=$(id -u kuma) \
      -o gid=$(id -g kuma)
    ```

    Вы можете настроить автоматическое монтирование бакета при запуске операционной системы, для этого откройте файл `/etc/fstab` (команда `sudo nano /etc/fstab`) и добавьте в него строку:

    ```text
    s3fs#<имя_бакета> /var/log/yandex-cloud fuse _netdev,uid=<kuma_uid>,gid=<kuma_gid>,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/kuma/.passwd-s3fs 0 0
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

Настройка передачи событий {{ yandex-cloud }} завершена. События будут располагаться в следующих директориях в [JSON](https://ru.wikipedia.org/wiki/JSON)-файлах:

```text
/var/log/yandex-cloud/{audit_trail_id}/{year}/{month}/{day}/*.json
```

## Настройте коллектор KUMA {#setup-collector}

На этом шаге вам понадобятся файлы дистрибутива и лицензии, входящие в комплект поставки KUMA. Используйте их, чтобы установить и настроить коллектор в сетевой инфраструктуре KUMA. Подробнее см. в [инструкции](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/220708.htm).

После успешного завершения настройки аудитные события начнут поставляться в KUMA. Веб-интерфейс KUMA позволяет выполнять [поиск связанных событий](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/217989.htm).

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* удалите [трейл](../../audit-trails/concepts/trail.md);
* [удалите](../../storage/operations/objects/delete-all.md) все объекты в бакете, затем [удалите](../../storage/operations/buckets/delete.md) сам бакет;
* [удалите](../../kms/operations/key.md#delete) ключ шифрования {{ kms-short-name }};
* [удалите](../../iam/operations/sa/delete.md) сервисные аккаунты;
* [удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину, если вы создавали ее.