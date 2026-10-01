[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Инструменты](index.md) > Файловые браузеры > Obsidian

# Remotely Save

[Remotely Save](https://github.com/remotely-save/remotely-save) — плагин для [Obsidian](https://obsidian.md/), который синхронизирует хранилище заметок с облачными хранилищами, совместимыми с [Amazon S3 API](../../glossary/s3.md), в том числе с Object Storage.

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

1. В Obsidian откройте **Settings** → **Community plugins**.
1. Отключите **Restricted mode**, если он включен.
1. Нажмите **Browse** и в строке поиска введите `Remotely Save`.
1. Выберите плагин **Remotely Save**, для установки нажмите **Install**.
1. Чтобы включить плагин после установки, нажмите **Enable**.

## Настройка {#configuration}

1. В Obsidian откройте **Settings** → **Remotely Save**.
1. В поле **Choose a remote service** выберите **S3 or compatible**.
1. Укажите параметры подключения:
    * **Endpoint** — `https://storage.yandexcloud.net`;
    * **Region** — `ru-central1`;
    * **Access Key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin);
    * **Secret Access Key** — содержимое статического ключа, [полученное ранее](#before-you-begin);
    * **Bucket Name** — имя бакета, [созданного ранее](#before-you-begin).
1. Нажмите **Check** для проверки подключения.
1. Закройте окно настроек, данные сохранятся автоматически.
1. Перезагрузите Obsidian.

## Синхронизация {#sync}

Для запуска синхронизации нажмите на иконку плагина на боковой панели Obsidian или воспользуйтесь командой `Remotely Save: start sync` через палитру команд (`Ctrl+P` / `Cmd+P`).

После синхронизации файлы из Obsidian появятся в бакете как объекты с ключами вида `folder/subfolder/note.md`.

Подробнее о работе плагина читайте в [документации Remotely Save](https://github.com/remotely-save/remotely-save).