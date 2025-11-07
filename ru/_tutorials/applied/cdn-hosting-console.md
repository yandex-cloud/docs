1. [Подготовьте облако к работе](#before-you-begin).
1. [Добавьте сертификат в {{ certificate-manager-name }}](#add-certificate).
1. [Создайте бакет в {{ objstorage-name }} и загрузите файлы сайта](#create-bucket).
1. [Настройте хостинг статического сайта](#hosting).
1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Настройте DNS для CDN-ресурса](#configure-dns).
1. [Проверьте работу CDN](#check-cdn).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/cdn-hosting/paid-resources.md) %}


## Добавьте сертификат в {{ certificate-manager-name }} {#add-certificate}

{% include [add-certificate](../_tutorials_includes/cdn-hosting/add-certificate.md) %}


## Создайте бакет в {{ objstorage-name }} и загрузите файлы сайта {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета, например `example.com`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. {% include [create-index-page](../_tutorials_includes/cdn-hosting/create-index-page.md) %}
  1. На странице созданного ранее бакета нажмите кнопку ![image](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** и выберите файл `index.html`.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте бакет в каталоге по умолчанию:

      ```bash
      yc storage bucket create --name <имя_бакета> \
        --public-read \
        --public-list
      ```

      Где:
      * `--name` — имя бакета, например `example.com`. Обязательный параметр. Подробнее см. [Правила именования бакетов](../../storage/concepts/bucket.md#naming).
      * `--public-read` — включить публичный доступ на чтение объектов в бакете.
      * `--public-list` — включить публичный доступ на просмотр списка объектов в бакете.

      Результат:

      ```text
      name: example.com
      folder_id: b1geoelk7fld********
      anonymous_access_flags:
        read: true
        list: true
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      created_at: "2025-10-26T17:38:54.635027Z"
      resource_id: e3ef9cmb253k********
      ```

  1. {% include [create-index-page](../_tutorials_includes/cdn-hosting/create-index-page.md) %}

  1. Загрузите файл главной страницы в бакет:

      ```bash
      yc storage s3api put-object \
        --body <путь_к_локальному_файлу> \
        --bucket <имя_бакета> \
        --key <путь_к_объекту>
      ```

      Где:

      * `--body` — путь к файлу, который нужно загрузить в бакет, например `index.html`.
      * `--bucket` — имя вашего бакета, например `example.com`.
      * `--key` — [ключ](../../storage/concepts/object.md#key), по которому объект будет храниться в бакете, например `index.html`.

      Результат:
      ```text
      etag: '"b810d087812333c7dd9cfa80********"'
      request_id: 8e8714b8********
      ```

- API {#api}

  1. Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

  1. {% include [create-index-page](../_tutorials_includes/cdn-hosting/create-index-page.md) %}

  1. Чтобы загрузить главную страницу сайта, воспользуйтесь методом S3 API [upload](../../storage/s3/api-ref/object/upload.md).

{% endlist %}


## Настройте хостинг статического сайта {#hosting}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, для которого хотите настроить хостинг.
  1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}**.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
  1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** в поле **{{ ui-key.yacloud.storage.bucket.website.field_index }}** укажите абсолютный путь к файлу в бакете для главной страницы сайта, например `index.html`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

  Проверить хостинг можно, перейдя по ссылке в поле **{{ ui-key.yacloud.storage.bucket.website.field_link }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Задайте параметры хостинга для бакета:

      ```bash
      yc storage bucket update --name <имя_бакета> \
        --website-settings '{"index":"index.html"}'
      ```
      
      Где `--name` — имя бакета.

      Результат:

      ```text
      name: example.com
      folder_id: b1geoelk7fld********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      acl: {}
      created_at: "2025-10-26T17:38:54.635027Z"
      website_settings:
        index: index.html
        redirect_all_requests: {}
      resource_id: e3ef9cmb253k********
      ```

- API {#api}

  Чтобы настроить хостинг статического сайта, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../storage/s3/api-ref/hosting/upload.md).

{% endlist %}


## Создайте CDN-ресурс {#create-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Задайте основные настройки CDN-ресурса:
      * В блоке **{{ ui-key.yacloud.cdn.label_section-content }}**:
        * Включите **{{ ui-key.yacloud.cdn.label_access }}**.
        * В поле **{{ ui-key.yacloud.cdn.label_content-query-type }}** выберите `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_source-type }}** выберите `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_bucket }}** выберите нужный бакет из списка.
        * Включите **{{ ui-key.yacloud.cdn.label_use-bucket-site }}**.
        * В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите `{{ ui-key.yacloud.common.label_http }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_personal-domain }}** укажите доменное имя, например `cdn.yandexcloud.example`.

          {% note alert %}

          Доменное имя `cdn.yandexcloud.example` станет основным, и его будет невозможно изменить после создания CDN-ресурса.

          {% endnote %}

      * В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** укажите `{{ ui-key.yacloud.cdn.value_certificate-custom }}` и выберите [сертификат](#add-certificate) для доменного имени `cdn.yandexcloud.example`.
        * В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}` и в **{{ ui-key.yacloud.cdn.label_custom-host-header }}** укажите доменное имя источника в формате: `<имя_бакета_с_файлами>.{{ s3-web-host }}`, чтобы бакет-источник корректно отвечал на запросы CDN-серверов.
  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  1. В разделах **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и **{{ ui-key.yacloud.cdn.label_section-additional }}** оставьте настройки по умолчанию и нажмите **{{ ui-key.yacloud.cdn.button_wizard-create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте группу источников:

      ```bash
      yc cdn origin-group create \
        --name <имя_группы_источников> \
        --origin source=<имя_бакета_с_файлами>.{{ s3-web-host }},enabled=true
      ```

      Где:
      * `--name` — имя группы источников.
      * `--origin source` — доменное имя источника в формате: `<имя_бакета_с_файлами>.{{ s3-web-host }}`, например `example.com.{{ s3-web-host }}`.

      Результат:

      ```text
      folder_id: b1geoelk7fld********
      name: mys3-origin
      use_next: true
      origins:
        - id: "27904"
          origin_group_id: "42742158888********"
          source: example.com.{{ s3-web-host }}
          enabled: true
          provider_type: ourcdn
      provider_type: ourcdn
     ```

  1. Создайте ресурс CDN:

      ```bash
      yc cdn resource create \
        --cname <доменное_имя_cdn> \
        --origin-group-id <идентификатор_группы_источников> \
        --origin-protocol http \
        --cert-manager-ssl-cert-id <идентификатор_TLS_сертифкатоа> \
        --host-header <имя_бакета_с_файлами>.{{ s3-web-host }}
      ```

      Где:
      * `--cname` — доменное имя для CDN-ресурса, например: `cdn.example.com`.
      * `--origin-group-id` — идентификатор группы источников для CDN, созданной на предыдущем шаге.
      * `--origin-protocol` — протокол, который будет использоваться для взаимодействия CDN-ресурса с источником, укажите `http`.
      * `--cert-manager-ssl-cert-id` — идентификатор TLS-сертификата, сохраненный ранее при его создании.
      * `--host-header` — значение заголовка Host. Чтобы бакет-источник корректно отвечал на запросы CDN-серверов, укажите доменное имя источника в формате: `<имя_бакета_с_файлами>.{{ s3-web-host }}`, например `example.com.{{ s3-web-host }}`.

      {% cut "Результат" %}

      ```text
      id: bc8r4l7awapj********
      folder_id: b1geoelk7fld********
      cname: cdn.example.com
      created_at: "2025-10-26T17:45:08.171948Z"
      updated_at: "2025-10-26T17:45:08.171948Z"
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
          host:
            enabled: true
            value: example.com.{{ s3-web-host }}
        static_headers:
          enabled: true
        stale: {}
        allowed_http_methods:
          enabled: true
          value:
            - GET
            - HEAD
            - OPTIONS
        proxy_cache_methods_set:
          enabled: true
        disable_proxy_force_ranges:
          enabled: true
          value: true
        static_request_headers:
          enabled: true
        custom_server_name: {}
        ignore_cookie:
          enabled: true
          value: true
        secure_key:
          type: DISABLE_IP_SIGNING
      origin_group_id: "42742158888********"
      origin_group_name: mys3-origin
      origin_protocol: HTTP
      ssl_certificate:
        type: CM
        status: READY
        data:
          cm:
            id: fpq4nl8g1c4h********
      provider_type: ourcdn
      provider_cname: b5384481********.a.yccdn.cloud.yandex.net
      ```

      {% endcut %}

- API {#api}

  Чтобы создать ресурс CDN, воспользуйтесь методом REST API [create](../../cdn/api-ref/Resource/create.md) для ресурса [Resource](../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md).

{% endlist %}

{% include [start-warn](../_tutorials_includes/cdn-hosting/start-warn.md) %}


## Настройте DNS для CDN-ресурса {#configure-dns}

Доменное имя `cdn.yandexcloud.example` должно быть связано с CDN-ресурсом с помощью записей [DNS](../../glossary/dns.md).

Чтобы настроить DNS для CDN-ресурса:

1. Получите доменное имя провайдера {{ cdn-name }}:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
     1. В списке CDN-ресурсов выберите ресурс с основным доменным именем `cdn.yandexcloud.example`.
     1. Из блока **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** внизу страницы скопируйте доменное имя вида `{{ cname-example-yc }}` или `{{ cname-example-edge }}` в зависимости от используемого [провайдера CDN](../../cdn/concepts/providers.md).

   {% endlist %}

1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
1. Создайте или измените CNAME-запись для `cdn.yandexcloud.example` так, чтобы она указывала на скопированное доменное имя:

   ```text
   cdn CNAME {{ cname-example-yc }}
   ```

   {% include [note-dns-aname](../../_includes/cdn/note-dns-aname.md) %}

   Если вы пользуетесь {{ dns-name }}, настройте запись по следующей инструкции:
   
   {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}
   
   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
     1. Если у вас нет публичной зоны DNS, создайте ее:

        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
        1. В поле **{{ ui-key.yacloud.dns.label_zone }}** укажите доменное имя сайта с точкой в конце: `yandexcloud.example.`.
        1. В поле **{{ ui-key.yacloud.common.type }}** выберите `{{ ui-key.yacloud.dns.label_public }}`.
        1. В поле **{{ ui-key.yacloud.common.name }}** укажите `example-dns-zone`.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      
     1. Создайте в зоне CNAME-запись для `cdn.yandexcloud.example`:

        1. Выберите зону `example-dns-zone`.
        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
        1. В поле **{{ ui-key.yacloud.common.name }}** укажите `cdn`.
        1. В поле **{{ ui-key.yacloud.common.type }}** укажите `CNAME`.
        1. В поле **{{ ui-key.yacloud.dns.label_records }}** вставьте скопированное значение вида `{{ cname-example-yc }}.` или `{{ cname-example-edge }}.` (в зависимости от используемого [провайдера CDN](../../cdn/concepts/providers.md)) с точкой на конце.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   {% endlist %}

   {% endcut %}


## Проверьте работу CDN {#check-cdn}

{% include [check-cdn](../_tutorials_includes/cdn-hosting/check-cdn.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы создавали зону в {{ dns-name }}, то [удалите](../../dns/operations/zone-delete.md) зону DNS `example-dns-zone`.
1. [Удалите](../../cdn/operations/resources/delete-resource.md) CDN-ресурс с основным доменным именем `cdn.yandexcloud.example`.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.