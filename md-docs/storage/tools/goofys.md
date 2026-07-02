[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Инструменты](index.md) > FUSE > goofys

# goofys

[goofys](https://github.com/kahing/goofys) — программа для Linux и macOS, позволяющая монтировать бакеты Object Storage через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

## Подготовка к работе {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях смотрите на странице [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).

          
    Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
    
    * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
    * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
    * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
    
    Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).


1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    
    В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:
    
    * `key_id` — идентификатор статического ключа доступа;
    * `secret` — секретный ключ.
    
    Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.



Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [Поддерживаемые инструменты](index.md).
  
{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).

{% endnote %}


Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее смотрите [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Установка {#installation}

Для установки `goofys` воспользуйтесь [инструкцией](https://github.com/kahing/goofys#installation) в репозитории проекта.

## Настройка {#setup}

`goofys` использует секретный ключ из настроек [AWS CLI](aws-cli.md), хранящихся в файле `.aws/credentials`. Также можно поместить данные ключа, [полученные ранее](#before-you-begin), в переменные окружения `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY`.

## Монтирование бакета {#bucket-mounting}

1. Выберите каталог, в который вы будете монтировать бакет, и убедитесь, что у вас достаточно прав для операции монтирования.
1. Для разового монтирования бакета выполните команду вида:

    ```
    goofys --endpoint=https://storage.yandexcloud.net <имя_бакета> <точка_монтирования>
    ```

Чтобы настроить монтирование бакета при запуске системы, добавьте в файл `/etc/fstab` строку вида:

```
goofys#<имя_бакета>  <точка_монтирования>  fuse  _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--endpoint=https://storage.yandexcloud.net  0  0
```