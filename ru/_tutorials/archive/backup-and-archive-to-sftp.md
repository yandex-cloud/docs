# Настройка SFTP-сервера на Centos 7

С помощью этой инструкции вы научитесь:
* разворачивать [SFTP](https://ru.wikipedia.org/wiki/SFTP)-сервер в инфраструктуре {{ yandex-cloud }};
* выполнять резервное копирование конфигурационных файлов с SFTP-клиента на SFTP-сервер по расписанию.

Чтобы развернуть нужную инфраструктуру, следуйте инструкциям:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину для SFTP-сервера](#create-vm-sftp-server).
1. [Настройте SFTP-сервер](#config-sftp-server).
1. [Создайте SFTP-пользователя](#create-sftp-user).
1. [Создайте виртуальную машину для SFTP-клиента](#create-vm-sftp-client).
1. [Сделайте бэкап конфигурационных файлов на SFTP-сервер](#backup).
1. [Настройте расписание для бэкапа](#schedule).
1. [Проверьте работоспособность бэкапа](#check-backup).
1. [Восстановите настройки из бэкапа](#restore).
1. [Проверьте корректность восстановления](#check-restore).
1. [Удалите созданные облачные ресурсы](#cleanup).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы

В стоимость инфраструктуры для примера входит:

* плата за две постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)):
    * виртуальная машина для SFTP-клиента;
    * виртуальная машина для SFTP-сервера.
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


{% endif %}

## Создайте виртуальную машину для SFTP-сервера {#create-vm-sftp-server}

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины, например `sftp-server`.

    {% include [name-format](../../_includes/name-format.md) %}

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой должна находиться виртуальная машина.
1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите образ [CentOS 7](/marketplace/products/yc/centos-7).
   
1. В блоке **Вычислительные ресурсы** выберите следующую конфигурацию:
   * **Платформа** — Intel Cascade Lake.
   * **Гарантированная доля vCPU** — 20%.
   * **vCPU** — 2.
   * **RAM** — 2 ГБ.

1. В блоке **Сетевые настройки** выберите сеть и подсеть, к которым нужно подключить виртуальную машину. Если нужной сети или подсети еще нет, вы можете создать их на странице создания виртуальной машины.

1. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}. Чтобы внешний IP-адрес не изменялся после остановки виртуальной машины, [сделайте его статическим](../../vpc/operations/set-static-ip.md).

1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH-ключ** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к виртуальным машинам по SSH](../../compute/operations/vm-connect/ssh.md).
      
    {% note alert %}
    
     IP-адрес и имя хоста (FQDN) для подключения к машине будут назначены ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к виртуальной машине из интернета.
    
    {% endnote %}

1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут. 


## Настройте SFTP-сервер {#config-sftp-server}

Функционал SFTP-сервера включен в стандартную программу SSH, которая поставляется с дистрибутивом Centos 7. Для настройки SFTP-сервера отредактируйте конфигурационный файл `/etc/ssh/sshd_config`:

1. Откройте конфигурационный файл в редакторе vi. Этот редактор поставляется с дистрибутивом и не требует установки. Если вы не знакомы с этим редактором, то подробности вы можете узнать в [официальной документации](https://www.vim.org/docs.php).

    ```bash
    sudo vi /etc/ssh/sshd_config
    ```

1. Добавьте следующие строчки в конец файла:

    ```
    Match User fuser
    ForceCommand internal-sftp
    PasswordAuthentication no
    ChrootDirectory /var/sftp
    PermitTunnel no
    AllowAgentForwarding no
    AllowTcpForwarding no
    X11Forwarding no
    ```
    
    Назначение параметров:

    * `Match User fuser` - указывает на то, что все последующие строчки будут применены только при подключении пользователя `fuser`.
    * `ForceCommand internal-sftp` — подключать пользователя только в режиме SFTP и не разрешать доступ в shell.
    * `PasswordAuthentication no` — отключить доступ по логину и паролю.
    * `ChrootDirectory /var/sftp` — ограничить доступ пользователя только в рамках папки `/var/sftp`.
    * `PermitTunnel no`, `AllowAgentForwarding no`, `AllowTcpForwarding no`, `X11Forwarding no` - отключить туннелирование, проброс портов и графических приложений через SSH-сессию.

1.  Сохраните файл.
1.  Выведите конфигурационный файл без закомментированных и пустых строк:

    ```bash
    cat /etc/ssh/sshd_config | grep -v -e '^#' -e '^$'
    ```

1. Убедитесь, что вывод предыдущей команды совпадает с данными строками:
    ```
    HostKey /etc/ssh/ssh_host_rsa_key
    HostKey /etc/ssh/ssh_host_ecdsa_key
    HostKey /etc/ssh/ssh_host_ed25519_key
    SyslogFacility AUTHPRIV
    AuthorizedKeysFile .ssh/authorized_keys
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    GSSAPIAuthentication yes
    GSSAPICleanupCredentials no
    UsePAM yes
    X11Forwarding yes
    AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
    AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
    AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
    AcceptEnv XMODIFIERS
    Subsystem sftp  /usr/libexec/openssh/sftp-server
    Match User fuser
    ForceCommand internal-sftp
    PasswordAuthentication no
    ChrootDirectory /var/sftp
    PermitTunnel no
    AllowAgentForwarding no
    AllowTcpForwarding no
    X11Forwarding no
    ```
1. Сохраните файл.
1. Перезагрузите SFTP-сервис, чтобы настройки вступили в силу:
    ```bash
    sudo systemctl restart sshd
    ```

1. Создайте группу для SFTP-пользователей:
    ```bash
    sudo groupadd ftpusers
    ```  

1. Создайте папки для сохранения файлов:
    ```bash
    sudo mkdir -p /var/sftp/backups
    ```

    * `sftp` — корневая папка SFTP-сервера.
    * `backups` — папка для хранения резервных копий на SFTP-сервере.

1.  Установите разрешения на папки таким образом, чтобы все пользователи, входящие в состав группы `ftpusers` могли записывать и читать файлы на SFTP-сервере:
    ```bash
    sudo chown root:ftpusers /var/sftp/backups
    sudo chmod 770 /var/sftp/backups
    ```

1. Проверьте корректность выставленных разрешений:

    ```bash
    ls -la /var | grep sftp
    ls -la /var/sftp
    ```
    Результат:
    
    ```bash
    drwxr-xr-x.  4 root root   37 Aug  7 11:35 sftp
    drwxrwx---. 2 root ftpusers 80 Aug  7 08:41 backups
    ```


## Создайте SFTP-пользователя {#create-sftp-user}

1. Создайте SFTP-пользователя, например `fuser`:
    ```bash
    sudo useradd fuser
    ```

1. Создайте пароль для SFTP-пользователя
    ```bash
    sudo passwd fuser
    ```

1. Создайте SSH-ключи для пользователя `fuser`. Команда должна выполняться от имени пользователя `fuser`:
    ```bash
    sudo runuser -l  fuser -c 'ssh-keygen -t ed25519'
    ```

    Процесс генерации ключа приведен ниже. Поле `passphrase` оставьте пустым.  

    ```
    [yc-user@ftp-server ~]$ sudo runuser -l fuser -c 'ssh-keygen -t ed25519'      
    Generating public/private ed25519 key pair.
    Enter file in which to save the key (/home/fuser/.ssh/id_ed25519): 
    Created directory '/home/fuser/.ssh'.
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /home/fuser/.ssh/id_ed25519.
    Your public key has been saved in /home/fuser/.ssh/id_ed25519.pub.
    The key fingerprint is:
    SHA256:sXiE7EfPl8mo9mZCG+ta7fBxwdwdhbjNux63P8EIYNs fuser@ftp-server.{{ region-id }}.internal
    The key's randomart image is:
    +--[ED25519 256]--+
    |             . ..|
    |     . . o  . . .|
    |      o = +  + . |
    |     . + * E.+o..|
    |      o S + X +..|
    |       ooo . o.o |
    |       .=+o . ..o|
    |       o+=oo  .+.|
    |      .o.++  ...+|
    +----[SHA256]-----+
    ```

1. Создайте файл для сохранения публичных SSH-ключей SFTP-клиента. Поставьте нужные разрешения. 

    ```bash
    sudo touch /home/fuser/.ssh/authorized_keys
    sudo chmod 600 /home/fuser/.ssh/authorized_keys
    sudo chown fuser:fuser /home/fuser/.ssh/authorized_keys
    ```

1. Убедитесь, что разрешения выставлены верно:

    ```bash
    ls -la /home/fuser/.ssh/
    ```

    Вывод должен быть таким:
    ```bash
    -rw-------. 1 fuser fuser  421 Aug  7 08:31 authorized_keys
    -rw-------. 1 fuser fuser  419 Aug  7 08:29 id_ed25519
    -rw-r--r--. 1 fuser fuser  107 Aug  7 08:29 id_ed25519.pub
    ```

1. Добавьте SFTP-пользователя в SFTP-группу:
    ```bash
    sudo usermod -G ftpusers fuser
    ```

## Создайте виртуальную машину для SFTP-клиента {#create-vm-sftp-client}

Процесс создания виртуальной машины для SFTP-клиента полностью совпадает с созданием виртуальной машины для SFTP-сервера. 

1. Выполните пункты 1-9 из раздела [создание виртуальной машины для SFTP-сервера](#create-vm-sftp-server) (в качестве имени машины укажите, например, `sftp-client`).

1. Создайте пару SSH-ключей на SFTP-клиенте. Процесс аналогичен описанному для пользователя `fuser` в [предыдущем разделе](#create-sftp-user):

    ```bash
    ssh-keygen
    ```

1. Выведите публичный ключ на экране SFTP-клиента:
    ```bash
    cat ~/.ssh/id_ed25519.pub
    ```

1. Зайдите на SFTP-сервер и откройте файл `/home/fuser/.ssh/authorized_keys`: 
        
    ```bash
    sudo vi /home/fuser/.ssh/authorized_keys
    ```
1. Скопируйте SSH-ключ, полученный на SFTP-клиенте, в конец файла.
1. Сохраните файл.
1. Убедитесь, что виртуальная машина SFTP-клиента доступна с SFTP-сервера, и наоборот:
   
   1. Зайдите по SSH на SFTP-сервер.
   1. Найдите публичный или внутренний IP адрес SFTP-клиента в консоли {{ yandex-cloud }} в разделе настроек виртуальной машины. 

      {% note warning %}
    
      Внутренние адреса SFTP-клиента и SFTP-сервера должны находиться в одной подсети или быть связаны через настройки маршрутизации.
    
      {% endnote %}

   1. Введите команду в терминале SFTP-сервера, подставив соответствующее значение:
      ```bash
      ping <IP адрес SFTP-клиента>
      ```
   1. Убедитесь, что пакеты отправляются и получаются успешно: 
    
      ```bash
      ping 84.201.170.171
      PING 84.201.170.171 (84.201.170.171) 56(84) bytes of data.
      64 bytes from 84.201.170.171: icmp_seq=1 ttl=55 time=8.59 ms
      64 bytes from 84.201.170.171: icmp_seq=2 ttl=55 time=6.32 ms
      64 bytes from 84.201.170.171: icmp_seq=3 ttl=55 time=5.95 ms
      ^C
      --- 84.201.170.171 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 2003ms
      rtt min/avg/max/mdev = 5.955/6.959/8.595/1.168 ms
      ```
   1. Повторите проверку на SFTP-клиенте.


## Создайте резервную копию конфигурационных файлов на SFTP-сервере {#backup}

В инструкции рассмотрено резервное копирование конфигурационных файлов (с расширением `.conf`) из папки `/etc`. 

Процесс резервного копирования:

1. Упакуйте все нужные конфигурационные файлы в архив.
1. Передайте архив на SFTP-сервер.
1. Удалите архив на SFTP-клиенте. 

Чтобы настроить процесс резервного копирования:

1. Зайдите по SSH на виртуальную машину SFTP-клиента таким же способом, как это было проделано для SFTP-сервера.
1. Установите переменные окружения для корректной работы скрипта. Для этого откройте файл `~/.bash_profile`

    ```bash
    vi ~/.bash_profile
    ```
1. Добавьте следующие строчки в конец файла, подставив нужные значения:
   ```bash
   export SFTP_SERVER=<IP адрес SFTP-клиента>
   export SFTP_USER='fuser'
   ```

1. Примените настройки:
   ```bash
   source ~/.bash_profile
   ```

1. Проверьте, что у вас появились данные переменные:
   ```bash
   env | grep SFTP
   ```

    На экране должно появиться:
    ```
    SFTP_USER=fuser
    SFTP_SERVER=10.128.0.5
    ```

1. Запакуйте все конфигурационные файлы в один архив:
    ```bash
    sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -
    ```
    * `sudo find /etc -type f -name *.conf -print0` — поиск всех файлов `.conf` из папки `/etc`.
    * `sudo tar -czf backup.tar.gz --null -T -` — перемещение конфигурационных файлов в архив `backup.tar.gz`.

1. Перешлите полученный архив на SFTP-сервер:
   ```bash
   url -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER:
   ```

   Где:

   * `-T` — загрузить файл `backup.tar.gz` на удаленный сервер.
   * `$SFTP_SERVER` – переменная, которая автоматически примет значение IP адреса SFTP-сервера.
   * `backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz` — добавить к названию архива название компьютера, а также дату и время, когда был создан архив. Это позволит не потеряться в навигации по списку резервных копий на сервере.
    
     Например, имя архива на сервере может выглядеть так: `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz`. 
    
   * `--insecure` — отключить проверку SSL сертификатов со стороны SFTP-сервера. При этом трафик в рамках SSH-сессии все равно шифруется.
   * `$SFTP_USER` – переменная, которая автоматически примет значение SFTP-пользователя.
    
1. Удалите архив на SFTP-клиенте:
    
   ```bash
   sudo rm -f backup.tar.gz
   ```

Все действия для создания резервной копии можно выполнить одной командой:
```bash
sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
```

## Настройте расписание для резервного копирования {#schedule}

Для создания регулярных резервных копий ваших настроек можно использовать встроенную программу `crontab`.

1. Откройте файл `crontab` для редактирования:

   ```bash
   crontab -e
   ```

1. Добавьте следующую строку, чтобы запускать резервное копирование каждый день в 11 часов вечера:

   ```
   0 23 * * * sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
   ```


## Проверьте работоспособность резервного копирования {#check-backup}

Чтобы убедиться в том, что резервная копия создается нужным образом, запустите копирование и найдите копию на сервере:

1. Запустите на SFTP-клиенте команду для резервного копирования:

   ```bash
   sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
    ```

1. Зайдите на SFTP-сервер и убедитесь, что файл вида `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz` появился в домашнем каталоге SFTP-пользователя. Для этого на SFTP-сервере запустите команду:

   ```bash
   sudo ls /var/sftp/backups
   ```


## Восстановите настройки из резервной копии {#restore}

Процесс восстановления настроек:

1. Скачайте резервную копию с SFTP-сервера на SFTP-клиент.
1. Распакуйте архив.
1. Скопируйте конфигурационные файлы из архива в систему.
1. Удалите архив. 

Чтобы восстановить настройки из резервной копии:

1. На SFTP-сервере в папке `/var/sftp/backups` выберите резервную копию, из которой следует восстановить конфигурационные файлы. Например, это будет `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz`.

1. На SFTP-клиенте сделайте переменную окружения для названия файла резервной копии:

    ```bash
    SFTP_BACKUP='backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz'
    ```

1. Скачайте резервную копию с SFTP-сервера на SFTP-клиент:

   ```bash
   sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP .
   ```

1. Распакуйте архив:

   ```bash
   tar -xzf $SFTP_BACKUP
   ```
1. Скопируйте конфигурационные файлы из архива в систему (`yes` — избегать ввода подтверждения при перезаписи файлов):

   ```bash
   yes | cp -rfp etc / 
   ```

1. Удалите архив и распакованное содержимое:

   ```bash
   rm -f $SFTP_BACKUP
   rm -rfd etc
    ```

Все действия для восстановления из резервной копии можно выполнить одной командой:

```bash
sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP . && tar -xzf $SFTP_BACKUP && yes | cp -rfp etc / && rm -rfd etc && rm -f $SFTP_BACKUP
```

## Проверьте корректность восстановления {#check-restore}
  
Чтобы проверить, что конфигурационные файлы из архива успешно попадают в файловую систему, добавьте проверочный блок в команду полученную выше:

```bash
sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP . && tar -xzf $SFTP_BACKUP && echo "## this is from backup" >> etc/yum.conf && yes | cp -rfp etc / && rm -rfd etc && rm -f $SFTP_BACKUP
```
    
Команда `echo "## this is from backup" >> etc/yum.conf` записывает тестовую фразу "## this is from backup" в конец файла `etc/yum.conf`, распакованного из архива.

После восстановления из резервной копии выполните следующую команду: 
```bash
cat /etc/yum.conf | grep backup
```

Убедитесь, что на экране отображается тестовая фраза:
```bash
## this is from backup
```


## Удалите созданные облачные ресурсы {#cleanup}

Если вам больше не нужны SFTP-сервер и SFTP-клиент:

* [Удалите виртуальные машины](../../compute/operations/vm-control/vm-delete.md) для SFTP-клиента и SFTP-сервера (в примере они названы `sftp-server` и `sftp-client`).
* [Удалите статический IP адрес](../../vpc/operations/address-delete.md), если он был вами создан.
