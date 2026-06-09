# Настройки DHCP для работы с корпоративным DNS-сервером


Если вам необходимо, чтобы виртуальные машины разрешали имена в приватной корпоративной зоне DNS, используйте [опции DHCP](../concepts/dhcp-options.md) в конфигурации [подсетей](../operations/subnet-create.md). Например, для узлов подсети можно указать DNS-суффикс и DNS-сервер.

Для выполнения данного сценария у вас уже должен быть развернут корпоративный DNS-сервер, доступный для виртуальных машин в облаке. Вы можете также выполнить развертывание Active Directory, чтобы создать инфраструктуру с DNS-сервером:

* Облачную сеть `ad-network` с подсетями в разных [зонах доступности](../../overview/concepts/geo-scope.md):
    * `ad-subnet-a` (10.1.0.0/16);
    * `ad-subnet-b` (10.2.0.0/16);
    * `ad-subnet-d` (10.3.0.0/16);
* Контроллеры домена и бастионный хост:
    * `ad-vm-a` (10.1.0.3);
    * `ad-vm-b` (10.2.0.3);
    * `jump-server-vm` (10.3.0.x).

В рамках сценария вы добавите новую подсеть `10.128.0.0/24` с указанием DNS-суффикса и DNS-сервера, а также создадите ВМ и проверите работу сети.

Чтобы добавить подсеть с настройками DHCP:

