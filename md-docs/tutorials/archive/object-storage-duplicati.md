# Резервное копирование в {{ objstorage-full-name }} с помощью Duplicati

{{ objstorage-full-name }} можно использовать для резервного копирования и восстановления данных с помощью утилиты [Duplicati](https://www.duplicati.com/).

Чтобы настроить резервное копирование в {{ objstorage-name }} с помощью  Duplicati:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте бакет](#create-bucket).
1. [Настройте сервисный аккаунт](#configure-service-account).
1. [Установите Duplicati](#install-duplicati).
1. [Настройте Duplicati](#configure-duplicati).
1. [Протестируйте резервное копирование](#test-backup).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования с помощью Duplicati входит:

* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-operations));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-traffic)).

## Создайте бакет {#create-bucket}

Чтобы создать бакет для резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}
 
  1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
  1. На странице каталога нажмите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя [бакета](../../storage/concepts/bucket.md) в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
  1. Укажите максимальный размер бакета в ГБ.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Настройте сервисный аккаунт {#configure-service-account}

Резервное копирование в {{ objstorage-name }} выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

Чтобы настроить сервисный аккаунт:

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `storage.editor`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Сохраните идентификатор и секретный ключ. После закрытия окна параметры закрытого ключа будут недоступны.

## Установите Duplicati {#install-duplicati}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Установите](https://dotnet.microsoft.com/en-us/download) Microsoft .NET Framework версии 4.6.2 или выше.
  1. [Установите](https://www.duplicati.com/download) Duplicati.

- Linux/macOS {#linux-macos}

  1. [Установите](https://www.mono-project.com/download/stable/) фреймворк Mono.
  1. [Установите](https://www.duplicati.com/download) Duplicati.

{% endlist %}

## Настройте Duplicati {#configure-duplicati}

Чтобы настроить Duplicati для работы с {{ objstorage-name }}:

1. Запустите Duplicati. Если требуется, установите пароль на свой аккаунт.
1. Нажмите **Add backup**.
1. Выберите **Add a new backup** ![image](../../_assets/plus.svg).
1. На шаге **General** введите имя плана резервного копирования: `{{ yandex-cloud }}`. Если вы выбрали шифрование резервной копии (`AES-256 encryption` или `GNU Privacy Guard`), введите пароль и подтвердите его. Нажмите **Continue**.
1. На шаге **Destination** выберите `S3 Compatible` и нажмите **Choose**:
   1. В поле **Bucket name** укажите имя вашего бакета.
   1. В поле **Folder path** укажите путь внутри бакета (префикс). Если нужно использовать корень бакета, оставьте поле пустым.
   1. В поле **Server** укажите адрес `{{ s3-storage-host }}/`. При возникновении ошибки подключения к бакету попробуйте указать адрес без слеша — `{{ s3-storage-host }}`.
   1. В поле **Access Key ID** вставьте идентификатор статического ключа доступа.
   1. В поле **Secret Access Key** вставьте секретный ключ. Нажмите **Continue**.
1. Чтобы убедиться, что настройки заданы верно, в появившемся окне нажмите **Test now**.
1. В случае успеха откроется следующий шаг **Source Data**. На этом шаге:
   1. В поле **Source Data** выберите файлы, которые требуется скопировать с вашего компьютера.
   1. (Опционально) В поле **Filters** настройте фильтры.
   1. (Опционально) В поле **Exclude** настройте исключения для копирования.
   1. Нажмите **Continue**.
1. На шаге **Schedule** выберите расписание копирования или задайте его, выбрав **Custom** в списке и включив опцию **Automatically run backups**. Чтобы создавать резервные копии вручную, выберите опцию **Don't run automatically**. Нажмите **Continue**.
1. На шаге **Options** укажите размер томов и задайте настройки продолжительности хранения. Нажмите **Submit**.

## Протестируйте резервное копирование {#test-backup}

Чтобы протестировать резервное копирование:

1. В списке планов резервного копирования рядом с планом `{{ yandex-cloud }}` нажмите **Start**. Дождитесь окончания выполнения операции.
1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите каталог, в котором находится бакет с резервными копиями.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Откройте бакет с резервными копиями и убедитесь, что все нужные файлы были скопированы.

Подробности о восстановлении данных из резервной копии см. в [документации Duplicati](https://duplicati.readthedocs.io/en/latest/03-using-the-graphical-user-interface/#restoring-files-from-a-backup).   

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete-all.md) [объекты](../../storage/concepts/object.md) в [бакете](../../storage/concepts/bucket.md).
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.