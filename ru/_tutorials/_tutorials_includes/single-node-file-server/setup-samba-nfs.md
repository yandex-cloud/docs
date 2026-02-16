После того как виртуальная машина `fileserver-tutorial` перейдет в статус `RUNNING`, выполните:

1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на виртуальную машину.

1. Настройте Samba и NFS:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     1. Скачайте и установите Samba:

        ```bash
        sudo apt-get update
        sudo apt-get install nfs-kernel-server samba
        ```

     1. Подготовьте и смонтируйте файловую систему на диске:

        ```bash
        sudo mkfs -t ext4 -L data /dev/vdb
        ```

     1. Подготовьте и смонтируйте папку `my_folder` для хранения данных на диске:

        ```bash
        sudo mkdir /my_folder
        echo "LABEL=data /my_folder ext4 defaults 0 0" | sudo tee -a /etc/fstab
        sudo mount /my_folder
        ```

     1. Задайте конфигурацию NFS в файле `/etc/exports`. Вы можете отредактировать файл с помощью утилиты `nano`:

        ```bash
        sudo nano /etc/exports
        ```

        Добавьте в файл следующие строки:

        ```bash
        /my_folder <IP-адрес>(rw,no_subtree_check,fsid=100)
        /my_folder 127.0.0.1(rw,no_subtree_check,fsid=100)
        ```

        Где `<IP-адрес>` – IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.

     1. Задайте конфигурацию Samba в файле `/etc/samba/smb.conf`. Вы можете отредактировать файл с помощью утилиты `nano`:

        ```bash
        sudo nano /etc/samba/smb.conf
        ```

        Приведите файл к виду:

        ```bash
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
           comment = /my_folder
           path = /my_folder
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

   {% endlist %}
