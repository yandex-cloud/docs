[Документация Yandex Cloud](../../../index.md) > [Интерфейс командной строки](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > Аутентификация от имени федеративного пользователя

# Аутентификация от имени федеративного пользователя

Вы можете использовать [федеративный аккаунт](../../../iam/concepts/users/accounts.md#saml-federation) для работы с Yandex Cloud, если ваша компания настроила [федерацию удостоверений](../../../iam/concepts/federations.md). В этом случае не требуется личный [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport).

{% note info %}

Для прохождения аутентификации на сервере без графического интерфейса нужен установленный браузер с [настроенным форвардингом X11](https://docs.ssh.com/manuals/client-user/53/tunnel-x11.html). С помощью X11 вы сможете использовать браузер на сервере по SSH. Для SSH-клиентов на ОС Linux эта функциональность доступна по умолчанию. Для клиентов на Windows можно использовать [Xming](https://sourceforge.net/projects/xming/).

Смотрите также [Пример аутентификации на ВМ Linux без графического интерфейса](#linux-vm-auth).

Если браузер установить невозможно, используйте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) вместо федеративного.

{% endnote %}

Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите его](../install-cli.md).


Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../../../organization/concepts/add-federation.md):

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

   После успешной аутентификации в профиле сохранится [IAM-токен](../../../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../../../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
   
   Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../../../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../../../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../../../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.

1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.

1. Выберите одно из предложенных [облаков](../../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:

   ```text
      Please select cloud to use:
       [1] cloud1 (id = aoe2bmdcvata********)
       [2] cloud2 (id = dcvatao4faoe********)
      Please enter your numeric choice: 2
      ```

   Если вам доступно только одно облако, оно будет выбрано автоматически.

1. Выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

   ```text
      Please choose a folder to use:
       [1] folder1 (id = cvatao4faoe2********)
       [2] folder2 (id = tao4faoe2cva********)
       [3] Create a new folder
      Please enter your numeric choice: 1
      ```

1. Чтобы выбрать [зону доступности](../../../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../../../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.

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

## Пример аутентификации на ВМ Linux без графического интерфейса {#linux-vm-auth}

Для аутентификации на ВМ Linux выполните следующие шаги:

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH.
1. [Установите](../install-cli.md) CLI.

1. Создайте на ВМ файл `/usr/local/bin/xdg-open` со следующим содержимым:

    ```bash
    #!/bin/sh
    echo $* > /dev/tty
    ```

1. Назначьте права на исполнение файла:

    ```bash
    sudo chmod +x /usr/local/bin/xdg-open
    ```

1. Запустите создание профиля CLI командой:

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

1. После нажатия клавиши **Enter** вы получите URL следующего вида:

    ```text
    https://auth.yandex.cloud/oauth/authorize?client_id=yc.oauth.public-sdk&code_challenge=y22kspX4VrKLmdg9hGr_Bwgte_a3RXtw1En********&code_challenge_method=S256&redirect_uri=http%3A%2F%2F127.0.0.1%3A42121%2Fauth%2Fcallback&response_type=code&scope=openid&state=aExf0z********&yc_federation_hint=federation-id
    ```

    Сохраните этот URL. Он потребуется для аутентификации в браузере. Вам также понадобится порт, который вы можете найти в query-параметре `redirect_uri` после IP-адреса `127.0.0.1`. В данном случае это порт `42121`.

1. На локальном компьютере откройте новое окно терминала и выполните команду для создания SSH-туннеля, указав порт, полученный в предыдущем шаге, имя пользователя и IP-адрес ВМ:

    ```bash
    ssh -L <порт>:127.0.0.1:<порт> <имя_пользователя>@<IP-адрес_ВМ>
    ```

1. В браузере на локальном компьютере откройте URL для аутентификации, полученный ранее.

1. Если аутентификация прошла успешно, в ожидающей команде CLI в SSH-сессии ВМ вы увидите следующий шаг настройки профиля. 
1. Завершите настройку CLI.