* [Подготовьте облако к работе](#before-begin).
* [Создайте подсеть](#create-subnet).
* [Проверьте работу сети](#check-config).

Если инфраструктура вам больше не нужна, [удалите](#clear-out) созданные ресурсы.

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Чтобы полностью пройти данный сценарий, необходимо развернуть Active Directory. Если вы используете собственные DNS-серверы, доступные для виртуальных машин облака, указывайте в сценарии свои значения DNS-суффикса и IP-адресов.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за объем дисков виртуальных машин (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических или статических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Создайте подсеть {#create-subnet}

Чтобы создать новую подсеть с настройками DHCP, выполните следующее:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать подсеть:
  1. Откройте раздел **{{ vpc-name }}** в каталоге, где требуется создать подсеть.
  1. Нажмите на имя облачной сети `ad-network`.
  1. Нажмите кнопку **Добавить подсеть**.
  1. Заполните форму:
      * Укажите название подсети: `test-subnet-1`. Выберите зону доступности `{{ region-id }}-a`.
      * Введите CIDR подсети: `10.128.0.0/24`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../concepts/network.md).
  1. Задайте **Настройки DHCP**:
      * В поле **Доменное имя** укажите DNS-суффикс: `yantoso.net`.
      * В поле **Серверы доменных имен** нажмите кнопку **Добавить DNS-сервер** и укажите адрес [DNS-сервера](../../glossary/dns.md): `10.1.0.3`. Повторите то же для адреса `10.2.0.3`.
  1. Нажмите кнопку **Создать подсеть**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  Выполните следующую команду:

  ```
  yc vpc subnet create --name test-subnet-1 \
    --description "My test subnet" \
    --folder-id <идентификатор_каталога> \
    --network-name ad-network \
    --zone {{ region-id }}-a \
    --range 10.128.0.0/24 \
    --domain-name yantoso.net \
    --domain-name-server 10.1.0.3,10.2.0.3
  ```

  Где `<идентификатор_каталога>` — идентификатор каталога, в котором создаются ресурсы. Если каталог указан в профиле CLI, параметр можно не использовать.

  Результат:

  ```
  id: e2ldy0b1prtj********
  folder_id: b1gbvco8fejm********
  created_at: "2021-07-12T13:28:54Z"
  name: test-subnet-1
  description: My test subnet
  network_id: enpl0t90hept********
  zone_id: {{ region-id }}-a
  v4_cidr_blocks:
  - 10.128.0.0/24
  dhcp_options:
    domain_name_servers:
    - 10.1.0.3
    - 10.2.0.3
    domain_name: yantoso.net
  ```

{% endlist %}

## Проверьте работу сети {#check-config}

Чтобы проверить конфигурацию, создайте ВМ и подключитесь к ней по RDP:

1. Подготовьте ВМ:

    {% list tabs group=instructions %}
    
    - Консоль управления {#console}

      1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку `{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}` и выберите образ **Windows Server**. Как загрузить свой образ для продуктов Microsoft подробнее см. в разделе [Импортировать нужный образ](../../microsoft/byol.md#how-to-import).
      1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, в которой будет создана ВМ.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** задайте размер загрузочного [диска](../../compute/concepts/disk.md) `50 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Cascade Lake`.
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
          * При необходимости сделайте виртуальную машину [прерываемой](../../compute/concepts/preemptible-vm.md).

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите сеть `ad-network` и подсеть `test-subnet-1`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `vm-for-tests-in-subnet`.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

      1. Дождитесь, когда статус ВМ сменится на `Running`, и сбросьте пароль:
         
         1. Выберите виртуальную машину.
         1. Нажмите кнопку **Сбросить пароль**.
         1. Укажите **Имя пользователя**, для которого нужно сбросить пароль. Если у ВМ не существует пользователя с таким именем, он будет создан с правами администратора.
         1. Нажмите кнопку **Сгенерировать пароль**.
         1. Сохраните **Новый пароль**. После закрытия окна он будет недоступен.

    - CLI {#cli}
    
      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
      Чтобы установить на виртуальной машине пароль, подготовьте файл metadata.yaml со следующим содержимым:

      ```
      #ps1
      net user administrator '<пароль>'
      ```

      Выполните команду, чтобы создать виртуальную машину:

      ```
      yc compute instance create \
        --name vm-for-tests-in-subnet \
        --metadata-from-file user-data=metadata.yaml \
        --zone {{ region-id }}-a \
        --cores 2 \
        --memory 4 \
        --network-interface subnet-name=test-subnet-1,nat-ip-version=ipv4 \
        --create-boot-disk image-id=<идентификатор_образа>
      ```

      Где `<идентификатор_образа>` — идентификатор вашего образа с Windows Server, который используется для создания ВМ.

      {% note info %}
      
      Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды {{ yandex-cloud }} CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
      
      Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
      
      Подробнее см. в разделе [{#T}](../../compute/concepts/metadata/sending-metadata.md#environment-variables).
      
      {% endnote %}

      Если команда выполнена успешно, сохраните IP-адрес из поля `one_to_one_nat`. Адрес будет использован на следующем шаге, чтобы создать подключение по RDP:

      ```
      ...
      status: RUNNING
      ...
      primary_v4_address:
        address: 10.128.0.26
      ...
      one_to_one_nat:
        address: 130.193.40.112
        ip_version: IPV4
      ...
      ```

    {% endlist %}

1. Подождите несколько минут и [подключитесь к виртуальной машине](../../compute/operations/vm-connect/rdp.md) по RDP.

1. На виртуальной машине запустите PowerShell.

1. Чтобы посмотреть конфигурацию сети Windows, выполните команду:

    ```
    ipconfig /all
    ```

    Результат:

    ```
    Windows IP Configuration
    
      Host Name . . . . . . . . . . . . : epdpjtg********
      Primary Dns Suffix  . . . . . . . :
      Node Type . . . . . . . . . . . . : Hybrid
      IP Routing Enabled. . . . . . . . : No
      WINS Proxy Enabled. . . . . . . . : No
      DNS Suffix Search List. . . . . . : yantoso.net
    
    Ethernet adapter Ethernet 2:
    
      Connection-specific DNS Suffix  . : yantoso.net
      Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #2
      Physical Address. . . . . . . . . : D0-0D-19-9F-60-C2
      DHCP Enabled. . . . . . . . . . . : Yes
      Autoconfiguration Enabled . . . . : Yes
      Link-local IPv6 Address . . . . . : fe80::1f0:5a1e:76ea:3ded%3(Preferred)
      IPv4 Address. . . . . . . . . . . : 10.128.0.11(Preferred)
      Subnet Mask . . . . . . . . . . . : 255.255.255.0
      Lease Obtained. . . . . . . . . . : Wednesday, July 14, 2021 11:00:09 AM
      Lease Expires . . . . . . . . . . : Saturday, August 20, 2157 5:33:50 PM
      Default Gateway . . . . . . . . . : 10.128.0.1
      DHCP Server . . . . . . . . . . . : 10.128.0.2
      DHCPv6 IAID . . . . . . . . . . . : 114298137
      DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-28-80-7B-90-D0-0D-19-9F-60-C2
      DNS Servers . . . . . . . . . . . : 10.1.0.3
                                          10.2.0.3
      NetBIOS over Tcpip. . . . . . . . : Enabled
    
    Tunnel adapter isatap.yantoso.net:
    
      Media State . . . . . . . . . . . : Media disconnected
      Connection-specific DNS Suffix  . : yantoso.net
      Description . . . . . . . . . . . : Microsoft ISATAP Adapter
      Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
      DHCP Enabled. . . . . . . . . . . : No
      Autoconfiguration Enabled . . . . : Yes
    ```

1. Проверьте, есть ли связь с контроллером домена `yantoso.net`. 

    Для этого выполните команду:

    ```
    ping ad-vm-a
    ```
    
    Результат в случае успешного соединения:

    ```
    PS C:\Users\Administrator> ping ad-vm-a
    
    Pinging ad-vm-a.yantoso.net [10.1.0.3] with 32 bytes of data:
    Reply from 10.1.0.3: bytes=32 time=1ms TTL=127
    Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
    Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
    Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
    
    Ping statistics for 10.1.0.3:
        Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 0ms, Maximum = 1ms, Average = 0ms
    ```

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Удалите виртуальную машину `vm-for-tests-in-subnet`.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ. 
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Выберите виртуальную машину → нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) → выберите пункт **Удалить**.
      1. Подтвердите удаление.

    - CLI {#cli}
    
      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Для удаления ВМ выполните:

      ```
      yc compute instance delete vm-for-tests-in-subnet
      ```

    {% endlist %}

1. Удалите подсеть `test-subnet-1`.

    {% list tabs group=instructions %}

    - Консоль управления {#console}
    
      1. Откройте раздел **{{ vpc-name }}** в каталоге, где требуется удалить подсеть.
      1. Нажмите на имя облачной сети, в которой находится подсеть: `ad-network`.
      1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке подсети `test-subnet-1`.
      1. В открывшемся меню нажмите кнопку **Удалить**.
      1. Подтвердите действие нажатием кнопки **Удалить**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Чтобы удалить подсеть, выполните:

      ```
      yc vpc subnet delete --name test-subnet-1
      ```

    {% endlist %}