# Резервное копирование в Yandex Object Storage с помощью Bacula

Yandex Object Storage можно использовать для резервного копирования и восстановления данных виртуальной машины с помощью утилиты [Bacula](https://www.bacula.org/).

Bacula состоит из нескольких компонентов:
* **Bacula Director** — контролирует резервное копирование и восстановление.
* **File Daemon** — обеспечивает доступ к файлам для резервного копирования. 
* **Storage Daemon** — осуществляет чтение и запись файлов на жесткий диск.
* **Catalog** — поддерживает каталог файлов для резервного копирования. Каталог хранится в базе данных [MariaDB](https://mariadb.com/kb/en/documentation/).
* **Bacula Console** — консоль управления для взаимодействия с Bacula Director. 

Чтобы настроить резервное копирование и восстановление с помощью Bacula:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину](#create-vm).
1. [Настройте AWS CLI](#configure-aws).
1. [Установите Bacula и дополнительные компоненты](#install-bacula).
1. [Настройте базу данных MariaDB](#configure-db).
1. [Сконфигурируйте хранилище](#configure-storage).
1. [Настройте компоненты Bacula](#configure-bacula).
1. [Запустите резервное копирование](#run-backup).
1. [Восстановите файлы](#run-restore).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования и восстановления входит:

* плата за вычислительные ресурсы и диски ВМ (см. [тарифы Yandex Compute Cloud](../pricing.md));
* плата за хранение данных в бакете и операции с ними (см. [тарифы Yandex Object Storage](../../storage/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

### Создайте бакет {#create-bucket}

Чтобы создать бакет для резервного копирования в Object Storage:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите каталог, в котором будете выполнять операции.
  1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Бакет**.
  1. В поле **Имя** введите имя бакета.
  1. Задайте параметры [публичного доступа](../../storage/security/public-access.md) на чтение [объектов](../../storage/concepts/object.md) в бакете, получение списка объектов и чтение настроек бакета — `С авторизацией`.
  1. В поле **Класс хранилища** выберите **Холодное**.
  1. Нажмите кнопку **Создать бакет**.

{% endlist %}

### Создайте сервисный аккаунт {#create-service-account}

[Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../iam/concepts/access-control/roles.md) `editor`.

### Создайте статические ключи доступа {#create-access-key}

[Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статические ключи доступа.

Сразу сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

## Создайте виртуальную машину {#create-vm}

Чтобы создать ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** выберите публичный образ [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку **Своя конфигурация** и укажите параметры:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `2`.
      * **Гарантированная доля vCPU** — `20%`.
      * **RAM** — `2 ГБ`.

  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **Создать подсеть**.
          * Если сети нет, нажмите **Создать сеть** и создайте ее:

              * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
              * (Опционально) Выберите опцию **Создать подсети**, чтобы автоматически создать подсети во всех зонах доступности.
              * Нажмите **Создать сеть**.

      * В поле **Публичный IP-адрес** выберите `Автоматически`, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **Доступ** выберите **SSH-ключ** и укажите данные для доступа к ВМ:

      * В поле **Логин** введите имя пользователя, который будет создан на виртуальной машине, например `yc-user`.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `bacula-vm`.
  1. Нажмите **Создать ВМ**.
  1. Дождитесь перехода ВМ в статус `RUNNING`.

{% endlist %}

## Настройте AWS CLI {#configure-aws}

Чтобы настроить утилиту AWS CLI на ВМ `bacula-vm`:

1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу ВМ и узнайте ее публичный IP-адрес.
1. [Подключитесь](../operations/vm-connect/ssh.md) к ВМ по протоколу SSH.

    Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Настройте использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на ВМ.
1. Обновите установленные в системе пакеты, для этого в терминале выполните команду:

    ```bash
    yum update -y
    ```

1. Установите AWS CLI:

    ```bash
    yum install awscli -y
    ```

1. Настройте AWS CLI:

    ```bash
    sudo aws configure
    ```

    Укажите значения параметров:
    * `AWS Access Key ID` — идентификатор `key_id`, который вы получили при [создании статического ключа](#create-access-key).
    * `AWS Secret Access Key` — секретный ключ `secret`, который вы получили при [создании статического ключа](#create-access-key).
    * `Default region name` — `ru-central1`.
    * `Default output format` — `json`.
1. Проверьте, что файл `/root/.aws/credentials` содержит правильные значения параметров `key_id` и `secret`:

    ```bash
    sudo cat /root/.aws/credentials
    ```

1. Проверьте, что файл `/root/.aws/config` содержит правильные значения параметров `Default region name` и `Default output format`:

    ```bash
    sudo cat /root/.aws/config
    ```

## Установите Bacula и дополнительные компоненты {#install-bacula}

1. Установите компоненты Bacula:

    ```bash
    sudo yum install -y bacula-director bacula-storage bacula-console bacula-client
    ```

1. Установите базу данных [MariaDB](https://mariadb.com/kb/en/documentation/):

    ```bash
    sudo yum install -y mariadb-server
    ```

1. Установите утилиту `s3fs` для монтирования бакета Object Storage в файловую систему:

    ```bash
    sudo yum install -y epel-release
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

1. Создайте таблицы БД и настройте права доступа:

    ```bash
    /usr/libexec/bacula/grant_mysql_privileges
    /usr/libexec/bacula/create_mysql_database -u root
    /usr/libexec/bacula/make_mysql_tables -u bacula
    ```

1. Настройте безопасность БД:

    ```bash
    sudo mysql_secure_installation
    ```

    При следующих запросах:
    * `Enter current password for root (enter for none)` — чтобы пропустить поле, нажмите клавишу **Enter**.
    * `Set root password? [Y/n]` — введите `Y`, установите и подтвердите пароль для суперпользователя. Пароль понадобится на следующем шаге.
    * `Remove anonymous users? [Y/n]` — чтобы принять значение по умолчанию, нажмите клавишу **Enter**.
    * `Disallow root login remotely? [Y/n]` — чтобы принять значение по умолчанию, нажмите клавишу **Enter**.
    * `Remove test database and access to it? [Y/n]` — чтобы принять значение по умолчанию, нажмите клавишу **Enter**.
    * `Reload privilege tables now? [Y/n]` — чтобы принять значение по умолчанию, нажмите клавишу **Enter**.

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

    ```bash
      Selection    Command
    -----------------------------------------------
       1           /usr/lib64/libbaccats-mysql.so
       2           /usr/lib64/libbaccats-sqlite3.so
    *+ 3           /usr/lib64/libbaccats-postgresql.so

    Enter to keep the current selection[+], or type selection number: 1
    ```

## Сконфигурируйте хранилище {#configure-storage}

### Подготовьте папку для резервного копирования {#prepare-folder}

1. Создайте папку для резервного копирования `/tmp/bacula`:

    ```bash
    sudo mkdir /tmp/bacula
    ``` 

1. Настройте права доступа к папке `/tmp/bacula`:

    ```bash
    sudo chown -R bacula:bacula /tmp/bacula
    sudo chmod -R 700 /tmp/bacula
    sudo semanage permissive -a bacula_t 
    ``` 

### Смонтируйте бакет в файловую систему {#mount-bucket}

1. Смонтируйте бакет с помощью утилиты `s3fs`, чтобы загружать резервные копии в Object Storage, для этого выполните команду, указав имя бакета:

    ```bash
    sudo s3fs <имя_бакета> /tmp/bacula \
      -o url=https://storage.yandexcloud.net \
      -o use_path_request_style \
      -o allow_other \
      -o nonempty \
      -o uid=133,gid=133,mp_umask=077
    ```

    Где:
    * `uid=133` — идентификатор пользователя `bacula` из файла `/etc/passwd`.
    * `gid=133` — идентификатор группы `bacula` из файла `/etc/passwd`.

1. Проверьте права доступа к папке `/tmp/bacula`:

    ```bash
    sudo ls -la /tmp/bacula/
    ```

    Результат:

    ```text
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

    1. В [консоли управления](https://console.yandex.cloud) на странице каталога выберите сервис **Object Storage** и убедитесь, что файл `test.test` появился в бакете.
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

1. Чтобы настроить соединение с Bacula Director, в блоке конфигурации `Director` добавьте строку `DirAddress = 127.0.0.1`:

    ```text
    ...
    Director {                              # define myself
      Name = bacula-dir
      DIRport = 9101                        # Specify the port (a positive integer) on which the Director daemon will listen for Bacula Console connections.
                                            # This same port number must be specified in the Director resource of the Console configuration file.
                                            # The default is 9101, so normally this directive need not be specified.
                                            # This directive should not be used if you specify the DirAddresses (plural) directive.
      QueryFile = "/etc/bacula/query.sql"
      WorkingDirectory = "/var/spool/bacula"
      PidDirectory = "/var/run"
      Maximum Concurrent Jobs = 1
      Password = "@@DIR_PASSWORD@@"         # Console password
      Messages = Daemon
      DirAddress = 127.0.0.1
    }    
    ...
    ```

1. Для удобства переименуйте задачу `BackupClient1` на `BackupFiles`:

    ```text
    ...
    Job {
      Name = "BackupFiles"
      JobDefs = "DefaultJob"
    }
    ...
    ```

1. Чтобы назначить `/tmp/bacula-restores` папкой для восстановленных файлов, в конфигурации задачи `RestoreFiles` добавьте строку `Where = /tmp/bacula-restores`:

    ```text
    ...
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
    ...
    ```

1. В блоке конфигурации `FileSet` с именем `Full Set`, в разделе `Include`:
    * Добавьте строку `compression = GZIP` в раздел `Options` для сжатия при резервировании.
    * Укажите `File = /` для резервирования всей файловой системы.

    ```text
    ...
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
    ...
    ```

1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу ВМ и узнайте ее внутренний IP-адрес.
1. Чтобы настроить исходящее подключение к Storage Daemon, в блоке конфигурации `Storage` в поле `Address` укажите внутренний IP-адрес ВМ:

    ```text
    ...
    Storage {
      Name = File
    # Do not use "localhost" here
      Address = <внутренний_IP-адрес_ВМ>  # N.B. Use a fully qualified name here
      SDPort = 9103
      Password = "@@SD_PASSWORD@@"
      Device = FileStorage
      Media Type = File
    }
    ...
    ```

1. Для подключения к БД в блоке конфигурации `Catalog` укажите пароль для БД `dbpassword = "bacula_db_password"`, созданный при [настройке MariaDB](#configure-db):

    ```text
    ...
    # Generic catalog service
    Catalog {
      Name = MyCatalog
    # Uncomment the following line if you want the dbi driver
    # dbdriver = "dbi:postgresql"; dbaddress = 127.0.0.1; dbport =
      dbname = "bacula"; dbuser = "bacula"; dbpassword = "bacula_db_password"
    }
    ...
    ```

1. Сохраните файл.
1. Проверьте, что в файле `bacula-dir.conf` нет синтаксических ошибок:

    ```bash
    sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
    ```

    Если сообщений об ошибках нет, конфигурация корректна.

### Настройте Storage Daemon {#configure-storage-daemon}

1. Откройте конфигурационный файл Storage Daemon:

    ```bash
    sudo nano /etc/bacula/bacula-sd.conf
    ``` 

1. Чтобы настроить входящее соединение со Storage Daemon, в блоке конфигурации `Storage`, в поле `SDAddress` укажите внутренний IP-адрес ВМ:

    ```text
    ...
    Storage {                                      # definition of myself
      Name = BackupServer-sd
      SDPort = 9103                                # Specifies port number on which the Storage daemon listens for Director connections. The default is 9103.
      WorkingDirectory = "/var/spool/bacula"
      Pid Directory = "/var/run/bacula"
      Maximum Concurrent Jobs = 20
      SDAddress = <внутренний_IP-адрес_ВМ>         # This directive is optional, and if it is specified,
                                                   # it will cause the Storage daemon server (for Director and File daemon connections) to bind to the specified IP-Address,
                                                   # which is either a domain name or an IP address specified as a dotted quadruple.
                                                   # If this directive is not specified, the Storage daemon will bind to any available address (the default).
    }
    ...
    ``` 

1. В блоке конфигурации `Device` укажите папку для резервного копирования `Archive Device = /tmp/bacula`:

    ```text
    ...
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
    ...
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

1. Чтобы настроить профиль резервного копирования, создайте метку:

    ```bash
    label
    ```

1. Присвойте название `MyVolume` новому тому:

    ```bash
    Enter new Volume name: MyVolume
    ```  

1. Чтобы выбрать пул `File`, введите `2`:

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

    Чтобы запустить задачу `BackupFiles`, выберите `1`:

    ```bash
    A job name must be specified.
    The defined Job resources are:
        1: BackupFiles
        2: BackupCatalog
        3: RestoreFiles
    Select Job resource (1-3): 1
    ```

    Чтобы подтвердить запуск, введите `yes`:

    ```bash
    OK to run? (yes/mod/no): yes 
    ```

1. Проверьте статус резервного копирования:

    ```bash
    status director
    ```

    Результат, если резервное копирование выполняется:

    ```text
    Running Jobs:
    Console connected at 12-Sep-19 07:22
     JobId Level   Name                       Status
    ======================================================================
         2 Full    BackupFiles.2019-09-12_07.22.56_03 is running
    ```

    Результат, если резервное копирование завершено:

    ```text
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

### Проверьте резервную копию {#check-backup}

Чтобы убедиться, что резервное копирование выполнено:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на странице каталога выберите сервис **Object Storage**.
  1. Откройте бакет.
  1. Убедитесь, что внутри находится объект `MyVolume`.

{% endlist %}

## Восстановите файлы {#run-restore}

1. Чтобы проверить восстановление, предварительно удалите произвольный файл, например утилиту `ping`:

    ```bash
    sudo rm -f /bin/ping
    ```

1. Убедитесь, что утилита `ping` удалена:

    ```bash
    ping
    ```

    Результат:

    ```text
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

    Чтобы запустить восстановление из последней резервной копии, введите `5`:

    ```bash
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

    Чтобы подтвердить полное восстановление, введите `done`:

    ```bash
    You are now entering file selection mode where you add (mark) and
    remove (unmark) files to be restored. No files are initially added, unless
    you used the "all" keyword on the command line.
    Enter "done" to leave this mode.
    
    cwd is: /
    done
    ```

    Чтобы подтвердить запуск восстановления, введите `yes`:

    ```bash
    OK to run? (yes/mod/no): yes
    ```

1. Проверьте статус восстановления:

    ```bash
    status director
    ```

    Результат, если восстановление выполняется:

    ```text
    Running Jobs:
    Console connected at 12-Sep-19 07:25
     JobId Level   Name                       Status
    ======================================================================
         3         RestoreFiles.2019-09-12_07.27.42_05 is running
    ```

    Результат, если восстановление завершено:

    ```text
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

### Проверьте восстановленные файлы {#check-restore}

1. Убедитесь, что в папке `/tmp/bacula-restores` появились восстановленные файлы:

    ```bash
    sudo ls -la /tmp/bacula-restores
    ```

    Результат:

    ```text
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

    ```text
    -rwxr-xr-x 1 root root 66176 Aug  4  2017 /tmp/bacula-restores/bin/ping
    ```

1. Скопируйте утилиту `ping` в основную файловую систему:

    ```bash
    sudo cp /tmp/bacula-restores/bin/ping /bin/ping
    ```

1. Убедитесь, что `ping` работает: 

    ```bash
    sudo ping 127.0.0.1 -c 1
    ```

    Результат:

    ```text
    PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
    64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.016 ms
    
    --- 127.0.0.1 ping statistics ---
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    rtt min/avg/max/mdev = 0.016/0.016/0.016/0.000 ms
    ```

1. Чтобы освободить место на диске, удалите копию восстановленных файлов:

    ```bash
    sudo rm -rfd /tmp/bacula-restores/*
    ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../operations/vm-control/vm-delete.md) ВМ.
1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты из бакета Object Storage.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет Object Storage.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.