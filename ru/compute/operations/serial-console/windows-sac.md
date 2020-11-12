# Запустить командную оболочку в Windows SAC

Чтобы подключиться к серийной консоли и запустить командную оболочку:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит виртуальная машина.
1. Выберите сервис **{{ compute-name }}**.
1. Нажмите на строку с нужной виртуальной машиной.
1. Перейдите на вкладку **Серийная консоль**.
1. В блоке **Серийная консоль** выберите `COM2` и нажмите кнопку **Подключиться**. В командной строке отобразится приглашение ввода команд:

    ```bash
    SAC>
    ```

1. Просмотрите список открытых каналов:

    ```bash
    SAC>ch
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    1 (AV)    Cmd0001
    ```

1. При необходимости создайте новый канал с экземпляром командной оболочки:

    ```bash
    SAC>cmd
    The Command Prompt session was successfully launched.
    SAC>
    EVENT:   A new channel has been created.  Use "ch -?" for channel help.
    Channel: Cmd0002
    ```

1. Чтобы перейти на канал нажмите сочетание клавиш `ESC+TAB` или выполните команду:

    ```bash
    SAC>ch -sn Cmd0002
    Name:                  Cmd0002
    Description:           Command
    Type:                  VT-UTF8
    Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
    Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

    Press <esc><tab> for next channel.
    Press <esc><tab>0 to return to the SAC channel.
    Use any other key to view this channel.
    ```

1. Нажмите **Enter**, последовательно введите:
    - Имя пользователя.
    - Домен, если вход выполняется доменной учетной записью. Иначе введите имя хоста либо оставьте пустым.
    - Пароль.

    ```bash
    Please enter login credentials.
    Username: Administrator
    Domain  :
    Password: ***************
    ```

1. Запустится экземпляр интерпретатора командной строки:

    ```bash
    C:\Windows\system32>
    ```

1. Чтобы запустить экземпляр PowerShell:

    ```bash
    C:\Windows\system32>powershell
    Windows PowerShell
    Copyright (C) Microsoft Corporation. All rights reserved.

    PS C:\Windows\system32>
    ```

1. Чтобы вернуться в консоль управления нажмите сочетание клавиш `ESC+TAB+0`.
