# Создание и настройка шлюза UserGate в режиме прокси-сервера

[UserGate]{% if lang == "ru" %}(https://www.usergate.com/ru/products/enterprise-firewall){% else %}(https://www.usergate.com/products/enterprise-firewall){% endif %} — это межсетевой экран нового поколения от одноименной российской компании.

Вы создадите виртуальную машину UserGate в {{ yandex-cloud }} и настроите шлюз в режиме прокси-сервера. Это позволит организовать безопасный доступ в интернет для сотрудников вашей компании из любой точки мира (офис, дом, кафе и прочие публичные места). Для более расширенного изучения возможностей UserGate пройдите бесплатный курс [UserGate Getting Started](https://university.tssolution.ru/usergate-getting-started-v6).

Типовая схема использования UserGate в режиме прокси-сервера в {{ yandex-cloud }} представлена на рисунке ниже.

![image](../../_assets/tutorials/usergate-proxy-mode.svg)

Чтобы развернуть шлюз UserGate:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсеть](#create-network).
1. [Зарезервируйте статический публичный IP-адрес](#get-static-ip).
1. [Создайте виртуальную машину UserGate](#create-vm).
1. [Настройте UserGate NGFW через веб-консоль администратора](#admin-console).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки шлюза UserGate входит:

* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование [UserGate NGFW](/marketplace/products/usergate/ngfw);
* плата за использование публичного статического IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

{% endif %}

## Создайте облачную сеть и подсеть {#create-network}

Создайте облачную [сеть](../../vpc/concepts/network.md#network) с [подсетями](../../vpc/concepts/network.md#subnet) в тех [зонах доступности](../../overview/concepts/geo-scope.md), где будет находиться виртуальная машина.

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Сеть**.
  1. Задайте имя сети: `usergate-network`.
  1. Включите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сеть `usergate-network`:
  
     ```bash
     yc vpc network create usergate-network
     ```
     
     Результат:
       
     ```
     id: enptrcle5q3d3ktd33hj
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2022-06-08T09:25:03Z"
     name: usergate-network
     default_security_group_id: enpbsnnop4akg7ng70ll
     ```
     
     Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).
     
  1. Создайте подсеть `usergate-subnet-{{ region-id }}-a` в зоне доступности `{{ region-id }}-a`:
  
     ```
     yc vpc subnet create usergate-subnet-{{ region-id }}-a \
       --zone {{ region-id }}-a \
       --network-name usergate-network \
       --range 10.1.0.0/16
     ```
   
     Результат:
    
     ``` 
     id: e9bnnssj8sc8mjhat9qk
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2022-06-08T09:27:00Z"
     name: usergate-subnet-{{ region-id }}-a
     network_id: enptrcle5q3d3ktd33hj
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 10.1.0.0/16
     ```
     
     Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

- {{ TF }}

  1. Опишите в конфигурационном файле параметры сети `usergate-network` и ее подсети `usergate-subnet-{{ region-id }}-a`:

     ```
     resource "yandex_vpc_network" "usergate-network" {
       name = "usergate-network"
     }

     resource "yandex_vpc_subnet" "usergate-subnet" {
       name           = "usergate-subnet-{{ region-id }}-a"
       zone           = "{{ region-id }}-a"
       network_id     = "${yandex_vpc_network.usergate-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }
     ```

     Подробнее см. в описаниях ресурсов [yandex_vpc_network]({{ tf-provider-link }}/vpc_network) и [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet) в документации провайдера {{ TF }}.
     
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

- API

  1. Создайте сеть `usergate-network` с помощью вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create) или метода REST API [create](../../vpc/api-ref/Network/create.md) для ресурса Network.
  1. Создайте подсеть `usergate-subnet-{{ region-id }}-a` с помощью вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create) или метода REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса Subnet.

{% endlist %}

## Создайте группу безопасности {#create-security-group}

{% include [security-groups-note](../../application-load-balancer/_includes_service/security-groups-note.md) %}

{% list tabs %}

- Консоль управления 

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором нужно создать группу.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Группы безопасности**.
  1. Нажмите кнопку **Создать группу**.
  1. Укажите **Имя** группы: `usergate-sg`.
  1. Выберите **Сеть** `usergate-network`.
  1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:
   
     | Направление<br/>трафика | Описание | Диапазон<br/>портов | Протокол | Тип источника /<br/>назначения | Источник /<br/>назначение |
     | --- | --- | --- | --- | --- | --- |
     | Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0 |
     | Входящий | icmp | Весь| ICMP | CIDR | 0.0.0.0/0 |
     | Входящий | rdp | 3389 | TCP | CIDR | 0.0.0.0/0 |
     | Входящий | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |
     | Входящий | usergate 8001 | 8001 | TCP | CIDR | 0.0.0.0/0 |
     | Входящий | usergate 8090 | 8090 | TCP | CIDR | 0.0.0.0/0 |
      
     1. Перейдите на вкладку **Исходящий трафик** или **Входящий трафик**.
     1. Нажмите кнопку **Добавить правило**.
     1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
     1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
     1. В поле **Назначение** или **Источник** выберите назначение правила:
      
        * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
        * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
         
     1. Нажмите кнопку **Сохранить**.
   
  1. Нажмите кнопку **Сохранить**.

- CLI

  Выполните следующую команду:

  ```bash
  yc vpc security-group create usergate-sg \
    --network-name usergate-network \
    --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,protocol=icmp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=3389,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=22,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=8001,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=8090,protocol=tcp,v4-cidrs=[0.0.0.0/0]
  ```
  
  Результат:
  
  ```
  id: enpu0e0nrqdnvk10r3lp
  folder_id: b1g86q4m5vej8lkljme5
  created_at: "2022-06-29T09:38:40Z"
  name: usergate-sg
  network_id: enp3srbi9u49pjvcejnb
  status: ACTIVE
  rules:
  - id: enpdp9d0pingp28d04kn
    direction: EGRESS
    protocol_name: ANY
    protocol_number: "-1"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enps2r5ru3s11mdark60
    direction: INGRESS
    protocol_name: ICMP
    protocol_number: "1"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpgonbui61ah7ifdc9i
    direction: INGRESS
    ports:
      from_port: "3389"
      to_port: "3389"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpbg1jh11hvp9tu1mq9
    direction: INGRESS
    ports:
      from_port: "22"
      to_port: "22"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpgdavevku7583jo3ah
    direction: INGRESS
    ports:
      from_port: "8001"
      to_port: "8001"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enp335ibig9kq7qvcg7q
    direction: INGRESS
    ports:
      from_port: "8090"
      to_port: "8090"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  ```

  Подробнее о команде `yc vpc security-group create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры группы безопасности `usergate-sg`:
  
     ```
     resource "yandex_vpc_security_group" "usergate-sg" {
       name       = "usergate-sg"
       network_id = "${yandex_vpc_network.usergate-network.id}"
     
       egress {
         protocol       = "ANY"
         port           = "ANY"
         v4_cidr_blocks = ["0.0.0.0/0"]
       }
     
       ingress {
         protocol       = "ICMP"
         port           = "ANY"
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         protocol       = "TCP"
         port           = 3389
         v4_cidr_blocks = ["0.0.0.0/0"]
       }
     
       ingress {
         protocol       = "TCP"
         port           = 22
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         protocol       = "TCP"
         port           = 8001
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         protocol       = "TCP"
         port           = 8090
         v4_cidr_blocks = ["0.0.0.0/0"]
       }
     }
     ```
     
     Подробнее о ресурсе `yandex_vpc_security_group` см. в [документации]({{ tf-provider-link }}/vpc_security_group) провайдера {{ TF }}.
     
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

- API

  Используйте вызов gRPC API {% if audience != "internal" %}[SecurityGroupService/Create](../../vpc/api-ref/grpc/security_group_service.md#Create){% else %}SecurityGroupService/Create{% endif %} или метод REST API {% if audience != "internal" %}[create](../../vpc/api-ref/SecurityGroup/create.md){% else %}create{% endif %}.
     
{% endlist %}

## Зарезервируйте статический публичный IP-адрес {#get-static-ip}

Для работы шлюзу потребуется статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором нужно зарезервировать адрес.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/ip-addresses.svg) **IP-адреса**.
  1. Нажмите кнопку **Зарезервировать адрес**.
  1. В открывшемся окне выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`.
  1. Нажмите кнопку **Зарезервировать**.
  
- CLI

  Выполните команду:

  ```bash
  yc vpc address create --external-ipv4 zone={{ region-id }}-a
  ```

  Результат:

  ```bash
  id: e9b6un9gkso6stdh6b3p
  folder_id: b1g7gvsi89m34pipa3ke
  created_at: "2022-06-08T17:52:42Z"
  external_ipv4_address:
    address: 178.154.253.52
    zone_id: {{ region-id }}-a
    requirements: {}
  reserved: true
  ```

  Подробнее о команде `yc vpc address create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/address/create.md).

{% endlist %}

## Создайте виртуальную машину UserGate {#create-vm}

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Виртуальная машина**.
  1. В поле **Имя** введите имя ВМ — `usergate-proxy`.
  1. Выберите зону доступности `{{ region-id }}-a`.
  1. В блоке **Выбор образа/загрузочного диска** на вкладке **{{ marketplace-name }}** выберите образ [UserGate NGFW](/marketplace/products/usergate/ngfw).
  1. В блоке **Вычислительные ресурсы**:

     * Выберите [платформу](../../compute/concepts/vm-platforms.md) Intel Ice Lake.
     * Укажите необходимое количество vCPU и объем RAM:

       * **vCPU** — 4.
       * **Гарантированная доля vCPU** — 100%.
       * **RAM** — 8 ГБ.

       {% note info %}

       Указанные параметры подойдут для функционального тестирования шлюза. Чтобы рассчитать параметры для более серьезной нагрузки, ознакомьтесь с [официальными рекомендациями]{% if lang == "ru" %}(https://www.usergate.com/ru/products/usergate-vm){% else %}(https://www.usergate.com/products/usergate-vm){% endif %} UserGate.

       {% endnote %}
   
  1. В блоке **Сетевые настройки**:
  
     * Выберите сеть `usergate-network` и подсеть `usergate-subnet-{{ region-id }}-a`.
     * В поле **Публичный адрес** выберите из списка зарезервированный ранее IP-адрес.
     * В поле **Группы безопасности** выберите из списка группу `usergate-sg`.

  1. В блоке **Доступ** укажите данные для доступа на ВМ:

     * В поле **Логин** введите имя пользователя.
     * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

       Пару ключей для подключения по SSH необходимо создать самостоятельно, см. раздел [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

  1. Нажмите кнопку **Создать ВМ**.
   
- CLI
  
  1. [Создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей SSH.
  1. Получите идентификатор группы безопасности `usergate-sg`:

     ```
     yc vpc security-group get usergate-sg | grep "^id"
     ```

     Подробнее о команде `yc vpc security-group get` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/get.md).

  1. Выполните команду:

     ```bash
     yc compute instance create \
       --name usergate-proxy \
       --memory 8 \
       --cores 4 \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=usergate-subnet-{{ region-id }}-a,nat-ip-version=ipv4,security-group-ids=<идентификатор группы безопасности usergate-sg> \
       --create-boot-disk image-folder-id=standard-images,image-family=usergate-ngfw \
       --ssh-key <путь к открытой части SSH-ключа> \
     ```

     Результат:

     ```bash
     id: fhm2na1siftpfhrfc03l
     folder_id: b1g86q4m5vej8lkljme5
     created_at: "2022-06-09T11:15:52Z"
     name: usergate-proxy
     zone_id: {{ region-id }}-a
     platform_id: standard-v2
     resources:
       memory: "8589934592"
       cores: "4"
       core_fraction: "100"
     status: RUNNING
     boot_disk:
       mode: READ_WRITE
       device_name: fhmiq60rni2tqvjdiq3l
       auto_delete: true
       disk_id: fhmiq60rni2tqvjdiq3l
     network_interfaces:
     - index: "0"
       mac_address: d0:0d:2b:a8:3c:93
       subnet_id: e9bqlr188as7rgsgh4kn
       primary_v4_address:
         address: 10.1.0.27
         one_to_one_nat:
           address: 51.250.72.1
           ip_version: IPV4
     fqdn: fhm2na1siftpfhrfc03l.auto.internal
     scheduling_policy: {}
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

     Подробнее о команде `yc compute instance create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/compute/instance/create.md).

- {{ TF }}

  1. [Получите](../../compute/operations/images-with-pre-installed-software/get-list.md) идентификатор последней версии образа UserGate NGFW из списка публичных образов.
  1. Опишите в конфигурационном файле параметры ВМ `usergate-proxy`:

     ```
     resource "yandex_compute_instance" "usergate-proxy" {
       name        = "usergate-proxy"
       platform_id = "standard-v3"
       zone        = "{{ region-id }}-a"
       hostname    = "usergate"
       resources {
         cores         = 4
         core_fraction = 100
         memory        = 8
       }

       boot_disk {
         initialize_params {
           image_id = "<идентификатор образа UserGate NGFW>"
           size     = 110
         }
       }

       network_interface {
         subnet_id          = "${yandex_vpc_subnet.usergate-subnet.id}"
         nat                = true
         security_group_ids = <идентификатор группы безопасности usergate-sg>
       }
     ```

     Подробнее см. в описании ресурса [yandex_compute_instance]({{ tf-provider-link }}/compute_instance) в документации провайдера {{ TF }}.
     
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

- API

  Создайте ВМ `usergate-proxy` с помощью метода REST API [create](../../compute/api-ref/Instance/create.md) для ресурса Instance.

{% endlist %}

## Настройте UserGate NGFW через веб-консоль администратора {#admin-console}

Для настройки шлюза перейдите в веб-консоль администратора UserGate NGFW по адресу `https://<публичный адрес ВМ>:8001` и авторизуйтесь с данными по умолчанию: логин — `Admin`, пароль — `utm`.

После авторизации вам будет предложено изменить пароль по умолчанию и провести обновление ОС.

### Настройте шлюз для работы в режиме прокси-сервера {#proxy-setup}

Cконфигурируйте UserGate NGFW для работы в режиме прокси-сервера:

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
 
На этом первоначальная настройка шлюза закончена. Теперь можно использовать UserGate в качестве прокси-сервера, указав в настройках браузера публичный IP-адрес и порт `8090`.

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

### Настройте правила фильтрации контента {#content-rules}

Из политик, предустановленных по умолчанию, рекомендуется включить `Example black list`, `Example threats sites` и `Example AV check`:

1. Перейдите в раздел **Политики безопасности** ⟶ **Фильтрация контента**.
1. Выделите строку с выбранным правилом и в верхней части экрана нажмите кнопку **Включить**.

Для обеспечения большей безопасности настройте дополнительные правила для фильтрации контента:

1. Перейдите в раздел **Политики безопасности** ⟶ **Фильтрация контента**.
1. Добавьте правило для фильтрации:

   1. В верхней части экрана нажмите кнопку **Добавить**.
   1. Укажите параметры правила:
      
      * **Название** — `Блокировка социальных сетей`.
      * **Действия** — Запретить.

   1. Перейдите на вкладку **Источник** и выберите `Trusted`.
   1. Перейдите на вкладку **Категории**.
   1. Нажмите кнопку **Добавить**.
   1. В поисковой строке найдите категорию `Социальные сети` и нажмите кнопку **Добавить**. Затем нажмите кнопку **Закрыть**.
   1. Нажмите кнопку **Сохранить**.

Вы можете добавить и другие правила для фильтрации контента. Не рекомендуется совмещать несколько параметров в одном правиле. В этом случае правило может не сработать.

### Настройте SSL-инспектирование {#ssl}

По умолчанию UserGate использует для расшифровки трафика свой сертификат `CA (Default)`. Но вы также можете добавить свой собственный сертификат.

Чтобы добавить сертификат:

1. Перейдите в раздел **UserGate** ⟶ **Сертификаты**.
1. В верхней части экрана нажмите кнопку **Импорт**.
1. Заполните параметры сертификата:

   * **Название** — введите произвольное название.
   * **Файл сертификата** — выберите файл сертификата в форматах DER, PEM или PKCS12.
   * (опционально) **Приватный ключ** — выберите приватный ключ сертификата.
   * (опционально) **Пароль** — пароль для приватного ключа или контейнера PKCS12.
   * (опционально) **Цепочка сертификатов** — выберите файл, если необходимио возвращать клиентам полную цепочку сертификатов.

1. Нажмите кнопку **Сохранить**.
1. Нажмите на имя добавленного сертификата.
1. В поле **Используется** выберите **SSL инспектирование**.
1. Нажмите кнопку **Сохранить**.
1. Добавьте правило для SSL-инспектирования:

   1. Перейдите в раздел **Политики безопасности** ⟶ **Инспектирование SSL**.
   1. В верхней части экрана нажмите кнопку **Добавить**.
   1. Заполните параметры правила и нажмите кнопку **Сохранить**.

      Для реализации SSL-инспектирования вы также можете использовать правило по умолчанию `Decrypt all for unknown users`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md) `usergate-proxy`.
1. [Удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md).
