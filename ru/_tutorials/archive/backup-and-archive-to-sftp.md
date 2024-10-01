# Настройка SFTP-сервера на Centos 7

В этом руководстве вы создадите виртуальные машины для [SFTP](https://ru.wikipedia.org/wiki/SFTP)-сервера и клиента с помощью сервиса {{ compute-short-name }}, подключитесь к ним по [SSH](../../glossary/ssh-keygen.md), создадите SFTP-пользователя и настроите резервное копирование данных.

Чтобы развернуть инфраструктуру:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину для SFTP-сервера](#create-vm-sftp-server).
1. [Настройте SFTP-сервер](#config-sftp-server).
1. [Создайте SFTP-пользователя](#create-sftp-user).
1. [Создайте и настройте виртуальную машину для SFTP-клиента](#create-vm-sftp-client).
1. [Сделайте бэкап конфигурационных файлов на SFTP-сервер](#backup).
1. [Проверьте работоспособность бэкапа](#check-backup).
1. [Настройте расписание для бэкапа](#schedule).
1. [Восстановите настройки из бэкапа](#restore).
1. [Проверьте корректность восстановления](#check-restore).

Если созданные ресурсы вам больше не нужны, [удалите их](#cleanup).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за две постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)):
  * виртуальная машина для SFTP-клиента;
  * виртуальная машина для SFTP-сервера.
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Создайте виртуальную машину для SFTP-сервера {#create-vm-sftp-server}

Чтобы создать виртуальную машину:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ [CentOS 7](/marketplace/products/yc/centos-7).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите параметры:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

              * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
              * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
              * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}. Чтобы внешний IP-адрес не изменялся после остановки виртуальной машины, [сделайте его статическим](../../vpc/operations/set-static-ip.md).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на виртуальной машине, например `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      {% note alert %}

      IP-адрес и имя хоста (FQDN) для подключения к машине будут назначены ей при создании. Если вы выбрали вариант **{{ ui-key.yacloud.component.compute.network-select.switch_none }}** в поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, вы не сможете обращаться к виртуальной машине из интернета.

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `sftp-server`.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Создание виртуальной машины может занять несколько минут. 

## Настройте SFTP-сервер {#config-sftp-server}

Функционал SFTP-сервера включен в стандартную программу SSH, которая поставляется с дистрибутивом Centos 7. Для настройки SFTP-сервера отредактируйте конфигурационный файл `/etc/ssh/sshd_config`:

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-сервера.
1. Откройте конфигурационный файл в редакторе vi. Этот редактор поставляется с дистрибутивом и не требует установки. Если вы не знакомы с этим редактором, то подробности можете узнать в [официальной документации](https://www.vim.org/docs.php).

   ```bash
   sudo vi /etc/ssh/sshd_config
   ```

1. Добавьте следующие строчки в конец файла:

   ```text
   Match User fuser
   ForceCommand internal-sftp
   PasswordAuthentication no
   ChrootDirectory /var/sftp
   PermitTunnel no
   AllowAgentForwarding no
   AllowTcpForwarding no
   X11Forwarding no
   ```

   Где:

   * `Match User fuser` — указывает на то, что все последующие строчки будут применены только при подключении пользователя `fuser`.
   * `ForceCommand internal-sftp` — подключает пользователя только в режиме SFTP и не разрешает доступ в shell.
   * `PasswordAuthentication no` — отключает доступ по логину и паролю.
   * `ChrootDirectory /var/sftp` — ограничивает доступ пользователя только папкой `/var/sftp`.
   * `PermitTunnel no`, `AllowAgentForwarding no`, `AllowTcpForwarding no`, `X11Forwarding no` — отключает туннелирование, проброс портов и графических приложений через SSH-сессию.

1. Сохраните файл.
1. Выведите конфигурационный файл без закомментированных и пустых строк:

    ```bash
    sudo cat /etc/ssh/sshd_config | grep -v -e '^#' -e '^$'
    ```

1. Убедитесь, что вывод предыдущей команды совпадает с данными строками:

   ```text
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

1. Перезагрузите SFTP-сервер, чтобы настройки вступили в силу:

   ```bash
   sudo systemctl restart sshd
   ```

   После перезагрузки заново [зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-сервера.

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

1. Установите разрешения на папки таким образом, чтобы все пользователи, входящие в состав группы `ftpusers`, могли записывать и читать файлы на SFTP-сервере:

   ```bash
   sudo chown root:ftpusers /var/sftp/backups
   sudo chmod 770 /var/sftp/backups
   ```

1. Проверьте корректность установленных разрешений:

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

На виртуальной машине SFTP-сервера:

1. Создайте SFTP-пользователя, например `fuser`:

   ```bash
   sudo useradd fuser
   ```

1. Создайте пароль для SFTP-пользователя:

   ```bash
   sudo passwd fuser
   ```

1. Создайте SSH-ключи для пользователя `fuser`. Команда `ssh-keygen` выполняется от имени пользователя `fuser`:

   ```bash
   sudo runuser -l  fuser -c 'ssh-keygen'
   ```

   Процесс генерации ключа приведен ниже. Поле `passphrase` оставьте пустым.

   ```text
   Generating public/private rsa key pair.
   Enter file in which to save the key (/home/fuser/.ssh/id_rsa): 
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

1. Создайте файл для сохранения публичных SSH-ключей SFTP-клиента. Установите нужные разрешения: 

   ```bash
   sudo touch /home/fuser/.ssh/authorized_keys
   sudo chmod 600 /home/fuser/.ssh/authorized_keys
   sudo chown fuser:fuser /home/fuser/.ssh/authorized_keys
   ```

1. Убедитесь, что разрешения установлены верно:

   ```bash
   ls -la /home/fuser/.ssh/
   ```

   Результат:

   ```bash
   -rw-------. 1 fuser fuser  421 Aug  7 08:31 authorized_keys
   -rw-------. 1 fuser fuser  419 Aug  7 08:29 id_ed25519
   -rw-r--r--. 1 fuser fuser  107 Aug  7 08:29 id_ed25519.pub
   ```

1. Добавьте SFTP-пользователя в SFTP-группу:

   ```bash
   sudo usermod -G ftpusers fuser
   ```

## Создайте и настройте виртуальную машину для SFTP-клиента {#create-vm-sftp-client}

Процесс создания виртуальной машины для SFTP-клиента полностью совпадает с созданием виртуальной машины для SFTP-сервера. 

1. Выполните пункты 1-11 из раздела о [создании виртуальной машины для SFTP-сервера](#create-vm-sftp-server) (в качестве имени машины укажите `sftp-client`).

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-клиента.
1. Создайте пару SSH-ключей на SFTP-клиенте. Процесс аналогичен описанному для пользователя `fuser` в [предыдущем разделе](#create-sftp-user):

   ```bash
   ssh-keygen
   ```

1. Выведите публичный ключ на экране SFTP-клиента:

   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-сервера.
1. Откройте файл `/home/fuser/.ssh/authorized_keys`: 

   ```bash
   sudo vi /home/fuser/.ssh/authorized_keys
   ```

1. Скопируйте SSH-ключ, полученный на SFTP-клиенте, в конец файла.
1. Сохраните файл.
1. Убедитесь, что виртуальная машина SFTP-клиента доступна с SFTP-сервера, и наоборот:

   1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-сервера.
   1. Найдите публичный или внутренний IP-адрес SFTP-клиента в консоли {{ yandex-cloud }} в разделе настроек виртуальной машины. 

      {% note warning %}

      Внутренние адреса SFTP-клиента и SFTP-сервера должны находиться в одной подсети или быть связаны через настройки маршрутизации.

      {% endnote %}

   1. Введите команду в терминале SFTP-сервера, подставив соответствующее значение:

      ```bash
      ping -с 3 <IP_адрес_SFTP_клиента>
      ```

   1. Убедитесь, что пакеты отправляются и получаются успешно: 

      ```bash
      ping -с 3 84.201.170.171
      ```

      Результат:

      ```bash
      PING 84.201.170.171 (84.201.170.171) 56(84) bytes of data.
      64 bytes from 84.201.170.171: icmp_seq=1 ttl=55 time=8.59 ms
      64 bytes from 84.201.170.171: icmp_seq=2 ttl=55 time=6.32 ms
      64 bytes from 84.201.170.171: icmp_seq=3 ttl=55 time=5.95 ms

      --- 84.201.170.171 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 2003ms
      rtt min/avg/max/mdev = 5.955/6.959/8.595/1.168 ms
      ```

   1. Повторите проверку на SFTP-клиенте, подставив в команду IP-адрес SFTP-сервера.

## Создайте резервную копию конфигурационных файлов на SFTP-сервере {#backup}

В инструкции рассмотрено резервное копирование конфигурационных файлов (с расширением `.conf`) из папки `/etc`. 

Процесс резервного копирования:

1. Упакуйте все нужные конфигурационные файлы в архив.
1. Передайте архив на SFTP-сервер.
1. Удалите архив на SFTP-клиенте. 

Чтобы настроить процесс резервного копирования:

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-клиента.
1. Задайте переменные окружения для корректной работы скрипта. Для этого откройте файл `~/.bash_profile`:

   ```bash
   vi ~/.bash_profile
   ```

1. Добавьте следующие строчки в конец файла, подставив нужные значения:

   ```bash
   export SFTP_SERVER=<IP_адрес_SFTP_сервера>
   export SFTP_USER='fuser'
   ```

1. Примените настройки:

   ```bash
   source ~/.bash_profile
   ```

1. Убедитесь, что эти переменные появились:

   ```bash
   env | grep SFTP
   ```

   Результат:

   ```text
   SFTP_USER=fuser
   SFTP_SERVER=10.128.0.5
   ```

1. Запакуйте все конфигурационные файлы в один архив:

   ```bash
   sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -
   ```

   Где:

   * `sudo find /etc -type f -name *.conf -print0` — поиск всех файлов `.conf` из папки `/etc`.
   * `sudo tar -czf backup.tar.gz --null -T -` — перемещение конфигурационных файлов в архив `backup.tar.gz`.

1. Перешлите полученный архив на SFTP-сервер:

   ```bash
   curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER:
   ```

   Где:

   * `-T` — загружает файл `backup.tar.gz` на удаленный сервер.
   * `$SFTP_SERVER` — переменная, которая автоматически принимает значение IP-адреса SFTP-сервера.
   * `backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz` — добавляет к названию архива название компьютера, а также дату и время, когда был создан архив. Это позволит не потеряться в навигации по списку резервных копий на сервере.

     Например, имя архива на сервере может выглядеть так: `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz`. 

   * `--insecure` — отключает проверку SSL сертификатов со стороны SFTP-сервера. При этом трафик в рамках SSH-сессии все равно шифруется.
   * `$SFTP_USER` — переменная, которая автоматически принимает значение SFTP-пользователя.
   * `:` — пустой пароль. Пароль не будет запрошен.

1. Удалите архив на SFTP-клиенте:

   ```bash
   sudo rm -f backup.tar.gz
   ```

Все действия для создания резервной копии можно выполнить одной командой в терминале SFTP-клиента:

```bash
sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
```

## Проверьте работоспособность резервного копирования {#check-backup}

Чтобы убедиться в том, что резервная копия создается нужным образом, запустите копирование и найдите копию на сервере:

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-клиента и запустите команду для резервного копирования:

   ```bash
   sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
   ```

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-сервера и убедитесь, что файл вида `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz` появился в домашнем каталоге SFTP-пользователя. Для этого на SFTP-сервере запустите команду:

   ```bash
   sudo ls /var/sftp/backups
   ```

## Настройте расписание для резервного копирования {#schedule}

Для создания регулярных резервных копий ваших настроек можно использовать встроенную программу `crontab`.

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-клиента и откройте файл `crontab` для редактирования:

   ```bash
   crontab -e
   ```

1. Добавьте следующие строки, чтобы запускать резервное копирование каждый день в 11 часов вечера по UTC:

   ```text
   SFTP_SERVER=<IP_адрес_SFTP_сервера>
   SFTP_USER='fuser'

   0 23 * * * sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+\%Y\%m\%d_\%H\%M\%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
   ```

   * На виртуальной машине по умолчанию время UTC. Учитывайте разницу с вашим локальным временем при настройке расписания.
   * В команде, вносимой в crontab, необходимо экранировать все `%` при помощи `\`.


## Восстановите настройки из резервной копии {#restore}

Процесс восстановления настроек:

1. Скачайте резервную копию с SFTP-сервера на SFTP-клиент.
1. Распакуйте архив.
1. Скопируйте конфигурационные файлы из архива в систему.
1. Удалите архив. 

Чтобы восстановить настройки из резервной копии:

1. На SFTP-сервере в папке `/var/sftp/backups` выберите резервную копию, из которой следует восстановить конфигурационные файлы. Например, это будет `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz`.

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на виртуальную машину SFTP-клиента.
1. Задайте переменную окружения для названия файла резервной копии:

   ```bash
   SFTP_BACKUP='backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz'
   ```

1. Скачайте эту резервную копию с SFTP-сервера:

   ```bash
   sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP .
   ```

1. Распакуйте архив:

   ```bash
   tar -xzf $SFTP_BACKUP
   ```

1. Скопируйте конфигурационные файлы из архива в систему. Используйте `yes` в команде, чтобы не вводить подтверждение при перезаписи файлов:

   ```bash
   yes | sudo cp -rfp etc / 
   ```

1. Удалите архив и распакованное содержимое:

   ```bash
   rm -f $SFTP_BACKUP
   rm -rfd etc
   ```

Все действия для восстановления из резервной копии можно выполнить одной командой в терминале SFTP-клиента:

```bash
sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP . && tar -xzf $SFTP_BACKUP && yes | sudo cp -rfp etc / && rm -rfd etc && rm -f $SFTP_BACKUP
```

## Проверьте корректность восстановления {#check-restore}
  
На виртуальной машине SFTP-клиента:

1. Чтобы проверить, что конфигурационные файлы из архива успешно попадают в файловую систему, добавьте проверочный блок в команду, полученную выше:

   ```bash
   sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP . && tar -xzf $SFTP_BACKUP && echo "## this is from backup" >> etc/yum.conf && yes | sudo cp -rfp etc / && rm -rfd etc && rm -f $SFTP_BACKUP
   ```

   Команда `echo "## this is from backup" >> etc/yum.conf` записывает тестовую фразу "## this is from backup" в конец файла `etc/yum.conf`, распакованного из архива.

1. После восстановления из резервной копии выполните следующую команду:

   ```bash
   cat /etc/yum.conf | grep backup
   ```

1. Убедитесь, что на экране отображается тестовая фраза:

   ```bash
   ## this is from backup
   ```

## Как удалить созданные ресурсы {#cleanup}

Если вам больше не нужны SFTP-сервер и SFTP-клиент:

* [Удалите виртуальные машины](../../compute/operations/vm-control/vm-delete.md) для SFTP-клиента и SFTP-сервера (в примере они названы `sftp-server` и `sftp-client`).
* [Удалите статический IP-адрес](../../vpc/operations/address-delete.md), если он был вами зарезервирован.
