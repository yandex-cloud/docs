1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте публичную зону DNS](#configure-dns).
1. [Добавьте сертификат в {{ certificate-manager-name }}](#add-certificate).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте группу безопасности](#create-security-group).
1. [Создайте бакет в {{ objstorage-name }}](#create-buckets).
1. [Загрузите файл сервиса в бакет](#upload-files).
1. [Создайте группу бэкендов в {{ alb-name }}](#create-l7backend).
1. [Создайте HTTP-роутер и виртуальный хост](#create-route-hosts).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Создайте ресурсную запись CNAME для CDN-ресурса](#create-cdn-cname-record).
1. [Проверьте работу сервиса](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Поддерживаемые инструменты {#supported-tools}

Для выполнения шагов можно использовать различные поддерживаемые инструменты. Бо́льшую часть шагов можно выполнить с помощью любого из стандартных инструментов: [консоли управления]({{ link-console-main }}), интерфейсов командной строки [{{ yandex-cloud }} CLI](../../cli/index.yaml) и [API {{ yandex-cloud }}](../../api-design-guide/index.yaml). В каждом шаге перечислены поддерживаемые для него инструменты.

Некоторые инструменты поддерживаются не для всех шагов: через {{ yandex-cloud }} CLI сейчас нельзя [создать группу бэкендов в {{ alb-name }} с бакетами в качестве бэкендов](#create-l7backend).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

В качестве примера будет использоваться каталог с именем `example-folder`.

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/cdn-storage-integration/paid-resources.md) %}

## Создайте и настройте публичную зону DNS {#configure-dns}

{% note info %}

В настоящем руководстве рассматривается сценарий, при котором доменом управляет сервис [{{ dns-full-name }}](../../dns/index.yaml).

Если вы не хотите делегировать управление вашим доменом платформе {{ yandex-cloud }}, вы можете выполнить необходимые настройки DNS с использованием инструментов, которые предлагает ваш администратор домена. В этом случае для создания ресурсных записей воспользуйтесь документацией вашего администратора домена или обратитесь в службу его технической поддержки.

{% endnote %}

Чтобы настроить публичную зону DNS в инфраструктуре {{ yandex-cloud }}:

1. {% include [delegate-domain](../_tutorials_includes/protected-access-to-content/delegate-domain.md) %}
1. Создайте публичную [зону DNS](../../dns/concepts/dns-zone.md) в {{ dns-full-name }}.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. Нажмите **{{ ui-key.yacloud.dns.button_zone-create }}**.
      1. Задайте настройки зоны, соответствующие вашему домену:

         1. **{{ ui-key.yacloud.dns.label_zone }}** — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).
         1. **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_public }}`.
         1. **{{ ui-key.yacloud.common.name }}** — `my-domain-zone`.

      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      yc dns zone create \
        --name my-domain-zone \
        --zone <имя_домена> \
        --public-visibility
      ```

      Где `--zone` — имя вашего домена, например `example.com.`. Значение параметра `--zone` должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`.

      Результат:

      ```text
      id: dns6b0mdas5r********
      folder_id: b1gt6g8ht345********
      created_at: "2026-02-05T10:42:16.017Z"
      name: my-domain-zone
      zone: example.com.
      public_visibility: {}
      ```

      Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/create.md).

    - API {#api}

      Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md).

    {% endlist %}

## Добавьте сертификат в {{ certificate-manager-name }} {#add-certificate}

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

В настоящем руководстве рассматривается сценарий, при котором для CDN-ресурса создается новый сертификат от Let's Encrypt®.

1. Добавьте в сервис {{ certificate-manager-name }} [сертификат](../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для вашего домена:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** и выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** укажите `mymanagedcert`.
      1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** укажите имя вашего домена, например `example.com`.
      1. Выберите [тип проверки прав на домен](../../certificate-manager/concepts/challenges.md) `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}`.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

    - {{ yandex-cloud }} CLI {#cli}

      Выполните команду:

      ```bash
      yc certificate-manager certificate request \
        --name mymanagedcert \
        --challenge dns \
        --domains <имя_домена>
      ```

      Где `<имя_домена>` — имя вашего домена. Например: `example.com`.

      Результат:

      ```text
      id: fpq7t9dpi4o0********
      folder_id: b1gt6g8ht345********
      created_at: "2026-02-05T11:00:15.952968372Z"
      name: mymanagedcert
      type: MANAGED
      domains:
        - example.com
      status: VALIDATING
      updated_at: "2026-02-05T11:00:15.952968372Z"
      ```

      Подробнее о команде `yc certificate-manager certificate request` читайте в [справочнике CLI](../../cli/cli-ref/certificate-manager/cli-ref/certificate/request.md).

      Сохраните идентификатор (`id`) созданного сертификата: он пригодится при создании CDN-ресурса.

    - API {#api}

      Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../certificate-manager/api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/RequestNew](../../certificate-manager/api-ref/grpc/Certificate/requestNew.md).

    {% endlist %}

    В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домен](../../certificate-manager/operations/managed/cert-validate.md).

1. Для успешного выпуска сертификата пройдите проверку прав на домен:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
        1. В списке сертификатов выберите `mymanagedcert`.
        1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** выберите `CNAME-запись` и ниже в секции с вашим доменом нажмите **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.
        1. В открывшемся окне подтвердите создание ресурсной записи.

        Проверка прав на домен может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

    - {{ yandex-cloud }} CLI {#cli}

        1. Получите значения ресурсной записи, необходимой для прохождения проверки:

            ```bash
            yc certificate-manager certificate get \
              --name mymanagedcert \
              --full
            ```

            Результат:

            ```text
            id: fpq7t9dpi4o0********
            folder_id: b1gt6g8ht345********
            created_at: "2026-02-05T11:00:15.952Z"
            name: mymanagedcert
            type: MANAGED
            domains:
              - example.com
            status: VALIDATING
            updated_at: "2026-02-05T11:00:15.952Z"
            challenges:
              - domain: example.com
                type: DNS
                created_at: "2026-02-05T11:00:15.952968372Z"
                updated_at: "2026-02-05T11:00:19.659820021Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.example.com.
                  type: CNAME
                  value: fpq7t9dpi4o0********.cm.yandexcloud.net.
              - domain: example.com
                type: DNS
                created_at: "2026-02-05T11:00:15.952968372Z"
                updated_at: "2026-02-05T11:00:19.659820021Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.example.com.
                  type: TXT
                  value: 77LcWo8-Qx4sHJuFDoNCpptLZkyWVW5A2dY********
            ```

            Подробнее о команде `yc certificate-manager certificate get` читайте в [справочнике CLI](../../cli/cli-ref/certificate-manager/cli-ref/certificate/get.md).

            Сохраните значение поля `value` из раздела с типом `CNAME` в блоке `challenges.dns_challenge`. Это значение понадобится на следующем шаге.

        1. Создайте [ресурсную запись](../../dns/concepts/resource-record.md) CNAME для прохождения проверки ваших прав на домен:

            ```bash
            yc dns zone add-records \
              --name my-domain-zone \
              --record "_acme-challenge 600 CNAME <значение_dns_challenge>"
            ```

            Где `<значение_dns_challenge>` — сохраненное на предыдущем шаге значение, необходимое для проверки прав на домен с помощью CNAME-записи.

            Результат:

            ```text
            +--------+------------------------------+-------+------------------------------------------+-----+
            | ACTION |             NAME             | TYPE  |                   DATA                   | TTL |
            +--------+------------------------------+-------+------------------------------------------+-----+
            | +      | _acme-challenge.example.com. | CNAME | fpq7t9dpi4o0********.cm.yandexcloud.net. | 600 |
            +--------+------------------------------+-------+------------------------------------------+-----+
            ```

            Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

            Проверка прав на домен может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

        1. Убедитесь, что статус сертификата изменился на `Issued`:

            ```bash
            yc certificate-manager certificate get \
              --name mymanagedcert
            ```

            Результат:

            ```text
            id: fpq7t9dpi4o0********
            folder_id: b1gt6g8ht345********
            created_at: "2026-02-05T11:00:15.952Z"
            name: mymanagedcert
            type: MANAGED
            domains:
              - example.com
            status: ISSUED
            issuer: CN=R12,O=Let's Encrypt,C=US
            subject: CN=example.com
            serial: 57bc7967996d73d63d9d52e337c********
            updated_at: "2026-02-05T13:29:23.658Z"
            issued_at: "2026-02-05T13:29:23.658Z"
            not_after: "2026-05-06T12:30:49Z"
            not_before: "2026-02-05T12:30:50Z"
            ```

            Сохраните полученный идентификатор сертификата — он понадобится позднее при создании CDN-ресурса.

    - API {#api}

      Для получения информации, необходимой для прохождения процедуры проверки прав на домен, воспользуйтесь методом REST API [get](../../certificate-manager/api-ref/Certificate/get.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/Get](../../certificate-manager/api-ref/grpc/Certificate/get.md) с параметром `view=FULL`.
      
      Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

    {% endlist %}

    {% note info %}

    {% include [checking-domain-rights-cname](../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

    {% endnote %}

    Если управление вашим доменом осуществляется вне платформы {{ yandex-cloud }}, создайте необходимую ресурсную запись для проверки прав на домен с использованием инструментов, которые предоставляет ваш администратор домена. Подробнее читайте в разделе [{#T}](../../certificate-manager/concepts/challenges.md).

## Создайте облачную сеть и подсети {#create-network}

Все ресурсы будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `example-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию `{{ ui-key.yacloud.vpc.networks.create.field_is-default }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте сеть `example-network`:

      ```bash
      yc vpc network create example-network
      ```

      Результат:

      ```text
        id: enpqm699f18v********
        folder_id: b1gt6g8ht345********
        created_at: "2026-02-05T11:57:02Z"
        name: example-network
        default_security_group_id: enp4qvbg2ri1********
      ```

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсети во всех [зонах доступности](../../overview/concepts/geo-scope.md):

      * В `{{ region-id }}-a`:

          ```bash
          yc vpc subnet create example-subnet-{{ region-id }}-a \
            --zone {{ region-id }}-a \
            --network-name example-network \
            --range 192.168.1.0/24
          ```

          Результат:

          ```text
          id: e9b0fo0hvhpd********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:00:21Z"
          name: example-subnet-{{ region-id }}-a
          network_id: enpqm699f18v********
          zone_id: {{ region-id }}-a
          v4_cidr_blocks:
            - 192.168.1.0/24
          ```

          Сохраните полученный идентификатор подсети — он понадобится позднее при создании L7-балансировщика.

      * В `{{ region-id }}-b`:

          ```bash
          yc vpc subnet create example-subnet-{{ region-id }}-b \
            --zone {{ region-id }}-b \
            --network-name example-network \
            --range 192.168.2.0/24
          ```

          Результат:

          ```text
          id: e2lo05oe9slo********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:02:02Z"
          name: example-subnet-{{ region-id }}-b
          network_id: enpqm699f18v********
          zone_id: {{ region-id }}-b
          v4_cidr_blocks:
            - 192.168.2.0/24
          ```

          Сохраните полученный идентификатор подсети — он понадобится позднее при создании L7-балансировщика.

      * В `{{ region-id }}-d`:

          ```bash
          yc vpc subnet create example-subnet-{{ region-id }}-d \
            --zone {{ region-id }}-d \
            --network-name example-network \
            --range 192.168.3.0/24
          ```

          Результат:

          ```text
          id: fl8bpb6lnu80********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:03:23Z"
          name: example-subnet-{{ region-id }}-d
          network_id: enpqm699f18v********
          zone_id: {{ region-id }}-d
          v4_cidr_blocks:
            - 192.168.3.0/24
          ```

          Сохраните полученный идентификатор подсети — он понадобится позднее при создании L7-балансировщика.

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать сеть `example-network`, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).
  1. Чтобы создать подсети `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` и `example-subnet-{{ region-id }}-d` в трех зонах доступности, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}

## Создайте группу безопасности {#create-security-group}

[Группы безопасности](../../vpc/concepts/security-groups.md) содержат правила, которые разрешают L7-балансировщику получать входящий трафик и отправлять его на бакеты-бэкенды.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите `example-sg`.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите `example-network`.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила [по инструкции](../../vpc/operations/security-group-create.md):
   
      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | `Исходящий` | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | `Входящий` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | `Входящий` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | `Входящий` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — |

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc security-group create example-sg \
    --network-name example-network \
    --rule "direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks"
  ```
  
  Результат:
  
  ```text
  id: enp9dpfa774h********
  folder_id: b1gt6g8ht345********
  created_at: "2026-02-05T12:29:47Z"
  name: example-sg
  network_id: enpqm699f18v********
  status: ACTIVE
  rules:
    - id: enpa11mk1r50********
      direction: EGRESS
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enp4aob2uiam********
      direction: INGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enpn8onb4lda********
      direction: INGRESS
      ports:
        from_port: "443"
        to_port: "443"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enp6j82kiu2p********
      direction: INGRESS
      ports:
        from_port: "30080"
        to_port: "30080"
      protocol_name: TCP
      protocol_number: "6"
      predefined_target: loadbalancer_healthchecks
  ```

  Сохраните полученный идентификатор группы безопасности — он понадобится позднее при создании L7-балансировщика.

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md).

  Чтобы добавить правило для проверок состояния балансировщика, используйте параметр `loadbalancer_healthchecks` в поле [predefinedTarget](../../vpc/api-ref/SecurityGroup/create.md#yandex.cloud.vpc.v1.CreateSecurityGroupRequest) для REST API или в поле [SecurityGroupRuleSpec.target.predefined_target](../../vpc/api-ref/grpc/SecurityGroup/create.md#yandex.cloud.vpc.v1.SecurityGroupRuleSpec) для gRPC API.

{% endlist %}

## Создайте бакет в {{ objstorage-name }} {#create-buckets}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите уникальное [имя](../../storage/concepts/bucket.md#naming) бакета.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду, указав уникальное [имя](../../storage/concepts/bucket.md#naming) бакета:

  ```bash
  yc storage bucket create \
    --name <имя_бакета> \
    --public-read \
    --public-list
  ```

  Результат:

  ```text
  name: my-cdn-bucket
  folder_id: b1gt6g8ht345********
  anonymous_access_flags:
    read: true
    list: true
  default_storage_class: STANDARD
  versioning: VERSIONING_DISABLED
  created_at: "2026-02-05T12:35:03.639102Z"
  resource_id: e3e8qar9vrim********
  ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md).

{% endlist %}

## Загрузите файл сервиса в бакет {#upload-files}

1. {% include [create-index-html](../_tutorials_includes/cdn-storage-integration/create-index-html.md) %}
1. Загрузите файл в бакет:

    {% list tabs group=instructions %}
    
    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
        1. Выберите бакет, созданный ранее.
        1. Нажмите кнопку ![arrow-up-from-line](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** и выберите для загрузки файл `index.html`.
        1. В открывшемся окне с подтверждением загрузки нажмите **{{ ui-key.yacloud.storage.button_upload }}**.

    - {{ yandex-cloud }} CLI {#cli}

      Загрузите в бакет файл `index.html`:

      ```bash
      yc storage s3api put-object \
        --bucket <имя_бакета> \
        --key index.html \
        --content-type "text/html" \
        --body <локальный_путь_к_файлу>
      ```

      Где:

      * `--bucket` — имя созданного ранее бакета.
      * `--body` — локальный путь, по которому находится созданный ранее HTML-файл. Например: `./index.html`.
      
      Результат:
      
      ```text
      etag: '"2f613d0f35668e1d98fa9c6b********"'
      request_id: a809736f********
      ```

      Подробнее о команде `yc storage s3api put-object` читайте в [справочнике CLI](../../storage/cli-ref/s3api/put-object.md).

   - API {#api}
   
     Воспользуйтесь методом REST API [upload](../../storage/s3/api-ref/object/upload.md).

   {% endlist %}

## Создайте группу бэкендов в {{ alb-name }} {#create-l7backend}

{% list tabs group=instructions %}
   
- Консоль управления {#console}
   
  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-bg`.
  1. В поле **{{ ui-key.yacloud.alb.label_backend-type }}** выберите [тип группы бэкендов](../../application-load-balancer/concepts/backend-group.md#group-types) `{{ ui-key.yacloud.alb.label_proto-http }}`.
  1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и задайте настройки бэкенда:
      1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-backend`.
      1. В поле **{{ ui-key.yacloud.alb.label_backend-weight }}** укажите `100`.
      1. В поле **{{ ui-key.yacloud.common.type }}** выберите [тип бэкенда](../../application-load-balancer/concepts/backend-group.md#types) `{{ ui-key.yacloud.alb.label_bucket }}`.
      1. В поле **{{ ui-key.yacloud.alb.label_bucket }}** выберите бакет, созданный ранее.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Если вы будете выполнять следующие шаги с помощью {{ yandex-cloud }} CLI, скопируйте идентификатор полученной группы бэкендов `example-bg` — он потребуется для выполнения дальнейших действий.

- {{ yandex-cloud }} CLI {#cli}

  Создать группу бэкендов с бэкендом [типа](../../application-load-balancer/concepts/backend-group.md#group-types) `бакет` с помощью {{ yandex-cloud }} CLI в настоящий момент нельзя. Воспользуйтесь консолью управления или API, чтобы создать нужную группу бэкендов.

- API {#api}

  Воспользуйтесь методом REST API [create](../../application-load-balancer/api-ref/BackendGroup/create.md) для ресурса [BackendGroup](../../application-load-balancer/api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Create](../../application-load-balancer/api-ref/grpc/BackendGroup/create.md).
     
{% endlist %} 

## Создайте HTTP-роутер и виртуальный хост {#create-route-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-router`.
  1. Создайте виртуальный хост `example-vh`:
  
     1. В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
     1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-vh`.
     1. В поле **{{ ui-key.yacloud.alb.label_authority }}** укажите имя вашего домена. Например: `example.com`.
     1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
     1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-route`.
     1. В поле **{{ ui-key.yacloud.alb.label_path }}** выберите `{{ ui-key.yacloud.alb.label_match-prefix }}` и укажите путь `/`.
     1. В списке **{{ ui-key.yacloud.alb.label_http-methods }}** выберите `GET`.
     1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** оставьте `{{ ui-key.yacloud.alb.label_route-action-route }}`.
     1. В списке **{{ ui-key.yacloud.alb.label_backend-group }}** выберите `example-bg`.

  1. Остальные настройки оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
- {{ yandex-cloud }} CLI {#cli}

  1. Создайте HTTP-роутер `example-router`:
  
      ```bash
      yc alb http-router create example-router
      ```
      
      Результат:
      
      ```text
      id: ds78i77j8lg0********
      name: example-router
      folder_id: b1gt6g8ht345********
      created_at: "2026-02-05T13:09:27.917359782Z"
      ```
      
      Подробнее о команде `yc alb http-router create` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/http-router/create.md).

  1. Создайте виртуальный хост `example-vh`:
  
      ```bash
      yc alb virtual-host create example-vh \
        --http-router-name example-router \
        --authority <имя_домена>
      ```

      Где `<имя_домена>` — имя вашего домена. Например: `example.com`.
      
      Результат:
      
      ```text
      done (1s)
      name: example-vh
      authority:
        - example.com
      ```
      
      Подробнее о команде `yc alb virtual-host create` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).
     
  1. Создайте маршрут `example-route` в виртуальном хосте `example-vh`:
  
      ```bash
      yc alb virtual-host append-http-route example-route \
        --http-router-name example-router \
        --virtual-host-name example-vh \
        --prefix-path-match "/" \
        --backend-group-name example-bg
      ```
      
      Результат:
      
      ```text
      done (1s)
      name: example-vh
      authority:
        - example.com
      routes:
        - name: example-route
          http:
            match:
              path:
                prefix_match: /
            route:
              backend_group_id: ds7glpil29lb********
      ```

      Подробнее о команде `yc alb virtual-host append-http-route` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

- API {#api}

  1. Чтобы создать HTTP-роутер `example-router`, воспользуйтесь методом REST API [create](../../application-load-balancer/api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../../application-load-balancer/api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../../application-load-balancer/api-ref/grpc/HttpRouter/create.md).
  1. Чтобы создать виртуальный хост `example-vh`, привязанный к роутеру, и его маршрут, воспользуйтесь методом REST API [create](../../application-load-balancer/api-ref/VirtualHost/create.md) для ресурса [VirtualHost](../../application-load-balancer/api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Create](../../application-load-balancer/api-ref/grpc/VirtualHost/create.md).

{% endlist %}

## Создайте L7-балансировщик {#create-balancer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}** и выберите **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-balancer`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:

     1. В поле **{{ ui-key.yacloud.mdb.forms.label_network }}** выберите `example-network`.
     1. В поле **{{ ui-key.yacloud.mdb.forms.field_security-group }}** выберите `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}` и в появившемся списке выберите созданную ранее группу безопасности `example-sg`.
      
  1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите три подсети для узлов балансировщика — `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` и `example-subnet-{{ region-id }}-d` — и включите передачу трафика в эти подсети.
  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}** и задайте настройки обработчика:
  
     1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-listener`.
     1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}**:
        * В поле **{{ ui-key.yacloud.alb.label_port }}** укажите `80`.
        * В поле **{{ ui-key.yacloud.common.type }}** выберите `{{ ui-key.yacloud.alb.label_address-auto }}`.
      
  1. В поле **{{ ui-key.yacloud.alb.label_http-router }}** выберите `example-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
- {{ yandex-cloud }} CLI {#cli}

  1. Создайте балансировщик `example-balancer`:
  
      ```bash
      yc alb load-balancer create example-balancer \
        --network-name example-network \
        --security-group-id <идентификатор_группы_безопасности_example-sg> \
        --location zone={{ region-id }}-a,subnet-id=<идентификатор_подсети_example-subnet-{{ region-id }}-a> \
        --location zone={{ region-id }}-b,subnet-id=<идентификатор_подсети_example-subnet-{{ region-id }}-b> \
        --location zone={{ region-id }}-d,subnet-id=<идентификатор_подсети_example-subnet-{{ region-id }}-d>
      ```

      Где:

      * `--security-group-id` — идентификатор группы безопасности, сохраненный ранее при ее создании.
      * `subnet-id` — идентификаторы подсетей в трех зонах доступности, сохраненные ранее при их создании.
        
      Результат:
      
      ```text
      done (7m17s)
      id: ds790ardig7r********
      name: example-balancer
      folder_id: b1gt6g8ht345********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: enpqm699f18v********
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9b0fo0hvhpd********
          - zone_id: {{ region-id }}-b
            subnet_id: e2lo05oe9slo********
          - zone_id: {{ region-id }}-d
            subnet_id: fl8bpb6lnu80********
      security_group_ids:
        - enp9dpfa774h********
      created_at: "2026-02-05T13:30:25.695763710Z"
      ```
      
      Подробнее о команде `yc alb load-balancer create` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/create.md).
     
  1. Добавьте к балансировщику обработчик:
  
      ```bash
      yc alb load-balancer add-listener \
        --name example-balancer \
        --listener-name example-listener \
        --external-ipv4-endpoint port=80 \
        --http-router-name example-router
      ```
      
      Результат:
      
      ```text
      done (9m53s)
      id: ds790ardig7r********
      name: example-balancer
      folder_id: b1gt6g8ht345********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: enpqm699f18v********
      listeners:
        - name: example-listener
          endpoints:
            - addresses:
                - external_ipv4_address:
                    address: 158.160.***.***
              ports:
                - "80"
          http:
            handler:
              http_router_id: ds78i77j8lg0********
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9b0fo0hvhpd********
          - zone_id: {{ region-id }}-b
            subnet_id: e2lo05oe9slo********
          - zone_id: {{ region-id }}-d
            subnet_id: fl8bpb6lnu80********
      security_group_ids:
        - enp9dpfa774h********
      ```

      Сохраните IP-адрес обработчика (значение поля `address`) — он понадобится позднее при создании CDN-ресурса.

      Подробнее о команде `yc alb load-balancer add-listener` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/add-listener.md).

- API {#api}

  Чтобы создать L7-балансировщик, воспользуйтесь методом REST API [create](../../application-load-balancer/api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../../application-load-balancer/api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Create](../../application-load-balancer/api-ref/grpc/LoadBalancer/create.md).
          
{% endlist %}

## Создайте CDN-ресурс {#create-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Задайте основные настройки CDN-ресурса:

      * В блоке **{{ ui-key.yacloud.cdn.label_section-content }}**:

          * Включите **{{ ui-key.yacloud.cdn.label_access }}**.
          * В поле **{{ ui-key.yacloud.cdn.label_content-query-type }}** выберите `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
          * В поле **{{ ui-key.yacloud.cdn.label_source-type }}** выберите `{{ ui-key.yacloud.cdn.value_source-type-balancer }}` и в появившемся поле **{{ ui-key.yacloud.cdn.label_balancer }}** выберите `example-balancer`.
          * В поле **{{ ui-key.yacloud.cdn.label_ip-address }}** выберите IP-адрес, назначенный балансировщику (будет единственным в списке).
          * В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите `{{ ui-key.yacloud.common.label_http }}`.
          * В поле **{{ ui-key.yacloud.cdn.label_personal-domain }}** укажите имя вашего домена. Например: `example.com`.

              {% note alert %}

              Указанное доменное имя станет основным, и его будет невозможно изменить после создания CDN-ресурса.

              {% endnote %}

      * В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:

          * В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
          * В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** укажите `{{ ui-key.yacloud.cdn.value_certificate-custom }}` и выберите [сертификат](#add-certificate) `mymanagedcert`, который вы создали ранее для вашего доменного имени.
          * В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите `{{ ui-key.yacloud.cdn.value_host-header-resend }}`.
  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  1. В разделах **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и **{{ ui-key.yacloud.cdn.value_stepper-additional }}** оставьте настройки по умолчанию и нажмите **{{ ui-key.yacloud.common.continue }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте группу источников `example-origin-group`, указав сохраненный ранее IP-адрес балансировщика:

      ```bash
      yc cdn origin-group create --name "example-origin-group" \
        --origin source=<IP-адрес_балансировщика>:80,enabled=true
      ```

      Результат:

      ```text
      id: "12756795849********"
      folder_id: b1gt6g8ht345********
      name: example-origin-group
      use_next: true
      origins:
        - id: "68784"
          origin_group_id: "12756795849********"
          source: 158.160.***.***:80
          enabled: true
          provider_type: ourcdn
      provider_type: ourcdn
      ```

      Сохраните идентификатор группы источников (значение поля `origin_group_id`) — он понадобится позднее при создании CDN-ресурса.

      Подробнее о команде `yc cdn origin-group create` читайте в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/origin-group/create.md).

  1. Создайте CDN-ресурс:
  
      ```bash
      yc cdn resource create \
        --cname <имя_домена> \
        --origin-group-id <идентификатор_группы_источников> \
        --origin-protocol http \
        --cert-manager-ssl-cert-id <идентификатор_сертификата> \
        --forward-host-header
      ```

      Где:

      * `--cname` — имя вашего домена. Например: `example.com`.
      * `--origin-group-id` — идентификатор группы источников, полученный на предыдущем шаге.
      * `--cert-manager-ssl-cert-id` — идентификатор созданного [ранее](#add-certificate) сертификата `mymanagedcert`.

      Результат:

      ```text
      id: bc8rpt67l6dl********
      folder_id: b1gt6g8ht345********
      cname: example.com
      created_at: "2026-02-05T14:05:24.913996Z"
      updated_at: "2026-02-05T14:05:24.913996Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "86400"
        browser_cache_settings: {}
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        slice: {}
        host_options:
          forward_host_header:
            enabled: true
            value: true
        static_headers:
          enabled: true
        stale: {}
        allowed_http_methods:
          enabled: true
          value:
            - GET
            - HEAD
            - OPTIONS
        static_request_headers:
          enabled: true
        custom_server_name: {}
        ignore_cookie:
          enabled: true
          value: true
        secure_key:
          type: DISABLE_IP_SIGNING
      origin_group_id: "12756795849********"
      origin_group_name: example-origin-group
      origin_protocol: HTTP
      ssl_certificate:
        type: CM
        status: READY
        data:
          cm:
            id: fpq7t9dpi4o0********
      provider_type: ourcdn
      provider_cname: d88c6ee6********.topology.gslb.yccdn.ru
      ```

      Сохраните идентификатор созданного ресурса (значение поля `id`), а также значение CNAME провайдера (значение поля `provider_cname`) — они понадобятся позднее.

      Подробнее о команде `yc cdn resource create` читайте в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/resource/create.md).

  1. Включите переадресацию клиентов для CDN-ресурса, указав сохраненный на предыдущем шаге идентификатор:

      ```bash
      yc cdn resource update <идентификатор_CDN-ресурса> \
        --redirect-http-to-https
      ```

      Подробнее о команде `yc cdn resource update` читайте в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- API {#api}

  Чтобы создать CDN-ресурс, воспользуйтесь методом REST API [create](../../cdn/api-ref/Resource/create.md) для ресурса [Resource](../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md).
  
{% endlist %}

## Создайте ресурсную запись CNAME для CDN-ресурса {#create-cdn-cname-record}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Получите](../../cdn/operations/resources/get-resources-info.md#get-cname) значение доменного имени провайдера CDN.
  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** и выберите созданную [ранее](#configure-dns) DNS-зону.
  1. Нажмите **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Задайте параметры записи:

        * В поле **{{ ui-key.yacloud.common.name }}** выберите `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
        * В поле **{{ ui-key.yacloud.common.type }}** выберите [тип записи](../../dns/concepts/resource-record.md#rr-types) `CNAME`.
        * В поле **{{ ui-key.yacloud.dns.label_records }}** укажите значение [доменного имени](../../cdn/operations/resources/get-resources-info.md#get-cname) провайдера CDN.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте ресурсную запись CNAME в сервисе {{ dns-name }}:

      ```bash
      yc dns zone add-records \
        --name my-domain-zone \
        --record "@ 600 CNAME <значение_cname>"
      ```

      Где `<значение_cname>` — полученное ранее значение CNAME провайдера.

      Результат:

      ```text
      +--------+--------------+-------+-----------------------------------------+-----+
      | ACTION |     NAME     | TYPE  |                  DATA                   | TTL |
      +--------+--------------+-------+-----------------------------------------+-----+
      | +      | example.com. | CNAME | d88c6ee6********.topology.gslb.yccdn.ru | 600 |
      +--------+--------------+-------+-----------------------------------------+-----+
      ```

      Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  Чтобы получить значение CNAME-записи для CDN-ресурса, воспользуйтесь методом REST API [getProviderCName](../../cdn/api-ref/Resource/getProviderCName.md) для ресурса [Resource](../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/GetProviderCName](../../cdn/api-ref/grpc/Resource/getProviderCName.md).

  Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

{% endlist %}

{% include [after-creation-tip-tutorials](../../_includes/cdn/after-creation-tip-tutorials.md) %}

Если управление вашим доменом осуществляется вне платформы {{ yandex-cloud }}, создайте необходимую ресурсную запись для CDN-ресурса с использованием инструментов, которые предоставляет ваш администратор домена. Подробнее читайте в разделе [{#T}](../../certificate-manager/concepts/challenges.md).

## Проверьте работу сервиса {#check}

{% include [test](../_tutorials_includes/cdn-storage-integration/test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы настраивали CNAME-записи в {{ dns-name }}, [удалите](../../dns/operations/zone-delete.md) зону DNS `example-dns-zone`.
1. [Удалите](../../cdn/operations/resources/delete-resource.md) CDN-ресурс с основным доменным именем `example.com`.
1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `example-balancer`.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсети `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` и `example-subnet-{{ region-id }}-d`.
1. [Удалите](../../vpc/operations/security-group-delete.md) группу безопасности `example-sg`.
1. [Удалите](../../vpc/operations/network-delete.md) сеть `example-network`.
1. При необходимости [удалите](../../certificate-manager/operations/managed/cert-delete.md) сертификат `mymanagedcert`.