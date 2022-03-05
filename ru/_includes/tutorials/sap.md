Вы научитесь настраивать сервер с установленной средой SAP и напишете первую программу. В ней будет реализована выгрузка существующих в системе пользователей в виде таблицы.

Чтобы создать SAP-программу в {{ yandex-cloud }}:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте ВМ для SAP](#vm-sap).
1. [Подготовьте файловую систему ВМ](#fs-settings).
1. [Подготовьте конфигурацию установки](#install-config).
1. [Установите SAP](#sap-install).
1. [Настройте SAP](#sap-settings).
1. [Проверьте работу программы](#sap-app).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Перед тем, как разворачивать сервер с SAP, зарегистрируйтесь в {{ yandex-cloud }} и создайте платежный аккаунт:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша ВМ, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость установки SAP входят:
* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте ВМ для SAP {#vm-sap}

Создайте ВМ с публичным адресом:

{% list tabs %}

- Консоль управления

    1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.

    1. В поле **Имя** введите имя виртуальной машины: `vhcalnplci`. На этот hostname завязан скрипт установки SAP.

    1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
    
    1. В блоке **Выбор образа/загрузочного диска** выберите образ операционной системы [SLES for SAP 15 SP2](https://cloud.yandex.ru/marketplace/products/yc/sles-for-sap-15-sp2).
    
    1. В блоке **Диски** выберите тип загрузочного диска `SSD` и укажите размер — 40 ГБ.
    
    1. Нажмите **Добавить диск**, чтобы добавить дополнительный диск.
        1. Задайте имя диска.
        1. Выберите тип `HDD`.
        1. Укажите размер — 90 ГБ.
        1. Нажмите **Добавить**.

    1. В блоке **Вычислительные ресурсы**:
        * Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Ice Lake.
        * Укажите необходимое количество vCPU и объем RAM:
            * **vCPU** — 2.
            * **Гарантированная доля vCPU** — 100%.
            * **RAM** — 8 ГБ.
    
    1. В блоке **Сетевые настройки**:
       * Укажите идентификатор подсети или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка. 
           
           Если сети нет, нажмите **Создать сеть** и создайте ее:
           * В открывшемся окне укажите имя сети и каталог, в котором она будет создана.
           * Вы можете выбрать функцию **Создать подсети** для автоматического создания подсетей.
           * Нажмите **Создать**.

           У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **Добавить подсеть**.          
       * В поле **Публичный адрес** выберите способ назначения адреса **Автоматически**.
    
    1. В блоке **Доступ** укажите данные для доступа на виртуальную машину: 
        * В поле **Логин** введите имя пользователя.
        * В поле **SSH-ключ** введите открытую часть SSH-ключа. Создать пару ключей SSH для подключения к виртуальной машине можно по [инструкции](../../compute/operations/vm-connect/ssh#creating-ssh-keys).

    1. Нажмите **Создать ВМ**.

 {% endlist %} 

## Подготовьте файловую систему ВМ {#fs-settings}

Подготовьте файловую структуру созданной ВМ к установке SAP.

1. [Подключитесь по протоколу SSH](../../compute/operations/vm-connect/ssh#vm-connect) к созданной виртуальной машине с помощью [PuTTY](https://www.putty.org/).

1. Переключитесь в режим root, чтобы получить привилегии суперпользователя:
    ```bash
    sudo su
    ```

1. Посмотрите список всех дисков:
    ```bash
    lsblk
    ```
    Результат:
    ```bash
    vda    254:0    0  40G  0 disk
    ├─vda1 254:1    0   4M  0 part
    └─vda2 254:2    0  40G  0 part /
    vdb    254:16   0  90G  0 disk
    ```  
    Где: 
    * `vda` — загрузочный диск.
    * `vdb` — диск для данных.

1. Создайте на диске для данных (`vdb`) два раздела: 20 ГБ под дистрибутив и 70 ГБ под SAP. 
    1. Чтобы управлять разделами жесткого диска, запустите утилиту `fdisk`:
        ```bash
        fdisk /dev/vdb
        ```
        Если при вызове утилиты `fdisk` появляется ошибка `command not found`, добавьте `fdisk` в `Path`:
        ```bash
        PATH=/sbin:$PATH
        ```
    1. Чтобы добавить первый раздел, введите команду `n` и нажмите **Enter**.
    1. Чтобы выбрать тип по умолчанию `primary`, нажмите **Enter**.
    1. Чтобы выбрать номер по умолчанию `1`, нажмите **Enter**.
    1. Чтобы выбрать первый сектор по умолчанию `2048`, нажмите **Enter**.
    1. Укажите размер `+20G` и нажмите **Enter**.
    1. Добавьте второй раздел аналогичным образом. Не указывайте его размер на последнем шаге. По умолчанию он займет все оставшееся пространство — 70 ГБ.
    1. Чтобы сохранить созданные разделы, введите команду `w` и **нажмите** Enter.

        Результат:
        ```bash
        Welcome to fdisk (util-linux 2.33.1).
        Changes will remain in memory only, until you decide to write them.
        Be careful before using the write command.

        Device does not contain a recognized partition table.
        Created a new DOS disklabel with disk identifier 0xb58ce40a.

        Command (m for help): n
        Partition type
        p   primary (0 primary, 0 extended, 4 free)
        e   extended (container for logical partitions)
        Select (default p):

        Using default response p.
        Partition number (1-4, default 1):
        First sector (2048-182452223, default 2048):
        Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-182452223, default 182452223): +20G

        Created a new partition 1 of type 'Linux' and of size 20 GiB.

        Command (m for help): n
        Partition type
        p   primary (1 primary, 0 extended, 3 free)
        e   extended (container for logical partitions)
        Select (default p):

        Using default response p.
        Partition number (2-4, default 2):
        First sector (41945088-182452223, default 41945088):
        Last sector, +/-sectors or +/-size{K,M,G,T,P} (41945088-182452223, default 182452223):

        Created a new partition 2 of type 'Linux' and of size 70 GiB.

        Command (m for help): w
        The partition table has been altered.
        Calling ioctl() to re-read partition table.
        Syncing disks.
        ```
    1. Проверьте структуру дисков:
        ```bash
        lsblk
        ```    
        Результат:

        ```bash        
        NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
        vda    254:0    0  40G  0 disk
        ├─vda1 254:1    0   4M  0 part
        └─vda2 254:2    0  40G  0 part /
        vdb    254:16   0  90G  0 disk
        ├─vdb1 254:17   0  20G  0 part
        └─vdb2 254:18   0  70G  0 part
        ```

1. Настройте на разделах `vdb1` и `vdb2` файловую систему `ext4`:
    ```bash
    mkfs.ext4 /dev/vdb1
    mkfs.ext4 /dev/vdb2
    ```
    Результат:
    ```bash
    mke2fs 1.43.8 (1-Jan-2018)
    Creating filesystem with 5242880 4k blocks and 1310720 inodes
    Filesystem UUID: e878b21b-da84-42f9-ba9f-b6ad3c6edab6
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
            4096000

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (32768 blocks): done
    Writing superblocks and filesystem accounting information: done

    ...

    mke2fs 1.43.8 (1-Jan-2018)
    Creating filesystem with 17563392 4k blocks and 4390912 inodes
    Filesystem UUID: 14be2468-6a99-4178-a77b-26096c3fcad4
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
            4096000, 7962624, 11239424

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (131072 blocks): done
    Writing superblocks and filesystem accounting information: done
    ```

1. Создайте директории под дистрибутив и SAP Application Server. Примонтируйте к ним разделы `vdb1` и `vdb2`:
    ```bash
    mkdir /usr/sap
    mkdir /distr
    mount /dev/vdb1 /distr
    mount /dev/vdb2 /usr/sap
    ```

1. Чтобы монтирование восстанавливалось при перезагрузке, отредактируйте файл `/etc/fstab`:
    ```bash
    vi /etc/fstab
    ```
    Приведите его к виду:
    ```bash
    LABEL=ROOT  /  xfs  defaults  0  1
    /dev/vdb1 /distr ext4 defaults 1 1
    /dev/vdb2 /usr/sap ext4 defaults 1 1
    ```

## Настройте параметры установки {#install-config}

Добавьте установочные файлы SAP на виртуальную машину и настройте конфигурацию для дальнейшей инсталляции.

1. Скачайте 11 архивов с установочными файлами [SAP NetWeaver AS ABAP Developer Edition 7.52 SP04](https://developers.sap.com/trials-downloads.html) и извлеките их содержимое в одну папку на локальном компьютере. 

1. Сохраните текущую сессию подключения к виртуальной машине в PuTTY. Название можно указать любое.

1. Установите и запустите программу [WinSCP](https://winscp.net/eng/download.php).

1. Импортируйте в WinSCP настройки из сохраненной сессии в PuTTY.
    1. В окне `Login` нажмите **Tools**.
    1. Выберите **Import Sites**.
    1. В поле `Import from` выберите **PuTTY** и отметьте сохраненную ранее сессию. 

1. Подключитесь к виртуальной машине через WinSCP.
    1. Выберите сессию, импортированную из PuTTY.
    1. Нажмите **Login**.
    1. Введите имя пользователя на ВМ.

1. Импортируйте в каталог `/distr` на виртуальной машине установочные файлы SAP, которые вы извлекли из загруженных ранее архивов.
    1. В левом окне откройте папку с извлеченными файлами SAP.
    1. Выделите их и нажмите **Upload**.
    1. Укажите каталог для импорта — `/distr/*.*` на виртуальной машине. 

    Для импорта файлов нужно быть владельцем каталога `/distr`. Другой вариант — подключиться через WinSCP как пользователь с root-правами или [настроить использование sudo при входе в систему](https://winscp.net/eng/docs/faq_su).

1. На виртуальной машине установите и запустите UUIDD. Это демон [UUID](https://datatracker.ietf.org/doc/html/rfc4122) — universally unique identifiers. Он требуется для работы SAP:
    ```bash
    zypper install uuidd
    service uuidd start
    ```

1. Проверьте наличие библиотек `libaio` и `libaio1`:
    ```bash
    rpm -qa | grep libaio
    rpm -qa | grep libaio1
    ```
    В ответе будут указаны версии библиотек, которые предустановлены на дистрибутиве.

1. Узнайте внутренний IP-адрес виртуальной машины:
    ```bash
    ip addr show
    ```
    Результат:
    ```bash    
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
        valid_lft forever preferred_lft forever
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        link/ether d0:0d:11:31:ee:a6 brd ff:ff:ff:ff:ff:ff
        inet 10.0.0.29/24 brd 10.0.0.255 scope global eth0
        valid_lft forever preferred_lft forever
        inet6 fe80::d20d:11ff:fe31:eea6/64 scope link
        valid_lft forever preferred_lft forever
    ```
    
1. Добавьте внутренний IP-адрес в файл `/etc/hosts`.
    1. Откройте файл:
        ```bash
        vi /etc/hosts
        ```
    1. Добавьте в него строку вида: 
        ```
        <inet> vhcalnplci vhcalnplci.ru-central1.internal. 
        ```
        Используйте значение `inet` из блока `eth0`.

        Результат:
        ```
        127.0.0.1 localhost
        10.0.0.29 vhcalnplci vhcalnplci.ru-central1.internal 
        ```

1. Проверьте имя хоста:
    ```bash
    hostname
    ```
    Результат:
    ```bash
    vhcalnplci
    ```

## Установите SAP {#sap-install}

1. Измените разрешения на папку с установочными файлами SAP:   
    ```bash
    chmod -R 777 /distr
    ```

1. Перейдите в каталог `/distr`:
    ```bash
    cd /distr
    ```

1. Запустите скрипт для установки SAP:
    ```bash
    ./install.sh
    ```

1. Согласитесь с условиями лицензионного соглашения.

1. Задайте мастер-пароль для пользователей, которые будут созданы при установке SAP.
    
    Требования к паролю:
    * Не менее 7 символов на латинице.
    * Содержит заглавные буквы и цифры.
    * Не используются специальные символы.

1. Дождитесь завершения установки.

    При установке может появиться сообщение об ошибке:

    ```bash
    Abort execution because of Step returns modlib.jslib.caughtException 
    Error: sapinst has finished with an error code, please find logs in /tmp/sapinst_instdir
    Error code: 20
    ```

    Ошибка связана с истекшим сроком лицензии. Чтобы устранить ее:
    1. Скачайте файл `SAP ABAP AS Part License` для SAP NetWeaver AS ABAP Developer Edition 7.52 SP04 с [официального сайта](https://developers.sap.com/trials-downloads.html).
    1. Распакуйте его и перенести в директорию `server/TAR/x86_64/` на виртуальной машине. Можно сделать это с помощью программы WinSCP.
    1. Заново запустите файл `./install.sh`, чтобы установить SAP.


## Запустите и настройте SAP {#sap-settings}

1. Установите на компьютер фронтенд-клиент [SAP Logon](https://help.sap.com/doc/2e5792a2569b403da415080f35f8bbf6/760.04/en-US/sap_frontend_inst_guide.pdf).

1. Запустите SAP Logon и настройте подключение к виртуальной машине.
    * **Application Server** — публичный IPv4-адрес.
    * **Instance number** — `00`.
    * **System ID** — `NPL`.

    После входа в SAP в левой части экрана вы увидите меню пользователя [SAP Easy Access](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/cb11a43814a54af19c4bcf0221c24eb7.html). Это специфичная для пользователя точка входа. Меню пользователя содержит только те элементы, которые необходимы для выполнения ежедневных задач. 

    Настройка SAP выполняется через [коды транзакций](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/f9/e1a442dc030e31e10000000a1550b0/frameset.htm). Они связаны с функциями в системе SAP. Коды транзакций необходимо вводить в [командной строке SAP](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/f735dd776e724195b5562592a5e88b45.html). Для быстрого доступа можно добавить их в [закладки](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/1e10a82969594103a99e1f7962b205b0.html).

1. Поменяйте стандартные пароли в целях безопасности.
   1. Через интерфейс SAP Easy Access запустите транзакцию `SU01`.
   1. Перейдите в раздел `Logon Data`.
   1. Выберите пользователя, пароль которого хотите изменить.
   1. Введите новый пароль.

### Обновите лицензию {#sap-license}

Чтобы продолжить работу с SAP, необходимо обновить лицензию.

1. Через интерфейс SAP Easy Access запустите транзакцию `SLICENSE`.
1. Скопируйте значение поля `Active Hardware Key`.
1. Откройте [страницу SAP с лицензионными ключами](https://go.support.sap.com/minisap/#/minisap).
1. Выберите пункт `NPL — SAP NetWeaver 7.x (Sybase ASE)`.
1. Укажите, как к вам обращаться. Впишите имя, фамилию, e-mail и значение `Active Hardware Key`, которое скопировали ранее.
1. Примите условия лицензионного соглашения и скачайте файл с лицензией `NPL.tx`.
1. Перенесите скачанный файл с лицензией на виртуальную машину и добавьте в транзакцию `SLICENSE`.

## Создайте первую программу {#sap-app}

Чтобы проверить работоспособность системы, создайте простую программу, которая будет выгружать список пользователей. 

1. Авторизуйтесь под учетной записью `DEVELOPER`.
1. Запустите транзакцию `SE38`. Это программа `ABAP Editor`.
1. Назовите программу `ZTEST`.
1. Добавьте код:

    ```
    TYPE-POOLS: slis.
  
    *&---------------------------------------------------------------------*

    *& Data Declaration

    *&---------------------------------------------------------------------*

    DATA: it_usr01     TYPE TABLE OF USR01.
    DATA: it_fieldcat  TYPE slis_t_fieldcat_alv,
        wa_fieldcat  TYPE slis_fieldcat_alv.`

    *&---------------------------------------------------------------------*

    *& START-OF-SELECTION`

    *&---------------------------------------------------------------------*

    START-OF-SELECTION.
    *Fetch data from the database
    SELECT * FROM USR01 INTO TABLE it_usr01.
    
    *Build field catalog
    wa_fieldcat-fieldname  = 'MANDT'.    
    wa_fieldcat-seltext_m  = 'MANDT'.  
    APPEND wa_fieldcat TO it_fieldcat.

    wa_fieldcat-fieldname  = 'BNAME'.
    wa_fieldcat-seltext_m  = 'USER'.
    APPEND wa_fieldcat TO it_fieldcat.

    * display ALV list
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
        it_fieldcat   = it_fieldcat
        TABLES
        t_outtab      = it_usr01
        EXCEPTIONS
        program_error = 1
        OTHERS        = 2

    ```
    Результат:
    ```    
    | MANDT| USER        |
    | -----| ----------- |
    | 001  | BWDEVELOPER |
    | 001  | DDIC        |
    | 001  | DEVELOPER   |
    | 001  | SAP*        |
    ```


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите ВМ](../../compute/operations/vm-control/vm-delete.md);
* [удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md), если вы его зарезервировали специально для этого проекта.
