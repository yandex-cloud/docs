# Создание и настройка шлюза UserGate в режиме межсетевого экрана


[UserGate](https://www.usergate.com/ru/products/enterprise-firewall) — межсетевой экран нового поколения от одноименной российской компании.

Вы создадите виртуальную машину UserGate в {{ yandex-cloud }} и настроите шлюз для работы в режиме межсетевого экрана. Для расширенного изучения возможностей UserGate пройдите бесплатный курс [UserGate Getting Started](https://university.tssolution.ru/usergate-getting-started-v6).

Чтобы развернуть шлюз UserGate и проверить его работу:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсеть](#create-network).
1. [Зарезервируйте статический публичный IP-адрес](#get-static-ip).
1. [Создайте виртуальную машину UserGate](#create-vm).
1. [Настройте UserGate NGFW через веб-консоль администратора](#admin-console).
1. [Настройте маршрутизацию в подсети](#subnet-routing).
1. [Проведите тестирование работы межсетевого экрана](#test-firewall).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки шлюза UserGate входит:

* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование [UserGate NGFW](/marketplace/products/usergate/ngfw);
* плата за использование публичного статического IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Создайте облачную сеть и подсеть {#create-network}

Создайте облачную [сеть](../../vpc/concepts/network.md#network) с [подсетями](../../vpc/concepts/network.md#subnet) в тех [зонах доступности](../../overview/concepts/geo-scope.md), где будет находиться виртуальная машина.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Сеть**.
  1. Задайте имя сети: `usergate-network`.
  1. Включите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сеть `usergate-network`:
  
     ```bash
     yc vpc network create usergate-network
     ```

     Результат:

     ```text
     id: enptrcle5q3d********
     folder_id: b1g9hv2loamq********
     created_at: "2022-06-08T09:25:03Z"
     name: usergate-network
     default_security_group_id: enpbsnnop4ak********
     ```

     Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).

  1. Создайте подсеть `usergate-subnet-{{ region-id }}-d` в зоне доступности `{{ region-id }}-d`:

     ```bash
     yc vpc subnet create usergate-subnet-{{ region-id }}-d \
       --zone {{ region-id }}-d \
       --network-name usergate-network \
       --range 10.1.0.0/16
     ```

     Результат:
    
     ```yaml
     id: e9bnnssj8sc8********
     folder_id: b1g9hv2loamq********
     created_at: "2022-06-08T09:27:00Z"
     name: usergate-subnet-{{ region-id }}-d
     network_id: enptrcle5q3d********
     zone_id: {{ region-id }}-d
     v4_cidr_blocks:
     - 10.1.0.0/16
     ```

     Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).



- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры сети `usergate-network` и ее подсетей:

     ```hcl
     resource "yandex_vpc_network" "usergate-network" {
       name = "usergate-network"
     }

     resource "yandex_vpc_subnet" {
       name           = "usergate-subnet-{{ region-id }}-d"
       zone           = "{{ region-id }}-d"
       network_id     = "${yandex_vpc_network.usergate-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }
     ```

     Подробнее см. в описаниях ресурсов [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network) и [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet) в документации провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  1. Создайте сеть `usergate-network` с помощью вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) или метода REST API [create](../../vpc/api-ref/Network/create.md) для ресурса Network.
  1. Создайте подсеть `usergate-subnet-{{ region-id }}-d` с помощью вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) или метода REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса Subnet.

{% endlist %}

## Зарезервируйте статический публичный IP-адрес {#get-static-ip}

Для работы шлюзу потребуется статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором нужно зарезервировать адрес.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/ip-addresses.svg) **IP-адреса**.
  1. Нажмите кнопку **Зарезервировать адрес**.
  1. В открывшемся окне выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-d`.
  1. Нажмите кнопку **Зарезервировать**.
  
- CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc address create --external-ipv4 zone={{ region-id }}-d
  ```

  Результат:

  ```text
  id: e9b6un9gkso6********
  folder_id: b1g7gvsi89m3********
  created_at: "2022-06-08T17:52:42Z"
  external_ipv4_address:
    address: 178.154.253.52
    zone_id: {{ region-id }}-d
    requirements: {}
  reserved: true
  ```

  Подробнее о команде `yc vpc address create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/address/create.md).

- {{ TF }} {#tf}

  Опишите в конфигурационном файле параметры публичного адреса `yandex_vpc_address`:

  ```hcl
  resource "yandex_vpc_address" "usergate-addr" {
  name = "usergate-addr"
  external_ipv4_address {
    zone_id = "{{ region-id }}-d"
    }
  }
  ```

  Подробнее см. описание ресурса [vpc_address]({{ tf-provider-resources-link }}/vpc_address) в документации провайдера {{ TF }}.

{% endlist %}

## Создайте виртуальную машину UserGate {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `UserGate NGFW` и выберите образ [UserGate NGFW](/marketplace/products/usergate/ngfw).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-d`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      {% note info %}

      Указанные параметры подойдут для функционального тестирования шлюза. Чтобы рассчитать параметры для более серьезной нагрузки, ознакомьтесь с [официальными рекомендациями](https://www.usergate.com/ru/products/usergate-vm) UserGate.

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `usergate-network` и подсеть `usergate-subnet-{{ region-id }}-d`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** нажмите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` и выберите [зарезервированный ранее](#get-static-ip) IP-адрес.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `usergate-firewall`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
   
- CLI {#cli}
  
  1. [Создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей SSH.
  
  1. Выполните команду:

     ```bash
     yc compute instance create \
       --name usergate-firewall \
       --memory 8 \
       --cores 4 \
       --zone {{ region-id }}-d \
       --create-boot-disk image-folder-id=standard-images,image-family=usergate-ngfw \
       --ssh-key <путь_к_открытой_части_SSH-ключа> \
       --public-address=<зарезервированный_IP_адрес>
     ```

     Результат:

     ```text
     id: fhm2na1siftp********
     folder_id: b1g86q4m5vej********
     created_at: "2022-06-09T11:15:52Z"
     name: usergate-firewall
     zone_id: {{ region-id }}-d
     platform_id: standard-v2
     resources:
       memory: "8589934592"
       cores: "4"
       core_fraction: "100"
     status: RUNNING
     boot_disk:
       mode: READ_WRITE
       device_name: fhmiq60rni2t********
       auto_delete: true
       disk_id: fhmiq60rni2t********
     network_interfaces:
     - index: "0"
       mac_address: d0:0d:2b:a8:3c:93
       subnet_id: e9bqlr188as7********
       primary_v4_address:
         address: 10.1.0.27
         one_to_one_nat:
           address: 51.250.72.1
           ip_version: IPV4
     fqdn: fhm2na1siftp********.auto.internal
     scheduling_policy: {}
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

     Подробнее о команде `yc compute instance create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/compute/instance/create.md).

- {{ TF }} {#tf}

  1. [Получите](../../compute/operations/images-with-pre-installed-software/get-list.md) идентификатор последней версии образа UserGate NGFW из списка публичных образов.
  1. Опишите в конфигурационном файле параметры ВМ `usergate-firewall`:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "boot-disk"
       type     = "network-hdd"
       zone     = "{{ region-id }}-d"
       size     = "110"
       image_id = "<идентификатор_образа_UserGate_NGFW>"
     }

     resource "yandex_compute_instance" "usergate-firewall" {
       name        = "usergate-firewall"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-d"
       hostname    = "usergate"
       resources {
         cores         = 4
         core_fraction = 100
         memory        = 8
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id          = "${yandex_vpc_subnet.usergate-subnet.id}"
         nat                = true
         nat_ip_address     = <зарезервированный_IP_адрес>
       }
     ```

     Подробнее см. в описании ресурса [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance) в документации провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где находится конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Создайте ВМ `usergate-firewall` с помощью метода REST API [create](../../compute/api-ref/Instance/create.md) для ресурса Instance.

{% endlist %}

## Настройте UserGate NGFW через веб-консоль администратора {#admin-console}

Для настройки шлюза перейдите в веб-консоль администратора UserGate NGFW по адресу `https://<публичный_адрес_ВМ_UserGate>:8001` и авторизуйтесь с данными по умолчанию: логин — `Admin`, пароль — `utm`.

После авторизации вам будет предложено изменить пароль по умолчанию и провести обновление ОС.

### Настройте шлюз для работы в режиме межсетевого экрана {#gateway-setup}

Сконфигурируйте UserGate NGFW:

1. В верхнем меню выберите **Настройки**.
1. В меню слева перейдите в раздел **Сеть** ⟶ **Зоны**.
1. Нажмите на имя зоны `Trusted`.
1. Перейдите на вкладку **Контроль доступа** и включите опцию **Консоль администрирования**. Нажмите кнопку **Сохранить**.
1. В меню слева перейдите в раздел **Сеть** ⟶ **Интерфейсы**.
1. Нажмите на имя сетевого интерфейса `port0`.
1. На вкладке **Общие** в поле **Зона** выберите из списка зону `Trusted`. Нажмите кнопку **Сохранить**.
1. В меню слева перейдите в раздел **Политики сети** ⟶ **Межсетевой экран**.
1. Нажмите на имя предустановленного правила `Allow trusted to untrusted`.
1. Перейдите на вкладку **Назначение** и отключите зону `Untrusted`. Нажмите кнопку **Сохранить**.
1. Включите правило `Allow trusted to untrusted`. Для этого выделите строку с правилом и в верхней части экрана нажмите кнопку **Включить**.
1. В меню слева перейдите в раздел **Политики сети** ⟶ **NAT и маршрутизация**.
1. Нажмите на имя предустановленного правила `NAT from Trusted to Untrusted`.
1. Перейдите на вкладку **Назначение** и измените зону назначения с `Untrusted` на `Trusted`. Нажмите кнопку **Сохранить**.
1. Включите правило `NAT from Trusted to Untrusted`. Для этого выделите строку с правилом и в верхней части экрана нажмите кнопку **Включить**.
 
На этом первоначальная настройка шлюза закончена. 

### Настройте правила фильтрации трафика {#traffic-rules}

Из политик, предустановленных по умолчанию, рекомендуется использовать `Block to botnets`, `Block from botnets` и `Example block RU RKN by IP list`. Предварительно измените в них значения нескольких параметров:

1. Перейдите в раздел **Политики сети** ⟶ **Межсетевой экран**.
1. Нажмите на имя предустановленного правила.
1. Перейдите на вкладку **Источник** и измените исходную зону с `Untrusted` на `Trusted`. 
1. Перейдите на вкладку **Назначение** и отключите зону `Untrusted`.
1. Нажмите кнопку **Сохранить**.
1. Включите выбранное правило. Для этого выделите строку с правилом и в верхней части экрана нажмите кнопку **Включить**.

Для обеспечения большей безопасности настройте дополнительные правила для фильтрации трафика:

1. Перейдите в раздел **Политики сети** ⟶ **Межсетевой экран**.
1. Добавьте первое правило для блокировки:
   
   1. В верхней части экрана нажмите кнопку **Добавить**.
   1. Укажите параметры правила:
      
      * **Название** — `Блокировка протокола QUIC`.
      * **Действие** — Запретить.

   1. Перейдите на вкладку **Источник** и выберите `Trusted`.
   1. Перейдите на вкладку **Сервис**.
   1. Нажмите кнопку **Добавить**.
   1. Выберите сервис `Quick UDP Internet Connections` и нажмите кнопку **Добавить**. Затем нажмите кнопку **Закрыть**.
   1. Нажмите кнопку **Сохранить**.

1. Добавьте второе правило для блокировки:
   
   1. В верхней части экрана нажмите кнопку **Добавить**.
   1. Укажите параметры правила:

      * **Название** — `Блокировка обновлений Windows`.
      * **Действие** — Запретить.
   
   1. Перейдите на вкладку **Источник** и выберите `Trusted`.
   1. Перейдите на вкладку **Приложения**.
   1. Нажмите **Добавить** ⟶ **Добавить приложения**.
   1. Выберите приложение `Microsoft Update` и нажмите кнопку **Добавить**.
   1. Выберите приложение `WinUpdate` и нажмите кнопку **Добавить**. Затем нажмите кнопку **Закрыть**.
   1. Нажмите кнопку **Сохранить**.

Вы можете добавить и другие правила для фильтрации трафика. Не рекомендуется совмещать сервисы и приложения в одном правиле. В этом случае правило может не сработать.


## Настройте маршрутизацию для подсети {#subnet-routing}

Создайте [статический маршрут](../../vpc/concepts/routing.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где нужно создать статический маршрут.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/route-tables.svg) **Таблицы маршрутизации**.
  1. Нажмите кнопку **Создать**.
  1. Задайте имя таблицы маршрутизации. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. (Опционально) Добавьте описание таблицы маршрутизации.
  1. Выберите сеть `usergate-network`.
  1. Нажмите кнопку **Добавить маршрут**.
  1. В открывшемся окне введите префикс подсети назначения `0.0.0.0` и выберите `0` в выпадающем списке.
  1. Укажите **next hop** — внутренний IP-адрес виртуальной машины UserGate `usergate-firewall`.
  1. Нажмите кнопку **Добавить**.
  1. Нажмите кнопку **Создать таблицу маршрутизации**.

  Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети:

  1. На панели слева выберите ![image](../../_assets/vpc/subnets.svg) **Подсети**.
  1. В строке подсети `usergate-subnet-{{ region-id }}-d` нажмите кнопку ![image](../../_assets/options.svg).
  1. В открывшемся меню выберите пункт **Привязать таблицу маршрутизации**.
  1. В открывшемся окне выберите созданную таблицу в списке.
  1. Нажмите кнопку **Привязать**.

- CLI {#cli}

  Чтобы создать таблицу маршрутизации и добавить в нее [статические маршруты](../../vpc/concepts/routing.md): 
  1. Посмотрите описание команды CLI для создания таблиц маршрутизации:

     ```bash
     yc vpc route-table create --help
     ```

  1. Получите идентификаторы облачных сетей в вашем облаке:

     ```bash
     yc vpc network list
     ```

     Результат:
     ```text
     +----------------------+--------------------+
     |          ID          |      NAME          |
     +----------------------+--------------------+
     | enp846vf5fus******** | usergate-network   |
     +----------------------+--------------------+
     ```

  1. Создайте таблицу маршрутизации в сети `usergate-network`:

     ```bash
     yc vpc route-table create \
       --name=test-route-table \
       --network-id=enp846vf5fus******** \
       --route destination=0.0.0.0/0,next-hop=10.129.0.24
     ```

     Где:

     * `name` — имя таблицы маршрутизации.
     * `network-id` — идентификатор сети, в которой будет создана таблица.
     * `route` — настройки маршрута, включают два параметра:
        * `destination` — префикс подсети назначения в нотации CIDR.
        * `next-hop` — внутренний IP-адрес виртуальной машины UserGate `usergate-firewall`.

     Результат:
     ```text
     ...done
     id: enpsi6b08q2v********
     folder_id: b1gqs1teo2q2********
     created_at: "2019-06-24T09:57:54Z"
     name: test-route-table
     network_id: enp846vf5fus********
     static_routes:
     - destination_prefix: 0.0.0.0/0
       next_hop_address: 10.129.0.24
     ```

  Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети:

  1. Получите список подсетей в вашем облаке:

     ```bash
     yc vpc subnet list
     ```

     Результат:
     ```text
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     |          ID          |               NAME            |      NETWORK ID      |    ROUTE TABLE ID    |       ZONE    |      RANGE      |
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     | b0c4l3v9jrgd******** | usergate-subnet-{{ region-id }}-d | enpjsdf771h0******** |                      | {{ region-id }}-d | [10.130.0.0/24] |
     +----------------------+-------------------------------+----------------------+----------------------+---------------+-----------------+
     ```

  1. Привяжите таблицу маршрутизации к подсети, в которой будет работать веб-сервис, например, к подсети `usergate-subnet-{{ region-id }}-d`:

     ```bash
     yc vpc subnet update b0c4l3v9jrgd******** --route-table-id e2l5345dlgr1********
     ```

     Результат:
     ```text
     ..done
     id: b0c4l3v9jrgd********
     folder_id: b1gqs1teo2q2********
     created_at: "2019-03-12T13:27:22Z"
     name: subnet-1
     network_id: enp846vf5fus********
     zone_id: {{ region-id }}-d
     v4_cidr_blocks:
     - 192.168.0.0/24
     route_table_id: e2l5345dlgr1********
     ```

- {{ TF }} {#tf}

  Чтобы создать таблицу маршрутизации и добавить в нее [статические маршруты](../../vpc/concepts/routing.md):

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя таблицы маршрутизации. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `network_id` — идентификатор сети, в которой будет создана таблица.
     * `static_route` — описание статического маршрута:
        * `destination_prefix` — префикс подсети назначения в нотации CIDR.
        * `next_hop_address` — внутренний IP-адрес виртуальной машины из [разрешенных диапазонов](../../vpc/concepts/network.md#subnet), через которую будет направляться трафик.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_vpc_route_table" "usergate-rt-d" {
	   name       = "<имя_таблицы_маршрутизации>"
       network_id = "<идентификатор_сети>"
       static_route {
         destination_prefix = "0.0.0.0/0"
         next_hop_address   = "10.129.0.24"
       }
     }
     ```

     Чтобы добавить, изменить или удалить таблицу маршрутизации, используйте ресурс `yandex_vpc_route_table` с указанием на сеть в поле `netword id` (например, `network_id = "${yandex_vpc_network.lab-net.id}"`).

     Более подробную информацию о параметрах ресурса `yandex_vpc_route_table` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_route_table).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```hcl
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```hcl
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc vpc route-table list
        ```

{% endlist %}


## Протестируйте межсетевой экран {#test-firewall}

Чтобы проверить межсетевой экран, создайте тестовый веб-сервис и убедитесь, что он доступен из интернета.


### Подготовьте тестовую виртуальную машину {#test-vm-prepare}

1. [Создайте](../../compute/operations/vm-create/create-linux-vm) виртуальную машину из публичного образа Linux в подсети `usergate-subnet-{{ region-id }}-d`. В настройках виртуальной машины включите [серийную консоль](../../compute/operations/serial-console/index.md).
1. Подключитесь к ВМ с помощью [CLI](../../compute/operations/serial-console/connect-cli.md), выполнив команду:

   ```bash
   yc compute connect-to-serial-port --instance-name <имя_виртуальной_машины>
   ```

   Где:
   `--instance-name` - имя тестовой ВМ.

1. Запустите тестовый веб-сервис:

   ```bash
   sudo python3 -m http.server 80
   ```

   Веб-сервер будет отвечать на запросы на порт 80 и возвращать список папок и файлов из каталога. 


### Настройте реверс-proxy к веб-сервису через межсетевой экран {#setup-access}

1. В веб-консоли администратора UserGate в верхнем меню выберите **Настройки**.
1. Слева в разделе **Глобальный портал** выберите **Веб-портал** и настройте доступ по HTTP-адресу:
   1. Нажмите кнопку **Добавить**, чтобы открыть диалог добавления портала.
   1. Активируйте чекбокс **Включено**.
   1. В поле **Название** введите `Тестовый веб-портал`.
   1. В поле **URL** введите `http://<IP_адрес_ВМ_UserGate>`.
   1. **Профиль SSL** оставьте по умолчанию.
   1. В поле **Сертификат** выберите `CA (Default)`.
   1. Нажмите **Сохранить**.
1. Выберите **Серверы reverse-прокси** и добавьте новый сервер:
   1. Нажмите кнопку **Добавить**, чтобы открыть диалог добавления сервера.
   1. В поле **Название** введите `Локальный сервер`.
   1. В поле **Адрес сервера** введите `<внутренний_IP_тестовой_ВМ>`, например, `10.129.0.24`.
   1. В поле **Порт** введите `80`.
   1. Нажмите **Сохранить**.
1. Выберите **Правила reverse-прокси** и добавьте новое правило:
   1. Нажмите кнопку **Добавить**, чтобы открыть диалог добавления правила.
   1. Активируйте чекбокс **Включено**.
   1. В поле **Название** введите `Доступ к локальному серверу`.
   1. В поле **Сервер reverse-прокси** выберите `Локальный сервер`.
   1. В поле **Порты** введите `5550`.
   1. Нажмите **Сохранить**.

   На этом настройка доступа к локальному серверу завершена. Межсетевой экран будет принимать запросы на порт 5550 и перенаправлять их на порт 80 по адресу тестовой ВМ.

### Протестируйте доступность веб-сервера из интернета {#service-access}

1. Убедитесь, что вы можете выполнить запрос к веб-сервису, перейдя в браузере по адресу:

   ```text
   http://<IP_адрес_ВМ_UserGate>:5550
   ```

   В ответ должен вернуться список папок и файлов из каталога.

1. В веб-консоли администратора UserGate в верхнем меню выберите **Журналы и отчёты**.
1. Слева в разделе **Журналы** выберите **Журнал веб-доступа** и убедитесь, что появилась запись о выполнении правила `Доступ к локальному серверу`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md) `usergate-firewall` и `local-service`.
1. [Удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md).
