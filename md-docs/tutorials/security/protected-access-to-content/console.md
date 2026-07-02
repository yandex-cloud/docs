[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > [Безопасность](../index.md) > [Организация защищенного доступа к контенту в Cloud CDN](index.md) > Консоль управления, CLI, API

# Организация защищенного доступа к контенту в Cloud CDN с помощью консоли управления, CLI или API

Чтобы настроить защищенный доступ к контенту в Cloud CDN:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину с веб-сервером](#create-web-server).
1. [Создайте и настройте публичную зону DNS](#configure-dns).
1. [Добавьте TLS-сертификат в Yandex Certificate Manager](#issue-certificate).
1. [Подготовьте бакет-источник для CDN-ресурса](#setup-bucket-origin).
1. [Создайте CDN-ресурс](#setup-cdn-resource).
1. [Создайте ресурсную запись CNAME для CDN-ресурса](#create-cdn-cname-record).
1. [Опубликуйте сайт на веб-сервере](#publish-website).
1. [Проверьте работу защищенного доступа к файлам](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для организации защищенного доступа к контенту в Cloud CDN входят:

* плата за использование [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [публичной DNS-зоны](../../../dns/concepts/dns-zone.md#public-zones) и публичные DNS-запросы ([тарифы Yandex Cloud DNS](../../../dns/pricing.md));
* плата за [хранение данных](../../../storage/concepts/bucket.md) в Object Storage, [операции](../../../storage/operations/index.md) с ними и исходящий трафик ([тарифы Object Storage](../../../storage/pricing.md));
* плата за исходящий трафик с [CDN-серверов](../../../cdn/concepts/index.md) ([тарифы Cloud CDN](../../../cdn/pricing.md)).


### Создайте облачную сеть и подсеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console} 

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Справа сверху нажмите **Создать сеть**.
  1. В поле **Имя** укажите `webserver-network`.
  1. В поле **Дополнительно** отключите опцию **Создать подсети**.
  1. Нажмите **Создать сеть**.
  1. На панели слева выберите ![subnets](../../../_assets/console-icons/nodes-right.svg) **Подсети**.
  1. Справа сверху нажмите **Создать подсеть**.
  1. В поле **Имя** укажите `webserver-subnet-ru-central1-b`.
  1. В поле **Зона доступности** выберите зону доступности `ru-central1-b`.
  1. В поле **Сеть** выберите облачную сеть `webserver-network`.
  1. В поле **CIDR** укажите `192.168.1.0/24`.
  1. Нажмите **Создать подсеть**.

- Yandex Cloud CLI {#cli}

  1. Создайте сеть `webserver-network`:

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

  1. Создайте подсеть в зоне доступности `ru-central1-b`:

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

  1. Чтобы создать сеть, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


### Создайте группу безопасности {#create-sg}

Создайте [группу безопасности](../../../vpc/concepts/security-groups.md), разрешающую входящий TCP-трафик для портов `22`, `80` и `443`, а также любой исходящий трафик.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/shield.svg) **Группы безопасности**. 
  1. Нажмите **Создать группу безопасности**.
  1. В поле **Имя** укажите имя `webserver-sg`.
  1. В поле **Сеть** выберите созданную ранее сеть `webserver-network`.
  1. В блоке **Правила** [создайте](../../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `http`           | `80` | `TCP` | `CIDR` | `0.0.0.0/0` |
      | Входящий | `https`            | `443`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Входящий | `ssh`            | `22`   | `TCP`  | `CIDR` | `0.0.0.0/0` |
      | Исходящий | `any`           | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |

  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}
  
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

  Сохраните полученный идентификатор (`id`) группы безопасности — он понадобится при создании ВМ.

- API {#api}

  Чтобы создать группу безопасности, воспользуйтесь методом REST API [create](../../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../../vpc/api-ref/grpc/SecurityGroup/create.md).

{% endlist %}


### Подготовьте файлы для загрузки в бакет {#prepare-files}

1. Сохраните любое изображение в формате JPEG в файл `content.jpg`.
1. Создайте файл `index.html`:

    ```html
    <html>
        <body>
        </body>
    </html>
    ```


## Создайте виртуальную машину с веб-сервером {#create-web-server}

Перед тем как приступать к созданию ВМ, подготовьте [пару ключей](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для доступа к ВМ по SSH.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `LAMP` и выберите образ [LAMP](https://yandex.cloud/ru/marketplace/products/yc/lamp).
  1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md) `ru-central1-b`.
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите созданную ранее подсеть `webserver-subnet-ru-central1-b`.
      * В поле **Публичный IP-адрес** выберите `Автоматически`.
      * В поле **Группы безопасности** выберите созданную ранее группу безопасности `webserver-sg`.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя: `yc-user`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `mywebserver`.
  1. Нажмите кнопку **Создать ВМ**.

- Yandex Cloud CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name mywebserver \
    --zone ru-central1-b \
    --network-interface subnet-name=webserver-subnet-ru-central1-b,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
    --create-boot-disk image-folder-id=standard-images,image-id=fd8jtn9i7e9ha5q25niu \
    --ssh-key ~/.ssh/id_ed25519.pub
  ```

  Где:
  * `<идентификатор_группы_безопасности>` — сохраненный ранее идентификатор группы безопасности.
  * `--ssh-key` — путь к файлу с открытым SSH-ключом. Например: `~/.ssh/id_ed25519.pub`.

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

  Чтобы создать ВМ, воспользуйтесь методом REST API [create](../../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}

В вашем каталоге будет создана ВМ `mywebserver`. Чтобы [подключиться](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ней по SSH, используйте логин `yc-user` и [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) этой ВМ. Если вы планируете пользоваться созданным веб-сервером длительное время, [сделайте](../../../vpc/operations/set-static-ip.md) публичный IP-адрес этой ВМ статическим.


## Создайте и настройте публичную зону DNS {#configure-dns}

1. Создайте публичную [зону DNS](../../../dns/concepts/dns-zone.md) в Yandex Cloud DNS.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
      1. Перейдите в сервис **Cloud DNS**.
      1. Нажмите **Создать зону**.
      1. Задайте настройки зоны, соответствующие вашему домену:

         1. **Зона** — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://ru.wikipedia.org/wiki/Punycode).
         1. **Тип** — `Публичная`.
         1. **Имя** — `my-domain-zone`.

      1. Нажмите **Создать**.

    - Yandex Cloud CLI {#cli}

      Выполните команду:

      ```bash
      yc dns zone create \
        --name my-domain-zone \
        --zone <имя_домена> \
        --public-visibility
      ```

      Где `--zone` — имя вашего домена, например `example.com.`. Значение параметра `--zone` должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`.

      Результат:

      ```
      id: dns39gihj0ef********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-21T16:43:37.883Z"
      name: my-domain-zone
      zone: example.com.
      public_visibility: {}
      ```

      Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/create.md).

    - API {#api}

      Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../../dns/api-ref/grpc/DnsZone/create.md).

    {% endlist %}

1. Делегируйте ваш домен сервису Cloud DNS. Для этого в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net`.

1. Создайте в вашей зоне DNS ресурсную A-запись, указывающую на публичный IP-адрес созданной ранее ВМ с веб-сервером:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
      1. Перейдите в сервис **Cloud DNS**.
      1. Выберите созданную ранее DNS-зону.
      1. Нажмите **Создать запись**.
      1. Задайте параметры записи:
         1. В поле **Имя** выберите `Совпадает с именем зоны (@)`.
         1. В поле **Тип** выберите [тип записи](../../../dns/concepts/resource-record.md#rr-types) `A`.
         1. В поле **Значение** укажите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) созданной ранее ВМ с веб-сервером.

             Узнать IP-адрес ВМ можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть** или с помощью команды CLI `yc compute instance get mywebserver`.

      1. Нажмите **Создать**.

    - Yandex Cloud CLI {#cli}

      Выполните команду:

      ```bash
      yc dns zone add-records \
        --name my-domain-zone \
        --record "@ 600 A <IP-адрес_ВМ>"
      ```

      Где `<IP-адрес_ВМ>` — [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) созданной ранее ВМ с веб-сервером.

      Узнать IP-адрес ВМ можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть** или с помощью команды CLI `yc compute instance get mywebserver`.

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

      Чтобы создать ресурсную запись в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

    {% endlist %}


## Добавьте TLS-сертификат в Yandex Certificate Manager {#issue-certificate}

1. Добавьте в сервис Certificate Manager [сертификат](../../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для ваших доменов, которые будут использоваться веб-сервером и CDN-ресурсом.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
      1. Перейдите в сервис **Certificate Manager**.
      1. Нажмите **Добавить сертификат** и выберите **Сертификат от Let's Encrypt**.
      1. В открывшемся окне в поле **Имя** укажите `mymanagedcert`.
      1. В поле **Домены** укажите имя вашего домена, например `example.com`.

          В этом же поле укажите с новой строки имя поддомена, который будет использоваться для CDN-ресурса, например `cdn.example.com`.
      1. Выберите [тип проверки прав на домен](../../../certificate-manager/concepts/challenges.md) `DNS`.
      1. Нажмите **Создать**.

    - Yandex Cloud CLI {#cli}

      Выполните команду:

      ```bash
      yc certificate-manager certificate request \
        --name mymanagedcert \
        --challenge dns \
        --domains <имя_домена>,<имя_поддомена>
      ```

      Где:
      * `<имя_домена>` — имя вашего домена для веб-сервера. Например: `example.com`.
      * `<имя_поддомена>` — имя поддомена, который будет использоваться CDN-ресурсом. Например: `cdn.example.com`.

      Результат:
      ```bash
      id: fpqbs12t6ion********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-24T14:36:39.299844798Z"
      name: mymanagedcert
      type: MANAGED
      domains:
        - example.com
        - cdn.example.com
      status: VALIDATING
      updated_at: "2023-12-24T14:36:39.299844798Z"
      ```

      Подробнее о команде `yc certificate-manager certificate request` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/request.md).

      Сохраните идентификатор (`id`) созданного сертификата: он пригодится при создании CDN-ресурса.

    - API {#api}

      Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../../certificate-manager/api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../../certificate-manager/api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/RequestNew](../../../certificate-manager/api-ref/grpc/Certificate/requestNew.md).

    {% endlist %}

    В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домены](../../../certificate-manager/operations/managed/cert-validate.md).

1. Для успешного выпуска сертификата пройдите проверку прав на домены:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
        1. Перейдите в сервис **Certificate Manager**.
        1. В списке сертификатов выберите `mymanagedcert`.
        1. В открывшемся окне в блоке **Проверка прав на домены** выберите `CNAME-запись`.
        1. В секции первого домена ниже нажмите **Создать запись** и в открывшемся окне нажмите **Создать**.
        1. Повторите предыдущее действие для второго домена.

        Проверка прав на домены может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

    - Yandex Cloud CLI {#cli}

        1. Получите значения ресурсных записей, необходимых для прохождения проверки:

            ```bash
            yc certificate-manager certificate get \
              --name mymanagedcert \
              --full
            ```

            Результат:

            ```bash
            id: fpq2gpi42teg********
            folder_id: b1gt6g8ht345********
            created_at: "2023-12-24T18:13:45.960Z"
            name: mymanagedcert
            type: MANAGED
            domains:
              - example.com
              - cdn.example.com
            status: VALIDATING
            updated_at: "2023-12-24T18:13:45.960Z"
            challenges:
              - domain: cdn.example.com
                type: DNS
                created_at: "2023-12-24T18:13:45.960Z"
                updated_at: "2023-12-24T18:13:49.280Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.cdn.example.com.
                  type: CNAME
                  value: fpq2gpi42teg********.cm.yandexcloud.net.
              - domain: cdn.example.com
                type: DNS
                created_at: "2023-12-24T18:13:45.960Z"
                updated_at: "2023-12-24T18:13:49.280Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.cdn.example.com.
                  type: TXT
                  value: d9RzZH8WZucSY8mXs9cEg1wNteaaNqbxZK7********
              - domain: example.com
                type: DNS
                created_at: "2023-12-24T18:13:45.960Z"
                updated_at: "2023-12-24T18:13:49.280Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.example.com
                  type: CNAME
                  value: fpq2gpi42teg********.cm.yandexcloud.net.
              - domain: example.com
                type: DNS
                created_at: "2023-12-24T18:13:45.960Z"
                updated_at: "2023-12-24T18:13:49.280Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.example.com.
                  type: TXT
                  value: iiyJJJlsaFIqQ7DMUzira0OKU3iXuaqiN7U********
            ```

            Подробнее о команде `yc certificate-manager certificate get` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/get.md).

            Сохраните значения полей `value` из разделов с типом `CNAME` в блоках `challenges.dns_challenge` для обоих доменных имен. Эти значения понадобятся на следующем шаге.

        1. Создайте [ресурсные записи](../../../dns/concepts/resource-record.md) CNAME для прохождения проверки ваших прав на домены:

            ```bash
            yc dns zone add-records \
              --name my-domain-zone \
              --record "_acme-challenge 600 CNAME <значение_dns_challenge>" \
              --record "_acme-challenge.<поддомен> 600 CNAME <значение_dns_challenge>"
            ```

            Где:
            * `<значение_dns_challenge>` — сохраненное на предыдущем шаге значение, необходимое для проверки прав на соответствующий домен с помощью CNAME-записи.
            * `<поддомен>` — имя, которое вы присвоили поддомену CDN-ресурса. Например: `cdn`, в этом случае запись будет выглядеть как `_acme-challenge.cdn 600 CNAME fpq2gpi42teg********.cm.yandexcloud.net.` 

            Результат:

            ```text
            +--------+----------------------------------+-------+------------------------------------------+-----+
            | ACTION |              NAME                | TYPE  |                   DATA                   | TTL |
            +--------+----------------------------------+-------+------------------------------------------+-----+
            | +      | _acme-challenge.cdn.example.com. | CNAME | fpq2gpi42teg********.cm.yandexcloud.net. | 600 |
            | +      | _acme-challenge.example.com.     | CNAME | fpq2gpi42teg********.cm.yandexcloud.net. | 600 |
            +--------+----------------------------------+-------+------------------------------------------+-----+
            ```

            Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

            Проверка прав на домены может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

        1. Убедитесь, что статус сертификата изменился на `Issued`:

            ```bash
            yc certificate-manager certificate get \
              --name mymanagedcert
            ```

            Результат:

            ```text
            id: fpqr2j0sdb1n********
            folder_id: b1gt6g8ht345********
            created_at: "2023-12-24T16:38:02.206Z"
            name: mymanagedcert
            type: MANAGED
            domains:
              - cdn.example.com
              - example.com
            status: ISSUED
            issuer: CN=R3,O=Let's Encrypt,C=US
            subject: CN=cdn.example.com
            serial: 4b7d7f0968097ae1a7707854a80********
            updated_at: "2023-12-24T16:46:03.578Z"
            issued_at: "2023-12-24T16:46:03.578Z"
            not_after: "2024-03-23T15:44:59Z"
            not_before: "2023-12-24T15:45:00Z"
            ```

    - API {#api}

      Для получения информации, необходимой для прохождения процедуры проверки прав на домены, воспользуйтесь методом REST API [get](../../../certificate-manager/api-ref/Certificate/get.md) для ресурса [Certificate](../../../certificate-manager/api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Get](../../../certificate-manager/api-ref/grpc/Certificate/get.md) с флагом `view=FULL`.
      
      Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

    {% endlist %}

    {% note info %}

    Чтобы DNS-проверка прав на домен по записи `CNAME` прошла успешно, для поддомена `_acme-challenge` проверяемого доменного имени не должно быть других [ресурсных записей](../../../dns/concepts/resource-record.md), кроме `CNAME`. Например, для имени `_acme-challenge.example.com.` должна существовать только CNAME-запись и не должно быть TXT-записи.

    {% endnote %}


## Подготовьте бакет-источник для CDN-ресурса {#setup-bucket-origin}

1. Создайте бакет Object Storage, который будет использоваться в качестве [источника](../../../cdn/concepts/origins.md) для CDN-ресурса. [Имя бакета](../../../storage/concepts/bucket.md#naming) должно быть уникальным.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
      1. Перейдите в сервис **Object Storage**.
      1. Справа сверху нажмите **Создать бакет**.
      1. В поле **Имя** укажите имя бакета, например `cdn-source-bucket`.
      1. В поле **Макс. размер** укажите `1 ГБ`.
      1. В полях **Чтение объектов** и **Чтение списка объектов** выберите `Для всех`.
      1. Нажмите **Создать бакет**.
      1. На странице со списком бакетов выберите созданный бакет.
      1. На панели слева выберите **Настройки**.
      1. На вкладке **Веб-сайт**:
         * Выберите `Хостинг`.
         * В поле **Главная страница** укажите `index.html`.
      1. Нажмите **Сохранить**.

    - Yandex Cloud CLI {#cli}

      1. Создайте бакет:

          ```bash
          yc storage bucket create \
            --name <имя_бакета> \
            --default-storage-class standard \
            --max-size 1073741824 \
            --public-read \
            --public-list
          ```

          Где `--name` — имя бакета, уникальное для всего сервиса Object Storage. Например: `cdn-source-bucket`.

          Результат:

          ```text
          name: cdn-source-bucket
          folder_id: b1gt6g8ht345********
          anonymous_access_flags:
            read: false
            list: false
          default_storage_class: STANDARD
          versioning: VERSIONING_DISABLED
          max_size: "1073741824"
          acl: {}
          created_at: "2023-12-22T18:11:23.028836Z"
          ```

          Подробнее о команде `yc storage bucket create` читайте в [справочнике CLI](../../../cli/cli-ref/storage/cli-ref/bucket/create.md).

      1. Включите в бакете хостинг статического сайта:

          ```bash
          yc storage bucket update \
            --name <имя_бакета> \
            --website-settings '{"index": "index.html"}'
          ```

          Результат:

          ```text
          name: cdn-source-bucket
          folder_id: b1gt6g8ht345********
          default_storage_class: STANDARD
          versioning: VERSIONING_DISABLED
          max_size: "1073741824"
          acl: {}
          created_at: "2023-12-23T09:56:58.249721Z"
          website_settings:
            redirect_all_requests: {}
          ```

          Подробнее о команде `yc storage bucket update` читайте в [справочнике CLI](../../../cli/cli-ref/storage/cli-ref/bucket/update.md).

    - AWS CLI {#aws-cli}

      Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).

      [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту, через который работает AWS CLI, [роль](../../../storage/security/index.md#storage-editor) `storage.editor`.

      1. Создайте бакет:

          ```bash
          aws s3api create-bucket \
            --endpoint-url https://storage.yandexcloud.net \
            --bucket <имя_бакета> \
            --acl public-read
          ```

          Где `--bucket` — имя бакета, уникальное для всего сервиса Object Storage. Например: `cdn-source-bucket`.

          Результат:

          ```json
          {
              "Location": "/cdn-source-bucket"
          }
          ```

      1. Включите в бакете хостинг статического сайта:

          ```bash
          aws --endpoint-url https://storage.yandexcloud.net \
            s3 website "s3://<имя_бакета>" \
            --index-document index.html
          ```

          Где `<имя_бакета>` — имя созданного ранее бакета. Например: `cdn-source-bucket`.

    - API {#api}

      Чтобы создать бакет, воспользуйтесь методом REST API [create](../../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../../storage/s3/api-ref/bucket/create.md).

      Чтобы включить в бакете хостинг статического сайта, воспользуйтесь методом REST API [update](../../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../../storage/api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../../storage/s3/api-ref/hosting/upload.md).

    {% endlist %}

1. Загрузите в бакет [подготовленные](#prepare-files) файлы:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
      1. Перейдите в сервис **Object Storage**.
      1. Выберите созданный ранее бакет.
      1. В правом верхнем углу страницы нажмите ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить** и выберите созданные файлы `index.html` и `content.jpg`.
      1. В открывшемся окне подтвердите загрузку объектов.

    - AWS CLI {#cli}

      1. Загрузите в бакет файл `index.html`:

          ```bash
          aws --endpoint-url https://storage.yandexcloud.net \
            s3 cp ./index.html s3://<имя_бакета>/index.html
          ```

          Где `<имя_бакета>` — имя созданного ранее бакета. Например: `cdn-source-bucket`.

          Результат:

          ```txt
          upload: ./index.html to s3://cdn-source-bucket/index.html
          ```

      1. Загрузите в бакет файл `content.jpg`:

          ```bash
          aws --endpoint-url https://storage.yandexcloud.net \
            s3 cp ./content.jpg s3://<имя_бакета>/content.jpg
          ```

          Результат:

          ```txt
          upload: ./content.jpg to s3://cdn-source-bucket/content.jpg
          ```

    - API {#api}

      Чтобы загрузить файлы в бакет, воспользуйтесь методом S3 API [upload](../../../storage/s3/api-ref/object/upload.md).

    {% endlist %}


## Создайте CDN-ресурс {#setup-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
  1. Перейдите в сервис **Cloud CDN**.
  1. Нажмите **Создать ресурс**.
  1. Задайте основные настройки CDN-ресурса:
      * В блоке **Контент**:
        * Включите **Доступ к контенту**.
        * В поле **Запрос контента** выберите `Из одного источника`.
        * В поле **Тип источника** выберите `Сервер`.
        * В поле **Доменное имя источника** укажите `<имя_бакета>.website.yandexcloud.net`, где `<имя_бакета>` — имя созданного ранее бакета, используемого CDN-ресурсом в качестве источника.
        * В поле **Протокол для источников** выберите `Как у клиента`.
        * В поле **Доменное имя** укажите доменное имя, которое вы присвоите вашему CDN-ресурсу: например `cdn.example.com`.
      * В блоке **Дополнительно**:
        * В поле **Переадресация клиентов** выберите `Не использовать`.
        * В поле **Тип сертификата** выберите `Сертификат из Certificate Manager` и в появившемся списке выберите созданный ранее сертификат `mymanagedcert`.
        * В поле **Заголовок Host** выберите `Свое значение` и в появившемся поле **Значение заголовка** укажите `<имя_бакета>.website.yandexcloud.net`, где `<имя_бакета>` — имя созданного ранее бакета, использующегося CDN-ресурсом в качестве источника.
        * Включите опцию **Доступ по защищённому токену**:
          1. В появившемся поле **Секретный ключ** укажите секретный ключ — произвольную строку длиной от 6 до 32 символов. Он будет передан в конфигурацию CDN-ресурса и будет использоваться для формирования и проверки подписанных ссылок.
          1. В поле **Ограничение доступа по IP-адресу** выберите `Только доверенные IP-адреса`.
  1. Нажмите **Продолжить**.
  1. В разделах **Кеширование**, **HTTP-заголовки и методы** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Продолжить**.

- Yandex Cloud CLI {#cli}

  1. Создайте ресурс:
  
      ```bash
      yc cdn resource create <имя_поддомена> \
        --origin-custom-source <имя_бакета>.website.yandexcloud.net \
        --origin-protocol 'match' \
        --cert-manager-ssl-cert-id <идентификатор_сертификата> \
        --host-header <имя_бакета>.website.yandexcloud.net \
        --secure-key <секретный_ключ> \
        --enable-ip-url-signing
      ```

      Где:
      * `<имя_поддомена>` — доменное имя, для которого ранее был создан TLS-сертификат и которое будет использоваться CDN-ресурсом. Например: `cdn.example.com`.
      * `<имя_бакета>` — имя созданного ранее бакета Object Storage. Например: `cdn-source-bucket`.
      * `--cert-manager-ssl-cert-id` — идентификатор TLS-сертификата, сохраненный ранее при его создании.
      * `--secure-key` — секретный ключ, произвольная строка длиной от 6 до 32 символов. Секретный ключ будет передан в конфигурацию CDN-ресурса и будет использоваться для формирования и проверки подписанных ссылок.

      Результат:

      ```text
      id: bc8yqhobvxk6********
      folder_id: b1gt6g8ht345********
      cname: cdn.example.com
      created_at: "2024-06-22T19:59:05.430376Z"
      updated_at: "2024-06-22T19:59:05.430394Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "345600"
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        host_options:
          host:
            enabled: true
            value: cdn-source-bucket.website.yandexcloud.net
        stale:
          enabled: true
          value:
            - error
            - updating
        secure_key:
          enabled: true
          key: sdh********
          type: ENABLE_IP_SIGNING
      origin_group_id: "310699"
      origin_group_name: Origins for cdn.example.com (211929)
      origin_protocol: MATCH
      ssl_certificate:
        type: CM
        status: READY
        data:
          cm:
            id: fpqia0s2fc21********
      provider_type: ourcdn
      provider_cname: d88c6ee6********.topology.gslb.yccdn.ru
      ```

      Сохраните значение CNAME провайдера (значение поля `provider_cname`) — оно понадобится позднее.

      Подробнее о команде `yc cdn resource create` читайте в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../../cdn/api-ref/Resource/create.md) для ресурса [Resource](../../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../../cdn/api-ref/grpc/Resource/create.md).

{% endlist %}

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](../../../cdn/operations/resources/purge-cache.md).

Контент на созданном CDN-ресурсе будет доступен только по [подписанным ссылкам](../../../cdn/concepts/secure-tokens.md#protected-link).

## Создайте ресурсную запись CNAME для CDN-ресурса {#create-cdn-cname-record}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Получите](../../../cdn/operations/resources/get-resources-info.md#get-cname) значение доменного имени провайдера CDN.
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете создавать ресурсы.
  1. Перейдите в сервис **Cloud DNS**.
  1. Выберите созданную ранее DNS-зону.
  1. Нажмите **Создать запись**.
  1. Задайте параметры записи:

        * В поле **Имя** выберите `Создать поддомен` и укажите имя, которое вы присвоили поддомену CDN-ресурса. Например: если доменное имя вашего CDN-ресурса — `cdn.example.com`, укажите только `cdn`.
        * В поле **Тип** выберите [тип записи](../../../dns/concepts/resource-record.md#rr-types) `CNAME`.
        * В поле **Значение** укажите значение [доменного имени](../../../cdn/operations/resources/get-resources-info.md#get-cname) провайдера CDN.

  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

  1. Создайте ресурсную запись CNAME в сервисе Cloud DNS:

      ```bash
      yc dns zone add-records \
        --name my-domain-zone \
        --record "<поддомен> 600 CNAME <значение_cname>"
      ```

      Где:
      * `<поддомен>` — поддомен, созданный для CDN-ресурса. Например, для доменного имени `cdn.example.com` здесь нужно указать `cdn`.
      * `<значение_cname>` — полученное на предыдущем шаге значение `cname` CDN-провайдера.

      Результат:

      ```text
      +--------+------------------+-------+-------------------------------------------+-----+
      | ACTION |       NAME       | TYPE  |           DATA                            | TTL |
      +--------+------------------+-------+-------------------------------------------+-----+
      | +      | cdn.example.com. | CNAME | e1b83ae3********.topology.gslb.yccdn.ru | 600 |
      +--------+------------------+-------+-------------------------------------------+-----+
      ```

      Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  Чтобы получить значение CNAME-записи для CDN-ресурса, воспользуйтесь методом REST API [getProviderCName](../../../cdn/api-ref/Resource/getProviderCName.md) для ресурса [Resource](../../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/GetProviderCName](../../../cdn/api-ref/grpc/Resource/getProviderCName.md).

  Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

{% endlist %}


## Опубликуйте сайт на веб-сервере {#publish-website}

Далее вы создадите и опубликуете на вашем веб-сервере сайт, который будет генерировать подписанные ссылки на контент, расположенный на защищенном CDN-ресурсе. Чтобы обеспечить безопасность передаваемых данных, вы скопируете на веб-сервер созданный ранее TLS-сертификат и включите SSL-шифрование.


### Выгрузите сертификат из Certificate Manager {#export-certificate}

Чтобы использовать созданный в Certificate Manager TLS-сертификат в конфигурации вашего веб-сервера, выгрузите цепочку сертификатов и закрытый ключ в текущую директорию:

{% list tabs group=instructions %}

- Yandex Cloud CLI {#cli}

  1. Узнайте идентификатор созданного ранее TLS-сертификата:

      ```bash
      yc certificate-manager certificate list
      ```

      Результат:

      ```text
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      |          ID          |     NAME      |           DOMAINS           |      NOT AFTER      |  TYPE   | STATUS |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      | fpq90lobsh0l******** | mymanagedcert | cdn.example.com,example.com | 2024-03-22 16:42:53 | MANAGED | ISSUED |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      ```

      Подробнее о команде `yc certificate-manager certificate list` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/list.md).

  1. Выгрузите ключ и сертификат, указав полученный на предыдущем шаге идентификатор:

      ```bash
      yc certificate-manager certificate content \
        --id <идентификатор_сертификата> \
        --chain ./certificate_full_chain.pem \
        --key ./private_key.pem
      ```

      Подробнее о команде `yc certificate-manager certificate content` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/content.md).

{% endlist %}


### Настройте веб-сервер {#setup-web-server}

1. Скопируйте на ВМ с веб-сервером полученные сертификаты и закрытый ключ:

    ```bash
    scp ./certificate_full_chain.pem yc-user@<IP-адрес_ВМ>:certificate_full_chain.pem \
      && scp ./private_key.pem yc-user@<IP-адрес_ВМ>:private_key.pem
    ```

    Где `<IP-адрес_ВМ>` — публичный IP-адрес созданной ранее ВМ с веб-сервером.

    Узнать IP-адрес ВМ можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть** или с помощью команды CLI `yc compute instance get mywebserver`.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ с веб-сервером:

    ```bash
    ssh yc-user@<IP-адрес_ВМ>
    ```

1. Создайте директорию для сертификата и перенесите в нее скопированные файлы:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate_full_chain.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```

1. Создайте директорию для файлов вашего сайта и предоставьте необходимые права на нее пользователю `www-data`:

    ```bash
    sudo mkdir -p /var/www/<имя_домена>/public_html
    sudo chown www-data:www-data /var/www/<имя_домена>/public_html
    ```

    Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

1. Настройте виртуальный хост для вашего сайта:

    1. Создайте файл конфигурации виртуального хоста:

        ```bash
        sudo nano /etc/apache2/sites-available/mywebsite.conf
        ```

    1. Поместите в созданный файл следующую конфигурацию:

        ```text
        <VirtualHost *:443>
        ServerName <имя_домена>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/<имя_домена>/public_html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        SSLEngine on
        SSLCertificateFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateChainFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

    1. Активируйте созданный виртуальный хост:

        ```bash
        sudo a2ensite mywebsite
        ```

        Результат:

        ```text
        Enabling site mywebsite.
        To activate the new configuration, you need to run:
          systemctl reload apache2
        ```

    1. Включите для веб-сервера поддержку `ssl`:

        ```bash
        sudo a2enmod ssl
        ```

        Результат:

        ```text
        Considering dependency setenvif for ssl:
        Module setenvif already enabled
        Considering dependency mime for ssl:
        Module mime already enabled
        Considering dependency socache_shmcb for ssl:
        Enabling module socache_shmcb.
        Enabling module ssl.
        See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
        To activate the new configuration, you need to run:
          systemctl restart apache2
        ```

    1. Перезапустите веб-сервер:

        ```bash
        sudo systemctl reload apache2
        ```


### Создайте сайт {#create-website}

1. Создайте файл главной страницы сайта:

    ```bash
    sudo nano /var/www/<имя_домена>/public_html/index.php
    ```

    Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

1. Поместите в созданный файл `index.php` следующий код:

    ```php
    <!DOCTYPE html>
    <html>
    <head>
      <title>Secure token generator website</title>
      <meta charset="utf-8" />
    </head>
    <body>

      <h2>Генератор защищенных ссылок</h2>
      <p>Ниже сгенерирована подписанная ссылка на защищенный CDN-ресурс. Срок жизни ссылки — 5 минут. Контент по ссылке доступен лишь тому пользователю, для которого сайт эту ссылку сгенерировал (проверяется по IP-адресу).</p>
      <br>

      <?php

        $secret = '<секретный_ключ>';
        $ip = trim(getUserIpAddr());
        $domain_name = '<доменное_имя>';
        $path = '<ключ_объекта>';
        $expires = time() + 300;
        $link = "$expires$path$ip $secret";
        $md5 = md5($link, true);
        $md5 = base64_encode($md5);
        $md5 = strtr($md5, '+/', '-_');
        $md5 = str_replace('=', '', $md5);
        $url = '<a href="https://'.$domain_name.$path.'?md5='.$md5.'&expires='.$expires.'" target="_blank">Подписанная ссылка на файл</a>';
    
        echo "<p>Ваш IP-адрес: <b>".$ip."</b></p><p>Если вы используете VPN, ссылка может не сработать. Для корректной работы генератора подписанных ссылок отключите VPN.</p>";
        echo "<br><br>";
        echo $url;
    
        function getUserIpAddr() {

            if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
               $addr = $_SERVER['HTTP_CLIENT_IP'];
            } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
               $addr = $_SERVER['HTTP_X_FORWARDED_FOR'];
            } else {
               $addr = $_SERVER['REMOTE_ADDR'];
            }
            return $addr;
        }
      ?>

    </body>
    </html>
    ```

    Где:
    * `$secret` — созданный при настройке CDN-ресурса секретный ключ.
    * `$domain_name` — доменное имя созданного CDN-ресурса. Например: `cdn.example.com`.
    * `$path` — [ключ объекта](../../../storage/concepts/object.md#key) в бакете-[источнике](../../../cdn/concepts/origins.md), например `/content.jpg`. Обязательно со знаком `/`.
       Сайт будет генерировать подписанную ссылку для доступа к этому объекту через CDN-ресурс.


## Проверьте работу защищенного доступа к файлам {#check}

Чтобы проверить работу генератора подписанных ссылок на защищенный CDN-ресурс:

1. Откройте в браузере созданный сайт, например `https://example.com`.
1. Пройдите по сгенерированной ссылке.

    Если все работает правильно, у вас должно открыться изображение на защищенном CDN-ресурсе.

    {% note info %}

    Подключенный VPN может мешать правильной работе генератора подписанных ссылок. Для корректной работы сайта отключите VPN.

    {% endnote %}

1. Откройте полученную ссылку на другом устройстве, выходящем в интернет с другого IP-адреса. Например, на смартфоне.

    Доступ к контенту окажется запрещен.

1. Попробуйте открыть полученную ссылку на исходном устройстве по истечении пяти минут.

    Доступ к контенту окажется запрещен.

Вы настроили защищенный доступ к контенту.

При формировании ссылок также можно [задать](../../../cdn/operations/resources/enable-secure-token.md) определенный доверенный IP-адрес, например IP-адрес компании, который используется в корпоративной сети для доступа к интернету. Так вы сможете запретить доступ к вашему контенту за пределами сетевой инфраструктуры вашей компании.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../cdn/operations/resources/delete-resource.md) CDN-ресурс, затем [удалите](../../../cdn/operations/origin-groups/delete-group.md) группу источников.
1. [Удалите](../../../storage/operations/objects/delete.md) созданные в бакете объекты, затем [удалите](../../../storage/operations/buckets/delete.md) сам бакет.
1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) созданную виртуальную машину.
1. [Удалите](../../../dns/operations/zone-delete.md) созданную доменную зону.
1. [Удалите](../../../certificate-manager/operations/managed/cert-delete.md) созданный TLS-сертификат.
1. [Удалите](../../../vpc/operations/security-group-delete.md) созданную группу безопасности, затем [удалите](../../../vpc/operations/subnet-delete.md) созданную подсеть, затем [удалите](../../../vpc/operations/network-delete.md) созданную сеть.

#### Полезные ссылки {#see-also}

* [Организация защищенного доступа к контенту в Cloud CDN с помощью Terraform](terraform.md)