# CyberDuck

[CyberDuck](https://cyberduck.io/) — это графический клиент для работы с облачными хранилищами, в том числе совместимыми с [Amazon S3 API](../../glossary/s3.md). CyberDuck доступен для macOS и Windows, а также в виде [консольного клиента](https://duck.sh/) для Linux.

## Подготовка к работе {#before-you-begin}

1. [Создайте](../operations/buckets/create.md) бакет.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) нужную роль сервисному аккаунту, например `storage.editor`. Подробнее о ролях читайте в разделе [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).

       
   Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
   
   * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
   * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
   * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
   
   Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).


   {% note tip %}

   Назначить роль сервисному аккаунту можно на каталог или на бакет. Если роль выдана на каталог, то у графического клиента будет доступ ко всем бакетам в каталоге. Если роль выдана на бакет, то доступ будет только к этому бакету. Для обеспечения гранулярного доступа, назначайте сервисному аккаунту роль на конкретный бакет.

   {% endnote %}

1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

        
    В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:
    
    * `key_id` — идентификатор статического ключа доступа;
    * `secret` — секретный ключ.
    
    Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Установка {#installation}

[Скачайте](https://cyberduck.io/download/) дистрибутив CyberDuck для вашей операционной системы и запустите его.

## Подключение {#connection}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. Запустите CyberDuck.
  1. Нажмите кнопку **Open Connection**.
  1. Выберите тип подключения — **Amazon S3**.
  1. Укажите параметры подключения:
      * **Server** — `storage.yandexcloud.net`.

        Чтобы подключиться к определенному бакету, откройте вкладку **More options** и в поле **Path** укажите имя вашего бакета.
      * **Port** — `443`.
      * **Access Key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin).
      * **Secret Access Key** — содержимое статического ключа, [полученное ранее](#before-you-begin).
  1. Нажмите кнопку **Connect**.

- macOS {#macos}

  1. Запустите CyberDuck.
  1. Нажмите кнопку **Open Connection**.
  1. Выберите тип подключения — **Amazon S3**.
  1. Укажите параметры подключения:
      * **Server** — `storage.yandexcloud.net`.

        Чтобы подключиться к определенному бакету, в поле **Server** укажите `<имя_бакета>.storage.yandexcloud.net`. Таким образом можно подключится только к бакету, в имени которого не содержится точка. Для бакетов с точкой в имени воспользуйтесь [альтернативной инструкцией](#alternative-connection).
      * **Port** — `443`.
      * **Access Key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin).
      * **Secret Access Key** — содержимое статического ключа, [полученное ранее](#before-you-begin).
  1. Нажмите кнопку **Connect**.

  Чтобы подключиться к бакету, в имени которого содержится точка, например `example.com`: {#alternative-connection}
  1. Загрузите конфигурацонный файл [Deprecated path style requests](https://profiles.cyberduck.io/S3%20(Deprecated%20path%20style%20requests).cyberduckprofile) (Подробнее см. в [документации Cyberduck](https://docs.cyberduck.io/protocols/s3/#connecting-using-deprecated-path-style-requests)).
      
      Некоторые браузеры автоматически открывают конфигурационный файл в новой вкладке. Чтобы загрузить конфигурационный файл, нажмите на ссылку для загрузки правой кнопкой, выберите **Загрузить файл по ссылке как...** (**Download Linked File As...**) и нажмите **Сохранить** (**Save**).
  1. Откройте конфигурационный файл.
  1. Укажите параметры подключения, аналогично стандартному способу.
  1. Раскройте блок **More Options** и в поле **Path** укажите имя вашего бакета.
  1. Закройте окно с параметрами.
  1. Двойным нажатием откройте созданное подключение.

{% endlist %}


После подключения откроется бакет, созданный ранее.

{% note info %}

CyberDuck работает с Object Storage как с иерархической файловой системой. Это значит, что ключи объектов, загруженных через CyberDuck, будут иметь вид пути к файлу, например `prefix/subprefix/picture.jpg`.

{% endnote %}

Подробности о работе CyberDuck с S3-совместимыми хранилищами см. в [документации CyberDuck](https://docs.cyberduck.io/protocols/s3/).