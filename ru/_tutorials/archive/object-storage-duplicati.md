# Резервное копирование в {{ objstorage-full-name }} через Duplicati

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

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования с помощью Duplicati входит:

* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-operations));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-traffic)).

## Создайте бакет {#create-bucket}

Чтобы создать бакет для резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}
 
  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Настройте сервисный аккаунт {#configure-service-account}

Резервное копирование в {{ objstorage-name }} выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

Чтобы настроить сервисный аккаунт:

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `storage.editor`.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статический ключ доступа. Сохраните идентификатор и секретный ключ. После закрытия окна параметры закрытого ключа будут недоступны.

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
1. Выберите **Configure a new backup** и нажмите **Next**.
1. Введите имя плана резервного копирования: `{{ yandex-cloud }}`. Если вы выбрали шифрование резервной копии (`AES-256 encryption` или `GNU Privacy Guard`), введите пароль и подтвердите его. Нажмите **Next**.
1. В поле **Storage Type** выберите `S3 compatible`.
1. В поле **Server** выберите `Custom server URL`. В появившемся поле укажите адрес `{{ s3-storage-host }}/`.
1. В поле **Bucket name** задайте имя вашего бакета.
1. В поле **AWS Access ID** вставьте идентификатор статического ключа доступа.
1. В поле **AWS Access Key** вставьте секретный ключ.
1. Чтобы убедиться, что настройки заданы верно, нажмите **Test connection**. В появившемся окне нажмите **No**.
1. В случае успеха появится окно с надписью **Connection worked!**. После проверки нажмите **Next**.
1. Выберите файлы, которые требуется скопировать с вашего компьютера. Нажмите **Next**.
1. Задайте расписание копирования или отключите опцию **Automatically run backups**, чтобы создавать резервные копии вручную. Нажмите **Next**.
1. Укажите размер томов и задайте настройки продолжительности хранения. Нажмите **Save**.

## Протестируйте резервное копирование {#test-backup}

Чтобы протестировать резервное копирование:

1. В интерфейсе Duplicati нажмите **Home**.
1. В списке планов резервного копирования рядом с планом `{{ yandex-cloud }}` нажмите **Run now**. Дождитесь окончания выполнения операции.
1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите каталог, в котором находится бакет с резервными копиями.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Откройте бакет с резервными копиями и убедитесь, что все нужные файлы были скопированы.

Подробности о восстановлении данных из резервной копии см. в [документации Duplicati](https://duplicati.readthedocs.io/en/latest/03-using-the-graphical-user-interface/#restoring-files-from-a-backup).   

## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
