# Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN



Чтобы [настроить хостинг](index.md) статического сайта в бакете с доступом через CDN с помощью консоли управления Yandex Cloud, CLI или API:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Добавьте сертификат в Certificate Manager](#add-certificate).
1. [Создайте бакет в Object Storage и загрузите файлы сайта](#create-bucket).
1. [Настройте хостинг статического сайта](#hosting).
1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Настройте DNS для CDN-ресурса](#configure-dns).
1. [Проверьте работу CDN](#check-cdn).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для сайта в бакете с доступом через CDN входят:
* плата за исходящий трафик с CDN-серверов (см. [тарифы Cloud CDN](../../../cdn/pricing.md));
* плата за хранение данных в Object Storage, операции с ними и исходящий трафик (см. [тарифы Object Storage](../../../storage/pricing.md));
* плата за публичные DNS-запросы и [DNS-зоны](../../../dns/concepts/dns-zone.md), если вы используете [Yandex Cloud DNS](../../../dns/index.md) (см. [тарифы Cloud DNS](../../../dns/pricing.md)).


## Добавьте сертификат в Certificate Manager {#add-certificate}

Поддерживаются сертификаты из [Yandex Certificate Manager](../../../certificate-manager/index.md). Вы можете [выпустить новый сертификат Let's Encrypt®](../../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный](../../../certificate-manager/operations/import/cert-create.md).

Сертификат должен находиться в том же [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен ваш CDN-ресурс.

Для сертификата Let's Encrypt® пройдите [проверку прав](../../../certificate-manager/operations/managed/cert-validate.md) на домен, который указан в сертификате.


## Создайте бакет в Object Storage и загрузите файлы сайта {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета, например `example.com`.
  1. Нажмите кнопку **Создать бакет**.
  1. На локальном компьютере создайте файл главной страницы сайта — `index.html`.
     
      {% cut "Пример файла index.html" %}
      
      ```html
      <!DOCTYPE html>
      <html>
        <head>
          <title>My site</title>
        </head>
        <body>
          <p>The site is working</p>
        </body>
      </html>
      ```
      
      {% endcut %}
  1. На странице созданного ранее бакета нажмите кнопку ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить** и выберите файл `index.html`.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте бакет в каталоге по умолчанию:

      ```bash
      yc storage bucket create --name <имя_бакета> \
        --public-read \
        --public-list
      ```

      Где:
      * `--name` — имя бакета, например `example.com`. Обязательный параметр. Подробнее см. [Правила именования бакетов](../../../storage/concepts/bucket.md#naming).
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

  1. На локальном компьютере создайте файл главной страницы сайта — `index.html`.
     
      {% cut "Пример файла index.html" %}
      
      ```html
      <!DOCTYPE html>
      <html>
        <head>
          <title>My site</title>
        </head>
        <body>
          <p>The site is working</p>
        </body>
      </html>
      ```
      
      {% endcut %}

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
      * `--key` — [ключ](../../../storage/concepts/object.md#key), по которому объект будет храниться в бакете, например `index.html`.

      Результат:
      ```text
      etag: '"b810d087812333c7dd9cfa80********"'
      request_id: 8e8714b8********
      ```

- API {#api}

  1. Чтобы создать бакет, воспользуйтесь методом REST API [create](../../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../../storage/s3/api-ref/bucket/create.md).

  1. На локальном компьютере создайте файл главной страницы сайта — `index.html`.
     
      {% cut "Пример файла index.html" %}
      
      ```html
      <!DOCTYPE html>
      <html>
        <head>
          <title>My site</title>
        </head>
        <body>
          <p>The site is working</p>
        </body>
      </html>
      ```
      
      {% endcut %}

  1. Чтобы загрузить главную страницу сайта, воспользуйтесь методом S3 API [upload](../../../storage/s3/api-ref/object/upload.md).

{% endlist %}


## Настройте хостинг статического сайта {#hosting}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Object Storage** и затем в бакет, для которого хотите настроить хостинг.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **Настройки**.
  1. Перейдите на вкладку **Основные**.
  1. В полях **Чтение объектов** и **Чтение списка объектов** выберите `Для всех`.
  1. Нажмите **Сохранить**.
  1. Выберите вкладку **Веб-сайт**.
  1. В разделе **Хостинг** в поле **Главная страница** укажите абсолютный путь к файлу в бакете для главной страницы сайта, например `index.html`.
  1. Нажмите кнопку **Сохранить**.

  Проверить хостинг можно, перейдя по ссылке в поле **Ссылка**.

- Yandex Cloud CLI {#cli}

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

  Чтобы настроить хостинг статического сайта, воспользуйтесь методом REST API [update](../../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../../storage/api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../../storage/s3/api-ref/hosting/upload.md).

{% endlist %}


## Создайте CDN-ресурс {#create-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud CDN**.
  1. Нажмите кнопку **Создать ресурс**.
  1. Задайте основные настройки CDN-ресурса:
      * В блоке **Контент**:
        * Включите **Доступ к контенту**.
        * В поле **Запрос контента** выберите `Из одного источника`.
        * В поле **Тип источника** выберите `Бакет`.
        * В поле **Бакет** выберите нужный бакет из списка.
        * Включите **Использовать сайт бакета**.
        * В поле **Протокол для источников** выберите `HTTP`.
        * В поле **Доменное имя** укажите доменное имя, например `cdn.yandexcloud.example`.

          {% note alert %}

          Доменное имя `cdn.yandexcloud.example` станет основным, и его будет невозможно изменить после создания CDN-ресурса.

          {% endnote %}

      * В блоке **Дополнительно**:
        * В поле **Переадресация клиентов** выберите `С HTTP на HTTPS`.
        * В поле **Тип сертификата** укажите `Сертификат из Certificate Manager` и выберите [сертификат](#add-certificate) для доменного имени `cdn.yandexcloud.example`.
        * В поле **Заголовок Host** выберите `Свое значение` и в **Значение заголовка** укажите доменное имя источника в формате: `<имя_бакета_с_файлами>.website.yandexcloud.net`, чтобы бакет-источник корректно отвечал на запросы CDN-серверов.
  1. Нажмите **Продолжить**.
  1. В разделах **Кеширование**, **HTTP-заголовки и методы** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Создать и продолжить**.

- Yandex Cloud CLI {#cli}

  1. Создайте группу источников:

      ```bash
      yc cdn origin-group create \
        --name <имя_группы_источников> \
        --origin source=<имя_бакета_с_файлами>.website.yandexcloud.net,enabled=true
      ```

      Где:
      * `--name` — имя группы источников.
      * `--origin source` — доменное имя источника в формате: `<имя_бакета_с_файлами>.website.yandexcloud.net`, например `example.com.website.yandexcloud.net`.

      Результат:

      ```text
      folder_id: b1geoelk7fld********
      name: mys3-origin
      use_next: true
      origins:
        - id: "27904"
          origin_group_id: "42742158888********"
          source: example.com.website.yandexcloud.net
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
        --host-header <имя_бакета_с_файлами>.website.yandexcloud.net
      ```

      Где:
      * `--cname` — доменное имя для CDN-ресурса, например: `cdn.example.com`.
      * `--origin-group-id` — идентификатор группы источников для CDN, созданной на предыдущем шаге.
      * `--origin-protocol` — протокол, который будет использоваться для взаимодействия CDN-ресурса с источником, укажите `http`.
      * `--cert-manager-ssl-cert-id` — идентификатор TLS-сертификата, сохраненный ранее при его создании.
      * `--host-header` — значение заголовка Host. Чтобы бакет-источник корректно отвечал на запросы CDN-серверов, укажите доменное имя источника в формате: `<имя_бакета_с_файлами>.website.yandexcloud.net`, например `example.com.website.yandexcloud.net`.

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
            value: example.com.website.yandexcloud.net
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

  Чтобы создать ресурс CDN, воспользуйтесь методом REST API [create](../../../cdn/api-ref/Resource/create.md) для ресурса [Resource](../../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../../cdn/api-ref/grpc/Resource/create.md).

{% endlist %}

{% note warning %}

После создания CDN-ресурса может пройти до 15 минут, прежде чем ресурс фактически заработает.

Перед тем как приступать к следующим шагам, убедитесь, что вновь созданный CDN-ресурс полностью работоспособен.

{% endnote %}


## Настройте DNS для CDN-ресурса {#configure-dns}

Доменное имя `cdn.yandexcloud.example` должно быть связано с CDN-ресурсом с помощью записей [DNS](../../../glossary/dns.md).

Чтобы настроить DNS для CDN-ресурса:

1. Получите доменное имя провайдера Cloud CDN:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud CDN**.
     1. В списке CDN-ресурсов выберите ресурс с основным доменным именем `cdn.yandexcloud.example`.
     1. Из блока **Настройки DNS** внизу страницы скопируйте доменное имя вида `e1b83ae3********.topology.gslb.yccdn.ru`.

   {% endlist %}

1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
1. Создайте или измените CNAME-запись для `cdn.yandexcloud.example` так, чтобы она указывала на скопированное доменное имя:

   ```text
   cdn CNAME e1b83ae3********.topology.gslb.yccdn.ru
   ```

   {% note info %}
   
   Не используйте ресурсную запись [ANAME](../../../dns/concepts/resource-record.md#aname) с доменными именами для раздачи контента, поскольку в таком случае конечный пользователь получит ответ от CDN-сервера, не связанного с геолокацией пользователя. Ответ всегда будет одинаков для всех пользователей.
   
   {% endnote %}

   Если вы пользуетесь Cloud DNS, настройте запись по следующей инструкции:
   
   {% cut "Инструкция по настройке DNS-записей для Cloud DNS" %}
   
   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
     1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
     1. Если у вас нет публичной зоны DNS, создайте ее:

        1. Нажмите кнопку **Создать зону**.
        1. В поле **Зона** укажите доменное имя сайта с точкой в конце: `yandexcloud.example.`.
        1. В поле **Тип** выберите `Публичная`.
        1. В поле **Имя** укажите `example-dns-zone`.
        1. Нажмите кнопку **Создать**.
      
     1. Создайте в зоне CNAME-запись для `cdn.yandexcloud.example`:

        1. Выберите зону `example-dns-zone`.
        1. Нажмите кнопку **Создать запись**.
        1. В поле **Имя** укажите `cdn`.
        1. В поле **Тип** укажите `CNAME`.
        1. В поле **Значение** вставьте скопированное значение вида `e1b83ae3********.topology.gslb.yccdn.ru.` с точкой на конце.
        1. Нажмите кнопку **Создать**.

   {% endlist %}

   {% endcut %}


## Проверьте работу CDN {#check-cdn}

Дождитесь обновления DNS-записей — на это может потребоваться несколько часов.

Проверьте доступность сайта: откройте его по новому URL `cdn.example.com`. Должно произойти перенаправление на страницу `https://cdn.example.com`, где уже подключен TLS-сертификат из Certificate Manager и источником для раздачи является Cloud CDN.


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы создавали зону в Cloud DNS, то [удалите](../../../dns/operations/zone-delete.md) зону DNS `example-dns-zone`.
1. [Удалите](../../../cdn/operations/resources/delete-resource.md) CDN-ресурс с основным доменным именем `cdn.yandexcloud.example`.
1. [Удалите](../../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../../storage/operations/buckets/delete.md) бакет.


#### См. также {#see-also}

* [Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN с помощью Terraform](terraform.md)