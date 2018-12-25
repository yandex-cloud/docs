# Резервное копирование в [!KEYREF objstorage-full-name] через Duplicati

Чтобы настроить резервное копирование в [!KEYREF objstorage-name] через CloudBerry Desktop Backup:
1. [Создайте публичную корзину](#create-public-bucket)
1. [Создайте сервисный аккаунт](#create-service-account)
1. [Создайте статический ключ доступа](#create-access-key)
1. [Установите Duplicati](#install-duplicati)
1. [Настройте Duplicati](#configure-duplicati)
1. [Протестируйте резервное копирование](#test-backup)

Бесплатная версия Duplicati позволяет создать не более 200 ГБ резервных копий.

## 1. Создайте публичную корзину {#create-public-bucket}

Чтобы создать корзину для резервного копирования:

[!INCLUDE [create-public-bucket](../_solutions_includes/create-public-bucket.md)]

## 2. Создайте сервисный аккаунт {#create-service-account}

Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `Editor`.
 
## 3. Создайте статический ключ доступа {#create-access-key}

Создайте [статические ключи доступа](../../iam/operations/sa/create-access-key.md). Сразу сохраните идентификатор и секретный ключ. После закрытия окна создания значения закрытого ключа будет недоступно. 

## 4. Установите Duplicati {#install-duplicati}

---

**[!TAB Windows/Linux]**

[Скачайте](https://www.duplicati.com/download) и установите Duplicati. 

**[!TAB macOS]**

Для работы Duplicati на macOS требуется [фреймворк Mono](https://www.mono-project.com/download/stable/#download-mac).

После установки Mono [скачайте](https://www.duplicati.com/download) и установите Duplicati. 

---

## 5. Настройте Duplicati {#configure-duplicati}

Чтобы настроить Duplicati для работы с [!KEYREF objstorage-name]:

1. Запустите Duplicati. Если требуется, установите пароль на свой аккаунт.
1. Выберите пункт меню **Add backup**.
1. Выберите пункт **Configure a new backup**. Нажмите кнопку **Next**.
1. Введите имя плана резервного копирования: `Yandex Cloud`. Введите пароль и подтверждение, если вы выбрали шифрование резервной копии. Нажмите кнопку **Next**.
1. В поле **Storage Type** укажите `S3 compatible`.
1. В списке **Server** укажите `Custom server URL`. В поле ниже укажите адрес `storage.yandexcloud.net/`.
1. В поле **Bucket name** укажите имя вашей публичной корзины — `backup`.
1. В поле **AWS Access ID** укажите идентификатор статического ключа доступа.
1. В поле **AWS Access Key** укажите секретный ключ.
1. Нажмите кнопку **Test connection**, чтобы убедиться, что настройки заданы верно. Появится окно с предложением добавить имя пользователя к имени корзины, нажмите кнопку **No**. 
1. После проверки нажмите кнопку **Next**.
1. Выберите файлы, которые требуется скопировать.
1. Нажмите кнопку **Next**.
1. Задайте расписание копирования или снимите флаг **Automatically run backups**, чтобы создавать резервные копии вручную. Нажмите кнопку **Next**.
1. Укажите размер томов и задайте настройки продолжительности хранения. Нажмите кнопку **Save**.

## 6. Протестируйте резервное копирование {#test-backup}

Чтобы протестировать резервное копирование:

1. Откройте пункт меню **Home**.
1. В списке планов резервного копирования рядом с планом `Yandex Cloud` нажмите ссылку **Run now**.
1. Откройте [консоль управления](https://console.cloud.yandex.ru).
1. Перейдите в каталог, где находится корзина, в которую помещаются резервные копии.
1. Откройте сервис **Object Storage**.
1. Откройте корзину `backup` и убедитесь, что все нужные файлы были скопированы.
