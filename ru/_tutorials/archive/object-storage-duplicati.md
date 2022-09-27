# Резервное копирование в {{ objstorage-full-name }} через Duplicati

Чтобы настроить резервное копирование в {{ objstorage-name }} через Duplicati:

1. [Подготовьте облако к работе](#before-you-begin)
1. [Создайте бакет](#create-bucket)
1. [Создайте сервисный аккаунт](#create-service-account)
1. [Создайте статический ключ доступа](#create-access-key)
1. [Установите Duplicati](#install-duplicati)
1. [Настройте Duplicati](#configure-duplicati)
1. [Протестируйте резервное копирование](#test-backup)
1. [Удалите созданные облачные ресурсы](#clear-out)

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования и восстановления входит:

* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-operations));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing#prices-storage.md#prices-traffic)).


## Создайте бакет {#create-bucket}

Чтобы создать бакет для резервного копирования:

{% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

## Создайте сервисный аккаунт {#create-service-account}

Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `editor`.

## Создайте статический ключ доступа {#create-access-key}

Создайте [статические ключи доступа](../../iam/operations/sa/create-access-key.md). Сразу сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры закрытого ключа будут недоступны.

## Установите Duplicati {#install-duplicati}

{% list tabs %}

- Windows/Linux

  [Скачайте](https://www.duplicati.com/download) и установите Duplicati.

- macOS

  Для работы Duplicati на macOS требуется [фреймворк Mono](https://www.mono-project.com/download/stable/#download-mac).

  После установки Mono [скачайте](https://www.duplicati.com/download) и установите Duplicati.

{% endlist %}

## Настройте Duplicati {#configure-duplicati}

Чтобы настроить Duplicati для работы с {{ objstorage-name }}:

1. Запустите Duplicati. Если требуется, установите пароль на свой аккаунт.
1. Выберите пункт меню **Add backup**.
1. Выберите пункт **Configure a new backup**. Нажмите кнопку **Next**.
1. Введите имя плана резервного копирования: `{{ yandex-cloud }}`. Введите пароль и подтверждение, если вы выбрали шифрование резервной копии. Нажмите кнопку **Next**.
1. В поле **Storage Type** укажите `S3 compatible`.
1. В списке **Server** укажите `Custom server URL`. В поле ниже укажите адрес `storage.yandexcloud.net/`.
1. В поле **Bucket name** укажите имя вашего бакета — `backup`.
1. В поле **AWS Access ID** укажите идентификатор статического ключа доступа.
1. В поле **AWS Access Key** укажите секретный ключ.
1. Нажмите кнопку **Test connection**, чтобы убедиться, что настройки заданы верно. Появится окно с предложением добавить имя пользователя к имени бакета, нажмите кнопку **No**.
1. После проверки нажмите кнопку **Next**.
1. Выберите файлы, которые требуется скопировать.
1. Нажмите кнопку **Next**.
1. Задайте расписание копирования или снимите флаг **Automatically run backups**, чтобы создавать резервные копии вручную. Нажмите кнопку **Next**.
1. Укажите размер томов и задайте настройки продолжительности хранения. Нажмите кнопку **Save**.

## Протестируйте резервное копирование {#test-backup}

Чтобы протестировать резервное копирование:

1. Откройте пункт меню **Home**.
1. В списке планов резервного копирования рядом с планом `{{ yandex-cloud }}` нажмите ссылку **Run now**.
1. Откройте [консоль управления]({{ link-console-main }}).
1. Перейдите в каталог, где находится бакет, в который помещаются резервные копии.
1. Выберите сервис **{{ objstorage-short-name }}**.
1. Откройте бакет `backup` и убедитесь, что все нужные файлы были скопированы.

## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}