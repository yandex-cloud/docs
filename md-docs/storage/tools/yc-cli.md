# Интерфейс командной строки Yandex Cloud (CLI)

[Yandex Cloud CLI](../../cli/index.md) — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.

## Установите Yandex Cloud CLI {#install}

{% list tabs group=operating_system %}

- Linux {#linux}

    1. Выполните команду:

        ```bash
        curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ```

        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
        
        {% note info %}
        
        Скрипт дополнит переменную `PATH` только если его запустить в командных оболочках `bash` или `zsh`.
        
        Если вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную `PATH` самостоятельно.
        
        {% endnote %}

        {% note warning %}

        Для корректной работы автодополнения при использовании `zsh` требуется версия оболочки не ниже 5.1, а при использовании `bash` на CentOS и производных дистрибутивах необходимо установить пакет `bash-completion`.

        {% endnote %}
        
    1. После завершения установки перезапустите командную оболочку.

- macOS {#macos}

    1. Выполните команду:

        ```bash
        curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ```

        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
    1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

    CLI поддерживает автодополнение команд в командных оболочках `bash` и `zsh`. Чтобы включить автодополнение:
    
    1. Установите менеджер пакетов [Homebrew](https://brew.sh).
    1. Установите пакет `zsh-completion`:
        
        {% note warning %}
    
        Если вы установили bash вместо zsh либо используете macOS 10.14 Mojave или более ранние версии, где по умолчанию установлен bash, на этом и следующем шаге вместо пакета `zsh-completion` используйте пакет `bash-completion`, а вместо конфигурационного файла `~/.zshrc` — `~/.bash_profile`.

        {% endnote %}

        ```
        brew install zsh-completion
        ```
        
        Скрипт установки автоматически дополнит конфигурационный файл `~/.zshrc`:
        
        ```
        # The next line updates PATH for Yandex Cloud CLI.
        if [ -f '/Users/<username>/yandex-cloud/path.bash.inc' ]; then source '/Users/<username>/yandex-cloud/path.bash.inc'; fi
        # The next line enables shell command completion for yc.
        if [ -f '/Users/<username>/yandex-cloud/completion.zsh.inc' ]; then source '/Users/<username>/yandex-cloud/completion.zsh.inc'; fi
        ```

    1. После завершения установки добавьте в конфигурационный файл `~/.zshrc` следующие строки. Расположите их выше строк, автоматически добавленных скриптом установки.
    
        ```
        if [ -f $(brew --prefix)/etc/zsh_completion ]; then
        . $(brew --prefix)/etc/zsh_completion
        fi
        ```
    1. Перезапустите командную оболочку.

- Windows {#windows}

    Для Windows CLI можно установить с помощью PowerShell или командной строки:

    - Для установки с помощью PowerShell:

        1. Выполните команду:


            
            
            ```bash
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1')
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```
            Add yc installation dir to your PATH? [Y/n]
            ```        
        1. Введите `Y`. После этого Yandex Cloud CLI можно пользоваться, командную оболочку перезапускать не нужно.

    - Для установки с помощью командной строки:

        1. Выполните команду:


            
            
            ```bash
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```
            Add yc installation dir to your PATH? [Y/n]
            ```
        1. Введите `Y`.
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

{% endlist %}

Если в процессе установки CLI возникла ошибка, смотрите раздел [Решение проблем CLI](../../cli/error.md#failure-writing-output-to-destination).

## Аутентифицируйтесь в Yandex Cloud CLI {#cli-auth}

Для доступа к Yandex Cloud CLI выполните аутентификацию, выбрав один из следующих методов:

{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}

  Чтобы аутентифицироваться с помощью [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport):
  
  1. Получите адрес электронной почты:
    
     1. Перейдите в ваш аккаунт на [Яндексе](https://id.yandex.ru/personal).
     1. В блоке **Контакты** скопируйте адрес электронной почты.
  
  1. Запустите интерактивное создание профиля:
    
          
      ```bash
      yc init --username=<электронная_почта>
      ```
  
  
  
  1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.
  
     ```text
     Welcome! This command will take you through the configuration process.
     Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
     ```
  
  1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.
  
     ```text
     You are going to be authenticated via username '<электронная_почта>'.
     Authentication web site will be opened.
     After your successful authentication, you will be redirected to 'https://console.yandex.cloud'.
  
     Press 'enter' to continue...
     ```
  
     После успешной аутентификации в профиле сохранится [IAM-токен](../../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
     
     Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных [облаков](../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:
  
     ```text
        Please select cloud to use:
         [1] cloud1 (id = aoe2bmdcvata********)
         [2] cloud2 (id = dcvatao4faoe********)
        Please enter your numeric choice: 2
        ```
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
  
     ```text
        Please choose a folder to use:
         [1] folder1 (id = cvatao4faoe2********)
         [2] folder2 (id = tao4faoe2cva********)
         [3] Create a new folder
        Please enter your numeric choice: 1
        ```
  
  1. Чтобы выбрать [зону доступности](../../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.
  
     ```bash
     Do you want to configure a default Yandex Compute Cloud availability zone? [Y/n] Y
     ```
  
     Если вы ввели `Y`, выберите зону доступности:
  
     
     ```text
     Which zone do you want to use as a profile default?
      [1] ru-central1-a
      [2] ru-central1-b
      [3] ru-central1-d
      [4] Do not set default zone
     Please enter your numeric choice: 2
     ```
  
  
  
  1. Проверьте настройки вашего профиля CLI:
  
     ```bash
     yc config list
     ```
  
     Результат:
  
     
     ```bash
     subject-id: b1g159pa15cd********
     username: <электронная_почта>
     folder-id: b1g8o9jbt58********
     compute-default-zone: ru-central1-b
     ```

- Федеративный аккаунт {#federated-account}

  Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../../organization/concepts/add-federation.md):
  
  1. Узнайте идентификатор федерации у вашего администратора.
  1. Запустите интерактивное создание профиля:
  
        
     ```bash
     yc init --federation-id=<идентификатор_федерации>
     ```
  
  
  
  1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.
  
     ```text
     Welcome! This command will take you through the configuration process.
     Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
     ```
  
  1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.
  
     ```text
     You are going to be authenticated via federation-id 'aje1f0hsgds3a********'.
     Your federation authentication web site will be opened.
     After your successful authentication, you will be redirected to 'https://console.yandex.cloud'.
  
     Press 'enter' to continue...
     ```
  
     После успешной аутентификации в профиле сохранится [IAM-токен](../../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
     
     Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных [облаков](../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:
  
     ```text
        Please select cloud to use:
         [1] cloud1 (id = aoe2bmdcvata********)
         [2] cloud2 (id = dcvatao4faoe********)
        Please enter your numeric choice: 2
        ```
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
  
     ```text
        Please choose a folder to use:
         [1] folder1 (id = cvatao4faoe2********)
         [2] folder2 (id = tao4faoe2cva********)
         [3] Create a new folder
        Please enter your numeric choice: 1
        ```
  
  1. Чтобы выбрать [зону доступности](../../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.
  
     ```bash
     Do you want to configure a default Yandex Compute Cloud availability zone? [Y/n] Y
     ```
  
     Если вы ввели `Y`, выберите зону доступности:
  
     
     ```text
     Which zone do you want to use as a profile default?
      [1] ru-central1-a
      [2] ru-central1-b
      [3] ru-central1-d
      [4] Do not set default zone
     Please enter your numeric choice: 2
     ```
  
  
  
  1. Проверьте настройки вашего профиля CLI:
  
     ```bash
     yc config list
     ```
  
     Результат:
  
     
     ```bash
     federation-id: aje1f0hs6oja********
     subject-id: ajea53egl28l********
     cloud-id: b1g159pa15cd********
     folder-id: b1g8o9jbt58********
     compute-default-zone: ru-central1-b
     ```

- Сервисный аккаунт {#service-account}

  Чтобы аутентифицироваться от имени сервисного аккаунта:
  
  1. Получите список сервисных аккаунтов, которые существуют в вашем облаке:
     
     ```bash
     yc iam service-account --folder-id <идентификатор_каталога> list
     ```
     
     Результат:
     ```text
     +----------------------+------------+--------+---------------------+-----------------------+
     |          ID          |    NAME    | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
     +----------------------+------------+--------+---------------------+-----------------------+
     | ajeg2b2et02f******** | my-robot   |        | 2024-09-08 18:59:45 | 2025-08-21 06:40:00   |
     | ajegtlf2q28a******** | default-sa |        | 2023-06-27 16:18:18 | 2025-08-21 06:30:00   |
     +----------------------+------------+--------+---------------------+-----------------------+
     ```
  1. Создайте авторизованный ключ для сервисного аккаунта и сохраните его в файл `key.json`:
  
      ```bash
      yc iam key create \
        --service-account-name default-sa \
        --output key.json \
        --folder-id <идентификатор_каталога>
      ```
      
      Результат:
      ```text
      id: aje83v701b1u********
      service_account_id: aje3932acd0c********
      created_at: "2019-08-26T12:31:25Z"
      key_algorithm: RSA_2048
      ```
  
  1. Добавьте авторизованный ключ сервисного аккаунта в профиль CLI.
  
      1. Создайте новый профиль CLI:
  
          ```bash
          yc config profile create sa-profile
          ```
      1. Добавьте авторизованный ключ:
  
          ```bash
          yc config set service-account-key key.json
          ```
  
  1. Убедитесь, что параметры для сервисного аккаунта добавлены верно:
  
      ```bash
      yc config list
      ```
      
      Результат:
  
      ```text
      service-account-key:
        id: aje83v701b1u********
        service_account_id: aje3932acd0c********
        created_at: "2019-08-26T12:31:25Z"
        key_algorithm: RSA_2048
        public_key: |
          -----BEGIN PUBLIC KEY-----
          MIIBIjANBg...
          -----END PUBLIC KEY-----
        private_key: |
          -----BEGIN PRIVATE KEY-----
          MIIEvwIBAD...
          -----END PRIVATE KEY-----
      ```
  
  1. Настройте профиль для запуска команд.
  
      Для некоторых команд требуется указание уникального идентификатора облака и каталога. Вы можете указать информацию о них в профиле или запускать такие команды с соответствующим флагом.
      
      1. Укажите облако в профиле:
      
          ```bash
          yc config set cloud-id <идентификатор_облака>
          ```
      
          Или [запускайте команды](../../cli/concepts/index.md#manage-properties) с параметром `--cloud-id`.
      1. Укажите каталог в профиле:
      
          ```bash
          yc config set folder-id <идентификатор_каталога>
          ```
      
          Или [запускайте команды](../../cli/concepts/index.md#manage-properties) с параметром `--folder-id`.
      
      Все операции в этом профиле будут выполняться от имени привязанного сервисного аккаунта. Вы можете [изменить параметры профиля](../../cli/operations/profile/manage-properties.md) или [сменить его](../../cli/operations/profile/profile-activate.md).

- Аккаунт локального пользователя {#local-account}

  Чтобы аутентифицироваться с помощью [аккаунта локального пользователя](../../iam/concepts/users/accounts.md#local):
  
  1. Запустите интерактивное создание профиля:
  
     {% list tabs %}
  
     - Пул пользователей
     
       1. Узнайте идентификатор пула пользователей у вашего администратора.
       1. Запустите интерактивное создание профиля:
  
                    
           ```bash
           yc init --userpool-id=<идентификатор_пула_пользователей>
           ```
  
  
  
     - Электронная почта
  
        1. Получите адрес электронной почты:
           1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
           1. На панели слева выберите ![alt](../../_assets/console-icons/passport.svg) **Профиль**.
           1. В блоке **Контакты** скопируйте адрес электронной почты.
        1. Запустите интерактивное создание профиля:
  
                    
           ```bash
           yc init --username=<электронная_почта>
           ```
  
  
  
     {% endlist %}
  
  1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.
  
     ```text
     Welcome! This command will take you through the configuration process.
     Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
     ```
  
  1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.
  
     ```text
     You are going to be authenticated via userpool-id 'ek0auknfc0mh********'.
     Your userpool authentication web site will be opened.
     After your successful authentication, you will be redirected to cloud console.
  
     Press 'enter' to continue...
     ```
  
     После успешной аутентификации в профиле сохранится [IAM-токен](../../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
     
     Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных [облаков](../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:
  
     ```text
        Please select cloud to use:
         [1] cloud1 (id = aoe2bmdcvata********)
         [2] cloud2 (id = dcvatao4faoe********)
        Please enter your numeric choice: 2
        ```
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
  
     ```text
        Please choose a folder to use:
         [1] folder1 (id = cvatao4faoe2********)
         [2] folder2 (id = tao4faoe2cva********)
         [3] Create a new folder
        Please enter your numeric choice: 1
        ```
  
  1. Чтобы выбрать [зону доступности](../../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.
  
     ```bash
     Do you want to configure a default Yandex Compute Cloud availability zone? [Y/n] Y
     ```
  
     Если вы ввели `Y`, выберите зону доступности:
  
     
     ```text
     Which zone do you want to use as a profile default?
      [1] ru-central1-a
      [2] ru-central1-b
      [3] ru-central1-d
      [4] Do not set default zone
     Please enter your numeric choice: 2
     ```
  
  
  
  1. Проверьте настройки вашего профиля CLI:
  
     ```bash
     yc config list
     ```
  
     Результат:
     
     {% list tabs %}
  
     - Пул пользователей
     
        
        ```bash
        userpool-id: ek0auknfc0mh********
        subject-id: ek00cd1m8hdd8********
        cloud-id: b1g159pa15cd********
        folder-id: b1g8o9jbt58********
        compute-default-zone: ru-central1-b
        ```
  
  
  
     - Электронная почта
        
        ```bash
        subject-id: b1g159pa15cd********
        username: <электронная_почта>
        folder-id: b1g8o9jbt58********
        compute-default-zone: ru-central1-b
        ```
  
  
  
     {% endlist %}

{% endlist %}

## Проверьте работу Yandex Cloud CLI с Object Storage

{% note info %}

Для включения отладочного вывода в консоли используйте флаг `--debug`.

{% endnote %}

### Создайте бакет {#create-bucket}

По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Посмотрите описание команды CLI для создания бакета:

    ```bash
    yc storage bucket create --help
    ```

1. Создайте бакет в каталоге по умолчанию:

    ```bash
    yc storage bucket create --name <имя_бакета>
    ```

    Где `--name` — имя бакета. Обязательный параметр. Подробнее в разделе [Правила именования бакетов](../concepts/bucket.md#naming).

    
    По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите](../operations/hosting/certificate.md) собственный сертификат безопасности в Object Storage.


    Результат:

    ```text
    name: example
    folder_id: b1gmit33ngp6********
    anonymous_access_flags:
    read: false
    list: false
    default_storage_class: STANDARD
    versioning: VERSIONING_DISABLED
    max_size: "53687091200"
    acl: {}
    created_at: "2022-12-16T14:05:12.196007Z"
    ```

    {% cut "Опциональные параметры" %}

    * `--default-storage-class` — [класс хранилища](../concepts/storage-class.md). Доступные значения:
    * `standard` — стандартное хранилище. Устанавливается по умолчанию.
    * `cold` — холодное хранилище.
    * `ice` — ледяное хранилище.
    * `intelligent_tiering` — умное хранилище.

    Более «холодные» классы предназначены для длительного хранения объектов, работать с которыми планируется реже. Чем «холоднее» хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать. Умное хранилище автоматически оптимизирует расходы, перемещая объекты между уровнями доступа в зависимости от частоты обращения к ним.

    * `--max-size` — максимальный размер бакета в байтах. Значение по умолчанию — `0` (без ограничений).
    * Параметры для включения [публичного доступа](../security/public-access.md) к бакету:
    * `--public-read` — включить публичный доступ на чтение объектов в бакете.
    * `--public-list` — включить публичный доступ на просмотр списка объектов в бакете.
    * `--public-config-read` — включить публичный доступ на чтение настроек в бакете.

    По умолчанию публичный доступ к бакету выключен.

    {% note warning %}
    
    Публичный доступ предоставляется неограниченному кругу анонимных пользователей. Используйте его только в случае, когда нет возможности применить другие механизмы предоставления доступа.
    
    {% endnote %}

    * Параметры для настройки [ACL](../concepts/acl.md) бакета:
    * `--acl` — предопределенный ACL. Список возможных значений приведен в разделе [Предопределенные ACL](../concepts/acl.md#predefined-acls). Нельзя использовать одновременно с параметром `--grants`.
    * `--grants` — настройки разрешений для отдельных пользователей, [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md), [групп пользователей](../../organization/concepts/groups.md) и [публичных групп](../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей Yandex Cloud). Нельзя использовать одновременно с параметром `--acl`. Значение параметра указывается в формате: `grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=<тип_разрешения>`, где:
        * `grant-type` — тип получателя разрешения. Возможные значения:
        * `grant-type-account` — пользователь, [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или [группа пользователей](../../organization/concepts/groups.md);
        * `grant-type-all-authenticated-users` — [публичная группа](../concepts/acl.md#public-groups) всех аутентифицированных пользователей Yandex Cloud;
        * `grant-type-all-users` — публичная группа всех пользователей интернета.
        * `grantee-id` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение. Указывается, только если `grant-type=grant-type-account`.
        * `permission` — тип разрешения ACL. Возможные значения: `permission-full-control`, `permission-write`, `permission-read`. Подробнее о разрешениях в разделе [Виды разрешений](../concepts/acl.md#permissions-types).

        Чтобы настроить несколько разрешений, укажите параметр `--grants` несколько раз.

    По умолчанию для каждого нового бакета создается пустой ACL.

    {% endcut %}

    Подробнее о команде `yc storage bucket create` в [Справочнике YC CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

### Загрузите объект в бакет {#upload-object}

1. Посмотрите описание команды CLI для загрузки файла в бакет:

    ```bash
    yc storage s3api put-object --help
    ```

1. Получите список бакетов в каталоге по умолчанию:
   
   ```bash
   yc storage bucket list
   ```
   
   Результат:
   
   ```text
   +------------------+----------------------+-------------+-----------------------+---------------------+
   |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
   +------------------+----------------------+-------------+-----------------------+---------------------+
   | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
   +------------------+----------------------+-------------+-----------------------+---------------------+
   ```
1. Выполните команду:

    ```bash
    yc storage s3api put-object \
      --body <путь_к_локальному_файлу> \
      --bucket <имя_бакета> \
      --key <путь_к_объекту>
    ```

    Где:

    * `--body` — путь к файлу, который нужно загрузить в бакет.
    * `--bucket` — имя вашего бакета.
    * `--key` — [ключ](../concepts/object.md#key), по которому объект будет храниться в бакете.

    Результат:

    ```text
    etag: '"d41d8cd98f00b204e980099********"'
    request_id: 3f2705f********
    ```

    Альтернативная команда:

    ```bash
    yc storage s3 cp \
      <путь_к_локальному_файлу> \
      s3://<имя_бакета>/<путь_к_объекту>
    ```

    Результат:

    ```text
    upload: object.txt to s3://my-bucket/object.txt
    ```

    {% cut "Настройка параметров для команды `yc storage s3 cp`" %}

    Вы можете настроить следующие параметры для команды `yc storage s3 cp`:
    
    * `s3.max-queue-size` — максимальное количество задач в очереди. Значение по умолчанию — `1000`.
    * `s3.max-concurrent-requests` — максимальное количество одновременных запросов. Значение по умолчанию — `10`.
    * `s3.multipart-threshold` — пороговый размер объекта, при превышении которого будет использоваться составная (multipart) загрузка. Значение по умолчанию — `8MB`.
    * `s3.multipart-chunksize` — размер частей, на которые будет делиться объект при составной (multipart) загрузке. Значение по умолчанию — `8MB`.
    
    Чтобы задать эти параметры, используйте команду `yc config set <параметр> <значение>`.

    {% endcut %}

### Скачайте объект из бакета {#download-object}

1. Посмотрите описание команды CLI для скачивания объекта из бакета:

    ```bash
    yc storage s3api get-object --help
    ```

1. Получите список бакетов в каталоге по умолчанию:
   
   ```bash
   yc storage bucket list
   ```
   
   Результат:
   
   ```text
   +------------------+----------------------+-------------+-----------------------+---------------------+
   |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
   +------------------+----------------------+-------------+-----------------------+---------------------+
   | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
   +------------------+----------------------+-------------+-----------------------+---------------------+
   ```
1. Выполните команду:

    ```bash
    yc storage s3api get-object \
      --bucket <имя_бакета> \
      --key <ключ_объекта> \
      <путь_для_скачивания>
    ```

    Где:

    * `--bucket` — имя вашего бакета.
    * `--key` — [ключ](../concepts/object.md#key) объекта.
    * `<путь_для_скачивания>` — локальный путь для скачивания.

    Результат:

    ```bash
    etag: '"d41d8cd98f00b204e9800998********"'
    request_id: af194b83********
    accept_ranges: bytes
    content_type: application/octet-stream
    last_modified_at: "2024-10-08T12:36:36Z"
    server_side_encryption: aws:kms
    sse_kms_key_id: abj497vtg3h0********
    ```

    Альтернативная команда:

    ```bash
    yc storage s3 cp \
      s3://<имя_бакета>/<ключ_объекта> \
      <путь_для_скачивания>
    ```

    Результат:

    ```text
    download: s3://my-bucket/object.txt to object.txt
    ```

    {% cut "Настройка параметров для команды `yc storage s3 cp`" %}

    Вы можете настроить следующие параметры для команды `yc storage s3 cp`:
    
    * `s3.max-queue-size` — максимальное количество задач в очереди. Значение по умолчанию — `1000`.
    * `s3.max-concurrent-requests` — максимальное количество одновременных запросов. Значение по умолчанию — `10`.
    * `s3.multipart-threshold` — пороговый размер объекта, при превышении которого будет использоваться составная (multipart) загрузка. Значение по умолчанию — `8MB`.
    * `s3.multipart-chunksize` — размер частей, на которые будет делиться объект при составной (multipart) загрузке. Значение по умолчанию — `8MB`.
    
    Чтобы задать эти параметры, используйте команду `yc config set <параметр> <значение>`.

    {% endcut %}