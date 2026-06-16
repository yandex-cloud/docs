# Арендовать сервер в готовой конфигурации

Вы можете арендовать [сервер BareMetal](../../concepts/servers.md) в одной из [готовых конфигураций](../../concepts/server-configurations.md#standard).

Если же ваша задача требует от сервера каких-то нетиповых аппаратных характеристик, вы можете сами [сконфигурировать](custom-server-lease.md) ваш сервер.

Чтобы арендовать сервер в стандартной конфигурации:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите арендовать сервер.
  1. Перейдите в сервис **BareMetal**.
  1. Нажмите кнопку **Заказать сервер** и в открывшемся окне выберите вариант `Готовые конфигурации` и подходящую [конфигурацию](../../concepts/server-configurations.md) сервера BareMetal.
     
     Чтобы выбрать подходящую вам конфигурацию сервера, нажмите на блок с именем этой конфигурации в центральной части экрана.
     
     {% note info %}
     
     Чтобы быстрее подобрать подходящую конфигурацию, вы можете воспользоваться фильтром с аппаратными характеристиками конфигураций в правой части экрана.
     
     {% endnote %}
     
     {% note tip %}
     
     Вы можете снизить стоимость аренды сервера в некоторых конфигурациях, заказав его [сборку](../../concepts/server-custom-configurations.md#assembly).
     
     Чтобы воспользоваться скидкой, в блоке с нужной конфигурацией наведите курсор на **Дешевле со сборкой** ![circle-info.svg](../../../_assets/console-icons/circle-info.svg) и во всплывающем окне нажмите ![person-nut-hex.svg](../../../_assets/console-icons/person-nut-hex.svg) **Перейти к сборке**.
     
     При заказе сервера со сборкой воспользуйтесь приведенной ниже инструкцией, чтобы задать необходимые параметры сервера. При этом сервер станет доступен вам не сразу, а после завершения сборки (в течение четырех календарных дней) и по более низкой цене.
     
     {% endnote %}
  1. В открывшемся окне с настройками конфигурации сервера:

      1. В блоках **Конфигурация**, **Расположение** и **Условия аренды** убедитесь, что параметры выбранной конфигурации сервера соответствуют вашим потребностям.
         
         Если выбранные параметры вам не подходят, нажмите значок ![arrow-left](../../../_assets/console-icons/arrow-left.svg) в блоке **Конфигурация**, чтобы вернуться к выбору конфигурации.
      1. В поле **Период аренды** выберите [период](../../concepts/servers.md#server-lease), на который вы хотите арендовать сервер: `1 день`, `1 месяц`, `3 месяца`, `6 месяцев` или `1 год`.
         
         По окончании указанного периода аренда сервера будет автоматически продлена на такой же период. Прервать аренду в течение указанного периода аренды нельзя, но можно [отказаться](server-lease-cancel.md) от дальнейшего продления аренды сервера.
      1. В поле **Количество серверов** выберите количество серверов данной конфигурации, которое вы хотите арендовать.
      1. В блоке **Образ** выберите:
         
         * `Marketplace` — чтобы установить на сервер один из доступных [публичных образов](../../concepts/images.md#marketplace-images) ОС в Yandex Cloud Marketplace.
         * `Без операционной системы` — чтобы арендовать сервер без операционной системы.
         
             [Установить](reinstall-os-from-own-image.md) операционную систему из [собственного ISO-образа](../../concepts/images.md#user-images) вы сможете позднее.
      1. (Опционально) В блоке **Диск** настройте разметку [дисков](../../concepts/disks/disk-types.md):
         
         1. Нажмите кнопку **Настроить разделы диска**.
         1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![icon](../../../_assets/console-icons/plus.svg) **Добавить раздел**.
         
             Чтобы самостоятельно собрать [RAID](../../concepts/disks/raid.md)-массивы и настроить разделы дисков, нажмите кнопку **Разобрать RAID**.
         1. Нажмите кнопку **Сохранить**.
      1. В блоке **Сетевые интерфейсы** в разделе **Интерфейс 1** выберите [приватную подсеть](../../concepts/private-network.md#private-subnet) в той [зоне доступности](../../../overview/concepts/geo-scope.md), в которой вы арендуете сервер.
         
         Если в зоне доступности арендуемого сервера еще нет приватной подсети или вы хотите создать новую приватную подсеть, нажмите кнопку **Создать** и в открывшемся окне задайте параметры подсети по инструкции [Создать приватную подсеть](../subnet-create.md).
      1. В блоке **Сетевые интерфейсы** в разделе **Интерфейс 2**:
         
         * В поле **Публичный адрес** выберите способ назначения публичного адреса:
         
             * `Из эфемерной подсети` — чтобы назначить случайный IP-адрес. Если необходимо получить IP-адрес при создании сервера через запрос к DHCP-серверу, включите опцию **Назначить по DHCP**.
         
             * `Из выделенной подсети` — чтобы назначить IP-адрес из диапазона адресов [выделенной публичной подсети](../../concepts/public-network.md#public-subnet).
             
                 В появившемся поле выберите публичную подсеть или нажмите кнопку **Заказать**, чтобы [заказать](../reserve-public-subnet.md) новую.
             
                 {% note warning %}
             
                 В выделенной публичной подсети [отсутствует](../../concepts/dhcp.md#dhcp-public-subnet) DHCP-сервер, поэтому на сетевом интерфейсе сервера, подключенного к такой подсети, необходимо вручную настраивать статический IP-адрес из диапазона публичных IP-адресов, доступных в выбранной публичной подсети, а также задать адрес шлюза по умолчанию.
             
                 {% endnote %}
         
             * `Без адреса` — чтобы не назначать публичный IP-адрес.
         
         * В поле **Объём данных** выберите пакет [потребления трафика сервера](../../concepts/network-restrictions.md#bandwidth-for-pubic-network). Доступные пакеты потребления трафика:
           
           * `10 ТБ в сутки, ёмкость подключения — 1 Гбит/с`;
           * `100 ТБ в сутки, ёмкость подключения — 10 Гбит/с`.
           
           {% note info %}
           
           Возможность выбора пакетов трафика доступна только для конфигураций с публичным IP-адресом и с сетевыми картами со скоростью соединения 10 Гбит/с и выше.
           
           Уменьшить емкость подключения до 10 ТБ в сутки можно будет не раньше, чем через 24 часа после начала аренды сервера.
           
           {% endnote %}
      1. Если вы устанавливаете на сервер операционную систему из публичного образа в Marketplace, в блоке **Доступ** задайте параметры доступа к серверу:

          1. В поле **Пароль** воспользуйтесь одним из вариантов создания пароля для root-пользователя:
          
              * Чтобы сгенерировать пароль для root-пользователя, выберите опцию `Новый пароль` и нажмите кнопку **Сгенерировать**.
          
                  {% note warning %}
                  
                  Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в Yandex Cloud, и после заказа сервера вы не сможете посмотреть его.
                  
                  {% endnote %}
          
              * Чтобы использовать пароль root-пользователя, сохраненный в [секрете](../../../lockbox/concepts/secret.md) Yandex Lockbox, выберите опцию `Секрет Lockbox`:
          
                  В полях **Имя**, **Версия** и **Ключ** выберите соответственно секрет, его версию и ключ, в которых сохранен ваш пароль.
                  
                  Если у вас еще нет секрета Yandex Lockbox, нажмите кнопку **Создать**, чтобы создать его.
          
                  Этот вариант позволяет вам как задать собственный пароль (тип секрета `Пользовательский`), так и использовать пароль, сгенерированный автоматически (тип секрета `Генерируемый`).
          
          1. В поле **Открытый SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
          
              Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
              
              1. Нажмите кнопку **Добавить ключ**.
              1. Задайте имя SSH-ключа.
              1. Выберите вариант:
              
                  * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                  * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                  * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
                  
                    При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
              
              1. Нажмите кнопку **Добавить**.
              
              SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

      1. (Опционально) Включите резервное копирование сервера в [Yandex Cloud Backup](../../../backup/index.md):

          1. Включите опцию **Резервное копирование**.
          1. Выберите [политику резервного копирования](../../../backup/concepts/policy.md) или [создайте](../../../backup/operations/policy-vm/create.md) новую.
          1. Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с назначенными ролями [`baremetal.editor`](../../security/index.md#baremetal-editor) и [`backup.user`](../../../backup/security/index.md#backup-user) или [создайте](../../../iam/operations/sa/create.md) новый.

          Подробнее в инструкции [Арендовать сервер Yandex BareMetal с подключением к Cloud Backup](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).
      1. В блоке **Информация о сервере**:
         
           1. В поле **Имя** введите имя сервера. Требования к имени:
         
               * длина — от 3 до 63 символов;
               * может содержать строчные буквы латинского алфавита, цифры и дефисы;
               * первый символ — буква, последний — не дефис.
         
           1. (Опционально) В поле **Описание** добавьте описание сервера.
           1. (Опционально) В поле **Метки** задайте [метки](../../../resource-manager/concepts/labels.md).
      1. Нажмите кнопку **Заказать сервер**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для аренды сервера:
     
     ```bash
     yc baremetal server create --help
     ```
  1. Получите список конфигураций:
     
     ```bash
     yc baremetal configuration list
     ```
     
     Примерный результат:
     
     ```text
     +----------------------+---------------------+-----------+--------------------------------+--------------------------------+-------------------------+---------+
     |          ID          |        NAME         | MEMORYGIB |              CPU               |          DISK DRIVES           | NETWORK BМANDWIDTH GBPS | CPU NUM |
     +----------------------+---------------------+-----------+--------------------------------+--------------------------------+-------------------------+---------+
     | ly577w5sepew******** | LA-i108-S-1/10G     |        32 | physical cores: 4, mhz: 2400,  | [ type: SSD count: 2 size_gib: |                      10 |       1 |
     |                      |                     |           | name: Xeon D-1521, vendor:     | 838 ]                          |                         |         |
     |                      |                     |           | Intel                          |                                |                         |         |
     | ly5tdlrmwezt******** | LA-i107-S-1/10G     |        16 | physical cores: 4, mhz: 2400,  | [ type: SSD count: 2 size_gib: |                      10 |       1 |
     |                      |                     |           | name: Xeon D-1521, vendor:     | 838 ]                          |                         |         |
     |                      |                     |           | Intel                          |                                |                         |         |
     | ly527jeaz2nb******** | BA-i202-S           |       128 | physical cores: 8, mhz: 2600,  | [ type: SSD count: 2 size_gib: |                       1 |       2 |
     |                      |                     |           | name: Xeon E5-2650V2, vendor:  | 838 ]                          |                         |         |
     |                      |                     |           | Intel                          |                                |                         |         |
     ...
     ...
     | ly52arjxxbl3******** | LA-i114-S           |        64 | physical cores: 8, mhz: 2200,  | [ type: SSD count: 2 size_gib: |                       1 |       2 |
     |                      |                     |           | name: Xeon E5-2660, vendor:    | 838 ]                          |                         |         |
     |                      |                     |           | Intel                          |                                |                         |         |
     +----------------------+---------------------+-----------+--------------------------------+--------------------------------+-------------------------+---------+
     ```
  1. Получите подробную информацию о конфигурации, указав ее идентификатор или имя:

      ```bash
      yc baremetal configuration get <идентификатор_или_имя_конфигурации>
      ```

      Результат:
      
      ```yaml
      id: ly5tdlrmwezt********
      name: LA-i107-S-1/10G
      memory_gib: "16"
      cpu:
        name: Xeon D-1521
        vendor: Intel
        cores: "8"
        physical_cores: "4"
        frequency_mhz: "2400"
      disk_drives:
        - type: SSD
          disk_count: "2"
          disk_size_gib: "838"
      network_capacity_gbps: "10"
      cpu_num: "1"
      network_interfaces:
      - id: ly5oc5p4u6vg********
        name: iface0
        configuration_id: ly5tdlrmwezt********
        link_speed_gbps: '1'
        available_modes:
        - PRIVATE
      - id: ly5dmh2u3qwe********
        name: iface1
        configuration_id: ly5tdlrmwezt********
        link_speed_gbps: '1'
        available_modes:
        - PUBLIC
        - PRIVATE
      ```

  1. Арендуйте сервер:
     
     ```bash
     yc baremetal server create \
       --hardware-pool-id <пул> \
       --configuration-id <идентификатор_конфигурация> \
       --storage "partition={type=<файловая_система>,size-gib=<размер_раздела>,mount-point=<точка_монтирования>},raid-type=<уровень RAID-массива>,disk={id=<номер_диска>,size-gib=<размер_диска>,type=<тип_диска>}" \
       --os-settings "image-id=<идентификатор_образа>,image-name=<имя_образа>,ssh-key-public=<содержимое_открытого_SSH-ключа>,ssh-key-user-id=<идентификатор_пользователя_SSH-ключа>,password-plain-text=<пароль_пользователя>,password-lockbox-secret={secret-id=<идентификатор_секрета>,version-id=<версия_секрета>,key=<ключ_секрета>}" \
       --rental-period-id <период_аренды> \
       --network-interfaces private-subnet-id=<идентификатор_приватной_подсети> \
       --network-interfaces public-subnet-id=<идентификатор_публичной_подсети> \
       --name <имя_сервера> \
       --description "<описание_сервера>" \
       --labels <ключ_метки>=<значение_метки>
     ```

      Где:
      * `--hardware-pool-id` — [пул](../../concepts/servers.md#server-pools), из которого будет арендован сервер.
      * `--configuration-id` — идентификатор [конфигурации сервера](../../concepts/server-configurations.md).
      * `--storage` — настройки разметки [дисков](../../concepts/disks/disk-types.md). Необязательный параметр. Возможные настройки:
        
        * `partition` — раздел диска:
          
          * `type` — файловая система. Возможные значения: `Ext3`, `Ext4`, `Swap`, `Xfs`.
          * `size-gib` — размер раздела в гигабайтах.
          * `mount-point` — точка монтирования.
        
        * `disk` — диск:
          
          * `id` — номер диска.
          * `size-gib` — размер диска в гигабайтах.
          * `type` — тип диска
        * `raid-type` — [уровень RAID-массива](../../concepts/disks/raid.md#levels).
      * `--os-settings` — настройки операционной системы. Чтобы арендовать сервер без операционной системы, пропустите этот параметр. Возможные настройки:
        
        * `image-id` — идентификатор одного из доступных [публичных образов](../../concepts/images.md#marketplace-images) ОС в Yandex Cloud Marketplace.
        * `image-name` — имя одного из доступных публичных образов ОС в Yandex Cloud Marketplace.
        * `ssh-key-public` — содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к серверу по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
        * `ssh-key-user-id` — идентификатор пользователя SSH-ключа.
        * `password-plain-text` — пароль root-пользователя.
        
          {% note warning %}
          
          Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в Yandex Cloud, и после заказа сервера вы не сможете посмотреть его.
          
          {% endnote %}
        
        * `password-lockbox-secret` — [секрет](../../../lockbox/concepts/secret.md) Yandex Lockbox:
          * `secret-id` — идентификатор секрета.
          * `version-id` — версия секрета.
          * `key` — ключ секрета.

          [Установить](reinstall-os-from-own-image.md) операционную систему из [собственного ISO-образа](../../concepts/images.md#user-images) вы сможете позднее.

      * `--rental-period-id` — период аренды сервера. Возможные значения: `1 day`, `1 month`, `3 months`, `6 months` или `1 year`.

          По окончании указанного периода аренда сервера будет автоматически продлена на такой же период. Прервать аренду в течение указанного периода аренды нельзя, но можно [отказаться](server-lease-cancel.md) от дальнейшего продления аренды сервера.

      * `--network-interfaces` — сетевые настройки:
        
        * `private-subnet-id` — идентификатор [приватной подсети](../../concepts/private-network.md#private-subnet).
        * `public-subnet-id` — идентификатор [выделенной публичной подсети](../../concepts/public-network.md#public-subnet). Необязательный параметр.

          {% note warning %}

          В выделенной публичной подсети [отсутствует](../../concepts/dhcp.md#dhcp-public-subnet) DHCP-сервер, поэтому на сетевом интерфейсе сервера, подключенного к такой подсети, необходимо вручную настраивать статический IP-адрес из диапазона публичных IP-адресов, доступных в выбранной публичной подсети, а также задать адрес шлюза по умолчанию.

          {% endnote %}

      * `--name` — имя сервера.
      * `--description` — описание сервера. Необязательный параметр.
      * `--labels` — метки сервера. Необязательный параметр.

- API {#api}

  Чтобы арендовать сервер, воспользуйтесь методом REST API [create](../../api-ref/Server/create.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/Create](../../api-ref/grpc/Server/create.md).

{% endlist %}

После того как вы арендуете сервер, вы в любой момент сможете установить или переустановить на нем операционную систему из публичного образа в Cloud Marketplace или из собственного ISO-образа. Подробнее в инструкциях [Переустановить операционную систему из образа Marketplace](reinstall-os-from-marketplace.md) и [Переустановить операционную систему из своего ISO-образа](reinstall-os-from-own-image.md).

## Пример {#example}

Арендуйте сервер с публичным образом ОС:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal server create \
    --hardware-pool-id ru-central1-m4 \
    --configuration-id ly5lymxdltk3******** \
    --storage "partition={type=EXT3,size-gib=1000,mount-point=/},partition={type=EXT4,size-gib=500,mount-point=/root},raid-type=RAID0,disk={id=1,size-gib=1862,type=HDD},disk={id=2,size-gib=1862,type=HDD}" \
    --storage "partition={type=EXT3,size-gib=1000,mount-point=/boot},partition={type=SWAP,size-gib=10},disk={id=3,size-gib=1862,type=HDD}" \
    --os-settings "image-id=ly5vhn4lapev********,ssh-key-public=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********,password-lockbox-secret={secret-id=e6qmvglkitn6********,version-id=e6qquvv4kh8e********,key=password}" \
    --rental-period-id 1-day \
    --network-interfaces private-subnet-id=ly5ztavbezrf******** \
    --network-interfaces public-subnet-id=ly5o6l7pxmk2********* \
    --name demo-baremetal-server \
    --description "My first BareMetal server" \
    --labels env=test
  ```

  Результат:
  
  ```text
  done (22m45s)
  id: ly52dtzdi55r********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-baremetal-server
  description: My first BareMetal server
  zone_id: ru-central1-m
  hardware_pool_id: ru-central1-m4
  status: PROVISIONING
  os_settings:
    image_id: ly5vhn4lapev********
    ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
    storages:
      - partitions:
          - type: EXT3
            size_gib: "999"
            mount_point: /
          - type: EXT4
            size_gib: "499"
            mount_point: /root
        raid:
          type: RAID0
          disks:
            - id: ly5ual3jbnhr********
              type: HDD
              size_gib: "1862"
            - id: ly54qfjw55d4********
              type: HDD
              size_gib: "1862"
      - partitions:
          - type: EXT3
            size_gib: "999"
            mount_point: /boot
          - type: SWAP
            size_gib: "9"
        disk:
          id: ly5ojffpngul********
          type: HDD
          size_gib: "1862"
  network_interfaces:
    - id: ly5wbsiklrtd********
      mac_address: 00:25:90:92:fa:48
      private_subnet:
        private_subnet_id: ly5ztavbezrf********
    - id: ly5ygl4loyy6********
      mac_address: 00:25:90:92:fa:49
      public_subnet:
        public_subnet_id: ly5o6l7pxmk2********
  configuration_id: ly5lymxdltk3xitpkrmi
  created_at: "2025-07-06T21:53:46.186130Z"
  labels:
    env: test
  ```

- API {#api}

  ```bash
  curl -X POST \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer <IAM-токен>" \
   -d '{
     "folderId": "b1g07hj5r6i4********",
     "name": "bm-test-server",
     "description": "New Test Baremetal Server",
     "hardwarePoolId": "ru-central1-m3",
     "configurationId": "ly5fcdnlzp7j********",
     "rentalPeriodId": "1-day",
     "networkInterfaces": [
       {
         "privateSubnet": {
           "privateSubnetId": "ly52xefxa2hi********"
         }
       },
       {
         "publicSubnet": {
           "publicSubnetId": "ly52yjugkj57********"
         }
       }
     ],
     "osSettingsSpec": {
       "imageId": "ly5vyzcggvci********",
       "storages": [
         {
           "partitions": [
             {
               "type": "EXT3",
               "sizeGib": "9",
               "mountPoint": "/boot"
             },
             {
               "type": "SWAP",
               "sizeGib": "4"
             },
             {
               "type": "EXT4",
               "mountPoint": "/"
             }
           ],
           "raid": {
             "type": "RAID10",
             "disks": [
               {
                 "id": "1",
                 "type": "HDD",
                 "sizeGib": "1862"
               },
               {
                 "id": "2",
                 "type": "HDD",
                 "sizeGib": "1862"
               },
               {
                 "id": "3",
                 "type": "HDD",
                 "sizeGib": "1862"
               },
               {
                 "id": "4",
                 "type": "HDD",
                 "sizeGib": "1862"
               }
             ]
           }
         }
       ],
       "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0********",
       "passwordLockboxSecret": {
         "secretId": "e6q44i0gmlrh********",
         "versionId": "e6q3ba84ur0a********",
         "key": "password"
       }
     },
     "labels": {
       "key": "bms"
     }
   }' \
   "POST https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>"
  ```

  Где:
  * `folderId` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан сервер.
  * `name` — имя сервера. Имя должно быть уникальным в рамках каталога.

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

  * `description` — описание сервера. Необязательный параметр.
  * `labels` — метки ресурса в формате `ключ:значение`. Необязательный параметр.
  * `hardwarePoolId` — идентификатор [пула](../../concepts/servers.md#server-pools), из которого будет арендован сервер.
  * `configurationId` — идентификатор [конфигурации сервера](../../concepts/server-configurations.md).
  * `rentalPeriodId` — период аренды сервера. Возможные значения: `1-day`, `1-month`, `3-months`, `6-months` или `1-year`.
  * `networkInterfaces[]` — сетевые интерфейсы:
    * `id` — идентификатор сетевого интерфейса. Не указывается при создании сервера.
    * `privateSubnetId` — идентификатор [приватной подсети](../../concepts/private-network.md#private-subnet).
    * `publicSubnetId` — идентификатор [выделенной публичной подсети](../../concepts/public-network.md#public-subnet). Необязательный параметр.

      {% note warning %}

      В выделенной публичной подсети [отсутствует](../../concepts/dhcp.md#dhcp-public-subnet) DHCP-сервер, поэтому на сетевом интерфейсе сервера, подключенного к такой подсети, необходимо вручную настраивать статический IP-адрес из диапазона публичных IP-адресов, доступных в выбранной публичной подсети, а также задать адрес шлюза по умолчанию.

      {% endnote %}

  * `osSettingsSpec` — настройки операционной системы. Чтобы арендовать сервер без операционной системы, пропустите этот параметр.
  Возможные настройки:
    * `imageId` — идентификатор одного из доступных [публичных образов](../../concepts/images.md#marketplace-images) ОС в Yandex Cloud Marketplace.
    * `storages[]` — настройки разметки дисков. Необязательный параметр. Возможные настройки:
      * `partitions[]` — раздел диска:
        * `type` — файловая система. Возможные значения: `EXT4`, `EXT3`, `SWAP`, `XFS`.
        * `sizeGib` — размер раздела в гигабайтах.
        * `mountPoint` — точка монтирования.
      * `disk` — настройки диска:
        * `id` — идентификатор диска.
        * `type` — тип диска. Возможные значения: `HDD`, `SSD`, `NVME`.
        * `sizeGib` — размер диска в гигабайтах.
      * `raid` — настройки RAID-массива:
        * `type` — тип RAID. Возможные значения: `RAID0`, `RAID1`, `RAID10`.
        * `disks[]` — массив дисков в RAID-конфигурации. Каждый диск содержит поля `id`, `type` и `sizeGib`.
    * `sshPublicKey` — содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к серверу по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
    * `userSshId` — идентификатор пользователя SSH-ключа. Необязательный параметр.
    * `passwordPlainText` — пароль root-пользователя. Необязательный параметр.
  
      {% note warning %}
      
      Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в Yandex Cloud, и после заказа сервера вы не сможете посмотреть его.
      
      {% endnote %}
  
    * `passwordLockboxSecret` — [секрет](../../../lockbox/concepts/secret.md) Yandex Lockbox:
      * `secretId` — идентификатор секрета.
      * `versionId` — версия секрета.
      * `key` — ключ секрета.

  Результат:

  ```bash
  {
    "id": "e0q5abc123def4********",
    "description": "Server create",
    "createdAt": "2025-12-14T18:03:38.240Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T18:03:38.240Z",
    "done": true,
    "metadata": {
      "serverId": "ly56xpblirh4********"
    },
    "response": {
      "id": "ly56xpblirh4********",
      "cloudId": "b1g07hj5r6i4********",
      "folderId": "b1g07hj5r6i4********",
      "name": "bm-test-server",
      "description": "New Test Baremetal Server",
      "zoneId": "ru-central1",
      "hardwarePoolId": "ru-central1-m3",
      "status": "PROVISIONING",
      "osSettings": {
        "imageId": "ly5vyzcggvci********",
        "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0z3********",
        "storages": [
          {
            "partitions": [
              {
                "type": "EXT3",
                "sizeGib": "9",
                "mountPoint": "/boot"
              },
              {
                "type": "SWAP",
                "sizeGib": "4"
              },
              {
                "type": "EXT4",
                "mountPoint": "/"
              }
            ],
            "raid": {
              "type": "RAID10",
              "disks": [
                {
                  "id": "1",
                  "type": "HDD",
                  "sizeGib": "1862"
                },
                {
                  "id": "2",
                  "type": "HDD",
                  "sizeGib": "1862"
                },
                {
                  "id": "3",
                  "type": "HDD",
                  "sizeGib": "1862"
                },
                {
                  "id": "4",
                  "type": "HDD",
                  "sizeGib": "1862"
                }
              ]
            }
          }
        ]
      },
      "networkInterfaces": [
        {
          "id": "e0q5abc123def4********",
          "macAddress": "00:1a:4b:23:*:*",
          "ipAddress": "192.168.*.*",
          "privateSubnet": {
            "privateSubnetId": "ly52xefxa2hi********"
          }
        },
        {
          "id": "e0q5abc123def4********",
          "macAddress": "00:1a:4b:23:*:*",
          "ipAddress": "93.158.*.*",
          "publicSubnet": {
            "publicSubnetId": "ly52yjugkj57********"
          }
        }
      ],
      "configurationId": "ly5fcdnlzp7j********",
      "disks": [
        {
          "id": "1",
          "type": "HDD",
          "sizeGib": "1862"
        },
        {
          "id": "2",
          "type": "HDD",
          "sizeGib": "1862"
        },
        {
          "id": "3",
          "type": "HDD",
          "sizeGib": "1862"
        },
        {
          "id": "4",
          "type": "HDD",
          "sizeGib": "1862"
        }
      ],
      "createdAt": "2025-12-14T18:03:38.240Z",
      "labels": {
        "key": "bms"
      }
    }
  }
  ```

  Отслеживайте статус операции по полю `done`.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Арендовать сервер в своей конфигурации](custom-server-lease.md)