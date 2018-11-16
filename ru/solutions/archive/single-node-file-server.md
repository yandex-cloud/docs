# Создание однонодового файлового сервера

Чтобы создать однонодовый файловый сервер:

* [Создайте виртуальную машину](#create-vm)
* [Настройте NFS и Samba](#nfs-samba-setup)

## Создать виртуальную машину с предустановленным веб-сервером {#create-vm}

Перед тем, как создавать виртуальную машину:

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru) Яндекс.Облака и выберите каталог, в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть сеть с подсетью, к которой можно подключить виртуальную машину. Для этого на странице каталога нажмите плитку **Yandex Virtual Private Cloud**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если ни одной подсети или сети нет, [создайте их](../../vpc/quickstart.md).

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления](https://console.cloud.yandex.ru) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины, например `fileserver`.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
1. В блоке **Публичные образы** выберите Ubuntu 18.04, 16.04 или 14.04 или CentOS 6 или 7.
1. В блоке **Вычислительные ресурсы** выберите [тип использования ядра](../../compute/concepts/vm-types.md) (частичное или полное), укажите необходимое количество vCPU и объем RAM.

   Рекомендованные требования для достаточной производительности:
   * **Гарантированная доля vCPU** — 100%.
   * **vCPU** — 8 и больше.
   * **RAM** — 56 ГБ и больше.
   * **Тип диска** — NVME.

1. 
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить виртуальную машину при создании.
1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH ключ** вставьте содержимое файла открытого ключа.
        Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS.
1. Нажмите кнопку **Создать ВМ**.

## Установить и настроить NFS и Samba {#nfs-samba-setup}

1. После того как машина `fileserver` перейдет в состояние `running`, подключитесь к ней по [протоколу SSH](../../compute/operations/vm-control/vm-connect-ssh.md).
1. Скачайте и установите Samba:

   ---

   **[!TAB Ubuntu 14/16/18]**
   ```
   sudo apt-get update
   sudo apt-get install nfs-kernel-server samba
   ```

   **[!TAB CentOS 6/7]**
   ```
   sudo yum check-update
   sudo yum -y install nfs-utils nfs-utils-lib samba nano
   sudo chkconfig smb on
   sudo chkconfig nfs on
   ```
   ---

1. Подготовьте и смонтируйте файловую систему:

   ```
   sudo mkfs -t ext4 -L data /dev/vdb
   sudo mkdir /data
   echo "LABEL=data /data ext4 defaults 0 0" | sudo tee -a /etc/fstab
   sudo mount /data
   ```

1. Настройте NFS:

* Откройте файл `/etc/exports`: 
    ```
     sudo nano /etc/exports
    ```
* Добавьте в файл следующие строки:
    ```
    /data <подсеть>(rw,no_subtree_check,fsid=100)
    /data 127.0.0.1(rw,no_subtree_check,fsid=100)
    ```

1. Задайте конфигурацию Samba:

```
sudo nano /etc/samba/smb.conf`
```

   ---
   **[!TAB Ubuntu 14/16/18]**

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
      hosts allow = <подсеть> 127.0.0.1
      hosts deny = 0.0.0.0/0
   ```

   **[!TAB CentOS 6]**

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
      hosts allow = <подсеть> 127.0.0.1
      hosts deny = 0.0.0.0/0
   ```

   **[!TAB CentOS 7]**

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
      hosts allow = <подсеть> 127.0.0.1
      hosts deny = 0.0.0.0/0
   ```

   ---

1. Перезапустите NFS и Samba, для CentOS 6 и 7 разрешите чтение файлов в папке `/data`:

   ---
   **[!TAB Ubuntu 14/16/18]**
   ```
   sudo service nfs-kernel-server restart
   sudo service smbd restart
   ```

   **[!TAB CentOS 6/7]**
   ```
   sudo chcon -t samba_share_t /data
   sudo semanage fcontext -a -t samba_share_t "/data(/.*)?"
   sudo restorecon -R -v /data
   sudo service rpcbind restart
   sudo service nfs restart
   sudo service smb restart
   ```
   ---

1. Если вы используете CentOS 6, настройте фаерволл:

   ---
   **[!TAB CentOS 6]**
   ```
   sudo iptables -I INPUT -p tcp -s <подсеть> -j ACCEPT
   sudo iptables -I INPUT -p udp -s <подсеть> -j ACCEPT
   sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

## Проверьте работу хранилища

---

**[!TAB Windows]**

* Запустите **cmd.exe**.
* Выполните команду `net use x: \\<внешний IP-адрес виртуальной машины>\data`

Файлы сервера будут доступны на диске X.

**[!TAB Windows]**

Выполните команду `mount -t nfs <внешний IP>:/data /<точка монтирования>`.

Файлы сервера будут доступны в указанной точке монтирования.

---
