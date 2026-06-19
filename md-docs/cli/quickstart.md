# Начало работы с интерфейсом командной строки



_Интерфейс командной строки Yandex Cloud (CLI)_ — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.


## Установка {#install}

В разделе представлена инструкция по интерактивной установке CLI с помощью скрипта, который:
1. Определяет вашу операционную систему и архитектуру.
1. Скачивает исполняемый файл с последней стабильной версией CLI для вашего окружения.
1. Проверяет работоспособность.
1. Добавляет CLI в переменную окружения `PATH`.
1. Генерирует настройки автодополнения.

{% note tip %}

Чтобы вручную настроить директорию установки CLI, автодополнение, скрипт автозапуска оболочки и добавить CLI в переменную окружения `PATH`, воспользуйтесь [неинтерактивной установкой CLI с помощью скрипта](operations/install-cli.md#non-interactive).


Также вы можете самостоятельно загрузить и установить исполняемый файл с последней стабильной версией CLI. Подробнее в разделе [Установка без использования скрипта](operations/install-cli.md#bin).


{% endnote %}

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

Если в процессе установки CLI возникла ошибка, смотрите раздел [Решение проблем CLI](error.md#failure-writing-output-to-destination).

## Создание профиля {#initialize}

{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}
  
  Чтобы аутентифицироваться с помощью [аккаунта на Яндексе](../iam/concepts/users/accounts.md#passport):
  
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
  
     После успешной аутентификации в профиле сохранится [IAM-токен](../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
     
     Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных [облаков](../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:
  
     ```text
        Please select cloud to use:
         [1] cloud1 (id = aoe2bmdcvata********)
         [2] cloud2 (id = dcvatao4faoe********)
        Please enter your numeric choice: 2
        ```
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
  
     ```text
        Please choose a folder to use:
         [1] folder1 (id = cvatao4faoe2********)
         [2] folder2 (id = tao4faoe2cva********)
         [3] Create a new folder
        Please enter your numeric choice: 1
        ```
  
  1. Чтобы выбрать [зону доступности](../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.
  
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

  Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../organization/concepts/add-federation.md):
  
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
  
     После успешной аутентификации в профиле сохранится [IAM-токен](../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
     
     Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных [облаков](../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:
  
     ```text
        Please select cloud to use:
         [1] cloud1 (id = aoe2bmdcvata********)
         [2] cloud2 (id = dcvatao4faoe********)
        Please enter your numeric choice: 2
        ```
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
  
     ```text
        Please choose a folder to use:
         [1] folder1 (id = cvatao4faoe2********)
         [2] folder2 (id = tao4faoe2cva********)
         [3] Create a new folder
        Please enter your numeric choice: 1
        ```
  
  1. Чтобы выбрать [зону доступности](../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.
  
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

- Аккаунт локального пользователя {#local-account}

  Чтобы аутентифицироваться с помощью [аккаунта локального пользователя](../iam/concepts/users/accounts.md#local):
  
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
           1. На панели слева выберите ![alt](../_assets/console-icons/passport.svg) **Профиль**.
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
  
     После успешной аутентификации в профиле сохранится [IAM-токен](../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
     
     Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных [облаков](../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:
  
     ```text
        Please select cloud to use:
         [1] cloud1 (id = aoe2bmdcvata********)
         [2] cloud2 (id = dcvatao4faoe********)
        Please enter your numeric choice: 2
        ```
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
  
     ```text
        Please choose a folder to use:
         [1] folder1 (id = cvatao4faoe2********)
         [2] folder2 (id = tao4faoe2cva********)
         [3] Create a new folder
        Please enter your numeric choice: 1
        ```
  
  1. Чтобы выбрать [зону доступности](../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.
  
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


## Примеры команд {#example}

Ниже описано, как создать [облачную сеть](../vpc/concepts/network.md#network), [подсеть](../vpc/concepts/network.md#subnet) и [виртуальную машину](../compute/concepts/vm.md), подключенную к этой подсети.
1. Посмотрите описание команд CLI для работы с облачными сетями:

   ```bash
   yc vpc network --help
   ```

1. Создайте облачную сеть в [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), указанном в вашем профиле CLI:

   ```bash
   yc vpc network create \
     --name my-yc-network \
     --labels my-label=my-value \
     --description "my first network via yc"
   ```

1. Создайте подсеть в облачной сети `my-yc-network`:

   
   ```bash
   yc vpc subnet create \
     --name my-yc-subnet-a \
     --zone ru-central1-a \
     --range 10.1.2.0/24 \
     --network-name my-yc-network \
     --description "my first subnet via yc"
   ```



1. Получите список всех облачных сетей в каталоге, указанном в вашем профиле CLI:

   ```bash
   yc vpc network list
   ```

   Результат:

   ```text
   +----------------------+------------------+-------------------------+
   |          ID          |       NAME       |       DESCRIPTION       |
   +----------------------+------------------+-------------------------+
   | skesdqhkc644******** | my-ui-network    | my first network via ui |
   | c6449hbqqar1******** | my-yc-network    | my first network via yc |
   +----------------------+------------------+-------------------------+
   ```

   Получите тот же список с большим количеством деталей в формате YAML:

   ```bash
   yc vpc network list --format yaml
   ```

   Результат:

   ```text
   - id: skesdqhkc644********
     folder_id: ijkl9012
     created_at: "2018-09-05T09:51:16Z"
     name: my-ui-network
     description: "my first network via ui"
     labels: {}
   - id: c6449hbqqar1********
     folder_id: ijkl9012
     created_at: "2018-09-05T09:55:36Z"
     name: my-yc-network
     description: "my first network via yc"
     labels:
       my-label: my-value
   ```

1. Создайте ВМ и подключите к подсети `my-yc-subnet-a`:
   1. [Подготовьте](../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../glossary/ssh-keygen.md) на ВМ.
   1. Создайте ВМ Linux:

      
      ```bash
      yc compute instance create \
        --name my-yc-instance \
        --network-interface subnet-name=my-yc-subnet-a,nat-ip-version=ipv4 \
        --zone ru-central1-a \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```



      Где `ssh-key` – путь к открытому ключу для SSH-доступа. В операционной системе ВМ будет автоматически создан пользователь `yc-user` с указанным открытым ключом.
1. Подключитесь к ВМ по SSH:
   1. Узнайте [публичный IP-адрес](../vpc/concepts/address.md#public-addresses) ВМ. Для этого посмотрите подробную информацию о вашей ВМ:

      ```bash
      yc compute instance get my-yc-instance
      ```

      В выводе команды найдите адрес ВМ в блоке `one_to_one_nat`:

      ```yaml
      one_to_one_nat:
        address: 130.193.32.90
        ip_version: IPV4
      ```

   1. Подключитесь к ВМ по SSH от имени пользователя `yc-user`, используя закрытый ключ:


      ```bash
      ssh yc-user@130.193.32.90
      ```

1. Удалите ВМ `my-yc-instance`, подсеть `my-yc-subnet-a` и сеть `my-yc-network`:

   ```bash
   yc compute instance delete my-yc-instance
   yc vpc subnet delete my-yc-subnet-a
   yc vpc network delete my-yc-network
   ```


#### Полезные ссылки {#see-also}

* [Обновление CLI](operations/update-cli.md)