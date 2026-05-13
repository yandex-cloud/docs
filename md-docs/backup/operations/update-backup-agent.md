# Обновить или восстановить агент Yandex Cloud Backup на виртуальной машине

В некоторых ситуациях, чтобы обеспечить бесперебойное автоматическое резервное копирование [виртуальных машин](../../compute/concepts/vm.md) Yandex Compute Cloud, может понадобиться обновить [агент Cloud Backup](../concepts/agent.md) или восстановить нарушенную работоспособность агента.

## Обновление агента Cloud Backup {#update-agent}

Обновление агента Cloud Backup может потребоваться при технических обновлениях на стороне [провайдера резервного копирования](../concepts/index.md#providers). О подобных случаях Yandex Cloud заблаговременно предупреждает клиентов.

{% note info %}

Обновление агента Cloud Backup не влияет на данные в существующих резервных копиях.

{% endnote %}

Чтобы обновить агент Cloud Backup на ВМ:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  1. В терминале выполните команду:

      ```bash
      curl \
        --output backup_agent_linux_installer.bin \
        https://storage.yandexcloud.net/backup-distributions/backup_agent_linux_installer.bin && \
      sudo bash ./backup_agent_linux_installer.bin -a
      ```

      Результат:

      ```text
      ...
      Congratulations!
      Cyber Backup Agent has been successfully installed in the system.
      ```

      Обновление агента Cloud Backup может занимать около 15 минут.

  1. Отключитесь от ВМ.


- Windows {#windows}

  1. [Подключитесь](../../compute/operations/vm-connect/rdp.md) к ВМ по RDP.
  1. Запустите [Windows PowerShell](https://learn.microsoft.com/ru-ru/powershell/).
  1. Выполните команды:

      ```powershell
      Invoke-WebRequest `
        "https://storage.yandexcloud.net/backup-distributions/backup_agent_windows_installer.exe" `
        -OutFile ".\backup_agent_windows_installer.exe"
      Invoke-Expression .\backup_agent_windows_installer.exe
      ```

  1. В открывшемся окне нажмите **Repair**.
  1. Дождитесь сообщения `The installation was successfully repaired` и нажмите **CLOSE**.
      
      Обновление агента Cloud Backup может занимать около 15 минут.
  1. Отключитесь от ВМ.

{% endlist %}

Если по какой-либо причине обновить агент Cloud Backup не удалось, [обратитесь](https://center.yandex.cloud/support) в техническую поддержку.

## Восстановление работоспособности агента Cloud Backup {#restore-agent}

При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux виртуальной машины или сервера BareMetal, подключенных к Cloud Backup, работоспособность агента Cloud Backup может оказаться нарушена: будет невозможно создать резервную копию ВМ/сервера или восстановить ВМ/сервер из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](../concepts/index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра. 

Чтобы восстановить работоспособность агента Cloud Backup, нарушенную после обновления ядра ОС, необходимо обновить версию заголовков ядра Linux, на которую ориентируется DKMS при сборке модуля SnapAPI. Как только версия заголовков ядра станет соответствовать версии ядра, DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux при следующем запуске ВМ или сервера BareMetal.

{% list tabs group=operating_system %}

- Debian/Ubuntu {#ubuntu}

  1. Убедитесь, что версия ядра Linux расходится с версией заголовков ядра:
  
      * Чтобы узнать версию ядра Linux, в терминале выполните команду:
  
          ```bash
          uname -r
          ```
  
          Результат:
  
          ```text
          6.1.0-31-amd64
          ```
      * Чтобы узнать версию заголовков ядра Linux, выполните команду:
  
          ```bash
          sudo apt list --installed | grep header
          ```
  
          Результат:
  
          ```bash
          linux-headers-6.1.0-27-amd64/stable,now 6.1.115-1 amd64 [installed]
          linux-headers-6.1.0-27-common/stable,now 6.1.115-1 all [installed,automatic]
          ```
      Как видно из вывода команд, значения версий различаются: версия ядра Linux — `6.1.0-31`, версия заголовков ядра Linux — `6.1.0-27`.
  1. Установите пакет `linux-headers` для нового ядра Linux:
  
      ```bash
      sudo apt install linux-headers-$(uname -r)
      ```
  1. Убедитесь, что новые заголовки ядра были добавлены:
  
      ```bash
      sudo apt list --installed | grep header
      ```
  
      Результат:
  
      ```bash
      linux-headers-6.1.0-27-amd64/stable,now 6.1.115-1 amd64 [installed]
      linux-headers-6.1.0-27-common/stable,now 6.1.115-1 all [installed,automatic]
      linux-headers-6.1.0-31-amd64/stable-security,now 6.1.128-1 amd64 [installed]
      linux-headers-6.1.0-31-common/stable-security,now 6.1.128-1 all [installed,automatic]
      ```
  1. Перезапустите операционную систему:
  
      ```bash
      sudo reboot
      ```
  
      В процессе перезагрузки фреймворк DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux и агент Cloud Backup заработает.

- CentOS {#centos}

  1. Убедитесь, что версия ядра Linux расходится с версией заголовков ядра:
  
      * Чтобы узнать версию ядра Linux, в терминале выполните команду:
  
          ```bash
          uname -r
          ```
  
          Результат:
  
          ```text
          3.10.0.1160.81.1.el7.x86_64
          ```
      * Чтобы узнать версию заголовков ядра Linux, выполните команду:
  
          ```bash
          sudo yum list installed | grep kernel-dev*
          ```
  
          Результат:
  
          ```bash
          kernel-devel.x86_64             3.10.0-1160.76.1.el7            @updates
          ```
      Как видно из вывода команд, значения версий различаются: версия ядра Linux — `3.10.0.1160.81.1.el7`, версия заголовков ядра Linux — `3.10.0-1160.76.1.el7`.
  1. Установите пакет `linux-headers` для нового ядра Linux:
  
      ```bash
      sudo yum install kernel-$(uname -r)
      ```
  1. Убедитесь, что новые заголовки ядра были добавлены:
  
      ```bash
      sudo yum list installed | grep kernel-dev*
      ```
  
      Результат:
  
      ```bash
      kernel-devel.x86_64             3.10.0-1160.76.1.el7            @updates
      kernel-devel.x86_64             3.10.0.1160.81.1.el7            @updates
      ```
  1. Перезапустите операционную систему:
  
      ```bash
      sudo reboot
      ```
  
      В процессе перезагрузки фреймворк DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux и агент Cloud Backup заработает.

{% endlist %}

Если по какой-либо причине восстановить работу агента Cloud Backup не удалось, [обратитесь](https://center.yandex.cloud/support) в техническую поддержку.