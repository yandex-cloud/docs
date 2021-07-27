---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Однонодовый файловый сервер

Сценарий описывает создание однонодового файлового сервера с использованием Samba и NFS.

Чтобы создать однонодовый файловый сервер:

1. [Подготовьте облако к работе](#before-you-begin)
1. [Создайте виртуальную машину для файлового сервера](#create-vm)
1. [Настройте Samba и NFS](#setup-samba-nfs)
1. [Протестируйте работу файлового сервера](#test-file-server)
1. [Удалите созданные облачные ресурсы](#clear-out)

## Подготовьте облако к работе {#before-you-begin}

Перед использованием {{ compute-name }} нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет находиться ваш бакет. Перейдите на [страницу облака](https://console.cloud.yandex.ru/cloud) и выберите или создайте каталог, в котором вы хотите создать бакет. [Подробнее об иерархии ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки статического сайта входит:

* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте облачные сети и подсети {#before-you-begin}

Перед тем, как создавать виртуальную машину:

1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть сеть с подсетью, к которой можно подключить виртуальную машину. Для этого на странице каталога выберите сервис **Virtual Private Cloud**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если ни одной подсети или сети нет, [создайте их](../../vpc/quickstart.md).

## Создайте виртуальную машину для файлового сервера {#create-vm}

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины — `fileserver-tutorial`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
1. Выберите публичный образ **Ubuntu** или **CentOS**.
1. В блоке **Вычислительные ресурсы**:
   - Выберите [платформу](../../compute/concepts/vm-platforms.md).
   - Укажите необходимое количество vCPU и объем RAM.

   Рекомендованные значения для файлового сервера:
   * **Гарантированная доля vCPU** — 100%.
   * **vCPU** — 8 или больше.
   * **RAM** — 56 ГБ или больше.
1. В блоке **Диски** нажмите **Добавить диск**. В окне **Добавление диска** укажите параметры диска для хранения данные:

   * **Имя** — `fileserver-tutorial-disk`;
   * **Размер** — 100 ГБ;
   * **Тип диска** — SSD;
   * **Наполнение** — Пустой.

   Нажмите **Добавить**.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить виртуальную машину при создании.
1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH ключ** вставьте содержимое файла открытого ключа.
        Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут. Когда виртуальная машина перейдет в статус `RUNNING`, вы можете [настроить NFS и Samba](#setup-samba-nfs).

При создании виртуальной машине назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.


## Настройте Samba и NFS {#setup-samba-nfs}

После того как виртуальная машина `fileserver-tutorial` перейдет в статус `RUNNING`, выполните:
1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

      Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей.  Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на виртуальную машину.
1. Скачайте и установите Samba:

   {% list tabs %}

   - Ubuntu
     ```bash
     $ sudo apt-get update
     $ sudo apt-get install nfs-kernel-server samba
     ```

   - CentOS
     ```bash
     $ sudo yum check-update
     $ sudo yum -y install nfs-utils nfs-utils-lib samba nano
     $ sudo chkconfig smb on
     $ sudo chkconfig nfs on
     ```
   {% endlist %}

1. Подготовьте и смонтируйте файловую систему на диске для хранения данных:

   ```bash
   $ sudo mkfs -t ext4 -L data /dev/vdb
   $ sudo mkdir /data
   $ echo "LABEL=data /data ext4 defaults 0 0" | sudo tee -a /etc/fstab
   $ sudo mount /data
   ```

1. Задайте конфигурацию NFS в файле `/etc/exports`. Вы можете отредактировать файл с помощью утилиты `nano`:
   ```bash
   $ sudo nano /etc/exports
   ```
   Добавьте в файл следующие строки:
   ```bash
   /data <IP-адрес>(rw,no_subtree_check,fsid=100)
   /data 127.0.0.1(rw,no_subtree_check,fsid=100)
   ```
   Вместо `<IP-адрес>` укажите IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.
1. Задайте конфигурацию Samba в файле `/etc/samba/smb.conf`. Вы можете отредактировать файл с помощью утилиты `nano`:

   ```bash
   $ sudo nano /etc/samba/smb.conf
   ```
   Приведите файл к виду:

   {% list tabs %}
   - Ubuntu

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
        comment = /data
        path = /data
        browseable = yes
        read only = no
        writable = yes
        guest ok = yes
        hosts allow = <IP-адрес> 127.0.0.1
        hosts deny = 0.0.0.0/0
     ```

   - CentOS 6

     ```
     [global]
        workgroup = MYGROUP
        server string = Samba Server Version %v
        log file = /var/log/samba/log.%m
        max log size = 50
        security = user
        passdb backend = tdbsam
        load printers = yes
        cups options = raw
        map to guest = bad user
     [homes]
        comment = Home Directories
        browseable = no
        writable = yes
     [printers]
        comment = All Printers
        path = /var/spool/samba
        browseable = no
        guest ok = no
        writable = no
        printable = yes
     [data]
        comment = /data
        path = /data
        browseable = yes
        read only = no
        writable = yes
        guest ok = yes
        hosts allow = <IP-адрес> 127.0.0.1
        hosts deny = 0.0.0.0/0
     ```

   - CentOS 7

     ```
     [global]
             workgroup = SAMBA
             security = user

             passdb backend = tdbsam

             printing = cups
             printcap name = cups
             load printers = yes
             cups options = raw

     [homes]
             comment = Home Directories
             valid users = %S, %D%w%S
             browseable = No
             read only = No
             inherit acls = Yes

     [printers]
             comment = All Printers
             path = /var/tmp
             printable = Yes
             create mask = 0600
             browseable = No

     [print$]
             comment = Printer Drivers
             path = /var/lib/samba/drivers
             write list = @printadmin root
             force group = @printadmin
             create mask = 0664
             directory mask = 0775
     [data]
        comment = /data
        path = /data
        browseable = yes
        read only = no
        writable = yes
        guest ok = yes
        hosts allow = <IP-адрес> 127.0.0.1
        hosts deny = 0.0.0.0/0
     ```

   {% endlist %}

   В блоке `[data]` вместо `<IP-адрес>` укажите IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.
1. Перезапустите NFS и Samba, для CentOS 6 и 7 предварительно разрешите чтение файлов в директории `/data`:

   {% list tabs %}

   - Ubuntu
     ```bash
     $ sudo service nfs-kernel-server restart
     $ sudo service smbd restart
     ```

   - CentOS
     ```bash
     $ sudo chcon -t samba_share_t /data
     $ sudo semanage fcontext -a -t samba_share_t "/data(/.*)?"
     $ sudo restorecon -R -v /data
     $ sudo service rpcbind restart
     $ sudo service nfs restart
     $ sudo service smb restart
     ```

   {% endlist %}

1. Этот шаг нужно выполнять только на виртуальной машине с ОС CentOS 6.

   Разрешите сетевой доступ к виртуальной машине с помощью утилиты `iptables`:
   ```bash
   $ sudo iptables -I INPUT -p tcp -s <IP-адрес> -j ACCEPT
   $ sudo iptables -I INPUT -p udp -s <IP-адрес> -j ACCEPT
   $ sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```
   Вместо `<IP-адрес>` укажите IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.

## Протестируйте работу файлового сервера {#test-file-server}

1. Создайте на виртуальной машине `fileserver-tutorial` тестовую директорию и файл в ней:
   ```bash
   $ sudo mkdir /data/fileserver-tutorial
   $ sudo setfacl -m u:<имя вашего пользователя>:w /data/fileserver-tutorial
   $ echo "Hello world!" > /data/fileserver-tutorial/test.txt
   ```
1. Подключите по NFS сетевой диск к вашему компьютеру и проверьте доступность тестового файла:

   {% list tabs %}

   - Linux/macOS

     Выполните команду `mount -t nfs <внешний IP>:/data /<точка монтирования>`.

     Тестовая директория и файл должны быть доступны в указанной точке монтирования.

   - Windows

     1. Запустите утилиту **cmd.exe**. Для этого нажмите комбинацию клавиш **Windows**+**R** и выполните команду `cmd`.
     1. В командной строке выполните команду:
         ```
         net use x: \\<публичный IP-адрес виртуальной машины>\data
         ```

     Тестовая директория и файл должны быть доступны на диске X.

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутый сервер, достаточно удалить [созданную виртуальную машину](../../compute/operations/vm-control/vm-delete.md) `fileserver-tutorial`. 

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:

1. Откройте сервис **Virtual Private Cloud** в вашем каталоге.
1. Перейдите на вкладку **IP-адреса**.
1. Найдите нужный адрес, нажмите значок ![ellipsis](../../_assets/options.svg) и выберите пункт **Удалить**. 