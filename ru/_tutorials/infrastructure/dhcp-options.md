# Настройки DHCP для работы с корпоративным DNS-сервером


Чтобы виртуальные машины разрешали имена в приватной корпоративной зоне DNS, используйте [опции DHCP](../../vpc/concepts/dhcp-options.md) в конфигурации [подсетей](../../vpc/operations/subnet-create.md). Например, для узлов подсети можно указать DNS-суффикс и DNS-сервер.

Для выполнения этого сценария у вас уже должен быть развернут корпоративный DNS-сервер, доступный для виртуальных машин в облаке. Также вы можете развернуть Active Directory, чтобы создать инфраструктуру с DNS-сервером:

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

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Чтобы полностью пройти этот сценарий, необходимо развернуть Active Directory. Если вы используете собственные DNS-серверы, доступные для виртуальных машин облака, указывайте в сценарии свои значения DNS-суффикса и IP-адресов.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за постоянно запущенные виртуальные машины ([тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за объем дисков виртуальных машин ([тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических или статических публичных IP-адресов ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет ([тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Создайте подсеть {#create-subnet}

Чтобы создать новую подсеть с настройками DHCP:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.button_action-create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** укажите название подсети: `test-subnet-1`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** выберите зону доступности `{{ region-id }}-a`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** выберите облачную сеть `ad-network`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** укажите `10.128.0.0/24`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
  1. Задайте **{{ ui-key.yacloud.vpc.subnetworks.create.section_dhcp-options }}**:
     
     1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name }}** укажите DNS-суффикс: `yantoso.net`.
     1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name-servers }}** нажмите **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-domain-name-server }}** и укажите адрес [DNS-сервера](../../glossary/dns.md): `10.1.0.3`. Повторите то же для адреса `10.2.0.3`.

  1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  Выполните команду:

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
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку `{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}` и выберите образ **Windows Server**. Как загрузить свой образ для продуктов Microsoft смотрите в разделе [Импортировать нужный образ](../../microsoft/byol.md#how-to-import).
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

      1. {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

    - CLI {#cli}
    
      {% include [include](../../_includes/cli-install.md) %}
    
      Чтобы установить на виртуальной машине пароль, подготовьте файл `metadata.yaml` с содержимым:

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

      Где `<идентификатор_образа>` — идентификатор образа с Windows Server, который используется для создания ВМ.

      {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

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

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину `vm-for-tests-in-subnet`.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсеть.
1. [Удалите](../../vpc/operations/network-delete.md) облачную сеть.

