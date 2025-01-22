
# Хостинг статического сайта на фреймворке Gatsby в {{ objstorage-full-name }}

С помощью этого руководства вы разместите свой статический сайт, созданный на фреймворке [Gatsby](https://www.gatsbyjs.com/docs), в сервисе [{{ objstorage-name }}](../../storage/) и настроите доступ к нему по протоколу HTTPS с помощью сервиса [{{ certificate-manager-full-name }}](../../certificate-manager/).

Чтобы создать и разместить статический сайт в {{ objstorage-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Зарегистрируйте доменное имя](#register-domain).
1. [Создайте и настройте бакет {{ objstorage-name }}](#create-and-configure-bucket).
1. [Привяжите доменное имя к бакету](#bind-domain).
1. [Добавьте TLS-сертификат в {{ certificate-manager-full-name }}](#issue-certificate).
1. [Настройте доступ к бакету по HTTPS](#configure-https).
1. [Создайте сайт локально](#create-local-site).
1. [Загрузите сайт в бакет](#upload-site).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Установите и настройте AWS CLI

Установите и настройте AWS CLI по [инструкции](../../storage/tools/aws-cli.md#before-you-begin).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* плата за использование публичной DNS-зоны и за публичные DNS-запросы (см. [тарифы {{ dns-full-name }}](../../dns/pricing.md));
* плата за хранение данных в {{ objstorage-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).

## Зарегистрируйте доменное имя {#register-domain}

1. В личном кабинете вашего регистратора доменных имен зарегистрируйте доменное имя, например `gatsbytest.ru`.
1. Чтобы получить доступ к именам из публичной зоны, делегируйте домен. Для этого в настройках домена укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

    Делегирование происходит не сразу. Серверы интернет-провайдеров обновляют записи до 24 часов.
    Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

    ```bash
    dig +short NS gatsbytest.ru
    ```

    Результат:

    ```text
    ns2.{{ dns-ns-host-sld }}.
    ns1.{{ dns-ns-host-sld }}.
    ```

## Создайте и настройте бакет {{ objstorage-name }} {#create-and-configure-bucket}

Чтобы разместить статический сайт в облаке, [создайте](../../storage/operations/buckets/create.md) бакет и [настройте](../../storage/operations/hosting/setup.md#hosting) его.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md).
  1. В списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите зарегистрированное вами доменное имя, например `gatsbytest.ru`.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** укажите `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access) **Публичный** для всех операций.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. На странице со списком бакетов выберите созданный бакет.
  1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
  1. Выберите `{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}`.
  1. В поле **{{ ui-key.yacloud.storage.bucket.website.field_index }}** укажите абсолютный путь к файлу главной страницы сайта. Для сайта из шаблона Gatsby укажите `index.html`.
  1. (Опционально) В поле **{{ ui-key.yacloud.storage.bucket.website.field_error }}** укажите абсолютный путь к файлу, который будет отображаться при ошибках `4xx`. Для сайта из шаблона Gatsby укажите `404.html`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.


- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Создайте бакет:

      ```bash
      yc storage bucket create \
        --name <имя_бакета> \
        --default-storage-class standard \
        --max-size 1073741824 \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Где `--name` — имя бакета. Укажите зарегистрированное вами доменное имя, например `gatsbytest.ru`.

      Результат:

      ```text
      name: gatsbytest.ru
      folder_id: b1g681qpemb4********
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "1073741824"
      acl: {}
      created_at: "2024-09-09T15:23:34.919887Z"
      ```

      Подробнее о команде `yc storage bucket create` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

  1. Включите в бакете хостинг статического сайта:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --website-settings '{"index": "index.html", "error": "404.html"}'
      ```

      Где:

      * `--name` — имя созданного ранее бакета, например `gatsbytest.ru`.
      * `index` — абсолютный путь к файлу главной страницы сайта. Для сайта из шаблона Gatsby укажите `index.html`.
      * `error` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках `4xx`. Для сайта из шаблона Gatsby укажите `404.html`.

      Результат:

      ```yaml
      name: gatsbytest.ru
      folder_id: b1g681qpemb4********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "1073741824"
      acl: {}
      created_at: "2024-09-09T15:23:34.919887Z"
      website_settings:
        redirect_all_requests: {}
      ```

      Подробнее о команде `yc storage bucket update` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/bucket/update.md).

- AWS CLI {#aws-cli}

  1. Создайте бакет:

      ```bash
      aws s3api create-bucket \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --acl public-read
      ```

      Где `--bucket` — имя бакета. Укажите зарегистрированное вами доменное имя, например `gatsbytest.ru`.

      Результат:

      ```text
      {
          "Location": "/gatsbytest.ru"
      }
      ```

  1. Включите в бакете хостинг статического сайта:

      ```bash
      aws s3api put-bucket-website \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --website-configuration '{
          "IndexDocument": {
            "Suffix": "index.html"
          },
          "ErrorDocument": {
            "Key": "404.html"
          }
        }'
      ```

      Где:
      
      * `--bucket` — имя созданного ранее бакета, например `gatsbytest.ru`.
      * `IndexDocument.Suffix` — абсолютный путь к файлу главной страницы сайта. Для сайта из шаблона Gatsby укажите `index.html`.
      * `ErrorDocument.Key` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках `4xx`. Для сайта из шаблона Gatsby укажите `404.html`.

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

  Чтобы настроить хостинг статического сайта, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../storage/s3/api-ref/hosting/upload.md).

{% endlist %}

## Привяжите доменное имя к бакету {#bind-domain}

Привяжите к созданному бакету доменное имя — создайте на [DNS-сервере](../../glossary/dns.md#dns-server) публичную [зону DNS](../../dns/concepts/dns-zone.md) и [ресурсную запись ANAME](../../dns/concepts/resource-record.md#aname), которая связывает ваше доменное имя и бакет.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в созданный ранее бакет.
  1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
  1. В блоке **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** нажмите кнопку **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}** и выберите доменную зону, которая соответствует имени бакета, например `gatsbytest.ru.` (с точкой в конце). Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      Дождитесь создания записи.

  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте публичную зону DNS `gatsbytest-ru-zone` в {{ dns-full-name }}:

      ```bash
      yc dns zone create \
        --name gatsbytest-ru-zone \
        --zone <имя_домена> \
        --public-visibility
      ```

      Где `--zone` — имя вашего домена, например `gatsbytest.ru.`. Значение параметра `--zone` должно заканчиваться точкой. Например, название доменной зоны `gatsbytest.ru.` соответствует домену `gatsbytest.ru`.

      Результат:

      ```text
      id: dns39gihj0ef********
      folder_id: b1g681qpemb4********
      created_at: "2024-09-09T15:23:34.919887Z"
      name: gatsbytest-ru-zone
      zone: gatsbytest.ru.
      public_visibility: {}
      ```

      Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/create.md).

  1. Создайте ресурсную запись ANAME в публичной зоне DNS `gatsbytest-ru-zone`:

      ```bash
      yc dns zone add-records \
        --name gatsbytest-ru-zone \
        --record "@ 600 ANAME <имя_домена>.{{ s3-web-host }}"
      ```

      Результат:

      ```text
      +--------+----------------+-------+---------------------------------------+-----+
      | ACTION |      NAME      | TYPE  |                 DATA                  | TTL |
      +--------+----------------+-------+---------------------------------------+-----+
      | +      | gatsbytest.ru. | ANAME | gatsbytest.ru.website.yandexcloud.net | 600 |
      +--------+----------------+-------+---------------------------------------+-----+
      ```

      Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md).

  Чтобы создать ресурсную запись в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

{% endlist %}

## Добавьте TLS-сертификат в {{ certificate-manager-full-name }} {#issue-certificate}

Чтобы настроить доступ к сайту по защищенному протоколу, получите TLS-сертификат и настройте доступ к бакету по HTTPS.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Добавьте в сервис {{ certificate-manager-name }} [сертификат](../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для вашего домена, который будет использоваться сайтом:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать сертификат.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** и выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** укажите имя создаваемого сертификата. Например: `gatsbytestcert`.
      1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** укажите имя вашего домена, например `gatsbytest.ru`.
      1. Выберите [тип проверки прав на домен](../../certificate-manager/concepts/challenges.md) `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}`.
      1. Нажмите **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

          В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домен](../../certificate-manager/operations/managed/cert-validate.md).

  1. Для успешного выпуска сертификата пройдите проверку прав на домен:

      1. В списке сертификатов выберите `gatsbytestcert`.
      1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** выберите `CNAME-запись`.
      1. Нажмите **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}** и в открывшемся окне нажмите **{{ ui-key.yacloud.common.create }}**.

      Проверка прав на домен может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

- {{ yandex-cloud }} CLI {#cli}

  1. Добавьте в сервис {{ certificate-manager-name }} [сертификат](../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для вашего домена, который будет использоваться сайтом.

      Выполните команду:

      ```bash
      yc certificate-manager certificate request \
        --name gatsbytestcert \
        --challenge dns \
        --domains <имя_домена>
      ```

      Где `--domains` — имя вашего домена для веб-сервера. Например: `gatsbytest.ru`.

      Результат:
      ```bash
      id: fpqbs12t6ion********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-24T14:36:39.299844798Z"
      name: gatsbytestcert
      type: MANAGED
      domains:
        - gatsbytest.ru
      status: VALIDATING
      updated_at: "2023-12-24T14:36:39.299844798Z"
      ```

      Подробнее о команде `yc certificate-manager certificate request` читайте в [справочнике CLI](../../cli/cli-ref/certificate-manager/cli-ref/certificate/request.md).

      Сохраните идентификатор (`id`) созданного сертификата: он пригодится для прохождения проверки ваших прав на домен.

  1. Для успешного выпуска сертификата пройдите проверку прав на домен:

      1. Получите значения ресурсных записей, необходимых для прохождения проверки:

          ```bash
          yc certificate-manager certificate get \
            --name gatsbytestcert \
            --full
          ```

          Результат:

          ```bash
          id: fpq2gpi42teg********
          folder_id: b1gt6g8ht345********
          created_at: "2023-12-24T18:13:45.960Z"
          name: gatsbytestcert
          type: MANAGED
          domains:
            - gatsbytest.ru
          status: VALIDATING
          updated_at: "2023-12-24T18:13:45.960Z"
          challenges:
            - domain: gatsbytest.ru
              type: DNS
              created_at: "2023-12-24T18:13:45.960Z"
              updated_at: "2023-12-24T18:13:49.280Z"
              status: PENDING
              message: Create a record in your DNS provider.
              dns_challenge:
                name: _acme-challenge.gatsbytest.ru
                type: CNAME
                value: fpq2gpi42teg********.cm.yandexcloud.net.
            - domain: gatsbytest.ru
              type: DNS
              created_at: "2023-12-24T18:13:45.960Z"
              updated_at: "2023-12-24T18:13:49.280Z"
              status: PENDING
              message: Create a record in your DNS provider.
              dns_challenge:
                name: _acme-challenge.gatsbytest.ru.
                type: TXT
                value: iiyJJJlsaFIqQ7DMUzira0OKU3iXuaqiN7U********
          ```

          Подробнее о команде `yc certificate-manager certificate get` читайте в [справочнике CLI](../../cli/cli-ref/certificate-manager/cli-ref/certificate/get.md).

          Сохраните значение поля `value` из раздела с типом `CNAME` в блоке `challenges.dns_challenge`. Это значение понадобятся на следующем шаге.

          В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домен](../../certificate-manager/operations/managed/cert-validate.md).

      1. Создайте [ресурсную запись](../../dns/concepts/resource-record.md) CNAME для прохождения проверки ваших прав на домен:

          ```bash
          yc dns zone add-records \
            --name gatsbytest-ru-zone \
            --record "_acme-challenge 600 CNAME <значение_dns_challenge>"
          ```

          Где `<значение_dns_challenge>` — сохраненное на предыдущем шаге значение, необходимое для проверки прав на соответствующий домен с помощью CNAME-записи.

          Результат:

          ```text
          +--------+----------------------------------+-------+------------------------------------------+-----+
          | ACTION |              NAME                | TYPE  |                   DATA                   | TTL |
          +--------+----------------------------------+-------+------------------------------------------+-----+
          | +      | _acme-challenge.gatsbytest.ru.   | CNAME | fpq2gpi42teg********.cm.yandexcloud.net. | 600 |
          +--------+----------------------------------+-------+------------------------------------------+-----+
          ```

          Подробнее о команде `yc dns zone add-records` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

          Проверка прав на домены может занять от нескольких минут до нескольких дней — дождитесь ее успешного завершения. В результате сертификат будет выпущен и перейдет в статус `Issued`.

      1. Убедитесь, что статус сертификата изменился на `Issued`:

          ```bash
          yc certificate-manager certificate get \
            --name gatsbytestcert
          ```

          Результат:

          ```text
          id: fpqr2j0sdb1n********
          folder_id: b1gt6g8ht345********
          created_at: "2023-12-24T16:38:02.206Z"
          name: gatsbytestcert
          type: MANAGED
          domains:
            - gatsbytest.ru
          status: ISSUED
          issuer: CN=R3,O=Let's Encrypt,C=US
          serial: 4b7d7f0968097ae1a7707854a80********
          updated_at: "2023-12-24T16:46:03.578Z"
          issued_at: "2023-12-24T16:46:03.578Z"
          not_after: "2024-03-23T15:44:59Z"
          not_before: "2023-12-24T15:45:00Z"
          ```

- API {#api}

  1. Добавьте в сервис {{ certificate-manager-name }} [сертификат](../../certificate-manager/concepts/managed-certificate.md) от Let's Encrypt® для вашего домена, который будет использоваться сайтом.

      Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../certificate-manager/api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/RequestNew](../../certificate-manager/api-ref/grpc/Certificate/requestNew.md).

      В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домен](../../certificate-manager/operations/managed/cert-validate.md).

  1. Для успешного выпуска сертификата пройдите проверку прав на домен.

      Чтобы получить информацию, необходимую для прохождения процедуры проверки прав на домен, воспользуйтесь методом REST API [get](../../certificate-manager/api-ref/Certificate/get.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/Get](../../certificate-manager/api-ref/grpc/Certificate/get.md) с флагом `view=FULL`.

      Чтобы создать ресурсную запись CNAME в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

{% endlist %}


## Настройте доступ к бакету по HTTPS {#configure-https}

[Добавьте](../../storage/operations/hosting/certificate.md#cert-manager) сертификат в настройках бакета:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя необходимого бакета, в данном примере это `gatsbytest.ru`.
  1. На панели слева выберите ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_https }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_source }}** выберите **{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** выберите сертификат в появившемся списке.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc storage bucket set-https \
    --name <имя_бакета> \
    --certificate-id <идентификатор_сертификата>
  ```

  Где:

  * `--name` — имя бакета, в данном примере это `gatsbytest.ru`;
  * `--certificate-id` — идентификатор сертификата в {{ certificate-manager-name }}.

  Результат:

  ```text
  source_type: SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER
  certificate_id: fpqe2g0hfr0e********
  ```

- API {#api}

  Чтобы привязать к бакету TLS-сертификат {{ certificate-manager-name }}, воспользуйтесь методом REST API [setHTTPSConfig](../../storage/api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../storage/api-ref/grpc/Bucket/setHTTPSConfig.md).

{% endlist %}

{% note info %}

Для активации настроек может потребоваться некоторое время.

{% endnote %}


## Создайте сайт локально {#create-local-site}

Для целей тестирования создайте на вашем локальном компьютере сайт, используя шаблон из библиотеки [Gatsby Starter Library](https://www.gatsbyjs.com/starters/).

1. Чтобы создать сайт, выполните команды:

    ```bash
    sudo npm install -g gatsby-cli
    gatsby new my-gatsby-project https://github.com/gatsbyjs/gatsby-starter-blog
    ```

1. Перейдите в папку сайта:

    ```bash
    cd my-gatsby-project
    ```

1. Скомпилируйте сайт для локального доступа:

    ```bash
    gatsby develop
    ```

    Дождитесь выполнения команды.

1. Убедитесь, что сайт доступен по адресу `http://localhost:8000`.



## Загрузите сайт в бакет {#upload-site}

Чтобы собрать и загрузить рабочую версию сайта в бакет, воспользуйтесь консольной утилитой [AWS CLI](https://aws.amazon.com/ru/cli/) и специальным [плагином S3](https://www.gatsbyjs.com/plugins/gatsby-plugin-s3/?=S3) из набора встроенных плагинов Gatsby.


### Установите плагин S3 {#setup-s3-plugin}

1. На вашем локальном компьютере перейдите в папку сайта `my-gatsby-project` и выполните команду:

    ```bash
    npm i gatsby-plugin-s3
    ```

1. Откройте файл `gatsby-config.js` и добавьте декларацию плагина в секцию `plugins`:

    ```text
    plugins: [
        {
          resolve: 'gatsby-plugin-s3',
          options: {
            bucketName: '<имя_бакета>',
            region: 'us-east-1',
            customAwsEndpointHostname: '{{ s3-storage-host }}'
          }
        },
        ...
    ]
    ```

    Где `bucketName` — имя бакета, в данном примере `gatsbytest.ru`.

    {% note info %}

    Не меняйте значение региона, это может привести к ошибке.

    {% endnote %}

1. Откройте файл `package.json` и добавьте запись `deploy` в секцию `scripts`:

    ```text
    "scripts": {
        "deploy": "gatsby-plugin-s3 deploy --yes",
        ...
    }
    ```


### Загрузите сайт в бакет {#upload-site}

1. Скомпилируйте сайт, выполнив команду:

    ```bash
    sudo npm run build
    ```

1. Дождитесь окончания процесса компиляции и загрузите сайт в бакет, выполнив команду:

    ```bash
    npm run deploy
    ```

## Проверьте результат {#check-result}

По окончании загрузки убедитесь, что сайт доступен по доменному имени по защищенному протоколу. Для этого перейдите в браузере по адресу `https://<имя_бакета>`. В данном примере `https://gatsbytest.ru`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу и перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
1. При необходимости удалите [ресурсные записи](../../dns/operations/resource-record-delete.md) и [доменную зону](../../dns/operations/zone-delete.md).
1. При необходимости [удалите](../../certificate-manager/operations/managed/cert-delete.md) TLS-сертификат.
