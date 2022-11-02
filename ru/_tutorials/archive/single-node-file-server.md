# Однонодовый файловый сервер

Вы научитесь создавать однонодовый файловый сервер с помощью [Samba](https://www.samba.org/) и [NFS](https://docs.microsoft.com/ru-ru/windows-server/storage/nfs/nfs-overview), а также подключаться к нему с компьютеров на Linux, macOS и Windows.

Чтобы создать однонодовый файловый сервер:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину для файлового сервера](#create-vm).
1. [Настройте Samba и NFS](#setup-samba-nfs).
1. [Протестируйте работу файлового сервера](#test-file-server).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки статического сайта входит:

* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).



## Создайте облачные сети и подсети {#before-you-begin}

Перед тем, как создавать виртуальную машину:

1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции.

1. Убедитесь, что в выбранном каталоге есть сеть с подсетью, к которой можно подключить виртуальную машину. Для этого на странице каталога выберите сервис **{{ vpc-short-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть доступные подсети. Если ни одной подсети или сети нет, [создайте их](../../vpc/quickstart.md).


## Создайте виртуальную машину для файлового сервера {#create-vm}

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.

1. В поле **Имя** введите имя виртуальной машины — `fileserver-tutorial`.

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите публичный образ [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os).

1. В блоке **Диски** нажмите **Добавить диск**. В окне **Добавление диска** укажите параметры диска для хранения данных:

   * **Имя** — `fileserver-tutorial-disk`;
   * **Тип диска** — SSD;
   * **Размер** — 100 ГБ;
   * **Наполнение** — Пустой.

   Нажмите **Добавить**.

1. В блоке **Вычислительные ресурсы**:
   * Выберите [платформу](../../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество vCPU и объем RAM.

   Рекомендованные значения для файлового сервера:
   * **Гарантированная доля vCPU** — 100%.
   * **vCPU** — 8 или больше.
   * **RAM** — 56 ГБ или больше.

1. В блоке **Сетевые настройки** выберите, к какой подсети будет подключена виртуальная машина при создании.

1. Укажите данные для доступа на виртуальную машину:

    * В поле **Логин** введите имя пользователя.
    * В поле **SSH ключ** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать самостоятельно](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys).

1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут. Когда виртуальная машина перейдет в статус `RUNNING`, вы можете [настроить NFS и Samba](#setup-samba-nfs).

При создании виртуальной машине назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.


## Настройте Samba и NFS {#setup-samba-nfs}

После того как виртуальная машина `fileserver-tutorial` перейдет в статус `RUNNING`, выполните:
1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH.

      Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на виртуальную машину.
1. Скачайте и установите Samba:

   {% list tabs %}

   - Ubuntu
  
     ```bash
     sudo apt-get update
     sudo apt-get install nfs-kernel-server samba
     ```

   {% endlist %}

1. Подготовьте и смонтируйте файловую систему на диске:

   ```bash
   sudo mkfs -t ext4 -L data /dev/vdb
   ```

1. Подготовьте и смонтируйте папку для хранения данных на диске:

   ```bash
   sudo mkdir /имя_папки
   echo "LABEL=data /имя_папки ext4 defaults 0 0" | sudo tee -a /etc/fstab
   sudo mount /имя_папки
   ```

1. Задайте конфигурацию NFS в файле `/etc/exports`. Вы можете отредактировать файл с помощью утилиты `nano`:
   ```bash
   sudo nano /etc/exports
   ```

   Добавьте в файл следующие строки:
   ```bash
   /имя_папки <IP-адрес>(rw,no_subtree_check,fsid=100)
   /имя_папки 127.0.0.1(rw,no_subtree_check,fsid=100)
   ```
   Где `<IP-адрес>` – IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.

1. Задайте конфигурацию Samba в файле `/etc/samba/smb.conf`. Вы можете отредактировать файл с помощью утилиты `nano`:

   ```bash
   sudo nano /etc/samba/smb.conf
   ```
   Приведите файл к виду:

   ```
   [global]
      workgroup = WORKGROUP
      server string = %h server (Samba)
      dns proxy = no
      log file = /var/log/samba/log.%m
      max log size = 1000
      syslog = 0
      panic action = /usr/share/samba/panic-action %d
      server role = standalone server
      passdb backend = tdbsam
      obey pam restrictions = yes
      unix password sync = yes
      passwd program = /usr/bin/passwd %u
      passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
      pam password change = yes
      map to guest = bad user
      usershare allow guests = yes
   [printers]
      comment = All Printers
      browseable = no
      path = /var/spool/samba
      printable = yes
      guest ok = no
      read only = yes
      create mask = 0700
   [print$]
      comment = Printer Drivers
      path = /var/lib/samba/printers
      browseable = yes
      read only = yes
      guest ok = no
   [data]
      comment = /имя_папки
      path = /имя_папки
      browseable = yes
      read only = no
      writable = yes
      guest ok = yes
      hosts allow = <IP-адрес> 127.0.0.1
      hosts deny = 0.0.0.0/0
   ```
   
   Где `<IP-адрес>` в блоке `[data]` – IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.

1. Перезапустите NFS и Samba:

   ```bash
   sudo service nfs-kernel-server restart
   sudo service smbd restart
   ```


## Протестируйте работу файлового сервера {#test-file-server}

1. Создайте на виртуальной машине `fileserver-tutorial` директорию `remote` и файл test.txt:

   {% list tabs %}

   - Ubuntu
     ```bash
     sudo mkdir /имя_папки/remote
     sudo setfacl -m u:<имя вашего пользователя>:xw /имя_папки/remote
     echo "Hello world!" > /имя_папки/remote/test.txt
     ```
   {% endlist %}

1. Подключите по NFS сетевой диск к вашему компьютеру и проверьте доступность тестового файла:

   {% list tabs %}

   - Linux/macOS

      Если необходимо, установите утилиту для работы с сетевыми дисками:

      ```bash
      sudo apt-get install nfs-common
      ```

      Создайте точку монтирования:

      ```bash
      sudo mkdir /remote-test-dir
      ```

      Подключите сетевой диск:
     
      ```bash
      sudo mount -t nfs <внешний IP>:/имя_папки /remote-test-dir`
      ```

      В результате в указанной точке монтирования должны быть доступны тестовая директория и файл.

   - Windows

     1. Запустите утилиту **cmd.exe**. Для этого нажмите сочетание клавиш **Windows** + **R** и выполните команду `cmd`.
     1. В командной строке выполните команду:
         ```
         net use x: \\<публичный IP-адрес виртуальной машины>\имя_папки
         ```

     В результате появится диск X с тестовой директорией и файлом.

   {% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [удалите ВМ](../../compute/operations/vm-control/vm-delete.md);
1. [удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md), если вы его зарезервировали.
