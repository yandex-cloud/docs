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

{% list tabs %}

- Консоль управления
 
  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Настройте сервисный аккаунт {#configure-service-account}

Резервное копирование в {{ objstorage-name }} выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

Чтобы настроить сервисный аккаунт:

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `editor`.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статические ключи доступа. Сразу сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры закрытого ключа будут недоступны.

## Установите Duplicati {#install-duplicati}

{% list tabs %}

- Windows

  1. [Установите](https://dotnet.microsoft.com/en-us/download) Microsoft .NET Framework версии 4.6.2 или выше.
  1. [Установите](https://www.duplicati.com/download) Duplicati.

- Linux/macOS

  1. [Установите](https://www.mono-project.com/download/stable/) фреймворк Mono.
  1. [Установите](https://www.duplicati.com/download) Duplicati.

{% endlist %}

## Настройте Duplicati {#configure-duplicati}

Чтобы настроить Duplicati для работы с {{ objstorage-name }}:

1. Запустите Duplicati. Если требуется, установите пароль на свой аккаунт.
1. Нажмите кнопку **Add backup**.
1. Выберите пункт **Configure a new backup** и нажмите кнопку **Next**.
1. Введите имя плана резервного копирования: `{{ yandex-cloud }}`. Если вы выбрали шифрование резервной копии (`AES-256 encryption`), введите пароль и подтвердите его. Нажмите кнопку **Next**.
1. В списке **Storage Type** выберите `S3 compatible`.
1. В списке **Server** задайте `Custom server URL`. В поле ниже укажите адрес `{{ s3-storage-host }}/`.
1. В поле **Bucket name** задайте имя вашего бакета — `backup`.
1. В поле **AWS Access ID** введите идентификатор статического ключа доступа.
1. В поле **AWS Access Key** задайте секретный ключ.
1. Чтобы убедиться, что настройки заданы верно, нажмите кнопку **Test connection**. В появившемся окне нажмите кнопку **No**.
1. После проверки нажмите кнопку **Next**.
1. Выберите файлы, которые требуется скопировать.
1. Нажмите кнопку **Next**.
1. Задайте расписание копирования или отключите опцию **Automatically run backups**, чтобы создавать резервные копии вручную. Нажмите кнопку **Next**.
1. Укажите размер томов и задайте настройки продолжительности хранения. Нажмите кнопку **Save**.

## Протестируйте резервное копирование {#test-backup}

Чтобы протестировать резервное копирование:

1. В интерфейсе Duplicati нажмите кнопку **Home**.
1. В списке планов резервного копирования рядом с планом `{{ yandex-cloud }}` нажмите кнопку **Run now**.
1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
1. Перейдите в каталог, где находится бакет с резервными копиями.
1. Выберите сервис **{{ objstorage-short-name }}**.
1. Откройте бакет с резервными копиями и убедитесь, что все нужные файлы были скопированы.

Подробности о восстановлении данных из резервной копии см. в [документации Duplicati](https://duplicati.readthedocs.io/en/latest/03-using-the-graphical-user-interface/#restoring-files-from-a-backup).   

## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
