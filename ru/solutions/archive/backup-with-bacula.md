# Бэкап с помощью системы резервного копирования Bacula на Centos 7

С помощью этой инструкции вы выполните:
* установку системы [Bacula](https://www.bacula.org/) в инфраструктуре Яндекс.Облака;
* настройку компонентов Bacula;
* бэкап системы на Yandex Object Storage;
* восстановление системных файлов из бэкапа.

1. [Обзор компонентов Bacula](#overview).
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте виртуальную машину](#create-vm).
1. [Установите необходимые компоненты](#install).
1. [Настройте базу данных MariaDB](#config-db).
1. [Настройте хранилище для бэкапа](#config-storage).
1. [Настройте компоненты Bacula](#config-bacula).
1. [Запустите резервное копирование](#run-backup).
1. [Проверьте корректность резервного копирования](#check-backup).
1. [Запустите восстановление](#run-restore).
1. [Проверьте корректность восстановления](#check-restore).
1. [Удалите созданные облачные ресурсы](#cleanup).

## Обзор компонентов Bacula {#overview}

Система резервного копирования Bacula имеет модульную структуру, состоящую из следующих компонентов:
* **Bacula Director** - программа, которая контролирует бэкап и восстановление, выполняемые компонентами File Daemon и Storage Daemon.
* **File Daemon** - программа, которая обеспечивает доступ к файлам для резервирования. 
* **Storage Daemon** - программа, которая осуществляет чтение и запись на жесткий диск.
* **Catalog** - это сервисы, поддерживающие каталог файлов предназначенных для бэкапа. Каталог хранится в SQL базе данных.
* **Bacula Console** - интерфейс командной строки для взаимодействия с Bacula Director.  


## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать сервер, нужно зарегистрироваться в Облаке и создать платежный аккаунт:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина. Перейдите на [страницу облака](https://console.cloud.yandex.ru/cloud) и выберите или создайте каталог, в котором вы хотите создать виртуальную машину для вашего сервера. [Подробнее об иерархии ресурсов Облака](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы

В стоимость инфраструктуры для примера входит:

* плата за постоянно запущенную виртуальную машину (см. [тарифы Yandex Compute Cloud](https://cloud.yandex.ru/docs/compute/pricing)).
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы Yandex Virtual Private Cloud](https://cloud.yandex.ru/docs/vpc/pricing)).
* плата за использование Object Storage (см. [тарифы для Object Storage](https://cloud.yandex.ru/docs/storage/pricing)).


## Создайте и настройте виртуальную машину {#create-vm}

### Создайте виртуальную машину:

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины, например `bacula-vm`.

    {% include [name-format](../../_includes/name-format.md) %}

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой должна находиться виртуальная машина.
1. В блоке **Публичные образы** выберите образ **Centos 7**.
   
1. В блоке **Вычислительные ресурсы** выберите следующую конфигурацию:
   * **Платформа** — Intel Cascade Lake.
   * **Гарантированная доля vCPU** — 20%.
   * **vCPU** — 2.
   * **RAM** — 2 ГБ.

1. В блоке **Сетевые настройки** нужно выбрать сеть и подсеть, к которым нужно подключить виртуальную машину. Если нужной сети или подсети еще нет, вы можете создать их прямо на странице создания виртуальной машины.

1. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула Яндекс.Облака. Чтобы внешний IP-адрес не изменялся после остановки виртуальной машины, [сделайте его статическим](../../vpc/operations/set-static-ip.md).

1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH-ключ** вставьте содержимое файла открытого ключа.
      
      Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к виртуальным машинам по SSH](../../compute/operations/vm-connect/ssh.md).
      
    {% note alert %}
    
     IP-адрес и имя хоста (FQDN) для подключения к машине будут назначены ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к виртуальной машине из интернета.
    
    {% endnote %}

1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут. 

### Настройте Yandex.Cloud CLI

1. Зайдите на виртуальную машину по SSH.
1. Установите Yandex.Cloud CLI по [инструкции](../../cli/quickstart.md):
    1. Выполните установку.
        ```bash
        curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ```
    1. Перезапустите `shell`.
        ```bash
        exec -l $SHELL
        ```
    1. Выполните инициализацию.
        ```bash
        yc init
        ```
1. Убедитесь, что Yandex.Cloud CLI функционирует корректно:
    ```bash
    yc config list
    ```
    Результатом должен быть вывод настроек произведенных на этапе конфигурации.
    
### Настройте сервисный аккаунт {#sa-setup}

1. Создайте сервисный аккаунт, назовите его, например `bacula`:
    ```bash
    yc iam service-account create --name bacula --description "this is bacula service account"
    ```
1. Узнайте идентификатор каталога по [инструкции](https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id):
1. Узнайте идентификатор вашего сервисного аккаунта, подставив соответствующий идентификатор каталога:
    ```bash
    yc iam service-account --folder-id <FOLDER-ID>  get bacula
    ```
    На выводе вы получите одну из строк вида:
    ```
    id: <SERVICE-ACCOUNT-ID>
    ``` 
1. Назначьте роль `editor` для вашего сервисного аккаунта, подставив соответствующее значение:
    ```bash
    yc resource-manager folder add-access-binding default --role editor --subject serviceAccount:<SERVICE-ACCOUNT-ID>
    ```
1. Создайте статический ключ доступа для вашего сервисного аккаунта:
    ```bash
    yc iam access-key create --service-account-name bacula --description "this key is for bacula"
    ```
    Сохраните следующие значения, они понадобятся для конфигурации AWS CLI:
    * `key_id`
    * `secret`

### Настройте AWS CLI

1. Установите `yum` репозиторий:
    ```bash
    sudo yum install epel-release -y
    ```
1. Установите pip:
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
    * `AWS Access Key ID` - это значение `key_id` из раздела [Настройте сервисный аккаунт](#sa-setup).
    * `AWS Secret Access Key` - это значение `secret` там же.
    * `Default region name` - введите `ru-central1`
    * `Default output format` - введите `json`
1. Проверьте, что файл `/root/.aws/credentials` содержит правильные значения:
    ```bash
    sudo cat /root/.aws/credentials
    ```
1. Проверьте, что файл `/root/.aws/config` содержит правильные значения:
    ```bash
    sudo cat /root/.aws/config
    ```

## Установите необходимые компоненты {#install}

1. Установите компоненты  Baucla:  
    ```bash
    sudo yum install -y bacula-director bacula-storage bacula-console bacula-client
    ```
1. Установите базу данных MariaDB:
    ```bash
    sudo yum install -y mariadb-server
    ```
1. Установите s3fs для монтирования Object Storage бакета на сервер:
    ```bash
    sudo yum install -y s3fs-fuse
    ```
1. Установите текстовый редактор `nano`:
    ```bash
    sudo yum install -y nano
    ```
    
## Настройте базу данных MariaDB {#config-db}

1. Запустите MariaDB:
    ```bash
    sudo systemctl start mariadb
    ```

1. Убедитесь, что сервис базы данных в статусе `running`:
    ```bash
    sudo systemctl status mariadb | grep Active
    ```

1. Включите запуск сервера базы данных при старте системы:
    ```bash
    sudo systemctl enable mariadb
    ```

1. Выполните следующие скрипты для создания необходимых таблиц в базе данных и настройки разрешений:
    ```bash
    /usr/libexec/bacula/grant_mysql_privileges
    /usr/libexec/bacula/create_mysql_database -u root
    /usr/libexec/bacula/make_mysql_tables -u bacula    
    ```
1. Выполните скрипт для настройки безопасности базы данных:
    ```bash
    sudo mysql_secure_installation
    ```
    
    В соответствующие запросы введите значения, показанные ниже:  
    ```
    Enter current password for root (enter for none): <ENTER>
    Set root password? [Y/n] y
    Remove anonymous users? [Y/n] <ENTER>
    Disallow root login remotely? [Y/n] <ENTER>
    Remove test database and access to it? [Y/n] <ENTER>
    Reload privilege tables now? [Y/n] <ENTER>
    ```
1. Войдите в командную строку базы данных и введите  пароль пользователя `root`, который был создан на передыдущем шаге:
    ```bash
    mysql -u root -p
    ```

1. Создайте пароль для вашей базы данных:
    ```bash
    UPDATE mysql.user SET Password=PASSWORD('bacula_db_password') WHERE User='bacula';
    FLUSH PRIVILEGES;
    exit
    ``` 

1. Настройте использование mysql-библиотеки для Bacula:
    ```bash
    sudo alternatives --config libbaccats.so
    ``` 
    
    Выберите `1`:
    ```
      Selection    Command
    -----------------------------------------------
       1           /usr/lib64/libbaccats-mysql.so
       2           /usr/lib64/libbaccats-sqlite3.so
    *+ 3           /usr/lib64/libbaccats-postgresql.so
    
    Enter to keep the current selection[+], or type selection number: 1
    ```

## Настройте хранилище для бэкапа {#config-storage}

### Подготовьте необходимые директории на сервере

1. Создайте директорию для бэкапа:
    ```bash
    sudo mkdir /tmp/bacula    
    ``` 

1. Настройте разрешения:
     ```bash
    sudo chown -R bacula:bacula /tmp/bacula
    sudo chmod -R 700 /tmp/bacula  
    sudo semanage permissive -a bacula_t 
    ``` 

### Создайте бакет в Object Storage

1. Создайте Object Storage бакет по [инструкции](../../storage/operations/buckets/create.md):
    * Назовите бакет, например `bacula-bucket`.
    * Максимальный размер оставьте по умолчанию.
    * Доступ к бакету - Ограниченный.
    * Класс хранилища - Холодное.

1. Зайдите в консоль Яндекс.Облака в раздел Object Storage и убедитесь, что бакет успешно создался.

### Смонтируйте бакет в файловую систему на сервере

Чтобы загружать бэкап файловой системы на Object Storage в облаке нужно смонтировать бакет в файловую систему с помощью утилиты s3fs.

1. Запустите команду:
    ```bash
    sudo s3fs bacula-bucket /tmp/bacula -o url=https://storage.yandexcloud.net -o use_path_request_style -o allow_other -o nonempty -o uid=133,gid=133,mp_umask=077
    ```
    * `bacula-bucket` - название Object Storage бакета
    * `uid=133,gid=133` - идентификаторы пользователя `bacula` и группы `bacula` из файла `/etc/passwd`

1. Проверьте корректность выставленных разрешений в папке /tmp/bacula:
    ```bash
    sudo ls -la /tmp/bacula/
    ```
    ```
    drwx------.  2 bacula bacula        31 Sep 18 09:16 .
    drwxrwxrwt. 10 root   root         265 Sep 18 08:59 ..
    ```

1. Проверьте что пользователь `bacula` может создавать файлы в папке `/tmp/bacula`.
    1. Временно включите оболочку `bash`  для пользователя `bacula`:
        ```bash
        sudo sed -i "/^bacula/ s@/sbin/nologin@/bin/bash@" /etc/passwd 
        ```
    1. Создайте произвольный файл в папке `/tmp/bacula`:
        ```bash
        sudo runuser -l  bacula -c 'touch /tmp/bacula/test.test' 
        ```
    1. Убедитесь, что файл `test.test` успешно создался в папке `/tmp/bacula`:
        ```bash
        sudo ls -la /tmp/bacula | grep test.test 
        ```
    1. Убедитесь, что файл `test.test` успешно появился в Object Storage бакете.
    1. Удалите тестовый файл:
        ```bash
        sudo runuser -l  bacula -c 'rm -f /tmp/bacula/test.test' 
        ```
    1. Отключите оболочку `bash`  для пользователя `bacula`:
        ```bash
        sudo sed -i "/^bacula/ s@/bin/bash@/sbin/nologin@" /etc/passwd 
        ```
   
## Настройте компоненты Bacula {#config-bacula}

### Настройте Bacula Director  

1. Откройте конфигурационный файл Bacula Director:
    ```bash
    sudo nano /etc/bacula/bacula-dir.conf
    ```  
1. Настройте Bacula Director на текущей виртуальной машине, добавив строку `DirAddress = 127.0.0.1` в раздел `Director {}`:
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
1. Для удобства переименуйте задачу по умолчанию с `BackupClient1` на `BackupFiles`:
    ```
    Job {
      Name = "BackupFiles"
      JobDefs = "DefaultJob"
    }
    ```
1. Назначьте папку `/tmp/bacula-restores`, в которую будут помещаться файлы из бэкапа при восстановлении:
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

1. Добавьте следующие строчки в раздел `FileSet`:
    * `compression = GZIP` - для сжатия при резервировании
    * `File = /` - для резервирования всей файловой системы
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
        File = /var/lib/bacula
        File = /proc
        File = /tmp
        File = /.journal
        File = /.fsck
      }
    }
    ```
1. Настройте соединение с Storage Daemon, указав внутренний IP-адрес виртуальной машины:
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
1. Настройте Catalog, указав созданный ранее пароль для базы данных `dbpassword = "bacula_db_password"`:
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
1. Проверьте, что файл не содержит синтаксические ошибки:
    ```bash
    sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
    ```

### Настройте Storage Daemon
1. Откройте конфигурационный файл:
    ```bash
    sudo nano /etc/bacula/bacula-sd.conf
    ``` 
1. Настройте соединение с Storage Daemon, указав `SDAddress = <внутренний IP-адрес виртуальной машины>`:
    ```
    Storage {                             # definition of myself
      Name = BackupServer-sd
      SDPort = 9103                  # Director's port
      WorkingDirectory = "/var/lib/bacula"
      Pid Directory = "/var/run/bacula"
      Maximum Concurrent Jobs = 20
      SDAddress = <внутренний IP-адрес виртуальной машины> 
    }
    ``` 
1. Укажите директрию для бэкапа `Archive Device = /tmp/bacula`:
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
1. Проверьте, что файл не содержит синтаксические ошибки:
    ```bash
    sudo bacula-sd -tc /etc/bacula/bacula-sd.conf
    ``` 

### Создайте пароли для компонентов Bacula:

Взаимодействие между каждым компонентом Bacula должно быть защищено паролями.

1. Сгенерируйте пароли для Bacula Director, Storage Daemon и File Daemon:
    ```bash
    DIR_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    SD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    FD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    ```
1. Поместите пароли в соответствующие конфигурационные файлы:
    ```bash
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bconsole.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-sd.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-fd.conf
    ```

### Запустите компоненты Bacula
1. Запустите компоненты Bacula:
    ```bash
    sudo systemctl start bacula-dir
    sudo systemctl start bacula-sd
    sudo systemctl start bacula-fd
    ```
1. Проверьте запущены ли компоненты Bacula:
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

1. Запустите Bacula Console:
    ```bash
    sudo bconsole
    ```  
1. Настройте профиль резервного копирования, создав `label`:
    ```bash
    label
    ```
1. Присвойте название новому `volume`:
    ```bash
    Enter new Volume name: MyVolume
    ```  
1. Выберите `2`:
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
    
1. Выберите `1`, чтобы запустить `BackupFiles`:
    ```bash
    A job name must be specified.
    The defined Job resources are:
         1: BackupFiles
         2: BackupCatalog
         3: RestoreFiles
    Select Job resource (1-3): 1    
    ```
1. Подтвердите запуск:
    ```bash
    OK to run? (yes/mod/no): yes 
    ```
1. Проверьте статус резервного копирования:
    ```bash
    status director
    ```    
1. Убедитесь, что резервное копирование выполняется:
    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:22
     JobId Level   Name                       Status
    ======================================================================
         2 Full    BackupFiles.2019-09-12_07.22.56_03 is running
    ```    
## Проверьте корректность резервного копирования {#check-backup}
    
1. Убедитесь, что резервное копирование успешно завершено, запустив команду в Bacula Console:   
    ```bash
    status director
    ```    
    
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

1. Убедитесь, что каталог с бэкапом успешно создался:
    1. Зайдите в консоль Яндекс.Облака в раздел Object Storage.
    1. Откройте ваш бакет `bacula-bucket`.
    1. Убедитесь что внутри находится файл `MyVolume`.

## Запустите восстановление {#run-restore}

1. Чтобы убедиться, что бэкап и восстановление отрабатывают корректно, перед восстановлением удалите произвольный файл, например утилиту `ping`:
    ```bash
    sudo rm -f /bin/ping
    ```
    ```bash
    ping
    ```
    ```bash
    bash: ping: command not found
    ```

1. Запустите восстановление внутри Bacula Console:
    ```bash
    restore all
    ```
    Выберите `5`, чтобы запустить самый последний выполненный бэкап:
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
    $ done
    ```
    Введите `yes`, чтобы подтвердить запуск:
    ```
    OK to run? (yes/mod/no): yes
    ```
    
1. Убедитесь, что восстановление выполняется::
    ```
    status director
    ```
    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:25
     JobId Level   Name                       Status
    ======================================================================
         3         RestoreFiles.2019-09-12_07.27.42_05 is running
    ```

## Проверьте корректность восстановления {#check-restore}

1. Убедитесь, что восстановление завершено, запустив команду в Bacula Console:
    ```bash
    status director
    ```
    ```
    Terminated Jobs:
     JobId  Level    Files      Bytes   Status   Finished        Name 
    ====================================================================
         2  Full     32,776    483.6 M  OK       12-Sep-19 07:24 BackupFiles
         3           32,776    1.136 G  OK       12-Sep-19 07:27 RestoreFiles
    ```
1. После восстановления файлы из бэкапа распаковываются в папку `/tmp/bacula-restores`. Убедитесь, что в этой папке появились файлы из бэкапа:
    ```bash
    sudo ls -la /tmp/bacula-restores
    ```
    
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

    ```bash
    -rwxr-xr-x 1 root root 66176 Aug  4  2017 /tmp/bacula-restores/bin/ping
    ```

1. Скопируйте утилиту `ping` на основную файловую систему:
    ```bash
    sudo cp /tmp/bacula-restores/bin/ping /bin/ping
    ```

1. Убедитесь, что `ping` работает корректно: 

    ```bash
    sudo ping 127.0.0.1 -c 1
    ```
    ```bash
    PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
    64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.016 ms
    
    --- 127.0.0.1 ping statistics ---
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    rtt min/avg/max/mdev = 0.016/0.016/0.016/0.000 ms
    ```
    
1. После восстановления необходимых файлов, очистите место на диске удалив копию восстановленных файлов:
    ```bash
    sudo rm -rfd /tmp/bacula-restores/*
    ```

## Удалите созданные облачные ресурсы {#cleanup}
Если вам больше не нужны облачные ресурсы:

* [Удалите виртуальную машину](https://cloud.yandex.ru/docs/compute/operations/vm-control/vm-delete).
* [Удалите статический IP адрес](https://cloud.yandex.ru/docs/vpc/operations/address-delete), если он был вами создан.
* [Удалите Object Storage Bucket](https://cloud.yandex.ru/docs/storage/operations/buckets/delete).