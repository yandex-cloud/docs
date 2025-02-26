# Организация защищенного доступа к контенту в {{ cdn-name }} с помощью консоли управления, CLI или API

Чтобы настроить защищенный доступ к контенту в {{ cdn-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину с веб-сервером](#create-web-server).
1. [Создайте и настройте публичную зону DNS](#configure-dns).
1. [Добавьте TLS-сертификат в {{ certificate-manager-full-name }}](#issue-certificate).
1. [Подготовьте бакет-источник для CDN-ресурса](#setup-bucket-origin).
1. [Создайте CDN-ресурс](#setup-cdn-resource).
1. [Создайте ресурсную запись CNAME для CDN-ресурса](#create-cdn-cname-record).
1. [Опубликуйте сайт на веб-сервере](#publish-website).
1. [Проверьте работу защищенного доступа к файлам](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/protected-access-to-content/paid-resources.md) %}


### Создайте облачную сеть и подсеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console} 

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `webserver-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.vpc.subnetworks.button_action-create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** укажите `webserver-subnet-{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** выберите зону доступности `{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** выберите облачную сеть `webserver-network`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** укажите `192.168.1.0/24`.
  1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

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

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсеть в зоне доступности `{{ region-id }}-b`:

      ```bash
      yc vpc subnet create webserver-subnet-{{ region-id }}-b \
        --zone {{ region-id }}-b \
        --network-name webserver-network \
        --range 192.168.1.0/24
      ```

      Результат:

      ```text
      id: e2li9tcgi7ii********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:11:16Z"
      name: webserver-subnet-{{ region-id }}-b
      network_id: enp1gg8kr3pv********
      zone_id: {{ region-id }}-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


### Создайте группу безопасности {#create-sg}

Создайте [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую входящий TCP-трафик для портов `22`, `80` и `443`, а также любой исходящий трафик.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
  1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя `webserver-sg`.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите созданную ранее сеть `webserver-network`.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `http`           | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Входящий | `https`            | `443`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Входящий | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}
  
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

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

  Сохраните полученный идентификатор (`id`) группы безопасности — он понадобится при создании ВМ.

- API {#api}

  Чтобы создать группу безопасности, воспользуйтесь методом REST API [create](../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md).

{% endlist %}


### Подготовьте файлы для загрузки в бакет {#prepare-files}

{% include [prepare-files](../_tutorials_includes/protected-access-to-content/prepare-files.md) %}


## Создайте виртуальную машину с веб-сервером {#create-web-server}

Перед тем как приступать к созданию ВМ, подготовьте [пару ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для доступа к ВМ по SSH.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `LAMP` и выберите образ [LAMP](/marketplace/products/yc/lamp).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите созданную ранее подсеть `webserver-subnet-{{ region-id }}-b`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу безопасности `webserver-sg`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ::

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя: `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `mywebserver`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name mywebserver \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=webserver-subnet-{{ region-id }}-b,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
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

  Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Чтобы создать ВМ, воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}

В вашем каталоге будет создана ВМ `mywebserver`. Чтобы [подключиться](../../compute/operations/vm-connect/ssh.md#vm-connect) к ней по SSH, используйте логин `yc-user` и [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) этой ВМ. Если вы планируете пользоваться созданным веб-сервером длительное время, [сделайте](../../vpc/operations/set-static-ip.md) публичный IP-адрес этой ВМ статическим.


## Создайте и настройте публичную зону DNS {#configure-dns}

1. Создайте публичную [зону DNS](../../dns/concepts/dns-zone.md) в {{ dns-full-name }}.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. Нажмите **{{ ui-key.yacloud.dns.button_zone-create }}**.
      1. Задайте настройки зоны, соответствующие вашему домену:

         1. **{{ ui-key.yacloud.dns.label_zone }}** — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).
         1. **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_public }}`.
         1. **{{ ui-key.yacloud.common.name }}** — `my-domain-zone`.

      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    - {{ yandex-cloud }} CLI {#cli}

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

      Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/create.md).

    - API {#api}

      Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md).

    {% endlist %}

1. {% include [delegate-domain](../_tutorials_includes/protected-access-to-content/delegate-domain.md) %}

1. Создайте в вашей зоне DNS ресурсную A-запись, указывающую на публичный IP-адрес созданной ранее ВМ с веб-сервером:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. Выберите созданную ранее DNS-зону.
      1. Нажмите **{{ ui-key.yacloud.dns.button_record-set-create }}**.
      1. Задайте параметры записи:
         1. В поле **{{ ui-key.yacloud.common.name }}** выберите `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
         1. В поле **{{ ui-key.yacloud.common.type }}** выберите [тип записи](../../dns/concepts/resource-record.md#rr-types) `A`.
         1. В поле **{{ ui-key.yacloud.dns.label_records }}** укажите [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) созданной ранее ВМ с веб-сервером.

             Узнать IP-адрес ВМ можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** или с помощью команды CLI `yc compute instance get mywebserver`.

      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    - {{ yandex-cloud }} CLI {#cli}

      Выполните команду:

      ```bash
      yc dns zone add-records \
        --name my-domain-zone \
        --record "@ 600 A <IP-адрес_ВМ>"
      ```

      Где `<IP-адрес_ВМ>` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) созданной ранее ВМ с веб-сервером.

      Узнать IP-адрес ВМ можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** или с помощью команды CLI `yc compute instance get mywebserver`.

      Результат:

      ```text
      +--------+--------------+------+---------------+-----+
      | ACTION |     NAME     | TYPE |     DATA      | TTL |
      +--------+--------------+------+---------------+-----+
      | +      | example.com. | A    | 51.250.**.*** | 600 |
      +--------+--------------+------+---------------+-----+
      ```

      Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

    - API {#api}

      Чтобы создать ресурсную запись в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

    {% endlist %}


## Добавьте TLS-сертификат в {{ certificate-manager-full-name }} {#issue-certificate}

1. Добавьте в сервис {{ certificate-manager-name }} [сертификат](../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для ваших доменов, которые будут использоваться веб-сервером и CDN-ресурсом.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** и выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** укажите `mymanagedcert`.
      1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** укажите имя вашего домена, например `example.com`.

          В этом же поле укажите с новой строки имя поддомена, который будет использоваться для CDN-ресурса, например `cdn.example.com`.
      1. Выберите [тип проверки прав на домен](../../certificate-manager/concepts/challenges.md) `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}`.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

    - {{ yandex-cloud }} CLI {#cli}

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

      Подробнее о команде `yc certificate-manager certificate request` читайте в [справочнике CLI](../../cli/cli-ref/certificate-manager/cli-ref/certificate/request.md).

      Сохраните идентификатор (`id`) созданного сертификата: он пригодится при создании CDN-ресурса.

    - API {#api}

      Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../certificate-manager/api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/RequestNew](../../certificate-manager/api-ref/grpc/Certificate/requestNew.md).

    {% endlist %}

    В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домены](../../certificate-manager/operations/managed/cert-validate.md).

1. Для успешного выпуска сертификата пройдите проверку прав на домены:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
        1. В списке сертификатов выберите `mymanagedcert`.
        1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** выберите `CNAME-запись`.
        1. В секции первого домена ниже нажмите **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}** и в открывшемся окне нажмите **{{ ui-key.yacloud.common.create }}**.
        1. Повторите предыдущее действие для второго домена.

        Проверка прав на домены может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

    - {{ yandex-cloud }} CLI {#cli}

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

            Подробнее о команде `yc certificate-manager certificate get` читайте в [справочнике CLI](../../cli/cli-ref/certificate-manager/cli-ref/certificate/get.md).

            Сохраните значения полей `value` из разделов с типом `CNAME` в блоках `challenges.dns_challenge` для обоих доменных имен. Эти значения понадобятся на следующем шаге.

        1. Создайте [ресурсные записи](../../dns/concepts/resource-record.md) CNAME для прохождения проверки ваших прав на домены:

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

            Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

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

      Для получения информации, необходимой для прохождения процедуры проверки прав на домены, воспользуйтесь методом REST API [get](../../certificate-manager/api-ref/Certificate/get.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/Get](../../certificate-manager/api-ref/grpc/Certificate/get.md) с флагом `view=FULL`.
      
      Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

    {% endlist %}

    {% note info %}

    {% include [checking-domain-rights-cname](../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

    {% endnote %}


## Подготовьте бакет-источник для CDN-ресурса {#setup-bucket-origin}

1. Создайте бакет {{ objstorage-name }}, который будет использоваться в качестве [источника](../../cdn/concepts/origins.md) для CDN-ресурса. [Имя бакета](../../storage/concepts/bucket.md#naming) должно быть уникальным.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Справа сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета, например `cdn-source-bucket`.
      1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** укажите `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
      1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
      1. На странице со списком бакетов выберите созданный бакет.
      1. На панели слева выберите **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. На вкладке **{{ ui-key.yacloud.storage.bucket.switch_website }}**:
         * Выберите `{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}`.
         * В поле **{{ ui-key.yacloud.storage.bucket.website.field_index }}** укажите `index.html`.
      1. Нажмите **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

    - {{ yandex-cloud }} CLI {#cli}

      1. Создайте бакет:

          ```bash
          yc storage bucket create \
            --name <имя_бакета> \
            --default-storage-class standard \
            --max-size 1073741824 \
            --public-read \
            --public-list
          ```

          Где `--name` — имя бакета, уникальное для всего сервиса {{ objstorage-name }}. Например: `cdn-source-bucket`.

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

          Подробнее о команде `yc storage bucket create` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

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

          Подробнее о команде `yc storage bucket update` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/bucket/update.md).

    - AWS CLI {#aws-cli}

      Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).

      [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту, через который работает AWS CLI, [роль](../../storage/security/index.md#storage-editor) `storage.editor`.

      1. Создайте бакет:

          ```bash
          aws s3api create-bucket \
            --endpoint-url https://{{ s3-storage-host }} \
            --bucket <имя_бакета> \
            --acl public-read
          ```

          Где `--bucket` — имя бакета, уникальное для всего сервиса {{ objstorage-name }}. Например: `cdn-source-bucket`.

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

      Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

      Чтобы включить в бакете хостинг статического сайта, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../storage/s3/api-ref/hosting/upload.md).

    {% endlist %}

1. Загрузите в бакет [подготовленные](#prepare-files) файлы:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Выберите созданный ранее бакет.
      1. В правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** и выберите созданные файлы `index.html` и `content.jpg`.
      1. В открывшемся окне подтвердите загрузку объектов.

    - AWS CLI {#cli}

      1. Загрузите в бакет файл `index.html`:

          ```bash
          aws --endpoint-url https://{{ s3-storage-host }} \
            s3 cp ./index.html s3://<имя_бакета>/index.html
          ```

          Где `<имя_бакета>` — имя созданного ранее бакета. Например: `cdn-source-bucket`.

          Результат:

          ```txt
          upload: ./index.html to s3://cdn-source-bucket/index.html
          ```

      1. Загрузите в бакет файл `content.jpg`:

          ```bash
          aws --endpoint-url https://{{ s3-storage-host }} \
            s3 cp ./content.jpg s3://<имя_бакета>/content.jpg
          ```

          Результат:

          ```txt
          upload: ./content.jpg to s3://cdn-source-bucket/content.jpg
          ```

    - API {#api}

      Чтобы загрузить файлы в бакет, воспользуйтесь методом S3 API [upload](../../storage/s3/api-ref/object/upload.md).

    {% endlist %}


## Создайте CDN-ресурс {#setup-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. {% include [activate-provider](../../_includes/cdn/activate-provider.md) %}

  1. Нажмите **{{ ui-key.yacloud.cdn.button_resource-create }}**.

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-content }}** укажите:

      * **{{ ui-key.yacloud.cdn.label_content-query-type }}** — `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
      * **{{ ui-key.yacloud.cdn.label_source-type }}** — `{{ ui-key.yacloud.cdn.value_source-type-url }}`.
      * В поле **{{ ui-key.yacloud.cdn.field_origin }}** укажите `<имя_бакета>.{{ s3-web-host }}`, где `<имя_бакета>` — имя созданного ранее бакета, использующегося CDN-ресурсом в качестве источника.

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-domain }}** в поле **{{ ui-key.yacloud.cdn.label_personal-domain }}** укажите доменное имя, которое вы присвоите вашему CDN-ресурсу: например `cdn.example.com`.

      {% note info %}

      Внизу блока **{{ ui-key.yacloud.cdn.label_section-domain }}** отобразилось значение доменного имени {{ cdn-name }} провайдера. Скопируйте это значение, оно потребуется при создании CNAME-записи для CDN-ресурса.

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:

      1. В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите `{{ ui-key.yacloud.cdn.value_protocol-match }}`.
      1. В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_do-not-use }}`.
      1. В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите `{{ ui-key.yacloud.cdn.value_certificate-custom }}` и в появившемся списке выберите созданный ранее сертификат `mymanagedcert`.
      1. В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}` и появившемся поле **{{ ui-key.yacloud.cdn.label_custom-host-header }}** укажите `<имя_бакета>.{{ s3-web-host }}`, где `<имя_бакета>` — имя созданного ранее бакета, использующегося CDN-ресурсом в качестве источника.
      1. Включите опцию **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**.
      1. В появившемся поле **{{ ui-key.yacloud.cdn.field_secure-key }}** укажите секретный ключ — произвольную строку длиной от 6 до 32 символов. Он будет передан в конфигурацию CDN-ресурса и будет использоваться для формирования и проверки подписанных ссылок.
      1. В поле **{{ ui-key.yacloud.cdn.field_secure-key-type }}** выберите `{{ ui-key.yacloud.cdn.value_secure-key-type-enable }}`.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Если вы создаете свой первый CDN-ресурс, сначала подключитесь к провайдеру:

      ```bash
      yc cdn provider activate \
        --type gcore
      ```

      Подробнее о команде `yc cdn provider activate` читайте в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/provider/activate.md).

  1. Создайте ресурс:
  
      ```bash
      yc cdn resource create <имя_поддомена> \
        --origin-custom-source <имя_бакета>.{{ s3-web-host }} \
        --origin-protocol 'match' \
        --cert-manager-ssl-cert-id <идентификатор_сертификата> \
        --host-header <имя_бакета>.{{ s3-web-host }} \
        --secure-key <секретный_ключ> \
        --enable-ip-url-signing
      ```

      Где:
      * `<имя_поддомена>` — доменное имя, для которого ранее был создан TLS-сертификат и которое будет использоваться CDN-ресурсом. Например: `cdn.example.com`.
      * `<имя_бакета>` — имя созданного ранее бакета {{ objstorage-name }}. Например: `cdn-source-bucket`.
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
            value: cdn-source-bucket.{{ s3-web-host }}
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
      ```

      Подробнее о команде `yc cdn resource create` читайте в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/resource/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../cdn/api-ref/Resource/create.md) для ресурса [Resource](../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md).

{% endlist %}

{% include [after-changes-tip](../../_includes/cdn/after-changes-tip.md) %}

{% include [content-through-signed-links](../_tutorials_includes/protected-access-to-content/content-through-signed-links.md) %}

## Создайте ресурсную запись CNAME для CDN-ресурса {#create-cdn-cname-record}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать ресурсы.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите созданную ранее DNS-зону.
  1. Нажмите **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Задайте параметры записи:

        * В поле **{{ ui-key.yacloud.common.name }}** выберите `{{ ui-key.yacloud.dns.label_create-subdomain }}` и укажите имя, которое вы присвоили поддомену CDN-ресурса. Например: если доменное имя вашего CDN-ресурса — `cdn.example.com`, укажите только `cdn`.
        * В поле **{{ ui-key.yacloud.common.type }}** выберите [тип записи](../../dns/concepts/resource-record.md#rr-types) `CNAME`.
        * В поле **{{ ui-key.yacloud.dns.label_records }}** укажите скопированное при создании CDN-ресурса, значение [доменного имени](../../cdn/operations/resources/get-resources-info.md#get-cname) {{ cdn-name }} провайдера.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Получите значение [доменного имени](../../cdn/operations/resources/get-resources-info.md#get-cname) {{ cdn-name }} провайдера:  

      ```bash
      yc cdn resource get-provider-cname
      ```

      Результат:

      ```text
      cname: cl-ms6*****90.edgecdn.ru
      folder_id: b1gt6g8ht345********
      ```

      Подробнее о команде `yc cdn resource get-provider-cname` читайте в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/resource/get-provider-cname.md).

      Сохраните полученное значение `cname`: оно пригодится на следующем шаге.

  1. Создайте ресурсную запись CNAME в сервисе {{ dns-name }}:

      ```bash
      yc dns zone add-records \
        --name my-domain-zone \
        --record "<поддомен> 600 CNAME <значение_cname>"
      ```

      Где:
      * `<поддомен>` — поддомен, созданный для CDN-ресурса. Например, для доменного имени `cdn.example.com` здесь нужно указать `cdn`.
      * `<значение_cname>` — полученное на предыдущем шаге значение `cname` для CDN-ресурса.

      Результат:

      ```text
      +--------+------------------+-------+--------------------------+-----+
      | ACTION |       NAME       | TYPE  |           DATA           | TTL |
      +--------+------------------+-------+--------------------------+-----+
      | +      | cdn.example.com. | CNAME | cl-ms6*****90.edgecdn.ru | 600 |
      +--------+------------------+-------+--------------------------+-----+
      ```

      Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  Чтобы получить значение CNAME-записи для CDN-ресурса, воспользуйтесь методом REST API [getProviderCName](../../cdn/api-ref/Resource/getProviderCName.md) для ресурса [Resource](../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/GetProviderCName](../../cdn/api-ref/grpc/Resource/getProviderCName.md).

  Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

{% endlist %}


## Опубликуйте сайт на веб-сервере {#publish-website}

{% include [publish-website](../_tutorials_includes/protected-access-to-content/publish-website.md) %}


## Проверьте работу защищенного доступа к файлам {#check}

{% include [check](../_tutorials_includes/protected-access-to-content/check.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../cdn/operations/resources/delete-resource.md) CDN-ресурс, затем [удалите](../../cdn/operations/origin-groups/delete-group.md) группу источников.
1. [Удалите](../../storage/operations/objects/delete.md) созданные в бакете объекты, затем [удалите](../../storage/operations/buckets/delete.md) сам бакет.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) созданную виртуальную машину.
1. [Удалите](../../dns/operations/zone-delete.md) созданную доменную зону.
1. [Удалите](../../certificate-manager/operations/managed/cert-delete.md) созданный TLS-сертификат.
1. [Удалите](../../vpc/operations/security-group-delete.md) созданную группу безопасности, затем [удалите](../../vpc/operations/subnet-delete.md) созданную подсеть, затем [удалите](../../vpc/operations/network-delete.md) созданную сеть.