# Привязка доменного имени к ВМ с веб-сервером


В этом руководстве вы привяжете собственное доменное имя к [виртуальной машине](../../compute/concepts/vm.md) с веб-сервером. Доменное имя может быть зарегистрировано у любого регистратора доменных имен.

Виртуальная машина будет создана из публичного образа [LAMP](/marketplace/products/yc/lamp) с предустановленным веб-сервером [Apache HTTP Server](https://httpd.apache.org/). Также для руководства подойдет публичный образ [LEMP](/marketplace/products/yc/lemp) с веб-сервером [NGINX](https://www.nginx.com/).

Чтобы привязать доменное имя к ВМ с веб-сервером в {{ dns-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину с веб-сервером](#create-web-server).
1. [Создайте публичную зону DNS](#configure-dns).
1. [Делегируйте домен сервису {{ dns-name }}](#delegate-domain).
1. [Создайте ресурсную запись типа A](#create-record).
1. [Проверьте работу сайта](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также привязать доменное имя к виртуальной машине с веб-сервером можно через {{ TF }} с помощью [готового файла конфигурации](#terraform).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемого решения входят:

* плата за использование публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичной DNS-зоны и публичные DNS-запросы (см. [тарифы {{ dns-full-name }}](../../dns/pricing.md)).



### Создайте облачную сеть и подсеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `webserver-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. На панели слева выберите ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.common.create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** укажите `webserver-subnet-{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** выберите [облачную сеть](../../vpc/concepts/network.md) `webserver-network`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** укажите `192.168.1.0/24`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте [облачную сеть](../../vpc/concepts/network.md) `webserver-network`:

      ```bash
      yc vpc network create webserver-network
      ```

      Результат:

      ```
      id: enp1gg8kr3pv********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:08:11Z"
      name: webserver-network
      default_security_group_id: enppne4l2eg5********
      ```

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).

  1. Создайте подсеть в [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`:

      ```bash
      yc vpc subnet create webserver-subnet-{{ region-id }}-b \
        --zone {{ region-id }}-b \
        --network-name webserver-network \
        --range 192.168.1.0/24
      ```

      Результат:

      ``` 
      id: e2li9tcgi7ii********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:11:16Z"
      name: webserver-subnet-{{ region-id }}-b
      network_id: enp1gg8kr3pv********
      zone_id: {{ region-id }}-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API {#api}

  1. Чтобы создать [облачную сеть](../../vpc/concepts/network.md), воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create).

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create).

{% endlist %}


### Создайте группу безопасности {#create-sg}

Создайте [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую входящий TCP-трафик для портов `22`, `80` и `443`, а также любой исходящий трафик.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**. 
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя `webserver-sg`.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите созданную ранее сеть `webserver-network`.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `http`           | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Входящий | `https`            | `443`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Входящий | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

  Сохраните полученный идентификатор (`id`) группы безопасности: он пригодится при создании виртуальной машины.

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API {#api}

  Чтобы создать группу безопасности, воспользуйтесь методом REST API [create](../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/security_group_service.md#Create).

{% endlist %}


## Создайте виртуальную машину с веб-сервером {#create-web-server}

Перед тем как приступать к созданию виртуальной машины, подготовьте [пару ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для доступа к ВМ по SSH.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * В поле **{{ ui-key.yacloud.common.name }}** укажите имя `mywebserver`.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите `{{ region-id }}-b`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
  1. В открывшемся окне найдите и выберите продукт [LAMP](/marketplace/products/yc/lamp).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите созданную ранее подсеть `webserver-subnet-{{ region-id }}-b`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу безопасности `webserver-sg`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите имя пользователя `yc-user`.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое созданного ранее [публичного ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Выполните команду, указав сохраненный на предыдущем шаге идентификатор группы безопасности:

  ```bash
  yc compute instance create \
    --name mywebserver \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=webserver-subnet-{{ region-id }}-b,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
    --create-boot-disk image-folder-id=standard-images,image-id=fd8jtn9i7e9ha5q25niu \
    --ssh-key <SSH-ключ>
  ```

  Где `--ssh-key` — путь к файлу с открытым SSH-ключом и его имя. Например `~/.ssh/id_ed25519.pub`.

  Результат:

  ```yml

  done (32s)
  id: fhmaq4shfrcm********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-23T05:36:34Z"
  name: mywebserver
  zone_id: {{ region-id }}-b
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

  Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/compute/instance/create.md).

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API {#api}

  Чтобы создать виртуальную машину, воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/instance_service.md#Create).

{% endlist %}

В вашем каталоге будет создана виртуальная машина `mywebserver`. Чтобы [подключиться](../../compute/operations/vm-connect/ssh.md#vm-connect) к ней по SSH, используйте логин `yc-user` и публичный IP-адрес этой ВМ. Если вы планируете пользоваться созданным веб-сервером длительное время, [сделайте](../../vpc/operations/set-static-ip.md) публичный IP-адрес этой ВМ статическим.


## Создайте публичную зону DNS {#configure-dns}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Задайте настройки [зоны DNS](../../dns/concepts/dns-zone.md), соответствующие вашему домену:

      1. **{{ ui-key.yacloud.dns.label_zone }}** — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).
      1. **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_public }}`.
      1. **{{ ui-key.yacloud.common.name }}** — имя зоны.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc dns zone create \
    --name <имя_зоны> \
    --zone <доменная_зона> \
    --public-visibility
  ```

  Где:

  * `--name` — имя [зоны DNS](../../dns/concepts/dns-zone.md).
  * `--zone` — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).

  Результат:

  ```
  id: dns39gihj0ef********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-21T16:43:37.883Z"
  name: my-domain-zone
  zone: example.com.
  public_visibility: {}
  ```

  Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/dns/zone/create.md).

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API {#api}

  Чтобы создать публичную [зону DNS](../../dns/concepts/dns-zone.md), воспользуйтесь методом REST API [create](../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create).

{% endlist %}


## Делегируйте домен сервису {{ dns-name }} {#delegate-domain}

Чтобы делегировать домен сервису {{ dns-name }}, в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов:

* `ns1.{{ dns-ns-host-sld }}`
* `ns2.{{ dns-ns-host-sld }}`

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи до 24 часов (86400 секунд). Это обусловлено значением TTL, в течение которого кэшируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:


```
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```




## Создайте ресурсную запись типа A {#create-record}

Создайте в вашей зоне DNS [ресурсную запись типа А](../../dns/concepts/resource-record.md#a), указывающую на публичный IP-адрес веб-сервера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите созданную ранее DNS-зону.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Задайте параметры записи:
      1. В поле **{{ ui-key.yacloud.common.name }}** выберите `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
      1. В поле **{{ ui-key.yacloud.common.type }}** выберите [тип записи](../../dns/concepts/resource-record.md#rr-types) `A`.
      1. В поле **{{ ui-key.yacloud.dns.label_records }}** укажите [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) веб-сервера.

          Узнать IP-адрес виртуальной машины можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** или с помощью команды CLI `yc compute instance get <имя_ВМ>`.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

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
      * `<IP-адрес_ВМ>` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) веб-сервера.

          Узнать IP-адрес виртуальной машины можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** или с помощью команды CLI `yc compute instance get <имя_ВМ>`.

  Результат:

  ```text
  +--------+--------------+------+---------------+-----+
  | ACTION |     NAME     | TYPE |     DATA      | TTL |
  +--------+--------------+------+---------------+-----+
  | +      | example.com. | A    | 51.250.**.*** | 600 |
  +--------+--------------+------+---------------+-----+
  ```

  Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/dns/zone/add-records.md).

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API {#api}

  Чтобы создать ресурсную запись в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets).

{% endlist %}


## Проверьте работу сайта {#check}

Теперь сайт на вашем веб-сервере доступен по доменному имени. Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:

* `http://<публичный_IP-адрес_ВМ>`
* `http://example.com`


## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. В сервисе {{ compute-name }} [удалите](../../compute/operations/vm-control/vm-delete.md) созданную виртуальную машину.
1. В сервисе {{ dns-name }} [удалите](../../dns/operations/zone-delete.md) созданную доменную зону.
1. В сервисе {{ vpc-name }} [удалите](../../vpc/operations/security-group-delete.md) созданную группу безопасности, затем [удалите](../../vpc/operations/subnet-delete.md) созданную подсеть, затем [удалите](../../vpc/operations/network-delete.md) созданную сеть.


## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру для привязки доменного имени к ВМ с веб-сервером в {{ dns-name }} с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs %}

    - Готовый архив

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/???) (2 КБ).
      1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `bind-domain-to-vm.tf` и файл с пользовательскими данными `bind-domain-to-vm.auto.tfvars`.

    - Создание вручную

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `bind-domain-to-vm.tf`:

          {% cut "bind-domain-to-vm.tf" %}

          {% include [bind-domain-to-vm-tf-config](../../_includes/web/bind-domain-to-vm-tf-config.md) %}

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `bind-domain-to-vm.auto.tfvars`:

          {% cut "bind-domain-to-vm.auto.tfvars" %}

          {% include [bind-domain-to-vm-tf-variables](../../_includes/web/bind-domain-to-vm-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
    * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
    * [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
    * [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. В файле `bind-domain-to-vm.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ, например `~/.ssh/id_ed25519.pub`. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain_name` — имя вашего домена, например `example.com`.

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Проверьте работу защищенного доступа к файлам](#check).

#### См. также {#see-also}

* [Интеграция {{ dns-name }} с {{ compute-name }}](../../dns/concepts/compute-integration.md)