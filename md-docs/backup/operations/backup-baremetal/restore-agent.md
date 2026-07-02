[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Backup](../../index.md) > [Пошаговые инструкции](../index.md) > BareMetal в Cloud Backup > Восстановить работу агента Cloud Backup

# Восстановить работоспособность агента Cloud Backup после обновления ядра Linux


При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux виртуальной машины или сервера BareMetal, подключенных к Cloud Backup, работоспособность агента Cloud Backup может оказаться нарушена: будет невозможно создать резервную копию ВМ/сервера или восстановить ВМ/сервер из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](../../concepts/index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра. 

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

{% endlist %}

Если по какой-либо причине восстановить работу агента Cloud Backup не удалось, [обратитесь](https://center.yandex.cloud/support) в техническую поддержку.