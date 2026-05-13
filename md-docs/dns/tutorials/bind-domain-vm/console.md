# Привязка доменного имени к ВМ с веб-сервером с помощью консоли управления, CLI или API

Чтобы создать инфраструктуру для [привязки доменного имени к ВМ с веб-сервером](index.md):

Чтобы привязать доменное имя к ВМ с веб-сервером в Cloud DNS:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину с веб-сервером](#create-web-server).
1. [Создайте публичную зону DNS](#configure-dns).
1. [Делегируйте домен сервису Cloud DNS](#delegate-domain).
1. [Создайте ресурсную запись типа A](#create-record).
1. [Проверьте работу сайта](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемого решения входят:

* плата за использование [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) (см. [тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../../compute/concepts/vm.md) (см. [тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование публичной [DNS-зоны](../../concepts/dns-zone.md) и публичные [DNS-запросы](../../../glossary/dns.md) (см. [тарифы Yandex Cloud DNS](../../pricing.md)).

### Создайте облачную сеть и подсеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
  1. Справа сверху нажмите кнопку **Создать сеть**.
  1. В поле **Имя** укажите `webserver-network`.
  1. В поле **Дополнительно** отключите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.
  1. На панели слева выберите ![subnets](../../../_assets/vpc/subnets.svg) **Подсети**.
  1. Справа сверху нажмите **Создать**.
  1. В поле **Имя** укажите `webserver-subnet-ru-central1-b`.
  1. В поле **Зона доступности** выберите [зону доступности](../../../overview/concepts/geo-scope.md) `ru-central1-b`.
  1. В поле **Сеть** выберите [облачную сеть](../../../vpc/concepts/network.md) `webserver-network`.
  1. В поле **CIDR** укажите `192.168.1.0/24`.
  1. Нажмите кнопку **Создать подсеть**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте [облачную сеть](../../../vpc/concepts/network.md) `webserver-network`:

      ```bash
      yc vpc network create webserver-network
      ```

      Результат:

      ```text
      id: enp1gg8kr3pv********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:08:11Z"
      name: webserver-network
      default_security_group_id: enppne4l2eg5********
      ```

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсеть в [зоне доступности](../../../overview/concepts/geo-scope.md) `ru-central1-b`:

      ```bash
      yc vpc subnet create webserver-subnet-ru-central1-b \
        --zone ru-central1-b \
        --network-name webserver-network \
        --range 192.168.1.0/24
      ```

      Результат:

      ```text
      id: e2li9tcgi7ii********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:11:16Z"
      name: webserver-subnet-ru-central1-b
      network_id: enp1gg8kr3pv********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать [облачную сеть](../../../vpc/concepts/network.md), воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


### Создайте группу безопасности {#create-sg}

Создайте [группу безопасности](../../../vpc/concepts/security-groups.md), разрешающую входящий TCP-трафик для портов `22`, `80` и `443`, а также любой исходящий трафик.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../../_assets/vpc/security-group.svg) **Группы безопасности**. 
  1. Нажмите кнопку **Создать группу безопасности**.
  1. В поле **Имя** укажите имя `webserver-sg`.
  1. В поле **Сеть** выберите созданную ранее сеть `webserver-network`.
  1. В блоке **Правила** [создайте](../../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `http`           | `80` | `TCP` | `CIDR` | `0.0.0.0/0` |
      | Входящий | `https`            | `443`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Входящий | `ssh`            | `22`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Исходящий | `any`           | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc security-group create \
    --name webserver-sg \
    --rule "description=http,direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "description=https,direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "description=ssh,direction=ingress,port=22,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "description=any,direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
    --network-name webserver-network
  ```

  Результат:

  ```text
  id: enp4htsnl1sa********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-23T19:07:03Z"
  name: webserver-sg
  network_id: enp37qpnksl2********
  status: ACTIVE
  rules:
    - id: enpdu0t8san9********
      description: http
      direction: INGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enpr7oirpff5********
      description: https
      direction: INGRESS
      ports:
        from_port: "443"
        to_port: "443"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enp0bgk6dkdd********
      description: ssh
      direction: INGRESS
      ports:
        from_port: "22"
        to_port: "22"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enpspns0tfml********
      description: any
      direction: EGRESS
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
  ```

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

  Сохраните полученный идентификатор (`id`) группы безопасности: он пригодится при создании виртуальной машины.

- API {#api}

  Чтобы создать группу безопасности, воспользуйтесь методом REST API [create](../../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../../vpc/api-ref/grpc/SecurityGroup/create.md).

{% endlist %}


## Создайте виртуальную машину с веб-сервером {#create-web-server}

Перед тем как приступать к созданию виртуальной машины, подготовьте [пару ключей](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для доступа к ВМ по SSH.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Общая информация**:

      * В поле **Имя** укажите имя `mywebserver`.
      * В поле **Зона доступности** выберите `ru-central1-b`.

  1. В блоке **Образ загрузочного диска** перейдите на вкладку **Marketplace** и нажмите кнопку **Показать все продукты Marketplace**.
  1. В открывшемся окне найдите и выберите продукт [LAMP](https://yandex.cloud/ru/marketplace/products/yc/lamp).
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите созданную ранее подсеть `webserver-subnet-ru-central1-b`.
      * В поле **Публичный IP-адрес** выберите `Автоматически`.
      * В поле **Группы безопасности** выберите созданную ранее группу безопасности `webserver-sg`.

  1. В блоке **Доступ** укажите данные для доступа к ВМ:

      * В поле **Логин** укажите имя пользователя `yc-user`.
      * В поле **SSH-ключ** вставьте содержимое созданного ранее [публичного ключа](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

  1. Нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  Выполните команду, указав сохраненный на предыдущем шаге идентификатор группы безопасности:

  ```bash
  yc compute instance create \
    --name mywebserver \
    --zone ru-central1-b \
    --network-interface subnet-name=webserver-subnet-ru-central1-b,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
    --create-boot-disk image-folder-id=standard-images,image-id=fd8jtn9i7e9ha5q25niu \
    --ssh-key <SSH-ключ>
  ```

  Где `--ssh-key` — путь к файлу с открытым SSH-ключом и его имя. Например `~/.ssh/id_ed25519.pub`.

  Результат:

  ```text
  done (32s)
  id: fhmaq4shfrcm********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-23T05:36:34Z"
  name: mywebserver
  zone_id: ru-central1-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: fhmprher1d0q********
    auto_delete: true
    disk_id: fhmprher1d0q********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:ad:13:91:7e
      subnet_id: e9bk1m87r4m4********
      primary_v4_address:
        address: 192.168.1.11
        one_to_one_nat:
          address: 158.160.***.***
          ip_version: IPV4
      security_group_ids:
        - enpa5j0mrgm4********
  gpu_settings: {}
  fqdn: fhmaq4shfrcm********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  ```

  Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Чтобы создать виртуальную машину, воспользуйтесь методом REST API [create](../../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}

В вашем каталоге будет создана виртуальная машина `mywebserver`. Чтобы [подключиться](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ней по SSH, используйте логин `yc-user` и публичный IP-адрес этой ВМ. Если вы планируете пользоваться созданным веб-сервером длительное время, [сделайте](../../../vpc/operations/set-static-ip.md) публичный IP-адрес этой ВМ статическим.


## Создайте публичную зону DNS {#configure-dns}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
  1. Нажмите кнопку **Создать зону**.
  1. Задайте настройки [зоны DNS](../../concepts/dns-zone.md), соответствующие вашему домену:

      1. **Зона** — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://ru.wikipedia.org/wiki/Punycode).
      1. **Тип** — `Публичная`.
      1. **Имя** — имя зоны.

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc dns zone create \
    --name <имя_зоны> \
    --zone <доменная_зона> \
    --public-visibility
  ```

  Где:

  * `--name` — имя [зоны DNS](../../concepts/dns-zone.md).
  * `--zone` — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://ru.wikipedia.org/wiki/Punycode).

  Результат:

  ```text
  id: dns39gihj0ef********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-21T16:43:37.883Z"
  name: my-domain-zone
  zone: example.com.
  public_visibility: {}
  ```

  Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/create.md).

- API {#api}

  Чтобы создать публичную [зону DNS](../../concepts/dns-zone.md), воспользуйтесь методом REST API [create](../../api-ref/DnsZone/create.md) для ресурса [DnsZone](../../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../api-ref/grpc/DnsZone/create.md).

{% endlist %}


## Делегируйте домен сервису Cloud DNS {#delegate-domain}

Чтобы делегировать домен сервису Cloud DNS, в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов:

* `ns1.yandexcloud.net`
* `ns2.yandexcloud.net`

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи в течение 24 часов (86400 секунд). Это обусловлено значением TTL, в течение которого кешируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

```
ns2.yandexcloud.net.
ns1.yandexcloud.net.
```

## Создайте ресурсную запись типа A {#create-record}

Создайте в вашей зоне DNS [ресурсную запись типа А](../../concepts/resource-record.md#a), указывающую на публичный IP-адрес веб-сервера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
  1. Выберите созданную ранее DNS-зону.
  1. Нажмите кнопку **Создать запись**.
  1. Задайте параметры записи:
      1. В поле **Имя** выберите `Совпадает с именем зоны (@)`.
      1. В поле **Тип** выберите [тип записи](../../concepts/resource-record.md#rr-types) `A`.
      1. В поле **Значение** укажите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) веб-сервера.

          Узнать IP-адрес виртуальной машины можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть** или с помощью команды CLI `yc compute instance get <имя_ВМ>`.

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc dns zone add-records \
    --name <имя_зоны> \
    --record "<доменное_имя> 600 A <IP-адрес_ВМ>"
  ```

  Где:

  * `--name` — имя созданной ранее публичной зоны DNS.
  * `--record` — параметры создаваемой ресурсной записи:
      * `<доменное_имя>` — доменное имя, должно заканчиваться точкой. Например, для домена `example.com` здесь нужно указать `example.com.`
      * `<IP-адрес_ВМ>` — [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) веб-сервера.

          Узнать IP-адрес виртуальной машины можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть** или с помощью команды CLI `yc compute instance get <имя_ВМ>`.

  Результат:

  ```text
  +--------+--------------+------+---------------+-----+
  | ACTION |     NAME     | TYPE |     DATA      | TTL |
  +--------+--------------+------+---------------+-----+
  | +      | example.com. | A    | 51.250.**.*** | 600 |
  +--------+--------------+------+---------------+-----+
  ```

  Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  Чтобы создать ресурсную запись в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../api-ref/grpc/DnsZone/updateRecordSets.md).


{% endlist %}


## Проверьте работу сайта {#test}

Теперь сайт на вашем веб-сервере доступен по доменному имени. Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:

* `http://<публичный_IP-адрес_ВМ>`
* `http://example.com`

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы зарезервировали его специально для этой ВМ.
1. [Удалите](../../operations/zone-delete.md) созданную доменную зону.

#### См. также {#see-also}

* [Привязка доменного имени к ВМ с веб-сервером с помощью Terraform](terraform.md).