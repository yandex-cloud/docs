# Резервное копирование в {{ objstorage-full-name }} с помощью Veritas Backup Exec

{{ objstorage-full-name }} можно использовать для резервного копирования и восстановления данных с помощью утилиты Veritas Backup Exec.

Чтобы настроить резервное копирование в {{ objstorage-name }} с помощью Veritas Backup Exec:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте бакет](#create-bucket).
1. [Настройте сервисный аккаунт](#configure-service-account).
1. [Создайте облачный инстанс на {{ objstorage-full-name }}](#new-becloudinstance).
1. [Настройте облачное хранилище](#setup-cloud).
1. [Добавьте резервируемый сервер](#add-source).
1. [Задайте настройки резервного копирования](#add-target).
1. [Протестируйте резервное копирование](#test-backup).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования с помощью Veritas Backup Exec входят:

* плата за хранение данных;
* плата за операции с данными;
* плата за исходящий трафик из {{ yandex-cloud }} в интернет.

[Подробнее о тарифах {{ objstorage-full-name }}](../pricing.md#prices).

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
  1. На странице каталога нажмите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя [бакета](../concepts/bucket.md) в соответствии с [правилами именования](../concepts/bucket.md#naming).
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
  1. Укажите максимальный размер бакета в ГБ.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Настройте сервисный аккаунт {#configure-service-account}

Резервное копирование в {{ objstorage-name }} выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

Чтобы настроить сервисный аккаунт:

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#storage-admin) `storage.admin`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статические ключи доступа. Сразу сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры закрытого ключа будут недоступны.

## Создайте облачный инстанс на {{ objstorage-full-name }} {#new-becloudinstance}

1. Запустите Backup Exec Management Command Line Interface и выполните команду:

    ```bash
    BEMCLI> New-BECloudInstance
    ```

1. Последовательно введите параметры облачного инстанса:
    * `Provider:` — `compatible-with-s3`.
    * `ServiceHost:` — `{{ s3-storage-host }}`.
    * `SslMode:` — `disabled`.
    * `Name:` — `cloud`.

    Результат:

    ```text
    cmdlet New-BECloudInstance at command pipeline position 1
    Supply values for the following parameters:
      Provider: compatible-with-s3
      ServiceHost: {{ s3-storage-host }}
      SslMode: disabled
      Name: cloud


    Name        : cloud
    Id          : 12436533-a39e-4df6-81db-f836********
    Provider    : compatible-with-s3
    ServiceHost : {{ s3-storage-host }}
    SslMode     : Disabled
    UrlStyle    : Path
    HttpPort    : 80
    HttpsPort   : 443
    Endpoint    :
    ```

## Настройте облачное хранилище {#setup-cloud}

1. Запустите Veritas Backup Exec.
1. На панели **Хранилище** выберите **Настроить облачное хранилище**.
1. Введите **Имя** для устройства облачного хранилища и нажмите кнопку **Далее**.
1. Выберите поставщика для устройства **S3** и нажмите кнопку **Далее**.
1. Введите информацию о соединении:
    * Выберите **Облачное хранилище** `cloud [ compatible-with-s3 ]`.
    * В строке **Учетная запись** нажмите кнопку **Добавить/Изменить**.
    * В окне **Выбор учетной записи** нажмите кнопку **Добавить**.
    * В поле **Имя пользователя** введите идентификатор ключа.
    * В поле **Пароль** введите секретный ключ.
    * Повторно введите секретный ключ для подтверждения.
    * Задайте **Имя учетной записи**, например `Administrator of Bucket`.
    * Подтвердите имя учетной записи и нажмите кнопку **OK**.
    * Нажмите кнопку **Далее**.
1. Выберите бакет для резервного копирования и нажмите кнопку **Далее**.
1. Выберите количество параллельных операций для устройства и нажмите кнопку **Далее**.
1. Проверьте выбранные настройки и нажмите кнопку **Готово**.

## Добавьте резервируемый сервер {#add-source}

1. Откройте панель **Резервное копирование и восстановление** Veritas Backup Exec.
1. В выпадающем списке **Серверы и виртуальные хосты** выберите **Добавить**.
1. Выберите **Компьютеры и серверы Microsoft Windows** и нажмите кнопку **Далее**.
1. Выберите опцию **Разрешить Backup Exec устанавливать доверительные отношения с серверами** и нажмите кнопку **Далее**.
1. Добавьте сервер и нажмите кнопку **Далее**.
1. (Опционально) Выберите настройки обновления агента и перезапуска удаленного компьютера и нажмите кнопку **Далее**.
1. Проверьте выбранные настройки и нажмите кнопку **Установить**.

## Задайте настройки резервного копирования {#add-target}

1. Откройте панель **Резервное копирование и восстановление** Veritas Backup Exec.
1. Выберите добавленный ранее сервер.
1. В выпадающем списке **Резервное копирование** выберите **Резервное копирование в облако**.
1. Проверьте и, при необходимости, измените настройки резервного копирования.

   В качестве хранилища выберите созданное ранее облачное устройство.
1. Нажмите кнопку **OK**.

## Протестируйте резервное копирование {#test-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится бакет с резервными копиями.
  1. Перейдите в сервис **{{ objstorage-short-name }}**.
  1. Откройте бакет с резервными копиями и убедитесь, что все нужные файлы были скопированы.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../operations/objects/delete-all.md) [объекты](../concepts/object.md) в [бакете](../concepts/bucket.md).
1. [Удалите](../operations/buckets/delete.md) бакет.