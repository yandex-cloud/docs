# Резервное копирование в {{ objstorage-full-name }} через Bacula на Centos 7 

С помощью этой инструкции вы научитесь выполнять резервное копирование в {{ objstorage-full-name }} и восстановление данных через [Bacula](https://www.bacula.org/) на CentOS 7 в инфраструктуре {{ yandex-cloud }}.

Bacula состоит из нескольких компонентов:

* **Bacula Director** — контролирует резервное копирование и восстановление.
* **File Daemon** — обеспечивает доступ к файлам для резервного копирования. 
* **Storage Daemon** — осуществляет чтение и запись файлов на жесткий диск.
* **Catalog** — поддерживает каталог файлов для резервного копирования. Каталог хранится в базе данных SQL.
* **Bacula Console** — консоль управления для взаимодействия с Bacula Director. 

Чтобы выполнить резервное копирование и восстановление через Bacula:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину](#create-vm).
1. [Установите Bacula и дополнительные компоненты](#install-bacula).
1. [Настройте базу данных MariaDB](#configure-db).
1. [Настройте хранилище для резервного копирования](#configure-storage).
1. [Настройте компоненты Bacula](#configure-bacula).
1. [Запустите резервное копирование](#run-backup).
1. [Проверьте резервное копирование](#check-backup).
1. [Запустите восстановление](#run-restore).
1. [Проверьте восстановление](#check-restore).

Если резервное копирование и восстановление данных вам больше не нужно, [удалите все используемые для этого ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования и восстановления входит:

* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing));
* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing)).


## Создайте виртуальную машину {#create-vm}

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.

1. В поле **Имя** введите имя виртуальной машины: `bacula-vm`.

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите публичный образ [CentOS 7](/marketplace/products/yc/centos-7).

1. В блоке **Вычислительные ресурсы** выберите:
    * **Платформа** — Intel Cascade Lake.
    * **Гарантированная доля vCPU** — 20%.
    * **vCPU** — 2.
    * **RAM** — 2 ГБ.

1. В блоке **Сетевые настройки** выберите сеть и подсеть, к которым нужно подключить виртуальную машину. Если нужной сети или подсети еще нет, вы можете создать их прямо на странице создания ВМ.

1. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

       Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к виртуальным машинам по SSH](../../compute/operations/vm-connect/ssh.md).

     {% note alert %}

     IP-адрес и имя хоста (FQDN) для подключения к машине назначатся ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к ВМ из интернета.

     {% endnote %}

1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут.

При создании виртуальной машине назначается публичный IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

## Создайте бакет {#create-bucket}

Чтобы создать бакет для резервного копирования в {{ objstorage-name }}:

1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции.

1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Бакет**.

1. В поле **Имя** введите имя бакета: `bacula-bucket`.

1. В поле **Доступ к бакету** выберите **Ограниченный**.

1. В поле **Класс хранилища** выберите **Холодное**.

1. Нажмите кнопку **Создать бакет**.

## Создайте сервисный аккаунт {#create-service-account}

Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роль](../../iam/operations/sa/assign-role-for-sa) `editor`.

## Создайте статические ключи доступа {#create-access-key}

Создайте [статические ключи доступа](../../iam/operations/sa/create-access-key.md).

Сразу сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.


## Настройте AWS CLI {#configure-aws}

После того как виртуальная машина `bacula-vm` перейдет в статус `RUNNING`:

1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

    Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на виртуальную машину.

1. Установите yum-репозиторий:

    ```bash
    sudo yum install epel-release -y
    ```

1. Установите `pip`:

    ```bash
    sudo yum install python-pip -y
    ```

1. Установите AWS CLI:

    ```bash
    sudo pip install awscli --upgrade
    ```

1. Настройте AWS CLI:

    ```bash
    sudo aws configure
    ```

    Команда запросит значения параметров:

    * `AWS Access Key ID` — введите идентификатор `key_id`, который вы получили при [создании статического ключа](#create-access-key).
    * `AWS Secret Access Key` — введите секретный ключ `secret`, который вы получили при [создании статического ключа](#create-access-key).
    * `Default region name` — `{{ region-id }}`.
    * `Default output format` — `json`.

1. Проверьте, что файл `/root/.aws/credentials` содержит правильные значения `key_id` и `secret`:

    ```bash
    sudo cat /root/.aws/credentials
    ```

1. Проверьте, что файл `/root/.aws/config` содержит правильные значения `Default region name` и `Default output format`:

    ```bash
    sudo cat /root/.aws/config
    ```

## Установите Bacula и дополнительные компоненты {#install-bacula}

1. Установите компоненты Bacula:

    ```bash
    sudo yum install -y bacula-director bacula-storage bacula-console bacula-client
    ```

1. Установите базу данных MariaDB:

    ```bash
    sudo yum install -y mariadb-server
    ```

1. Установите утилиту `s3fs` для монтирования бакета {{ objstorage-name }} на сервер:

    ```bash
    sudo yum install -y s3fs-fuse
    ```

1. Установите текстовый редактор `nano`:

    ```bash
    sudo yum install -y nano
    ```

## Настройте базу данных MariaDB {#configure-db}

1. Запустите MariaDB:

    ```bash
    sudo systemctl start mariadb
    ```

1. Проверьте, что MariaDB запущена:

    ```bash
    sudo systemctl status mariadb | grep Active
    ```

1. Включите запуск MariaDB при старте системы:

    ```bash
    sudo systemctl enable mariadb
    ```

1. Создайте таблицы БД и настройте права:

    ```bash
    /usr/libexec/bacula/grant_mysql_privileges
    /usr/libexec/bacula/create_mysql_database -u root
    /usr/libexec/bacula/make_mysql_tables -u bacula    
    ```

1. Настройте безопасность базы данных:

    ```bash
    sudo mysql_secure_installation
    ```

    При следующих запросах:
    * `Enter current password for root (enter for none)` — нажмите **Enter**, чтобы пропустить поле.
    * `Set root password? [Y/n]` — введите `Y`, установите и подтвердите пароль для суперпользователя. Пароль понадобится на следующем шаге.
    * `Remove anonymous users? [Y/n]` — нажмите **Enter**, чтобы принять значение по умолчанию.
    * `Disallow root login remotely? [Y/n]` — нажмите **Enter**, чтобы принять значение по умолчанию.
    * `Remove test database and access to it? [Y/n]` — нажмите **Enter**, чтобы принять значение по умолчанию.
    * `Reload privilege tables now? [Y/n]` — нажмите **Enter**, чтобы принять значение по умолчанию.

1. Войдите в командную строку БД и введите пароль суперпользователя `root`, созданный на предыдущем шаге:

    ```bash
    mysql -u root -p
    ```

1. Создайте пароль `bacula_db_password` для пользователя `bacula`:

    ```bash
    UPDATE mysql.user SET Password=PASSWORD('bacula_db_password') WHERE User='bacula';
    FLUSH PRIVILEGES;
    exit
    ``` 

1. Настройте использование MySQL-библиотеки для Bacula:

    ```bash
    sudo alternatives --config libbaccats.so
    ``` 

    Введите `1`, чтобы выбрать MySQL:

    ```
      Selection    Command
    -----------------------------------------------
       1           /usr/lib64/libbaccats-mysql.so
       2           /usr/lib64/libbaccats-sqlite3.so
    *+ 3           /usr/lib64/libbaccats-postgresql.so

    Enter to keep the current selection[+], or type selection number: 1
    ```

## Настройте хранилище для резервного копирования {#configure-storage}

### Подготовьте папку для резервного копирования {#prepare-folder}

1. Создайте папку для резервного копирования `/tmp/bacula`:

    ```bash
    sudo mkdir /tmp/bacula
    ``` 

1. Настройте права доступа к `/tmp/bacula`:

    ```bash
    sudo chown -R bacula:bacula /tmp/bacula
    sudo chmod -R 700 /tmp/bacula  
    sudo semanage permissive -a bacula_t 
    ``` 

### Смонтируйте бакет в файловую систему {#mount-bucket}

Смонтируйте бакет в файловую систему, чтобы загружать скопированные файлы в {{ objstorage-name }}:

1. Смонтируйте бакет с помощью утилиты `s3fs`:

    ```bash
    sudo s3fs bacula-bucket /tmp/bacula -o url=https://{{ s3-storage-host }} -o use_path_request_style -o allow_other -o nonempty -o uid=133,gid=133,mp_umask=077
    ```

    Где:

    * `bacula-bucket` — название бакета в {{ objstorage-name }}.
    * `uid=133` — идентификатор пользователя `bacula` из файла `/etc/passwd`.
    * `gid=133` — идентификатор группы `bacula` из файла `/etc/passwd`.

1. Проверьте права доступа к папке `/tmp/bacula`:

    ```bash
    sudo ls -la /tmp/bacula/
    ```

    Результат:

    ```
    drwx------.  2 bacula bacula        31 Sep 18 09:16 .
    drwxrwxrwt. 10 root   root         265 Sep 18 08:59 ..
    ```

1. Проверьте, что пользователь `bacula` может создавать файлы в папке `/tmp/bacula`:

    1. Временно включите оболочку `bash` для пользователя `bacula`:

        ```bash
        sudo sed -i "/^bacula/ s@/sbin/nologin@/bin/bash@" /etc/passwd 
        ```

    1. Создайте произвольный файл в папке `/tmp/bacula`:

        ```bash
        sudo runuser -l  bacula -c 'touch /tmp/bacula/test.test' 
        ```

    1. Убедитесь, что файл `test.test` создан в папке `/tmp/bacula`:

        ```bash
        sudo ls -la /tmp/bacula | grep test.test 
        ```

    1. На странице каталога в [консоли управления]({{ link-console-main }}) выберите сервис **{{ objstorage-short-name }}**. Убедитесь, что файл `test.test` появился в бакете `bacula-bucket`.

    1. Удалите тестовый файл:

        ```bash
        sudo runuser -l  bacula -c 'rm -f /tmp/bacula/test.test' 
        ```

    1. Отключите оболочку `bash` для пользователя `bacula`:

        ```bash
        sudo sed -i "/^bacula/ s@/bin/bash@/sbin/nologin@" /etc/passwd 
        ```
   
## Настройте компоненты Bacula {#configure-bacula}

### Настройте Bacula Director {#configure-director}

1. Откройте конфигурационный файл Bacula Director:

    ```bash
    sudo nano /etc/bacula/bacula-dir.conf
    ```

1. В блоке конфигурации `Director` добавьте строку `DirAddress = 127.0.0.1`, чтобы настроить соединение с Bacula Director:

    ```
    Director {                            # define myself
      Name = bacula-dir
      DIRport = 9101                # where we listen for UA connections
      QueryFile = "/etc/bacula/query.sql"
      WorkingDirectory = "/var/spool/bacula"
      PidDirectory = "/var/run"
      Maximum Concurrent Jobs = 1
      Password = "@@DIR_PASSWORD@@"         # Console password
      Messages = Daemon
      DirAddress = 127.0.0.1
    }    
    ```

1. Для удобства переименуйте задачу `BackupClient1` на `BackupFiles`:

    ```
    Job {
      Name = "BackupFiles"
      JobDefs = "DefaultJob"
    }
    ```

1. В конфигурации задачи `RestoreFiles` добавьте строку `Where = /tmp/bacula-restores`, чтобы назначить `/tmp/bacula-restores` папкой для восстановленных файлов:

    ```
    Job {
      Name = "RestoreFiles"
      Type = Restore
      Client=bacula-fd
      FileSet="Full Set"
      Storage = File
      Pool = Default
      Messages = Standard
      Where = /tmp/bacula-restores
    }
    ```

1. В блоке конфигурации `FileSet` с именем `Full Set` в разделе `Include`:

    * Добавьте строку `compression = GZIP` в раздел `Options` для сжатия при резервировании.
    * Укажите `File = /` для резервирования всей файловой системы.

    ```
	FileSet {
	  Name = "Full Set"
	  Include {
		Options {
		  signature = MD5
		  compression = GZIP
		}
		File = /
	  }
	  Exclude {
		File = /var/spool/bacula
		File = /tmp
		File = /proc
		File = /tmp
		File = /.journal
		File = /.fsck
	  }
	}
    ```

1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите внутренний IP-адрес виртуальной машины.

1. В блоке конфигурации `Storage` укажите внутренний IP-адрес виртуальной машины в поле `Address`, чтобы настроить соединение с Storage Daemon:

    ```
    Storage {
      Name = File
    # Do not use "localhost" here
      Address = <внутренний IP-адрес виртуальной машины>  # N.B. Use a fully qualified name here
      SDPort = 9103
      Password = "@@SD_PASSWORD@@"
      Device = FileStorage
      Media Type = File
    }
    ```

1. В блоке конфигурации `Catalog` укажите пароль для базы данных `dbpassword = "bacula_db_password"`, созданный при [настройке MariaDB](#configure-db), для подключения к БД:

    ```
    # Generic catalog service
    Catalog {
      Name = MyCatalog
    # Uncomment the following line if you want the dbi driver
    # dbdriver = "dbi:postgresql"; dbaddress = 127.0.0.1; dbport =
      dbname = "bacula"; dbuser = "bacula"; dbpassword = "bacula_db_password"
    }
    ```

1. Сохраните файл.

1.  Проверьте, что в файле `bacula-dir.conf` нет синтаксических ошибок:

    ```bash
    sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
    ```

    Если сообщений об ошибках нет, конфигурация корректна.

### Настройте Storage Daemon {#configure-storage-daemon}

1. Откройте конфигурационный файл Storage Daemon:

    ```bash
    sudo nano /etc/bacula/bacula-sd.conf
    ``` 

1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите внутренний IP-адрес виртуальной машины.

1. В блоке конфигурации `Storage` укажите внутренний IP-адрес виртуальной машины в поле `SDAddress` для настройки соединения с Storage Daemon:

    ```
    Storage {                             # definition of myself
      Name = BackupServer-sd
      SDPort = 9103                  # Director's port
      WorkingDirectory = "/var/spool/bacula"
      Pid Directory = "/var/run/bacula"
      Maximum Concurrent Jobs = 20
      SDAddress = <внутренний IP-адрес ВМ> 
    }
    ``` 

1. В блоке конфигурации `Device` укажите папку для резервного копирования `Archive Device = /tmp/bacula`:

    ```
    Device {
      Name = FileStorage
      Media Type = File
      Archive Device = /tmp/bacula 
      LabelMedia = yes;                   # lets Bacula label unlabeled media
      Random Access = Yes;
      AutomaticMount = yes;               # when device opened, read it
      RemovableMedia = no;
      AlwaysOpen = no;
    }
    ``` 

1. Сохраните файл.

1. Проверьте, что в файле `bacula-sd.conf` нет синтаксических ошибок:

    ```bash
    sudo bacula-sd -tc /etc/bacula/bacula-sd.conf
    ``` 

    Если сообщений об ошибках нет, конфигурация корректна.

### Создайте пароли для компонентов Bacula {#create-bacula-passwords}

Bacula Director, Storage Daemon и File Daemon используют пароли для межкомпонентной аутентификации.

Чтобы установить пароли для компонентов Bacula:

1. Сгенерируйте пароли для Bacula Director, Storage Daemon и File Daemon:

    ```bash
    DIR_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    SD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    FD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    ```

1. Поместите пароли в конфигурационные файлы:

    ```bash
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bconsole.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-sd.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-fd.conf
    ```

### Запустите компоненты Bacula {#run-bacula-components}

1. Запустите компоненты Bacula:

    ```bash
    sudo systemctl start bacula-dir
    sudo systemctl start bacula-sd
    sudo systemctl start bacula-fd
    ```

1. Проверьте, что компоненты Bacula запущены:

    ```bash
    sudo systemctl status bacula-dir
    sudo systemctl status bacula-sd
    sudo systemctl status bacula-fd
    ```

1. Настройте запуск компонентов Bacula при старте системы:

    ```bash
    sudo systemctl enable bacula-dir
    sudo systemctl enable bacula-sd
    sudo systemctl enable bacula-fd
    ```

## Запустите резервное копирование {#run-backup}

1. Откройте Bacula Console:

    ```bash
    sudo bconsole
    ```  

1. Создайте метку, чтобы настроить профиль резервного копирования:

    ```bash
    label
    ```

1. Присвойте название `MyVolume` новому тому:

    ```bash
    Enter new Volume name: MyVolume
    ```  

1. Введите `2`, чтобы выбрать пул `File`:

    ```bash
    Defined Pools:
         1: Default
         2: File
         3: Scratch
    Select the Pool (1-3): 2
    ```

1. Запустите резервное копирование:

    ```bash
    run    
    ```
    
    Выберите `1`, чтобы запустить задачу `BackupFiles`:

    ```bash
    A job name must be specified.
    The defined Job resources are:
        1: BackupFiles
        2: BackupCatalog
        3: RestoreFiles
    Select Job resource (1-3): 1    
    ```

    Введите `yes`, чтобы подтвердить запуск:

    ```bash
    OK to run? (yes/mod/no): yes 
    ```

1. Проверьте статус резервного копирования:

    ```bash
    status director
    ```

    Результат, если резервное копирование выполняется:

    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:22
     JobId Level   Name                       Status
    ======================================================================
         2 Full    BackupFiles.2019-09-12_07.22.56_03 is running
    ```
    
    Результат, если резервное копирование завершено:

    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:25
    No Jobs running.
    ====

    Terminated Jobs:
     JobId  Level    Files      Bytes   Status   Finished        Name 
    ====================================================================
         2  Full     32,776    483.6 M  OK       12-Sep-19 07:24 BackupFiles    
    ```

1. Дождитесь завершения резервного копирования и выйдите из Bacula Console:

    ```bash
    exit
    ```

## Проверьте резервное копирование {#check-backup}

Чтобы убедиться, что резервное копирование выполнено:

1. На странице каталога в [консоли управления]({{ link-console-main }}) выберите сервис **{{ objstorage-short-name }}**.
1. Откройте бакет `bacula-bucket`.
1. Убедитесь что внутри находится объект `MyVolume`.

## Запустите восстановление {#run-restore}

1. Предварительно удалите произвольный файл, например утилиту `ping`, чтобы проверить восстановление:

    ```bash
    sudo rm -f /bin/ping
    ```

1. Убедитесь, что утилита `ping` удалена:

    ```bash
    ping
    ```

    Результат:

    ```bash
    bash: ping: command not found
    ```

1. Войдите в Bacula Console:

    ```bash
    sudo bconsole
    ```

1. Запустите полное восстановление:

    ```bash
    restore all
    ```

    Выберите `5`, чтобы запустить восстановление из последней резервной копии:

    ```
    To select the JobIds, you have the following choices:
        1: List last 20 Jobs run
        2: List Jobs where a given File is saved
        3: Enter list of comma separated JobIds to select
        4: Enter SQL list command
        5: Select the most recent backup for a client
        6: Select backup for a client before a specified time
        7: Enter a list of files to restore
        8: Enter a list of files to restore before a specified time
        9: Find the JobIds of the most recent backup for a client
        10: Find the JobIds for a backup for a client before a specified time
        11: Enter a list of directories to restore for found JobIds
        12: Select full restore to a specified Job date
        13: Cancel
    Select item:  (1-13): 5
    ```

    Введите `done`, чтобы подтвердить полное восстановление:

    ```
    You are now entering file selection mode where you add (mark) and
    remove (unmark) files to be restored. No files are initially added, unless
    you used the "all" keyword on the command line.
    Enter "done" to leave this mode.
    
    cwd is: /
    done
    ```

    Введите `yes`, чтобы подтвердить запуск восстановления:

    ```
    OK to run? (yes/mod/no): yes
    ```
    
1. Проверьте статус восстановления:

    ```
    status director
    ```

    Вывод команды, если восстановление выполняется:

    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:25
     JobId Level   Name                       Status
    ======================================================================
         3         RestoreFiles.2019-09-12_07.27.42_05 is running
    ```

    Вывод команды, если восстановление завершено:

    ```
    Terminated Jobs:
     JobId  Level    Files      Bytes   Status   Finished        Name 
    ====================================================================
         2  Full     32,776    483.6 M  OK       12-Sep-19 07:24 BackupFiles
         3           32,776    1.136 G  OK       12-Sep-19 07:27 RestoreFiles
    ```

1. Дождитесь завершения восстановления и выйдите из Bacula Console:

    ```bash
    exit
    ```

## Проверьте восстановление {#check-restore}

1. Убедитесь, что в папке `/tmp/bacula-restores` появились восстановленные файлы:

    ```bash
    sudo ls -la /tmp/bacula-restores
    ```

    Результат:

    ```bash
    total 16
    dr-xr-xr-x. 15 root   root    201 Sep 12 07:09 .
    drwx------.  4 bacula bacula   35 Sep 12 07:09 ..
    lrwxrwxrwx   1 root   root      7 Sep 12 07:27 bin -> usr/bin
    dr-xr-xr-x   5 root   root   4096 Sep 12 07:01 boot
    drwxr-xr-x   2 root   root      6 Sep 12 07:22 dev
    drwxr-xr-x  79 root   root   8192 Sep 12 07:07 etc
    drwxr-xr-x   3 root   root     18 Sep 12 07:01 home
    lrwxrwxrwx   1 root   root      7 Sep 12 07:27 lib -> usr/lib
    lrwxrwxrwx   1 root   root      9 Sep 12 07:27 lib64 -> usr/lib64
    drwxr-xr-x   2 root   root      6 Apr 11  2018 media
    drwxr-xr-x   2 root   root      6 Apr 11  2018 mnt
    drwxr-xr-x   2 root   root      6 Apr 11  2018 opt
    dr-xr-x---   3 root   root    217 Sep 12 07:21 root
    drwxr-xr-x   2 root   root      6 Sep 12 07:22 run
    lrwxrwxrwx   1 root   root      8 Sep 12 07:27 sbin -> usr/sbin
    drwxr-xr-x   2 root   root      6 Apr 11  2018 srv
    dr-xr-xr-x   2 root   root      6 Sep 12 07:22 sys
    drwxr-xr-x  13 root   root    155 Mar  4  2019 usr
    drwxr-xr-x  19 root   root    267 Sep 12 07:01 var
    ```

1. Убедитесь, что утилита `ping` находится в папке `/tmp/bacula-restores`:

    ```bash
    sudo ls -la /tmp/bacula-restores/bin/ping
    ```

    Результат:

    ```bash
    -rwxr-xr-x 1 root root 66176 Aug  4  2017 /tmp/bacula-restores/bin/ping
    ```

1. Скопируйте утилиту `ping` на основную файловую систему:

    ```bash
    sudo cp /tmp/bacula-restores/bin/ping /bin/ping
    ```

1. Убедитесь, что `ping` работает: 

    ```bash
    sudo ping 127.0.0.1 -c 1
    ```

    Результат:

    ```bash
    PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
    64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.016 ms
    
    --- 127.0.0.1 ping statistics ---
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    rtt min/avg/max/mdev = 0.016/0.016/0.016/0.000 ms
    ```
    

1. Удалите копию восстановленных файлов, чтобы освободить место на диске:

    ```bash
    sudo rm -rfd /tmp/bacula-restores/*
    ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за хранение данных, достаточно удалить [виртуальную машину](../../compute/operations/vm-control/vm-delete.md) и [бакет {{ objstorage-name }}](../../storage/operations/buckets/delete).

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:

1. Выберите сервис **{{ vpc-short-name }}** в вашем каталоге.
2. Перейдите на вкладку **IP-адреса**.
3. Найдите нужный адрес, нажмите на значок ![ellipsis](../../_assets/options.svg) и выберите пункт **Удалить**.
