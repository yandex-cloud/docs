# Интеграция L7-балансировщика с Cloud CDN и Object Storage с помощью консоли управления


{% note info %}

Для реализации решения вам понадобится домен. В качестве примера будет использовано доменное имя `example.com`.

{% endnote %}

Чтобы [настроить интеграцию](index.md) L7-балансировщика с Yandex Cloud CDN и Yandex Object Storage с помощью [консоли управления](https://console.yandex.cloud), Yandex Cloud [CLI](../../../cli/index.md) или [API](../../../api-design-guide/index.md):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте публичную зону DNS](#configure-dns).
1. [Добавьте сертификат в Certificate Manager](#add-certificate).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте группу безопасности](#create-security-group).
1. [Создайте бакет в Object Storage](#create-buckets).
1. [Загрузите файл сервиса в бакет](#upload-files).
1. [Создайте группу бэкендов в Application Load Balancer](#create-l7backend).
1. [Создайте HTTP-роутер и виртуальный хост](#create-route-hosts).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Создайте ресурсную запись CNAME для CDN-ресурса](#create-cdn-cname-record).
1. [Проверьте работу сервиса](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Поддерживаемые инструменты {#supported-tools}

Для выполнения шагов можно использовать различные поддерживаемые инструменты. Бо́льшую часть шагов можно выполнить с помощью любого из стандартных инструментов: [консоли управления](https://console.yandex.cloud), интерфейсов командной строки [Yandex Cloud CLI](../../../cli/index.md) и [API Yandex Cloud](../../../api-design-guide/index.md). В каждом шаге перечислены поддерживаемые для него инструменты.

Некоторые инструменты поддерживаются не для всех шагов: через Yandex Cloud CLI сейчас нельзя [создать группу бэкендов в Application Load Balancer с бакетами в качестве бэкендов](#create-l7backend).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

В качестве примера будет использоваться каталог с именем `example-folder`.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение данных в Object Storage, операции с ними и исходящий трафик (см. [тарифы Object Storage](../../../storage/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика (см. [тарифы Application Load Balancer](../../pricing.md));
* плата за исходящий трафик с CDN-серверов (см. [тарифы Cloud CDN](../../../cdn/pricing.md));
* плата за публичные DNS-запросы и DNS-зоны, если вы используете Yandex Cloud DNS (см. [тарифы Cloud DNS](../../../dns/pricing.md)).

## Создайте и настройте публичную зону DNS {#configure-dns}

{% note info %}

В настоящем руководстве рассматривается сценарий, при котором доменом управляет сервис [Yandex Cloud DNS](../../../dns/index.md).

Если вы не хотите делегировать управление вашим доменом платформе Yandex Cloud, вы можете выполнить необходимые настройки DNS с использованием инструментов, которые предлагает ваш администратор домена. В этом случае для создания ресурсных записей воспользуйтесь документацией вашего администратора домена или обратитесь в службу его технической поддержки.

{% endnote %}

Чтобы настроить публичную зону DNS в инфраструктуре Yandex Cloud:

1. Делегируйте ваш домен сервису Cloud DNS. Для этого в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net`.
1. Создайте публичную [зону DNS](../../../dns/concepts/dns-zone.md) в Yandex Cloud DNS.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
      1. Перейдите в сервис **Cloud DNS**.
      1. Нажмите **Создать зону**.
      1. Задайте настройки зоны, соответствующие вашему домену:

         1. **Зона** — доменная зона. Название зоны должно заканчиваться точкой. Например, название доменной зоны `example.com.` соответствует домену `example.com`. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://ru.wikipedia.org/wiki/Punycode).
         1. **Тип** — `Публичная`.
         1. **Имя** — `my-domain-zone`.

      1. Нажмите **Создать**.

    - Yandex Cloud CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

      Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/create.md).

    - API {#api}

      Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../../dns/api-ref/grpc/DnsZone/create.md).

    {% endlist %}

## Добавьте сертификат в Certificate Manager {#add-certificate}

Поддерживаются сертификаты из [Yandex Certificate Manager](../../../certificate-manager/index.md). Вы можете [выпустить новый сертификат Let's Encrypt®](../../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный](../../../certificate-manager/operations/import/cert-create.md).

Сертификат должен находиться в том же [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен ваш CDN-ресурс.

В настоящем руководстве рассматривается сценарий, при котором для CDN-ресурса создается новый сертификат от Let's Encrypt®.

1. Добавьте в сервис Certificate Manager [сертификат](../../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для вашего домена:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
      1. Перейдите в сервис **Certificate Manager**.
      1. Нажмите **Добавить сертификат** и выберите **Сертификат от Let's Encrypt**.
      1. В открывшемся окне в поле **Имя** укажите `mymanagedcert`.
      1. В поле **Домены** укажите имя вашего домена, например `example.com`.
      1. Выберите [тип проверки прав на домен](../../../certificate-manager/concepts/challenges.md) `DNS`.
      1. Нажмите **Создать**.

    - Yandex Cloud CLI {#cli}

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

      Подробнее о команде `yc certificate-manager certificate request` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/request.md).

      Сохраните идентификатор (`id`) созданного сертификата: он пригодится при создании CDN-ресурса.

    - API {#api}

      Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../../certificate-manager/api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../../certificate-manager/api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/RequestNew](../../../certificate-manager/api-ref/grpc/Certificate/requestNew.md).

    {% endlist %}

    В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домен](../../../certificate-manager/operations/managed/cert-validate.md).

1. Для успешного выпуска сертификата пройдите проверку прав на домен:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
        1. Перейдите в сервис **Certificate Manager**.
        1. В списке сертификатов выберите `mymanagedcert`.
        1. В открывшемся окне в блоке **Проверка прав на домены** выберите `CNAME-запись` и ниже в секции с вашим доменом нажмите **Создать запись**.
        1. В открывшемся окне подтвердите создание ресурсной записи.

        Проверка прав на домен может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

    - Yandex Cloud CLI {#cli}

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

            Подробнее о команде `yc certificate-manager certificate get` читайте в [справочнике CLI](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/get.md).

            Сохраните значение поля `value` из раздела с типом `CNAME` в блоке `challenges.dns_challenge`. Это значение понадобится на следующем шаге.

        1. Создайте [ресурсную запись](../../../dns/concepts/resource-record.md) CNAME для прохождения проверки ваших прав на домен:

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

            Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

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

      Для получения информации, необходимой для прохождения процедуры проверки прав на домен, воспользуйтесь методом REST API [get](../../../certificate-manager/api-ref/Certificate/get.md) для ресурса [Certificate](../../../certificate-manager/api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Get](../../../certificate-manager/api-ref/grpc/Certificate/get.md) с параметром `view=FULL`.
      
      Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

    {% endlist %}

    {% note info %}

    Чтобы DNS-проверка прав на домен по записи `CNAME` прошла успешно, для поддомена `_acme-challenge` проверяемого доменного имени не должно быть других [ресурсных записей](../../../dns/concepts/resource-record.md), кроме `CNAME`. Например, для имени `_acme-challenge.example.com.` должна существовать только CNAME-запись и не должно быть TXT-записи.

    {% endnote %}

    Если управление вашим доменом осуществляется вне платформы Yandex Cloud, создайте необходимую ресурсную запись для проверки прав на домен с использованием инструментов, которые предоставляет ваш администратор домена. Подробнее читайте в разделе [Проверка прав на домен](../../../certificate-manager/concepts/challenges.md).

## Создайте облачную сеть и подсети {#create-network}


Все ресурсы будут относиться к одной [облачной сети](../../../vpc/concepts/network.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Справа сверху нажмите кнопку **Создать сеть**.
  1. В поле **Имя** укажите `example-network`.
  1. В поле **Дополнительно** выберите опцию `Создать подсети`.
  1. Нажмите кнопку **Создать сеть**.

- Yandex Cloud CLI {#cli}

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

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсети во всех [зонах доступности](../../../overview/concepts/geo-scope.md):

      * В `ru-central1-a`:

          ```bash
          yc vpc subnet create example-subnet-ru-central1-a \
            --zone ru-central1-a \
            --network-name example-network \
            --range 192.168.1.0/24
          ```

          Результат:

          ```text
          id: e9b0fo0hvhpd********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:00:21Z"
          name: example-subnet-ru-central1-a
          network_id: enpqm699f18v********
          zone_id: ru-central1-a
          v4_cidr_blocks:
            - 192.168.1.0/24
          ```

          Сохраните полученный идентификатор подсети — он понадобится позднее при создании L7-балансировщика.

      * В `ru-central1-b`:

          ```bash
          yc vpc subnet create example-subnet-ru-central1-b \
            --zone ru-central1-b \
            --network-name example-network \
            --range 192.168.2.0/24
          ```

          Результат:

          ```text
          id: e2lo05oe9slo********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:02:02Z"
          name: example-subnet-ru-central1-b
          network_id: enpqm699f18v********
          zone_id: ru-central1-b
          v4_cidr_blocks:
            - 192.168.2.0/24
          ```

          Сохраните полученный идентификатор подсети — он понадобится позднее при создании L7-балансировщика.

      * В `ru-central1-d`:

          ```bash
          yc vpc subnet create example-subnet-ru-central1-d \
            --zone ru-central1-d \
            --network-name example-network \
            --range 192.168.3.0/24
          ```

          Результат:

          ```text
          id: fl8bpb6lnu80********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:03:23Z"
          name: example-subnet-ru-central1-d
          network_id: enpqm699f18v********
          zone_id: ru-central1-d
          v4_cidr_blocks:
            - 192.168.3.0/24
          ```

          Сохраните полученный идентификатор подсети — он понадобится позднее при создании L7-балансировщика.

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать сеть `example-network`, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).
  1. Чтобы создать подсети `example-subnet-ru-central1-a`, `example-subnet-ru-central1-b` и `example-subnet-ru-central1-d` в трех зонах доступности, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}

## Создайте группу безопасности {#create-security-group}

[Группы безопасности](../../../vpc/concepts/security-groups.md) содержат правила, которые разрешают L7-балансировщику получать входящий трафик и отправлять его на бакеты-бэкенды.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/shield.svg) **Группы безопасности**.
  1. Справа сверху нажмите кнопку **Создать группу безопасности**.
  1. В поле **Имя** укажите `example-sg`.
  1. В поле **Сеть** выберите `example-network`.
  1. В блоке **Правила** создайте следующие правила [по инструкции](../../../vpc/operations/security-group-create.md):
   
      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>назначение | CIDR блоки |
      | --- | --- | --- | --- | --- | --- |
      | `Исходящий` | `any` | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |
      | `Входящий` | `ext-http` | `80` | `TCP` | `CIDR` | `0.0.0.0/0` |
      | `Входящий` | `ext-https` | `443` | `TCP` | `CIDR` | `0.0.0.0/0` |
      | `Входящий` | `healthchecks` | `30080` | `TCP` | `Проверки состояния балансировщика` | — |

  1. Нажмите кнопку **Создать**.

- Yandex Cloud CLI {#cli}

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

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../../vpc/api-ref/grpc/SecurityGroup/create.md).

  Чтобы добавить правило для проверок состояния балансировщика, используйте параметр `loadbalancer_healthchecks` в поле [predefinedTarget](../../../vpc/api-ref/SecurityGroup/create.md#yandex.cloud.vpc.v1.CreateSecurityGroupRequest) для REST API или в поле [SecurityGroupRuleSpec.target.predefined_target](../../../vpc/api-ref/grpc/SecurityGroup/create.md#yandex.cloud.vpc.v1.SecurityGroupRuleSpec) для gRPC API.

{% endlist %}

## Создайте бакет в Object Storage {#create-buckets}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите уникальное [имя](../../../storage/concepts/bucket.md#naming) бакета.
  1. В полях **Чтение объектов** и **Чтение списка объектов** выберите `Для всех`.
  1. Нажмите кнопку **Создать бакет**.

- Yandex Cloud CLI {#cli}

  Выполните команду, указав уникальное [имя](../../../storage/concepts/bucket.md#naming) бакета:

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

  Воспользуйтесь методом REST API [create](../../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Create](../../../storage/api-ref/grpc/Bucket/create.md).

{% endlist %}

## Загрузите файл сервиса в бакет {#upload-files}

1. Создайте файл `index.html` со следующим содержимым:
   
   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>My service</title>
     </head>
     <body>
       <p>The service is working</p>
     </body>
   </html>
   ```
1. Загрузите файл в бакет:

    {% list tabs group=instructions %}
    
    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
        1. Перейдите в сервис **Object Storage**.
        1. Выберите бакет, созданный ранее.
        1. Нажмите кнопку ![arrow-up-from-line](../../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить** и выберите для загрузки файл `index.html`.
        1. В открывшемся окне с подтверждением загрузки нажмите **Загрузить**.

    - Yandex Cloud CLI {#cli}

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

      Подробнее о команде `yc storage s3api put-object` читайте в [справочнике CLI](../../../storage/cli-ref/s3api/put-object.md).

   - API {#api}
   
     Воспользуйтесь методом REST API [upload](../../../storage/s3/api-ref/object/upload.md).

   {% endlist %}

## Создайте группу бэкендов в Application Load Balancer {#create-l7backend}

{% list tabs group=instructions %}
   
- Консоль управления {#console}
   
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов**.
  1. Справа сверху нажмите кнопку **Создать группу бэкендов**.
  1. В поле **Имя** укажите `example-bg`.
  1. В поле **Тип** выберите [тип группы бэкендов](../../concepts/backend-group.md#group-types) `HTTP`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить** и задайте настройки бэкенда:
      1. В поле **Имя** укажите `example-backend`.
      1. В поле **Вес** укажите `100`.
      1. В поле **Тип** выберите [тип бэкенда](../../concepts/backend-group.md#types) `Бакет`.
      1. В поле **Бакет** выберите бакет, созданный ранее.
  1. Нажмите кнопку **Создать**.

  Если вы будете выполнять следующие шаги с помощью Yandex Cloud CLI, скопируйте идентификатор полученной группы бэкендов `example-bg` — он потребуется для выполнения дальнейших действий.

- Yandex Cloud CLI {#cli}

  Создать группу бэкендов с бэкендом [типа](../../concepts/backend-group.md#group-types) `бакет` с помощью Yandex Cloud CLI в настоящий момент нельзя. Воспользуйтесь консолью управления или API, чтобы создать нужную группу бэкендов.

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/BackendGroup/create.md) для ресурса [BackendGroup](../../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Create](../../api-ref/grpc/BackendGroup/create.md).
     
{% endlist %} 

## Создайте HTTP-роутер и виртуальный хост {#create-route-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/route.svg) **HTTP-роутеры**.
  1. Справа сверху нажмите кнопку **Создать HTTP-роутер**.
  1. В поле **Имя** укажите `example-router`.
  1. Создайте виртуальный хост `example-vh`:
  
     1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
     1. В поле **Имя** укажите `example-vh`.
     1. В поле **Authority** укажите имя вашего домена. Например: `example.com`.
     1. Нажмите кнопку **Добавить маршрут**.
     1. В поле **Имя** укажите `example-route`.
     1. В поле **Путь** выберите `Начинается с` и укажите путь `/`.
     1. В списке **Методы HTTP** выберите `GET`.
     1. В поле **Действие** оставьте `Маршрутизация`.
     1. В списке **Группа бэкендов** выберите `example-bg`.

  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.
  
- Yandex Cloud CLI {#cli}

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
      
      Подробнее о команде `yc alb http-router create` читайте в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/http-router/create.md).

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
      
      Подробнее о команде `yc alb virtual-host create` читайте в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).
     
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

      Подробнее о команде `yc alb virtual-host append-http-route` читайте в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

- API {#api}

  1. Чтобы создать HTTP-роутер `example-router`, воспользуйтесь методом REST API [create](../../api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../../api-ref/grpc/HttpRouter/create.md).
  1. Чтобы создать виртуальный хост `example-vh`, привязанный к роутеру, и его маршрут, воспользуйтесь методом REST API [create](../../api-ref/VirtualHost/create.md) для ресурса [VirtualHost](../../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Create](../../api-ref/grpc/VirtualHost/create.md).

{% endlist %}

## Создайте L7-балансировщик {#create-balancer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Application Load Balancer**.
  1. Справа сверху нажмите кнопку **Создать L7-балансировщик** и выберите **Вручную**.
  1. В поле **Имя** укажите `example-balancer`.
  1. В блоке **Сетевые настройки**:

     1. В поле **Сеть** выберите `example-network`.
     1. В поле **Группы безопасности** выберите `Из списка` и в появившемся списке выберите созданную ранее группу безопасности `example-sg`.
      
  1. В блоке **Размещение** выберите три подсети для узлов балансировщика — `example-subnet-ru-central1-a`, `example-subnet-ru-central1-b` и `example-subnet-ru-central1-d` — и включите передачу трафика в эти подсети.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик** и задайте настройки обработчика:
  
     1. В поле **Имя** укажите `example-listener`.
     1. В блоке **Публичный IP-адрес**:
        * В поле **Порт** укажите `80`.
        * В поле **Тип** выберите `Автоматически`.
      
  1. В поле **HTTP-роутер** выберите `example-router`.
  1. Нажмите кнопку **Создать**.
  
- Yandex Cloud CLI {#cli}

  1. Создайте балансировщик `example-balancer`:
  
      ```bash
      yc alb load-balancer create example-balancer \
        --network-name example-network \
        --security-group-id <идентификатор_группы_безопасности_example-sg> \
        --location zone=ru-central1-a,subnet-id=<идентификатор_подсети_example-subnet-ru-central1-a> \
        --location zone=ru-central1-b,subnet-id=<идентификатор_подсети_example-subnet-ru-central1-b> \
        --location zone=ru-central1-d,subnet-id=<идентификатор_подсети_example-subnet-ru-central1-d>
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
      region_id: ru-central1
      network_id: enpqm699f18v********
      allocation_policy:
        locations:
          - zone_id: ru-central1-a
            subnet_id: e9b0fo0hvhpd********
          - zone_id: ru-central1-b
            subnet_id: e2lo05oe9slo********
          - zone_id: ru-central1-d
            subnet_id: fl8bpb6lnu80********
      security_group_ids:
        - enp9dpfa774h********
      created_at: "2026-02-05T13:30:25.695763710Z"
      ```
      
      Подробнее о команде `yc alb load-balancer create` читайте в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/create.md).
     
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
      region_id: ru-central1
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
          - zone_id: ru-central1-a
            subnet_id: e9b0fo0hvhpd********
          - zone_id: ru-central1-b
            subnet_id: e2lo05oe9slo********
          - zone_id: ru-central1-d
            subnet_id: fl8bpb6lnu80********
      security_group_ids:
        - enp9dpfa774h********
      ```

      Сохраните IP-адрес обработчика (значение поля `address`) — он понадобится позднее при создании CDN-ресурса.

      Подробнее о команде `yc alb load-balancer add-listener` читайте в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/add-listener.md).

- API {#api}

  Чтобы создать L7-балансировщик, воспользуйтесь методом REST API [create](../../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md).
          
{% endlist %}

## Создайте CDN-ресурс {#create-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Cloud CDN**.
  1. Нажмите кнопку **Создать ресурс**.
  1. Задайте основные настройки CDN-ресурса:

      * В блоке **Контент**:

          * Включите **Доступ к контенту**.
          * В поле **Запрос контента** выберите `Из одного источника`.
          * В поле **Тип источника** выберите `L7-балансировщик` и в появившемся поле **L7-балансировщик** выберите `example-balancer`.
          * В поле **IP-адрес** выберите IP-адрес, назначенный балансировщику (будет единственным в списке).
          * В поле **Протокол для источников** выберите `HTTP`.
          * В поле **Доменное имя** укажите имя вашего домена. Например: `example.com`.

              {% note alert %}

              Указанное доменное имя станет основным, и его будет невозможно изменить после создания CDN-ресурса.

              {% endnote %}

      * В блоке **Дополнительно**:

          * В поле **Переадресация клиентов** выберите `С HTTP на HTTPS`.
          * В поле **Тип сертификата** укажите `Сертификат из Certificate Manager` и выберите [сертификат](#add-certificate) `mymanagedcert`, который вы создали ранее для вашего доменного имени.
          * В поле **Заголовок Host** выберите `Как у клиента`.
  1. Нажмите **Продолжить**.
  1. В разделах **Кеширование**, **HTTP-заголовки и методы** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Продолжить**.

- Yandex Cloud CLI {#cli}

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

      Подробнее о команде `yc cdn origin-group create` читайте в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/origin-group/create.md).

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

      Подробнее о команде `yc cdn resource create` читайте в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/create.md).

  1. Включите переадресацию клиентов для CDN-ресурса, указав сохраненный на предыдущем шаге идентификатор:

      ```bash
      yc cdn resource update <идентификатор_CDN-ресурса> \
        --redirect-http-to-https
      ```

      Подробнее о команде `yc cdn resource update` читайте в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- API {#api}

  Чтобы создать CDN-ресурс, воспользуйтесь методом REST API [create](../../../cdn/api-ref/Resource/create.md) для ресурса [Resource](../../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../../cdn/api-ref/grpc/Resource/create.md).
  
{% endlist %}

## Создайте ресурсную запись CNAME для CDN-ресурса {#create-cdn-cname-record}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Получите](../../../cdn/operations/resources/get-resources-info.md#get-cname) значение доменного имени провайдера CDN.
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Cloud DNS** и выберите созданную [ранее](#configure-dns) DNS-зону.
  1. Нажмите **Создать запись**.
  1. Задайте параметры записи:

        * В поле **Имя** выберите `Совпадает с именем зоны (@)`.
        * В поле **Тип** выберите [тип записи](../../../dns/concepts/resource-record.md#rr-types) `CNAME`.
        * В поле **Значение** укажите значение [доменного имени](../../../cdn/operations/resources/get-resources-info.md#get-cname) провайдера CDN.

  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

  1. Создайте ресурсную запись CNAME в сервисе Cloud DNS:

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

      Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  Чтобы получить значение CNAME-записи для CDN-ресурса, воспользуйтесь методом REST API [getProviderCName](../../../cdn/api-ref/Resource/getProviderCName.md) для ресурса [Resource](../../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/GetProviderCName](../../../cdn/api-ref/grpc/Resource/getProviderCName.md).

  Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

{% endlist %}

На обновление записей на DNS-серверах может потребоваться несколько часов. После этого вы сможете проверить работу сервиса.

Если управление вашим доменом осуществляется вне платформы Yandex Cloud, создайте необходимую ресурсную запись для CDN-ресурса с использованием инструментов, которые предоставляет ваш администратор домена. Подробнее читайте в разделе [Проверка прав на домен](../../../certificate-manager/concepts/challenges.md).

## Проверьте работу сервиса {#check}

Чтобы проверить работу сервиса, откройте в браузере адрес `https://example.com/index.html` (где вместо `example.com` — имя вашего домена). Если все было настроено правильно, вы должны увидеть страницу с таким содержанием:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My service</title>
  </head>
  <body>
    <p>The service is working</p>
  </body>
</html>
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы настраивали CNAME-записи в Cloud DNS, [удалите](../../../dns/operations/zone-delete.md) зону DNS `example-dns-zone`.
1. [Удалите](../../../cdn/operations/resources/delete-resource.md) CDN-ресурс с основным доменным именем `example.com`.
1. [Удалите](../../operations/application-load-balancer-delete.md) L7-балансировщик `example-balancer`.
1. [Удалите](../../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../../storage/operations/buckets/delete.md) бакет.
1. [Удалите](../../../vpc/operations/subnet-delete.md) подсети `example-subnet-ru-central1-a`, `example-subnet-ru-central1-b` и `example-subnet-ru-central1-d`.
1. [Удалите](../../../vpc/operations/security-group-delete.md) группу безопасности `example-sg`.
1. [Удалите](../../../vpc/operations/network-delete.md) сеть `example-network`.
1. При необходимости [удалите](../../../certificate-manager/operations/managed/cert-delete.md) сертификат `mymanagedcert`.

#### См. также {#see-also}

* [Интеграция L7-балансировщика с Cloud CDN и Object Storage с помощью Terraform](terraform.md)