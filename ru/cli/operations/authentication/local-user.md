---
title: Аутентификация в {{ yandex-cloud }} CLI от имени локального пользователя
description: Следуя данной инструкции, вы сможете аутентифицироваться в {{ yandex-cloud }} CLI от имени локального пользователя.
---

# Аутентификация от имени локального пользователя

{% include [userpools-preview-stage](../../../_includes/iam/userpools-preview-stage.md) %}

Вы можете использовать аккаунт [локального пользователя](../../../iam/concepts/users/accounts.md#local) для работы с {{ yandex-cloud }}, если в вашей [организации](../../../organization/concepts/organization.md) настроен [пул пользователей](../../../organization/concepts/user-pools.md). В этом случае для аутентификации не требуется личный [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport).

{% note info %}

Для прохождения аутентификации на сервере без графического интерфейса нужен установленный браузер с [настроенным форвардингом X11](https://docs.ssh.com/manuals/client-user/53/tunnel-x11.html). С помощью X11 вы сможете использовать браузер на сервере по SSH. Для SSH-клиентов на ОС Linux эта функциональность доступна по умолчанию. Для клиентов на Windows можно использовать [Xming](https://sourceforge.net/projects/xming/).

См. также [{#T}](#linux-vm-auth).

Если браузер установить невозможно, вместо локального аккаунта используйте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).

{% endnote %}

Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../install-cli.md).

{% include [auth-local-user](../../../_includes/cli/auth-local-user.md) %}

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
    yc init --federation-id=<идентификатор_пула_пользователей>
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
   After your successful authentication, you will be redirected to cloud console.

   Press 'enter' to continue...
   ```

1. После нажатия клавиши **Enter** вы получите URL следующего вида:

    ```text
    https://{{ auth-main-host }}/oauth/authorize?client_id=yc.oauth.public-sdk&code_challenge=y22kspX4VrKLmdg9hGr_Bwgte_a3RXtw1En********&code_challenge_method=S256&redirect_uri=http%3A%2F%2F127.0.0.1%3A42121%2Fauth%2Fcallback&response_type=code&scope=openid&state=aExf0z********&yc_federation_hint=ek0o6g0irskn********&yc_sub_hint=
    ```

    Сохраните этот URL. Он потребуется для аутентификации в браузере. Вам также понадобится порт, который вы можете найти в query-параметре `redirect_uri` после IP-адреса `127.0.0.1`. В данном случае это порт `42121`.

1. На локальном компьютере откройте новое окно терминала и выполните команду для создания SSH-туннеля, указав порт, полученный на предыдущем шаге, имя пользователя и IP-адрес ВМ:

    ```bash
    ssh -L <порт>:127.0.0.1:<порт> <имя_пользователя>@<IP-адрес_ВМ>
    ```

1. В браузере на локальном компьютере откройте URL для аутентификации, полученный ранее.

1. Если аутентификация прошла успешно, в ожидающей команде CLI в SSH-сессии ВМ вы увидите следующий шаг настройки профиля. 
1. Завершите настройку CLI.