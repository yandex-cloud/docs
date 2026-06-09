# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) — программа для Linux и macOS, позволяющая монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

{% note info %}

Рекомендуется использовать s3fs версии не ниже 1.84.

{% endnote %}

Если у вас возникнут вопросы, обратитесь к [официальной документации](https://github.com/s3fs-fuse/s3fs-fuse/wiki) проекта, в частности к разделу [FAQ](https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ), который содержит решения для многих проблем, возникающих при использовании s3fs.

Производительность s3fs зависит от производительности локального диска. Используйте высокопроизводительные диски, особенно если вы храните много маленьких (сотни килобайт и меньше) файлов. Производительность s3fs можно увеличить, включив кеширование (параметр `--use_cache <directory>`). Кеш s3fs растет неограниченно, и вам необходимо позаботиться о его регулярной очистке. Подробности читайте в [документации s3fs](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon#details).

## Подготовка к работе {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях см. на странице [Управление доступом с помощью {{ iam-full-name }}](../security/index.md).

          
    Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
    
    * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
    * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
    * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
    
    Подробнее см. [Сервисные роли {{ kms-name }}](../../kms/security/index.md#service-roles).


1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    
    В результате вы получите данные статического ключа доступа. Для аутентификации в {{ objstorage-name }} вам понадобятся:
    
    * `key_id` — идентификатор статического ключа доступа;
    * `secret` — секретный ключ.
    
    Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.



Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [{#T}](index.md).
  
{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).

{% endnote %}


Статический ключ для доступа к {{ objstorage-name }} можно безопасно хранить в сервисе {{ lockbox-full-name }}. Подробнее см. [{#T}](../tutorials/static-key-in-lockbox/index.md).

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Установка {#installation}

{% list tabs group=operating_system %}

- Ubuntu/Debian {#ubuntu}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     apt list --installed | grep fuse
     ```

     {% note warning %}
     
     Во многих дистрибутивах Linux утилиты для работы с FUSE уже установлены по умолчанию. Их переустановка или удаление могут привести к нарушению работы операционной системы.
     
     {% endnote %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo apt-get install fuse
     ```
  
  1. Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

- CentOS/Fedora/Red Hat {#centos}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     dnf list installed | grep fuse
     ```

     {% note warning %}
     
     Во многих дистрибутивах Linux утилиты для работы с FUSE уже установлены по умолчанию. Их переустановка или удаление могут привести к нарушению работы операционной системы.
     
     {% endnote %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo dnf install fuse
     ```
  
  1. Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

- macOS {#macos}

  1. Установите пакет [macFUSE](https://osxfuse.github.io/).
  1. [Включите](https://github.com/macfuse/macfuse/wiki/Getting-Started#enabling-support-for-third-party-kernel-extensions-apple-silicon-macs) поддержку сторонних расширений ядра. Этот шаг необходим только при первом использовании MacFUSE на Apple Silicon Mac.
  1. [Разрешите](https://github.com/macfuse/macfuse/wiki/Getting-Started#allow-the-macfuse-kernel-extension-to-load-apple-silicon-and-intel-macs) загрузку расширения ядра MacFUSE (Apple Silicon и Intel Mac).

      Подробнее об установке macFUSE см. в [инструкции по установке](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) в репозитории macFUSE на GitHub.
  
  1. Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

   {% endlist %}

## Настройка {#setup}

Для настройки s3fs сохраните идентификатор ключа и секретный ключ, [полученные ранее](#before-you-begin), в файле `~/.passwd-s3fs` в формате `<идентификатор_ключа>:<секретный_ключ>`, а также ограничьте доступ к файлу `~/.passwd-s3fs` следующим образом:

```bash
echo <идентификатор_ключа>:<секретный_ключ> > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

## Монтирование бакета {#mounting-bucket}

1. Выберите папку, в которую вы будете монтировать бакет, и убедитесь, что у вас достаточно прав для операции монтирования.
1. Выполните команду:

    ```bash
    s3fs <имя_бакета> /mount/<путь_к_папке> -o passwd_file=$HOME/.passwd-s3fs \
        -o url=https://{{ s3-storage-host }} -o use_path_request_style
    ```

   Чтобы выдать доступ к этой папке другим пользователям компьютера, укажите опцию `-o allow_other`.
   
   Чтобы задать права доступа к папке, в которую будет смонтирован бакет, при монтировании укажите опцию `-o mp_umask=<нужные_права>`.

Можно настроить монтирование бакета при запуске системы, для этого добавьте в файл `/etc/fstab` строку вида:

```bash
s3fs#<имя_бакета> /mount/<путь_к_папке> fuse _netdev,allow_other,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/<имя_пользователя>/.passwd-s3fs 0 0
```

Описание всех параметров s3fs смотрите в [вики проекта](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) на GitHub.