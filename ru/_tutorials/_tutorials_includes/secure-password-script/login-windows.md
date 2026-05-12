Чтобы проверить, что данные из секрета были успешно использованы для создания пользователей, авторизуйтесь в ОС виртуальной машины:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит виртуальная машина.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Выберите виртуальную машину `win-test`.
1. Перейдите на вкладку **{{ ui-key.yacloud.compute.instance.switch_console }}**.
1. В блоке **{{ ui-key.yacloud.compute.instance.switch_console }}** выберите `COM2` и нажмите кнопку **{{ ui-key.yacloud.compute.instance.console.connect }}**. В командной строке отобразится приглашение ввода команд:

    ```bash
    Computer is booting, SAC started and initialized.                               
                                                                                    
    Use the "ch -?" command for information about using channels.                   
    Use the "?" command for general help.                                           
                                                                                    
                                                                                    
    SAC>                                                                            
    EVENT: The CMD command is now available.                                         
    ```

1. Просмотрите список открытых каналов:

    ```bash
    SAC>ch
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    ```

1. При необходимости создайте новый канал с экземпляром командной оболочки:

    ```bash
    SAC>cmd
    The Command Prompt session was successfully launched.
    SAC>
    EVENT:   A new channel has been created.  Use "ch -?" for channel help.
    Channel: Cmd0001
    ```

1. Чтобы перейти на канал, нажмите сочетание клавиш **ESC** + **TAB** или выполните команду:

    ```bash
    SAC>ch -sn Cmd0001
    Name:                  Cmd0001
    Description:           Command
    Type:                  VT-UTF8
    Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
    Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

    Press <esc><tab> for next channel.
    Press <esc><tab>0 to return to the SAC channel.
    Use any other key to view this channel.
    ```

1. Нажмите **Enter** и последовательно введите:

    * Имя пользователя.
    * Домен, если вход выполняется под доменной учетной записью. Иначе введите имя хоста либо оставьте пустым.
    * Пароль.

    ```bash
    Please enter login credentials.
    Username: Administrator
    Domain  :
    Password: ***************
    ```

1. Если авторизация прошла успешно, запустится экземпляр интерпретатора командной строки:

    ```bash
    C:\Windows\system32>
    ```

    Успешная авторизация означает, что данные из секрета были использованы при создании виртуальной машины.
