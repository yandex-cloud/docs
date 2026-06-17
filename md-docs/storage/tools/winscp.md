# WinSCP

[WinSCP](https://winscp.net/eng/docs/lang:ru) — это графический клиент для работы с облачными хранилищами, в том числе совместимыми с [Amazon S3 API](../../glossary/s3.md), на Windows.

{% note info %}

Для работы с Object Storage используйте версию не ниже 5.14.

{% endnote %}

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

[Скачайте](https://winscp.net/eng/download.php) дистрибутив WinSCP и запустите его.

## Подключение {#connection}

1. Запустите WinSCP.
1. На вкладке **Sessions** выберите **New Session...**.
1. В блоке **Sessions** укажите следующие параметры:
    * **File protocol** — **Amazon S3**;
    * **Host name** — `storage.yandexcloud.net`;
    * **Port number** — `443`;
    * **Access key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin);
    * **Secret access key** — содержимое статического ключа, [полученное ранее](#before-you-begin).

   Чтобы подключиться к определенному бакету, нажмите кнопку **Advanced...**. В окне **Advanced Site Settings** в меню слева в блоке **Environment** выберите **Directories**. В поле **Remote directory:** укажите имя бакета и нажмите **OK**.
1. Нажмите кнопку **Login**.

После подключения на панели справа появится бакет, созданный ранее.

{% note info %}

WinSCP работает с Object Storage как с иерархической файловой системой. Это значит, что ключи объектов, загруженных через WinSCP, будут иметь вид пути к файлу, например `prefix/subprefix/picture.jpg`.

{% endnote %}

Подробности о работе WinSCP с S3-совместимыми хранилищами см. в [документации WinSCP](https://winscp.net/eng/docs/guide_amazon_s3#buckets).