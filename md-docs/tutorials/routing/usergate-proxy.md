# Создание и настройка шлюза UserGate в режиме прокси-сервера


[UserGate](https://www.usergate.com/ru/products/enterprise-firewall) — это межсетевой экран нового поколения от одноименной российской компании.

Вы создадите виртуальную машину UserGate в Yandex Cloud и настроите шлюз в режиме прокси-сервера. Это позволит организовать безопасный доступ в интернет для сотрудников вашей компании из любой точки мира (офис, дом, кафе и прочие публичные места). Для более расширенного изучения возможностей UserGate пройдите бесплатный курс [UserGate Getting Started](https://university.tssolution.ru/usergate-getting-started-v6).

Типовая схема использования UserGate в режиме прокси-сервера в Yandex Cloud представлена на рисунке ниже.

![image](../../_assets/tutorials/usergate-proxy-mode.svg)

Чтобы развернуть шлюз UserGate:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсеть](#create-network).
1. [Зарезервируйте статический публичный IP-адрес](#get-static-ip).
1. [Создайте виртуальную машину UserGate](#create-vm).
1. [Настройте UserGate NGFW через веб-консоль администратора](#admin-console).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки шлюза UserGate входит:

* плата за постоянно запущенную виртуальную машину ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование [UserGate NGFW](https://yandex.cloud/ru/marketplace/products/usergate/ngfw);
* плата за использование публичного статического IP-адреса ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

## Создайте облачную сеть и подсеть {#create-network}

Создайте облачную [сеть](../../vpc/concepts/network.md#network) с [подсетями](../../vpc/concepts/network.md#subnet) в тех [зонах доступности](../../overview/concepts/geo-scope.md), где будет находиться виртуальная машина.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления](https://console.yandex.cloud) в правом верхнем углу нажмите кнопку **Создать ресурс** и выберите пункт **Сеть**.
  1. Задайте имя сети: `usergate-network`.
  1. В поле **Дополнительно** включите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

     Подробнее о команде `yc vpc network create` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).
     
  1. Создайте подсеть `usergate-subnet-ru-central1-d` в зоне доступности `ru-central1-d`:
  
     ```bash
     yc vpc subnet create usergate-subnet-ru-central1-d \
       --zone ru-central1-d \
       --network-name usergate-network \
       --range 10.1.0.0/16
     ```

     Результат:
    
     ```text
     id: e9bnnssj8sc8********
     folder_id: b1g9hv2loamq********
     created_at: "2022-06-08T09:27:00Z"
     name: usergate-subnet-ru-central1-d
     network_id: enptrcle5q3d********
     zone_id: ru-central1-d
     v4_cidr_blocks:
     - 10.1.0.0/16
     ```

     Подробнее о команде `yc vpc subnet create` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры сети `usergate-network` и ее подсети `usergate-subnet-ru-central1-d`:

     ```hcl
     resource "yandex_vpc_network" "usergate-network" {
       name = "usergate-network"
     }

     resource "yandex_vpc_subnet" "usergate-subnet" {
       name           = "usergate-subnet-ru-central1-d"
       zone           = "ru-central1-d"
       network_id     = "${yandex_vpc_network.usergate-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }
     ```

     Подробнее в описаниях ресурсов [yandex_vpc_network](../../terraform/resources/vpc_network.md) и [yandex_vpc_subnet](../../terraform/resources/vpc_subnet.md) в документации провайдера Terraform.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  1. Создайте сеть `usergate-network` с помощью вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) или метода REST API [create](../../vpc/api-ref/Network/create.md) для ресурса Network.
  1. Создайте подсеть `usergate-subnet-ru-central1-d` с помощью вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) или метода REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса Subnet.

{% endlist %}

## Создайте группу безопасности {#create-security-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога, в котором нужно создать группу.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **Группы безопасности**.
  1. Нажмите кнопку **Создать группу безопасности**.
  1. Введите имя группы безопасности — `usergate-sg`.
  1. В поле **Сеть** выберите сеть `usergate-network`.
  1. В блоке **Правила** создайте правила по инструкции под таблицей:
   
     | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Назначение /<br/>Источник | CIDR блоки |
     | --- | --- | --- | --- | --- | --- |
     | Исходящий | `any` | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |
     | Входящий | `icmp` | `Весь` | `ICMPv6` | `CIDR` | `0.0.0.0/0` |
     | Входящий | `rdp` | `3389` | `TCP` | `CIDR` | `0.0.0.0/0` |
     | Входящий | `ssh` | `22` | `TCP` | `CIDR` | `0.0.0.0/0` |
     | Входящий | `usergate 8001` | `8001` | `TCP` | `CIDR` | `0.0.0.0/0` |
     | Входящий | `usergate 8090` | `8090` | `TCP` | `CIDR` | `0.0.0.0/0` |
      
     1. Перейдите на вкладку **Исходящий трафик** или **Входящий трафик**.
     1. Нажмите кнопку **Добавить правило**. В открывшемся окне:
        1. В поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **Назначение** или **Источник** выберите назначение правила:
            * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
            * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
         
        1. Нажмите кнопку **Сохранить**.
   
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

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
  
  ```text
  id: enpu0e0nrqdn********
  folder_id: b1g86q4m5vej********
  created_at: "2022-06-29T09:38:40Z"
  name: usergate-sg
  network_id: enp3srbi9u49********
  status: ACTIVE
  rules:
  - id: enpdp9d0ping********
    direction: EGRESS
    protocol_name: ANY
    protocol_number: "-1"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enps2r5ru3s1********
    direction: INGRESS
    protocol_name: ICMP
    protocol_number: "1"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpgonbui61a********
    direction: INGRESS
    ports:
      from_port: "3389"
      to_port: "3389"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpbg1jh11hv********
    direction: INGRESS
    ports:
      from_port: "22"
      to_port: "22"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpgdavevku7********
    direction: INGRESS
    ports:
      from_port: "8001"
      to_port: "8001"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enp335ibig9k********
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

  Подробнее о команде `yc vpc security-group create` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

- Terraform {#tf}

  1. Добавьте в конфигурационный файл параметры группы безопасности `usergate-sg`:
  
     ```hcl
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

     Подробнее о ресурсе `yandex_vpc_security_group` смотрите в [документации](../../terraform/resources/vpc_security_group.md) провайдера Terraform.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Используйте вызов gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md) или метод REST API [create](../../vpc/api-ref/SecurityGroup/create.md).
     
{% endlist %}

## Зарезервируйте статический публичный IP-адрес {#get-static-ip}

Для работы шлюзу потребуется статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога, в котором нужно зарезервировать адрес.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **Публичные IP-адреса**.
  1. Нажмите кнопку **Зарезервировать публичный IP-адрес**.
  1. В открывшемся окне в поле **Зона доступности** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
  1. Нажмите кнопку **Зарезервировать**.
  
- CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc address create --external-ipv4 zone=ru-central1-d
  ```

  Результат:

  ```text
  id: e9b6un9gkso6********
  folder_id: b1g7gvsi89m3********
  created_at: "2022-06-08T17:52:42Z"
  external_ipv4_address:
    address: 178.154.253.52
    zone_id: ru-central1-d
    requirements: {}
  reserved: true
  ```

  Подробнее о команде `yc vpc address create` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/address/create.md).

{% endlist %}

## Создайте виртуальную машину UserGate {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `UserGate NGFW` и выберите публичный образ [UserGate NGFW](https://yandex.cloud/ru/marketplace/products/usergate/ngfw).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `4`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `8 ГБ`.

      {% note info %}

      Указанные параметры подойдут для функционального тестирования шлюза. Чтобы рассчитать параметры для более серьезной нагрузки, ознакомьтесь с [официальными рекомендациями](https://www.usergate.com/ru/products/usergate-vm) UserGate.

      {% endnote %}

  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите сеть `usergate-network` и подсеть `usergate-subnet-ru-central1-d`.
      * В поле **Публичный IP-адрес** выберите `Список` и в появившемся списке выберите зарезервированный ранее IP-адрес.
      * В поле **Группы безопасности** выберите из списка группу `usergate-sg`.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `usergate-proxy`.
  1. Нажмите кнопку **Создать ВМ**.

- CLI {#cli}
  
  1. [Создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей SSH.
  1. Получите идентификатор группы безопасности `usergate-sg`:

     ```bash
     yc vpc security-group get usergate-sg | grep "^id"
     ```

     Подробнее о команде `yc vpc security-group get` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/security-group/get.md).

  1. Выполните команду:

     ```bash
     yc compute instance create \
       --name usergate-proxy \
       --memory 8 \
       --cores 4 \
       --zone ru-central1-d \
       --network-interface subnet-name=usergate-subnet-ru-central1-d,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности_usergate-sg> \
       --create-boot-disk image-folder-id=standard-images,image-family=usergate-ngfw \
       --ssh-key <путь_к_открытой_части_SSH-ключа> \
     ```

     Результат:

     ```text
     id: fhm2na1siftp********
     folder_id: b1g86q4m5vej********
     created_at: "2022-06-09T11:15:52Z"
     name: usergate-proxy
     zone_id: ru-central1-d
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

     Подробнее о команде `yc compute instance create` смотрите в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- Terraform {#tf}

  1. [Получите](../../compute/operations/images-with-pre-installed-software/get-list.md) идентификатор последней версии образа UserGate NGFW из списка публичных образов.
  1. Опишите в конфигурационном файле параметры ВМ `usergate-proxy`:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "boot-disk"
       type     = "network-hdd"
       zone     = "ru-central1-d"
       size     = "110"
       image_id = "<идентификатор_образа_UserGate_NGFW>"
     }

     resource "yandex_compute_instance" "usergate-proxy" {
       name        = "usergate-proxy"
       platform_id = "standard-v3"
       zone        = "ru-central1-d"
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
         security_group_ids = <идентификатор_группы_безопасности_usergate-sg>
       }
     }
     ```

     Подробнее смотрите в описании ресурса [yandex_compute_instance](../../terraform/resources/compute_instance.md) в документации провайдера Terraform.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Создайте ВМ `usergate-proxy` с помощью метода REST API [create](../../compute/api-ref/Instance/create.md) для ресурса Instance.

{% endlist %}

## Настройте UserGate NGFW через веб-консоль администратора {#admin-console}

Для настройки шлюза перейдите в веб-консоль администратора UserGate NGFW по адресу `https://<публичный_IP-адрес_ВМ>:8001` и авторизуйтесь с данными по умолчанию: логин — `Admin`, пароль — `utm`.

После авторизации вам будет предложено изменить пароль по умолчанию и провести обновление ОС.

### Настройте шлюз для работы в режиме прокси-сервера {#proxy-setup}

Сконфигурируйте UserGate NGFW для работы в режиме прокси-сервера:

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
   * (Опционально) **Приватный ключ** — выберите приватный ключ сертификата.
   * (Опционально) **Пароль** — пароль для приватного ключа или контейнера PKCS12.
   * (Опционально) **Цепочка сертификатов** — выберите файл, если необходимо возвращать клиентам полную цепочку сертификатов.

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