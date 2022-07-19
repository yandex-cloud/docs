В образах всех версий и редакций операционной системы Windows, подготовленных для запуска в {{ yandex-cloud }}, включен PowerShell Remoting Protocol (PSRP) с доступом по HTTPS. Вы сможете подключиться к виртуальной машине в статусе `RUNNING` по протоколу PSRP. Для инициализации всех служб после [запуска](../../compute/operations/vm-control/vm-stop-and-start.md#start) ВМ может потребоваться время. Если возникла ошибка соединения, попробуйте снова через несколько минут.

[Группы безопасности](../../vpc/concepts/security-groups.md) виртуальной машины должны разрешать входящий трафик по протоколу TCP на порт 5986.
  
  {% include [security-groups-note](../../compute/_includes_service/security-groups-note.md) %}

Для подключения по протоколу PSRP укажите публичный IP-адрес или полностью определенное доменное имя (Fully Qualified Domain Name, [FQDN]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FQDN){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Fully_qualified_domain_name){% endif %}). Доступ по FQDN возможен из другой ВМ {{ yandex-cloud }}, если она подключена к той же сети. IP-адрес и FQDN можно узнать в консоли управления, в блоке **Сеть** на странице ВМ.

Чтобы подключиться к ВМ:

1. Откройте консоль PowerShell.

1. Создайте объект `Credentials`, заменив `<password>` паролем пользователя `Administrator`, который вы указали при создании ВМ:

    ```powershell
    $myUserName = "Administrator"
    $myPlainTextPassword = "<password>"
    $myPassword = $MyPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($MyUserName, $myPassword)
    ```

1. Убедитесь, что имя пользователя и пароль в объекте верны:

    ```powershell
    $networkCredential = $credential.GetNetworkCredential()
    $networkCredential | Select-Object UserName, Password
    ```

    Результат:

    ```text
    UserName      Password
    --------      --------
    Administrator <password>
    ```

1. Создайте переменную для IP-адреса ВМ:

    ```powershell
    $ipAddress = "<ip-address>"
    ```

1. Создайте объект `SessionOption`. В объекте укажите проверки, которые нужно пропустить:

    ```powershell
    $sessionOption = New-PSSessionOption `
      -SkipCACheck `
      -SkipCNCheck `
      -SkipRevocationCheck
    ```

1. Подключитесь к интерактивной сессии:

    ```powershell
    $psSession = @{
      ComputerName = $ipAddress
      UseSSL = $true
      Credential = $credential
      SessionOption = $sessionOption
    }
    Enter-PSSession @psSession
    ```

    Результат:

    ```text
    [<ip-address>]: PS C:\Users\$myUserName\Documents>
    ```

    Завершите сессию:

    ```powershell
    Exit-PSSession
    ```

1. Создайте сессию для неинтерактивного выполнения команд:

    ```powershell
    $session = New-PSSession @psSession
    ```

    Просмотрите список открытых сессий:

    ```powershell
    Get-PSSession
    ```

    Результат:

    ```text
    Id Name            ComputerName    ComputerType    State         ConfigurationName     Availability
    -- ----            ------------    ------------    -----         -----------------     ------------
     2 WinRM2          <ip-address>    RemoteMachine   Opened        Microsoft.PowerShell     Available
    ```

    Выполните команду на удаленной машине:

    ```powershell
    $scriptBlock = { Get-Process }
    $invokeCommand = @{
      ScriptBlock = $scriptBlock
      Session = $session
    }
    Invoke-Command @invokeCommand
    ```

    Результат:

    ```text
    Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName                    PSComputerName
    -------  ------    -----      -----     ------     --  -- -----------                    --------------
        249      13     4248      16200       0.11   4176   2 conhost                        <ip-address>
        283      12     1888       4220       0.20    420   0 csrss                          <ip-address>
    ...
    ```

#### См. также {#see-also}

* [Сессии PowerShell (PSSessions)](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pssessions)
