# Публикация обновлений для игр с помощью {{ cdn-full-name }}

Создайте и настройте [CDN-ресурс](../../cdn/concepts/resource.md) {{ cdn-name }} для размещения в нем контента, к которому ожидается большое количество запросов в малый промежуток времени, например файлов для обновления игры (патчей, [DLC](https://ru.wikipedia.org/wiki/Загружаемый_контент) и т. п.). Чтобы в этот промежуток не создавалась высокая нагрузка на источники контента со стороны CDN-серверов, файлы будут однократно [предзагружены](../../cdn/concepts/caching.md#prefetch) в кеш серверов.

Предполагается, что патч состоит из одного файла с именем `ycgame-update-v1.1.exe`. Он будет загружен в [бакет](../../storage/concepts/bucket.md) [{{ objstorage-full-name }}](../../storage/).

{% note info %}

Не рекомендуется предзагружать файлы размером меньше 200 МБ или больше 5 ГБ.

{% endnote %}

Чтобы создать CDN-инфраструктуру:
1. [Подготовьтесь к работе](#before-you-begin).
1. [Создайте бакеты в {{ objstorage-name }}](#create-buckets).
1. [Включите логирование бакета с файлами](#enable-logging).
1. [Загрузите файл в бакет](#upload-object).
1. [Создайте CDN-ресурс и включите кеширование](#create-cdn-resource).
1. [Настройте DNS для своего домена](#dns-setup).
1. [Предзагрузите контент в кеш CDN-серверов](#prefetch-content).
1. [Проверьте работу CDN](#check-cdn-working).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Убедитесь, что у вас есть доменное имя и доступ к настройкам [DNS](../../glossary/dns.md) на сайте компании, которая предоставляет вам услуги DNS-хостинга. Обычно это компания-регистратор вашего домена.


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки CDN-инфраструктуры входят:
* Плата за исходящий трафик с CDN-серверов (см. [тарифы {{ cdn-name }}](../../cdn/pricing.md)).
* Плата за хранение данных в {{ objstorage-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за публичные DNS-запросы и [DNS-зоны](../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../dns/) (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


## Создайте бакеты в {{ objstorage-name }} {#create-buckets}

Необходимо создать два бакета: в первом будут храниться файлы, а во втором — логи запросов к первому.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Создайте бакет для файлов:
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
     1. Укажите **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** бакета.
     1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. Создайте бакет для логов:
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
     1. Укажите **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** бакета.
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI

  1. Создайте бакет для файлов:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api create-bucket \
       --bucket <имя_бакета_с_файлами> \
       --acl public-read
     ```

     Результат:

     ```json
     {
       "Location": "/<имя_бакета_с_файлами>"
     }
     ```

  1. Создайте бакет для логов:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api create-bucket \
       --bucket <имя_бакета_с_логами>
     ```

     Результат:

     ```json
     {
       "Location": "/<имя_бакета_с_логами>"
     }
     ```

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Перед началом работы получите [статические ключи доступа](../../iam/operations/sa/create-access-key.md) — [секретный ключ и идентификатор ключа](../../iam/concepts/authorization/access-key.md), используемые для аутентификации в {{ objstorage-name }}.
  1. Опишите в конфигурационном файле параметры бакета:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя создаваемого бакета.

     Пример структуры конфигурационного файла:

     
     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_storage_bucket" "storage" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "<имя_бакета_с_файлами>"
       acl        = "public-read"
     }

     resource "yandex_storage_bucket" "logs" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "<имя_бакета_с_логами>"
     }
     ```



  1. Проверьте корректность конфигурационных файлов:
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразятся параметры создаваемого бакета. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните бакет:
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание бакета.

- API

  Используйте метод API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}

## Включите логирование бакета с файлами {#enable-logging}

Чтобы проверить, что при пользовательском запросе файл скачивается не напрямую из бакета, а из кеша CDN-сервера, нужно включить логирование бакета.

{% list tabs %}

- API

  Используйте метод API [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md) для бакета с файлами. Тело HTTP-запроса:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
    <LoggingEnabled>
      <TargetBucket>имя_бакета_с_логами</TargetBucket>
    </LoggingEnabled>
  </BucketLoggingStatus>
  ```

  Где `TargetBucket` — имя бакета, в который будут записываться логи.

{% endlist %}

## Загрузите файл в бакет {#upload-object}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет с файлами.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. В появившемся окне выберите файл с патчем `ycgame-update-v1.1.exe` и нажмите кнопку **{{ ui-key.yacloud.common.open }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.

- AWS CLI

  Выполните команду:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 cp \
    <путь_к_файлу_ycgame-update-v1.1.exe> \
    s3://<имя_бакета_с_файлами>/ycgame-update-v1.1.exe
  ```

  Результат:

  ```text
  upload: <путь к файлу ycgame-update-v1.1.exe> to s3://<имя_бакета_с_файлами>/ycgame-update-v1.1.exe
  ```

- {{ TF }}

  1. Добавьте к конфигурационному файлу из [шага с созданием бакетов](#create-buckets) параметры [объекта](../../storage/concepts/object.md), который необходимо загрузить:
     * `bucket` — имя бакета для добавления объекта.
     * `key` — имя объекта в бакете: `ycgame-update-v1.1.exe`. Обязательный параметр.
     * `source` — относительный или абсолютный путь к файлу, загружаемому как объект.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_storage_object" "patch-v1-1" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket = "<имя_бакета_с_файлами>"
       key    = "ycgame-update-v1.1.exe"
       source = "<путь_к_файлу>/ycgame-update-v1.1.exe"
     }
     ```

  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку с конфигурационным файлом.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание объекта.

- API

  Используйте метод API [upload](../../storage/s3/api-ref/object/upload.md).

{% endlist %}

## Создайте CDN-ресурс и включите кеширование {#create-cdn-resource}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Если провайдер CDN еще не активирован, нажмите кнопку **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}**.
  1. Создайте CDN-ресурс:
     1. На вкладке ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
     1. Задайте основные параметры CDN-ресурса следующим образом:
        * **{{ ui-key.yacloud.cdn.label_content-query-type }}** — `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
        * **{{ ui-key.yacloud.cdn.label_source-type }}** — `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`.
        * **{{ ui-key.yacloud.cdn.label_bucket }}** — `<имя_бакета_с_файлами>`.
        * **{{ ui-key.yacloud.cdn.label_section-domain }}** — основное доменное имя, которое вы будете использовать для публикации патчей, например `cdn.ycprojectblue.example`.

          {% note alert %}

          Основное доменное имя для раздачи контента невозможно изменить после создания CDN-ресурса.

          {% endnote %}

        * В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:
          * В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите `{{ ui-key.yacloud.common.label_https }}`.
          * В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_do-not-use }}`.
          * Выберите опцию **{{ ui-key.yacloud.cdn.field_access }}**.
          * В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите `Let's Encrypt®`, чтобы автоматически выпустить [сертификат](../../certificate-manager/concepts/managed-certificate.md) для доменного имени `cdn.ycprojectblue.example` после создания CDN-ресурса.
          * В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}`. В поле **{{ ui-key.yacloud.cdn.label_custom-host-header }}** укажите доменное имя источника, `<имя_бакета_с_файлами>.{{ s3-storage-host }}`, чтобы бакет-источник корректно отвечал на запросы CDN-серверов.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

     Дождитесь выпуска сертификата Let's Encrypt® для доменного имени. Этот процесс может занять до 30 минут.
  1. Включите переадресацию клиентов с HTTP на HTTPS:
     1. На вкладке ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** выберите ресурс, созданный ранее.
     1. Убедитесь, что в блоке **{{ ui-key.yacloud.cdn.label_section-additional }}** статус сертификата изменился на `{{ ui-key.yacloud.cdn.value_certificate-status-ready }}`.
     1. Справа сверху нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
     1. В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}** в поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Включите для ресурса [кеширование](../../cdn/concepts/caching.md) на CDN-серверах:
     1. На вкладке ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** выберите ресурс, созданный ранее.
     1. Перейдите в раздел **{{ ui-key.yacloud.cdn.label_resource-cache }}**.
     1. Справа сверху нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
     1. Включите опцию **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Если CDN-провайдер еще не активирован, выполните команду:

     ```bash
     yc cdn provider activate --folder-id <идентификатор_каталога> --type gcore
     ```

  1. Создайте CDN-ресурс:

     ```bash
     yc cdn resource create \
       --cname cdn.ycprojectblue.example \
       --origin-bucket-source <имя_бакета_с_файлами>.{{ s3-storage-host }} \
       --origin-bucket-name <имя_бакета_с_файлами> \
       --origin-protocol https \
       --lets-encrypt-gcore-ssl-cert \
       --host-header <имя_бакета_с_файлами>.{{ s3-storage-host }} \
     ```

     Результат:

     ```text
     id: bc8e3l7s4dha********
     folder_id: b1g86q4m5vej********
     cname: cdn.ycprojectblue.example
     ...
     active: true
     ...
     ```

     Подробнее о команде `yc cdn resource create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/resource/create.md).
  1. Включите переадресацию клиентов для ресурса:

     ```bash
     yc cdn resource update <ID_ресурса> --redirect-http-to-https
     ```

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры CDN-ресурсов:

     ```hcl
     ...
     resource "yandex_cdn_origin_group" "my_group" {
       name     = "updates-origin-group"
       use_next = true
       origin {
         source = "<имя_бакета_с_файлами>.{{ s3-storage-host }}"
       }
     }

     resource "yandex_cdn_resource" "my_resource" {
       cname               = "cdn.ycprojectblue.example"
       active              = true
       origin_protocol     = "https"
       origin_group_id     = yandex_cdn_origin_group.my_group.id
       options {
         custom_host_header     = "<имя_бакета_с_файлами>.{{ s3-storage-host }}"
       }
       ssl_certificate {
         type = "lets_encrypt_gcore"
       }
     }
     ```

     Подробнее см. в описаниях ресурсов [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group) и [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource) в документации провайдера {{ TF }}.
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут созданы. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).
  1. Включите переадресацию клиентов для ресурса. Добавьте в начало блока `options` для CDN-ресурса следующее поле:

     ```hcl
     ...
     options {
       redirect_https_to_http = true
     ...
     ```

  1. Выполните проверку с помощью команды:

     ```bash
     terraform plan
     ```

     Если конфигурация описана верно, в терминале отобразится список обновляемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Если ошибок нет, выполните команду:

     ```bash
     terraform apply
     ```

  1. Подтвердите обновление ресурса: введите в терминал слово `yes` и нажмите **Enter**.

  После этого для у ресурса будет включена переадресация.

- API

  Используйте вызов gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/resource_service.md#Create) или метод REST API [create](../../cdn/api-ref/Resource/create.md). Чтобы включить [кеширование](../../cdn/concepts/caching.md) на CDN-серверах, добавьте в тело запроса поле `edge_cache_settings`.

{% endlist %}

## Настройте DNS для своего домена {#dns-setup}

1. Получите доменное имя в домене `.edgecdn.ru`, сгенерированное для созданного CDN-ресурса:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.ycprojectblue.example`).
     1. На вкладке **{{ ui-key.yacloud.common.overview }}** в разделе **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** скопируйте в буфер обмена сгенерированное сервисом имя в домене `.edgecdn.ru`.

   {% endlist %}

1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
1. Измените [CNAME-запись](../../dns/concepts/resource-record.md#cname) для `cdn` таким образом, чтобы она указывала на скопированный ранее адрес в домене `.edgecdn.ru`, например:

   ```http
   cdn CNAME cl-********.edgecdn.ru.
   ```

   Если вы пользуетесь {{ dns-name }}, настройте запись по следующей инструкции:

   {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
     1. Если у вас нет публичной зоны DNS, создайте ее:
        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
        1. Укажите **{{ ui-key.yacloud.common.name }}** зоны: `cdn-dns-a`.
        1. В поле **{{ ui-key.yacloud.dns.label_zone }}** укажите ваш домен с точкой в конце: `ycprojectblue.example.`
        1. Выберите **{{ ui-key.yacloud.common.type }}** зоны — `{{ ui-key.yacloud.dns.label_public }}`.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
     1. Создайте [запись](../../dns/concepts/resource-record.md) в зоне:
        1. В списке зон нажмите на зону `cdn-dns-a`.
        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
        1. В поле **{{ ui-key.yacloud.common.name }}** укажите `cdn`, чтобы запись соответствовала доменному имени `cdn.ycprojectblue.example`.
        1. Выберите **{{ ui-key.yacloud.common.type }}** записи — `CNAME`.
        1. В поле **{{ ui-key.yacloud.dns.label_records }}** вставьте скопированный адрес в домене `.edgecdn.ru` с точкой на конце.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   - CLI

     1. Если у вас нет публичной зоны DNS, создайте ее:

        ```bash
        yc dns zone create --name cdn-dns-a --zone ycprojectblue.example. --public-visibility
        ```

        Где:
        * `--name` — имя зоны.
        * `--zone` — доменная зона — ваш домен с точкой на конце.
        * `--public-visibility` — опция публичной видимости зоны.

        Результат:

        ```bash
        id: aetuvdw77q61********
        folder_id: aoewzf73jwdl********
        created_at: "2021-09-28T10:33:31.917Z"
        name: cdn-zone-a
        zone: ycprojectblue.example.
        public_visibility: {}
        ```

     1. Создайте [запись](../../dns/concepts/resource-record.md) в зоне:

        ```bash
        yc dns zone add-records --name cdn-dns-a --record "cdn CNAME cl-********.edgecdn.ru."
        ```

        Где:
        * `--name` — имя зоны.
        * `--record` — ресурсная запись.
     1. Проверьте, что запись создана:

        ```bash
        yc dns zone list-records --name cdn-dns-a
        ```

        Результат:

        ```text
        +----------------------------+------+-------+----------------------------+
        |            NAME            | TTL  | TYPE  |            DATA            |
        +----------------------------+------+-------+----------------------------+
        | ycprojectblue.example.     | 3600 | NS    | ns1.{{ dns-ns-host-sld }}. |
        |                            |      |       | ns2.{{ dns-ns-host-sld }}. |
        | ycprojectblue.example.     | 3600 | SOA   | ns1.{{ dns-ns-host-sld }}. |
        |                            |      |       | {{ dns-mx-host }}. 1 10800 |
        |                            |      |       | 900 604800 86400           |
        | cdn.ycprojectblue.example. |  600 | CNAME | cl-********.edgecdn.ru.    |
        +----------------------------+------+-------+----------------------------+
        ```

        В списке должна быть запись с именем `cdn.ycprojectblue.example.`

   - API

     1. Если у вас нет публичной зоны DNS, создайте ее с помощью вызова gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create) или метода REST API [create](../../dns/api-ref/DnsZone/create.md). Чтобы сделать зону публичной, добавьте в тело запроса поле `public_visibility` (gRPC) или `publicVisibility` (REST).
     1. Создайте в зоне [запись](../../dns/concepts/resource-record.md) `cdn CNAME cl-********.edgecdn.ru.` с помощью вызова gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) или метода REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md).

   {% endlist %}

   {% endcut %}

## Предзагрузите контент в кеш CDN-серверов {#prefetch-content}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.ycprojectblue.example`).
  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-content }}**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.
  1. В поле **{{ ui-key.yacloud.cdn.label_resource-content-prefetch-cache-paths }}** укажите путь к файлу, хранящемуся в источнике, без доменного имени:

     ```text
     /ycgame-update-v1.1.exe
     ```

  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Укажите путь к файлу, который нужно предзагрузить:

  ```bash
  yc cdn cache prefetch --resource-id <идентификатор_ресурса> \
    --path /ycgame-update-v1.1.exe
  ```

  Подробнее о команде `yc cdn cache prefetch` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/cache/prefetch.md).

- API

  Используйте вызов gRPC API [CacheService/Prefetch](../../cdn/api-ref/grpc/cache_service.md#Prefetch) или метод REST API [prefetch](../../cdn/api-ref/Cache/prefetch.md).

{% endlist %}

## Проверьте работу CDN {#check-cdn-working}

1. Дождитесь обновления DNS-записей (на это может потребоваться несколько часов) и предзагрузки файла на CDN-серверы.
1. Скачайте файл по новому URL:

   ```http request
   https://cdn.ycprojectblue.example/ycgame-update-v1.1.exe
   ```

1. Получите логи запросов к бакету с файлами:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
     1. Выберите бакет с логами.
     1. Нажмите на имя объекта, соответствующего времени скачивания файла `ycgame-update-v1.1.exe`.
     1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_download }}**.

   - AWS CLI

     1. Получите список объектов с логами:

        ```bash
        aws --endpoint-url=https://{{ s3-storage-host }} \
          s3 ls s3://<имя_бакета_с_логами>
        ```

        Результат:

        ```text
        2021-10-01 08:37:53         10 2021-10-01-08-37-53-631E0FC3B732AEDD
        2021-10-01 09:38:05         62 2021-10-01-09-38-05-436E6CDC832A20EF
        2021-10-01 10:38:01         23 2021-10-01-10-38-01-7F65EF1A6366FB18
        2021-10-01 11:37:57         41 2021-10-01-11-37-57-6F31613427A7DB9A
        2021-10-01 12:38:02         58 2021-10-01-12-38-02-AB893E6148AFDC55
        2021-10-01 13:38:02         73 2021-10-01-13-38-02-E69EAEC1C9083756
        ```

     1. Найдите в полученном списке объект с логом, сохраненным после скачивания файла `ycgame-update-v1.1.exe`, и скачайте его:

        ```bash
        aws --endpoint-url=https://{{ s3-storage-host }} \
          s3 cp s3://<имя_бакета_с_логами>/2021-10-01-13-38-02-E69EAEC1C9083756 \
          2021-10-01-13-38-02-E69EAEC1C9083756
        ```

        Результат:

        ```text
        download: s3://<имя_бакета_с_логами>/2021-10-01-13-38-02-E69EAEC1C9083756 to 2021-10-01-13-38-02-E69EAEC1C9083756
        ```

   - API

     1. Получите список объектов в бакете с логами с помощью метода API [listObjects](../../storage/s3/api-ref/bucket/listobjects.md).
     1. Найдите в полученном списке объект с логом, сохраненным после скачивания файла `ycgame-update-v1.1.exe`, и скачайте его с помощью метода API [get](../../storage/s3/api-ref/object/get.md).

   {% endlist %}

1. По логам запросов к бакету-источнику убедитесь, что CDN-серверы не скачивали файл из источника после вашего запроса. Подробнее о содержимом логов см. в разделе [{#T}](../../storage/concepts/server-logs.md#object-format) документации {{ objstorage-name }}.

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу CDN-ресурса и перестать платить за созданные ресурсы:
1. [Отключите](../../cdn/operations/resources/disable-resource.md) созданный ресурс.
1. [Удалите](../../storage/operations/objects/delete.md) объект `ycgame-update-v1.1.exe` из бакета с файлами.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет с файлами.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета с логами.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет с логами.
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS, если вы пользовались ей при [настройке DNS](#dns-setup).