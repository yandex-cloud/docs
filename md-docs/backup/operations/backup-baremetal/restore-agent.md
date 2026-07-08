[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Backup](../../index.md) > [Пошаговые инструкции](../index.md) > Восстановить работу агента Cloud Backup

# Восстановить работоспособность агента Cloud Backup после обновления ядра Linux


При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux [защищаемого ресурса](../../concepts/index.md#protected-resources), подключенного к Cloud Backup, работоспособность агента Cloud Backup может оказаться нарушена: будет невозможно создать резервную копию защищаемого ресурса или восстановить его из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](../../concepts/index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра.

Чтобы восстановить работоспособность агента Cloud Backup, нарушенную после обновления ядра ОС, необходимо обновить версию заголовков ядра Linux, на которую ориентируется DKMS при сборке модуля SnapAPI. Как только версия заголовков ядра станет соответствовать версии ядра, DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux при следующем запуске защищаемого ресурса.

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
  
      В процессе перезагрузки фреймворк DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux, и агент Cloud Backup заработает.
  1. Если в результате перезапуска работоспособность агента Cloud Backup не восстановилась, выполните следующие действия, чтобы вручную пересобрать модуль ядра SnapAPI в нужной версии:
     
     1. Узнайте версию ядра Linux:
     
         ```bash
         uname -r
         ```
     
         Результат:
     
         ```text
         6.8.0-110-generic
         ```
     
         Как видно из результата, версия ядра Linux — `6.8.0-110-generic`. Это значение понадобится при обновлении модуля.
     
     1. Узнайте версию модуля SnapAPI, при необходимости предварительно установив утилиту `dkms` для вашей операционной системы:
     
         ```bash
         sudo dkms status | grep snapapi
         ```
     
         Результат:
     
         ```text
         snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
         snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
         ```
     
         Как видно из результата, версия модуля SnapAPI — `snapapi26/2.0.6`. Это значение понадобится при обновлении модуля.
     
     1. Обновите модуль SnapAPI, указав в команде полученные ранее версии модуля SnapAPI и ядра Linux:
     
         ```bash
         sudo dkms install snapapi26/2.0.6 -k 6.8.0-110-generic
         ```
     
         Результат: 
     
         ```text
         Building module:
         cleaning build area...
         ...
         - Installation
           - Installing to /lib/modules/6.8.0-110-generic/updates/dkms/
         depmod.......
         ```
     1. Повторно выполните команду, чтобы проверить установленную версию модуля SnapAPI:
     
         ```bash
         sudo dkms status | grep snapapi
         ```
     
         Результат:
     
         ```text
         snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
         snapapi26/2.0.6, 6.8.0-110-generic, x86_64: installed
         snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
         ```
     1. Перезапустите операционную систему:
     
         ```bash
         sudo reboot
         ```

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
  
      В процессе перезагрузки фреймворк DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux, и агент Cloud Backup заработает.
  1. Если в результате перезапуска работоспособность агента Cloud Backup не восстановилась, выполните следующие действия, чтобы вручную пересобрать модуль ядра SnapAPI в нужной версии:
     
     1. Узнайте версию ядра Linux:
     
         ```bash
         uname -r
         ```
     
         Результат:
     
         ```text
         6.8.0-110-generic
         ```
     
         Как видно из результата, версия ядра Linux — `6.8.0-110-generic`. Это значение понадобится при обновлении модуля.
     
     1. Узнайте версию модуля SnapAPI, при необходимости предварительно установив утилиту `dkms` для вашей операционной системы:
     
         ```bash
         sudo dkms status | grep snapapi
         ```
     
         Результат:
     
         ```text
         snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
         snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
         ```
     
         Как видно из результата, версия модуля SnapAPI — `snapapi26/2.0.6`. Это значение понадобится при обновлении модуля.
     
     1. Обновите модуль SnapAPI, указав в команде полученные ранее версии модуля SnapAPI и ядра Linux:
     
         ```bash
         sudo dkms install snapapi26/2.0.6 -k 6.8.0-110-generic
         ```
     
         Результат: 
     
         ```text
         Building module:
         cleaning build area...
         ...
         - Installation
           - Installing to /lib/modules/6.8.0-110-generic/updates/dkms/
         depmod.......
         ```
     1. Повторно выполните команду, чтобы проверить установленную версию модуля SnapAPI:
     
         ```bash
         sudo dkms status | grep snapapi
         ```
     
         Результат:
     
         ```text
         snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
         snapapi26/2.0.6, 6.8.0-110-generic, x86_64: installed
         snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
         ```
     1. Перезапустите операционную систему:
     
         ```bash
         sudo reboot
         ```

{% endlist %}

Если по какой-либо причине восстановить работу агента Cloud Backup не удалось, [обратитесь](https://center.yandex.cloud/support) в службу технической поддержки.