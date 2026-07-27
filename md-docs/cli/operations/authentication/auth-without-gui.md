[Документация Yandex Cloud](../../../index.md) > [Интерфейс командной строки](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > Аутентификация на сервере без графического интерфейса

# Аутентификация на сервере без графического интерфейса

{% note warning %}

Аутентификация в CLI аккаунтом Яндекса, федеративным аккаунтом и аккаунтом локального пользователя осуществляется с помощью браузера и графического интерфейса.

Предпочтительным способом работы с CLI на сервере без графического интерфейса является [использование сервисного аккаунта](service-account.md).

Если по какой-то причине вы не можете использовать сервисный аккаунт, выполните аутентификацию через [SSH-туннель](auth-without-gui.md#linux-vm-auth) или с помощью [форвардинга X11](auth-without-gui.md#auth-without-gui).

{% endnote %}

В подразделе приведены следующие способы аутентификации на сервере без графического интерфейса:
* [Аутентификация с помощью форвардинга X11](#auth-without-gui)
* [Пример аутентификации через SSH-туннель](#linux-vm-auth)

## Аутентификация с помощью форвардинга X11 {#auth-without-gui}

В примере описана аутентификация с помощью [форвардинга X11](https://docs.ssh.com/manuals/client-user/53/tunnel-x11.html) на сервере с ОС Ubuntu.

1. Если вы подключаетесь к ВМ из macOS или Windows, установите и запустите X-сервер, например [XQuartz](https://www.xquartz.org/) для macOS или [VcXsrv](https://vcxsrv.com/) для Windows. На Linux эта функциональность доступна по умолчанию.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к серверу по SSH:

    ```bash
    ssh -i <файл_ключа> <имя_пользователя>@<публичный_IP-адрес_сервера>
    ```

1. Откройте файл `/etc/ssh/sshd_config`:

    ```bash
    sudo nano /etc/ssh/sshd_config
    ```

1. Раскомментируйте следующие строки:

    ```text
    X11Forwarding yes
    X11DisplayOffset 10
    X11UseLocalhost yes
    ```

1. Установите пакеты X-сервера:

    ```bash
    sudo apt get update
    sudo apt-get install xauth xorg
    ```

1. Отключитесь от сервера и заново подключитесь к X-серверу с помощью флага `-X`:

    ```bash
    ssh -X -i <файл_ключа> <имя_пользователя>@<публичный_IP-адрес_сервера>
    ```

1. (Опционально) Убедитесь, что форвардинг X11 работает, выполнив команду:

    ```bash
    xeyes
    ```

    Откроется окно Xeyes, закройте его.

1. Установите браузер [Chromium](https://www.chromium.org/Home/) и убедитесь, что он запускается:

    ```bash
    sudo apt update && sudo apt install chromium-browser
    export XAUTHORITY=$HOME/.Xauthority
    chromium
    ```

    Откроется окно браузера, закройте его.

1. Установите CLI и пакет для взаимодействия с X11:

    ```bash
    curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
    exec -l $SHELL
    sudo apt install xdg-utils
    ```

1. Запустите аутентификацию:

    {% list tabs group=authentication %}

    - Аккаунт на Яндексе {#yandex-account}

            
      ```bash
      yc init --username=<электронная_почта>
      ```



      Подробнее на странице [Аутентификация с аккаунтом на Яндексе](user.md).

    - Федеративный аккаунт {#federated-account}

            
      ```bash
      yc init --federation-id=<идентификатор_федерации>
      ```



      Подробнее на странице [Аутентификация от имени федеративного пользователя](federated-user.md).

    - Аккаунт локального пользователя {#local-account}

               
      ```bash
      yc init --userpool-id=<идентификатор_пула_пользователей>
      ```



      Подробнее на странице [Аутентификация от имени локального пользователя](local-user.md).

    {% endlist %}

    Откроется окно браузера со страницей аутентификации.

1. Завершите настройку CLI.

## Пример аутентификации через SSH-туннель {#linux-vm-auth}

Для аутентификации на ВМ Linux выполните следующие шаги:

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH.
1. Создайте на ВМ файл `/usr/local/bin/xdg-open` со следующим содержимым:

    ```bash
    #!/bin/sh
    echo $* > /dev/tty
    ```

1. Назначьте права на исполнение файла:

    ```bash
    sudo chmod +x /usr/local/bin/xdg-open
    ```

1. Установите CLI:

    ```bash
    curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
    exec -l $SHELL
    ```

1. Запустите аутентификацию:

    {% list tabs group=authentication %}

    - Аккаунт на Яндексе {#yandex-account}

            
      ```bash
      yc init --username=<электронная_почта>
      ```



      Подробнее на странице [Аутентификация с аккаунтом на Яндексе](user.md).

    - Федеративный аккаунт {#federated-account}

            
      ```bash
      yc init --federation-id=<идентификатор_федерации>
      ```



      Подробнее на странице [Аутентификация от имени федеративного пользователя](federated-user.md).

    - Аккаунт локального пользователя {#local-account}

               
      ```bash
      yc init --userpool-id=<идентификатор_пула_пользователей>
      ```



      Подробнее на странице [Аутентификация от имени локального пользователя](local-user.md).

    {% endlist %}

1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.

    ```text
    Welcome! This command will take you through the configuration process.
    Pick desired action:
    [1] Re-initialize this profile 'default' with new settings
    [2] Create a new profile
    ```

1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.

    {% list tabs group=authentication %}

    - Аккаунт на Яндексе {#yandex-account}

      ```text
      You are going to be authenticated via username '<электронная_почта>'.
      Authentication web site will be opened.
      After your successful authentication, you will be redirected to 'https://console.yandex.cloud'.

      Press 'enter' to continue...
      ```

    - Федеративный аккаунт {#federated-account}

      ```text
      You are going to be authenticated via federation-id 'aje1f0hsgds3a********'.
      Your federation authentication web site will be opened.
      After your successful authentication, you will be redirected to 'https://console.yandex.cloud'.

      Press 'enter' to continue...
      ```

    - Аккаунт локального пользователя {#local-account}

      ```text
      You are going to be authenticated via userpool-id 'ek0auknfc0mh********'.
      Your userpool authentication web site will be opened.
      After your successful authentication, you will be redirected to cloud console.

      Press 'enter' to continue...
      ```

    {% endlist %}

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

#### Полезные ссылки {#see-also}

* [Аутентификация от имени сервисного аккаунта](service-account.md)
* [Аутентификация с аккаунтом на Яндексе](user.md)
* [Аутентификация от имени федеративного пользователя](federated-user.md)
* [Аутентификация от имени локального пользователя](local-user.md)