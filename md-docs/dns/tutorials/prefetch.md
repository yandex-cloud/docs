[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Практические руководства](index.md) > Публикация обновлений для игр

# Публикация обновлений для игр с помощью Yandex Cloud CDN


Создайте и настройте [CDN-ресурс](../../cdn/concepts/resource.md) Cloud CDN для размещения в нем контента, к которому ожидается большое количество запросов в малый промежуток времени, например файлов для обновления игры (патчей, [DLC](https://ru.wikipedia.org/wiki/Загружаемый_контент) и т. п.). Чтобы в этот промежуток не создавалась высокая нагрузка на источники контента со стороны CDN-серверов, файлы будут однократно [предзагружены](../../cdn/concepts/caching.md#prefetch) в кеш серверов.

Предполагается, что патч состоит из одного файла с именем `ycgame-update-v1.1.exe`. Он будет загружен в [бакет](../../storage/concepts/bucket.md) [Yandex Object Storage](../../storage/index.md).

{% note info %}

Не рекомендуется предзагружать файлы размером меньше 200 МБ или больше 5 ГБ.

{% endnote %}

Чтобы создать CDN-инфраструктуру:
1. [Подготовьтесь к работе](#before-you-begin).
1. [Добавьте сертификат в Certificate Manager](#add-certificate)
1. [Создайте бакеты в Object Storage](#create-buckets).
1. [Включите логирование бакета с файлами](#enable-logging).
1. [Загрузите файл в бакет](#upload-object).
1. [Создайте CDN-ресурс и включите кеширование](#create-cdn-resource).
1. [Настройте DNS для своего домена](#dns-setup).
1. [Предзагрузите контент в кеш CDN-серверов](#prefetch-content).
1. [Проверьте работу CDN](#check-cdn-working).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Убедитесь, что у вас есть доменное имя и доступ к настройкам [DNS](../../glossary/dns.md) на сайте компании, которая предоставляет вам услуги DNS-хостинга. Обычно это компания-регистратор вашего домена.


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки CDN-инфраструктуры входят:
* Плата за исходящий трафик с CDN-серверов ([тарифы Cloud CDN](../../cdn/pricing.md)).
* Плата за хранение данных в Object Storage, операции с ними и исходящий трафик ([тарифы Object Storage](../../storage/pricing.md)).
* Плата за публичные DNS-запросы и [DNS-зоны](../concepts/dns-zone.md), если вы используете [Yandex Cloud DNS](../index.md) ([тарифы Cloud DNS](../pricing.md)).

## Добавьте сертификат в Certificate Manager {#add-certificate}

Поддерживаются сертификаты из [Yandex Certificate Manager](../../certificate-manager/index.md). Вы можете [выпустить новый сертификат Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный](../../certificate-manager/operations/import/cert-create.md).

Сертификат должен находиться в том же [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен ваш CDN-ресурс.

Для сертификата Let's Encrypt® пройдите [проверку прав](../../certificate-manager/operations/managed/cert-validate.md) на домен, который указан в сертификате.


## Создайте бакеты в Object Storage {#create-buckets}

Необходимо создать два бакета: в первом будут храниться файлы, а во втором — логи запросов к первому.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Создайте бакет для файлов:
     1. Нажмите кнопку **Создать бакет**.
     1. Укажите **Имя** бакета.
     1. В полях **Чтение объектов** и **Чтение списка объектов** выберите `Для всех`.
     1. Нажмите кнопку **Создать бакет**.
  1. Создайте бакет для логов:
     1. Нажмите кнопку **Создать бакет**.
     1. Укажите **Имя** бакета.
     1. Нажмите кнопку **Создать бакет**.

- AWS CLI {#cli}

  1. Создайте бакет для файлов:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net \
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
     aws --endpoint-url=https://storage.yandexcloud.net \
       s3api create-bucket \
       --bucket <имя_бакета_с_логами>
     ```

     Результат:

     ```json
     {
       "Location": "/<имя_бакета_с_логами>"
     }
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Перед началом работы получите [статические ключи доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) — [секретный ключ и идентификатор ключа](../../iam/concepts/authorization/access-key.md), используемые для аутентификации в Object Storage.
  1. Опишите в конфигурационном файле параметры бакета:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя создаваемого бакета.

     Пример структуры конфигурационного файла:

     ```hcl
     provider "yandex" {
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "ru-central1-a"
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

     Если конфигурация описана верно, в терминале отобразятся параметры создаваемого бакета. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Разверните бакет:
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание бакета.

- API {#api}

  Используйте метод API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}

## Включите логирование бакета с файлами {#enable-logging}

Чтобы проверить, что при пользовательском запросе файл скачивается не напрямую из бакета, а из кеша CDN-сервера, нужно включить логирование бакета.

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. Создайте файл с настройками логирования в формате JSON. Например:

      ```json
      {
        "LoggingEnabled": {
            "TargetBucket": "<имя_бакета_с_логами>",
            "TargetPrefix": "<префикс_ключа>"
        }
      }
      ```

      Где:

      * `TargetBucket` — имя целевого бакета, в который будут записываться логи.
      * `TargetPrefix` — [префикс ключа](../../storage/concepts/server-logs.md#key-prefix) для объектов с логами, например `logs/`.
  
  1. Включите логирование в бакете:

      ```bash
      aws s3api put-bucket-logging \
        --bucket <имя_бакета_с_файлами> \
        --endpoint-url https://storage.yandexcloud.net \
        --bucket-logging-status file://<путь_к_файлу_настроек>
      ```

      Где:

      * `--bucket` — имя исходного бакета, для которого нужно включить логирование действий.
      * `--bucket-logging-status` — путь к файлу с настройками логирования.

- API {#api}

  Используйте метод API [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md) для бакета с файлами. Тело HTTP-запроса:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
    <LoggingEnabled>
      <TargetBucket>имя бакета с логами</TargetBucket>
      <TargetPrefix>префикс ключа</TargetPrefix>
    </LoggingEnabled>
  </BucketLoggingStatus>
  ```

  Где:

   * `TargetBucket` — имя бакета, в который будут записываться логи.
   * `TargetPrefix` – [префикс ключа](../../storage/concepts/server-logs.md#key-prefix) для объектов с логами, например `logs/`.

{% endlist %}

## Загрузите файл в бакет {#upload-object}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет с файлами.
  1. Нажмите кнопку **Загрузить**.
  1. В появившемся окне выберите файл с патчем `ycgame-update-v1.1.exe` и нажмите кнопку **Открыть**.
  1. Нажмите кнопку **Загрузить**.

- AWS CLI {#cli}

  Выполните команду:

  ```bash
  aws --endpoint-url=https://storage.yandexcloud.net \
    s3 cp \
    <путь_к_файлу_ycgame-update-v1.1.exe> \
    s3://<имя_бакета_с_файлами>/ycgame-update-v1.1.exe
  ```

  Результат:

  ```text
  upload: <путь_к_файлу_ycgame-update-v1.1.exe> to s3://<имя_бакета_с_файлами>/ycgame-update-v1.1.exe
  ```

- Terraform {#tf}

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
       bucket     = "<имя_бакета_с_файлами>"
       key        = "ycgame-update-v1.1.exe"
       source     = "<путь_к_файлу>/ycgame-update-v1.1.exe"
     }
     ```

  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку с конфигурационным файлом.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание объекта.

- API {#api}

  Используйте метод API [upload](../../storage/s3/api-ref/object/upload.md).

{% endlist %}

## Создайте CDN-ресурс и включите кеширование {#create-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Cloud CDN**.
  1. На вкладке ![image](../../_assets/console-icons/nodes-right.svg) **CDN-ресурсы** нажмите кнопку **Создать ресурс**.
  1. Задайте основные настройки CDN-ресурса:
      * В блоке **Контент**:
        * Включите **Доступ к контенту**.
        * В поле **Запрос контента** выберите `Из одного источника`.
        * В поле **Тип источника** выберите `Бакет`.
        * В поле **Бакет** выберите `<имя_бакета_с_файлами>`.
        * В поле **Протокол для источников** выберите `HTTPS`.
        * В поле **Доменное имя** укажите основное доменное имя, которое вы будете использовать для публикации патчей, например `cdn.ycprojectblue.example`.

          {% note alert %}

          Основное доменное имя для раздачи контента невозможно изменить после создания CDN-ресурса.

          {% endnote %}

      * В блоке **Дополнительно**:
        * В поле **Переадресация клиентов** выберите `С HTTP на HTTPS`.
        * В поле **Тип сертификата** укажите `Сертификат из Certificate Manager` и выберите [сертификат](#add-certificate) для доменного имени `cdn.ycprojectblue.example`.
        * В поле **Заголовок Host** выберите `Свое значение`. В поле **Значение заголовка** укажите доменное имя источника, `<имя_бакета_с_файлами>.storage.yandexcloud.net`, чтобы бакет-источник корректно отвечал на запросы CDN-серверов.
  1. Нажмите **Продолжить**.
  1. В разделе **Кеширование** в блоке **CDN** включите опцию **Кеширование в CDN**.

      [Подробнее о кешировании](../../cdn/concepts/caching.md)

  1. Нажмите **Продолжить**.
  1. В разделах **HTTP-заголовки и методы** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Продолжить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте CDN-ресурс:

     ```bash
     yc cdn resource create \
       --cname cdn.ycprojectblue.example \
       --origin-bucket-source <имя_бакета_с_файлами>.storage.yandexcloud.net \
       --origin-bucket-name <имя_бакета_с_файлами> \
       --origin-protocol https \
       --cert-manager-ssl-cert-id <идентификатор_сертификата> \
       --host-header <имя_бакета_с_файлами>.storage.yandexcloud.net
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

     Подробнее о команде `yc cdn resource create` смотрите в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/resource/create.md).
  1. Включите переадресацию клиентов для ресурса:

     ```bash
     yc cdn resource update <идентификатор_ресурса> --redirect-http-to-https
     ```

- Terraform {#tf}

  1. Добавьте в конфигурационный файл параметры CDN-ресурсов:

     ```hcl
     ...
     resource "yandex_cdn_origin_group" "my_group" {
       name     = "updates-origin-group"
       use_next = true
       origin {
         source = "<имя_бакета_с_файлами>.storage.yandexcloud.net"
       }
     }

     resource "yandex_cdn_resource" "my_resource" {
       cname               = "cdn.ycprojectblue.example"
       active              = true
       origin_protocol     = "https"
       origin_group_id     = yandex_cdn_origin_group.my_group.id
       options {
         custom_host_header     = "<имя_бакета_с_файлами>.storage.yandexcloud.net"
       }
       ssl_certificate {
         type                   = "certificate_manager"
         certificate_manager_id = "<идентификатор_сертификата>"
       }
     }
     ```

     Подробнее в описаниях ресурсов [yandex_cdn_origin_group](../../terraform/resources/cdn_origin_group.md) и [yandex_cdn_resource](../../terraform/resources/cdn_resource.md) в документации провайдера Terraform.
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут созданы. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).
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

     Если конфигурация описана верно, в терминале отобразится список обновляемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Если ошибок нет, выполните команду:

     ```bash
     terraform apply
     ```

  1. Подтвердите обновление ресурса: введите в терминал слово `yes` и нажмите **Enter**.

  После этого для у ресурса будет включена переадресация.

- API {#api}

  Используйте вызов gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md) или метод REST API [create](../../cdn/api-ref/Resource/create.md). Чтобы включить [кеширование](../../cdn/concepts/caching.md) на CDN-серверах, добавьте в тело запроса поле `edge_cache_settings`.

{% endlist %}

## Настройте DNS для своего домена {#dns-setup}

1. Получите доменное имя, сгенерированное для созданного CDN-ресурса:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.ycprojectblue.example`).
     1. На вкладке **Обзор** в разделе **Настройки DNS** скопируйте в буфер обмена сгенерированное сервисом доменное имя вида `e1b83ae3********.topology.gslb.yccdn.ru`.

   {% endlist %}

1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
1. Измените [CNAME-запись](../concepts/resource-record.md#cname) для `cdn` таким образом, чтобы она указывала на скопированный ранее адрес в домене `.yccdn.cloud.yandex.net`, например:

   ```http
   cdn CNAME e1b83ae3********.topology.gslb.yccdn.ru.
   ```

   {% note info %}
   
   Не используйте ресурсную запись [ANAME](../concepts/resource-record.md#aname) с доменными именами для раздачи контента, поскольку в таком случае конечный пользователь получит ответ от CDN-сервера, не связанного с геолокацией пользователя. Ответ всегда будет одинаков для всех пользователей.
   
   {% endnote %}

   Если вы пользуетесь Cloud DNS, настройте запись по следующей инструкции:

   {% cut "Инструкция по настройке DNS-записей для Cloud DNS" %}

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
     1. Перейдите в сервис **Cloud DNS**.
     1. Если у вас нет публичной зоны DNS, создайте ее:
        1. Нажмите кнопку **Создать зону**.
        1. Укажите **Имя** зоны: `cdn-dns-a`.
        1. В поле **Зона** укажите ваш домен с точкой в конце: `ycprojectblue.example.`
        1. Выберите **Тип** зоны — `Публичная`.
        1. Нажмите кнопку **Создать**.
     1. Создайте [запись](../concepts/resource-record.md) в зоне:
        1. В списке зон нажмите на зону `cdn-dns-a`.
        1. Нажмите кнопку **Создать запись**.
        1. В поле **Имя** укажите `cdn`, чтобы запись соответствовала доменному имени `cdn.ycprojectblue.example`.
        1. Выберите **Тип** записи — `CNAME`.
        1. В поле **Значение** вставьте скопированный адрес в домене `.yccdn.cloud.yandex.net` с точкой на конце.
        1. Нажмите кнопку **Создать**.

   - CLI {#cli}

     1. Если у вас нет публичной зоны DNS, создайте ее:

        ```bash
        yc dns zone create --name cdn-dns-a --zone ycprojectblue.example. --public-visibility
        ```

        Где:
        * `--name` — имя зоны.
        * `--zone` — доменная зона — ваш домен с точкой на конце.
        * `--public-visibility` — опция публичной видимости зоны.

        Результат:

        ```text
        id: aetuvdw77q61********
        folder_id: aoewzf73jwdl********
        created_at: "2021-09-28T10:33:31.917Z"
        name: cdn-zone-a
        zone: ycprojectblue.example.
        public_visibility: {}
        ```

     1. Создайте [запись](../concepts/resource-record.md) в зоне:

        ```bash
        yc dns zone add-records --name cdn-dns-a --record "cdn CNAME e1b83ae3********.topology.gslb.yccdn.ru."
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
        +----------------------------+------+-------+--------------------------------------------+
        |            NAME            | TTL  | TYPE  |                    DATA                    |
        +----------------------------+------+-------+--------------------------------------------+
        | ycprojectblue.example.     | 3600 | NS    | ns1.yandexcloud.net.                       |
        |                            |      |       | ns2.yandexcloud.net.                       |
        | ycprojectblue.example.     | 3600 | SOA   | ns1.yandexcloud.net.                       |
        |                            |      |       | mx.cloud.yandex.net. 1 10800               |
        |                            |      |       | 900 604800 86400                           |
        | cdn.ycprojectblue.example. |  600 | CNAME | e1b83ae3********.topology.gslb.yccdn.ru. |
        +----------------------------+------+-------+--------------------------------------------+
        ```

        В списке должна быть запись с именем `cdn.ycprojectblue.example.`

   - API {#api}

     1. Если у вас нет публичной зоны DNS, создайте ее с помощью вызова gRPC API [DnsZoneService/Create](../api-ref/grpc/DnsZone/create.md) или метода REST API [create](../api-ref/DnsZone/create.md). Чтобы сделать зону публичной, добавьте в тело запроса поле `public_visibility` (gRPC) или `publicVisibility` (REST).
     1. Создайте в зоне [запись](../concepts/resource-record.md) `cdn CNAME e1b83ae3********.topology.gslb.yccdn.ru.` с помощью вызова gRPC API [DnsZoneService/UpdateRecordSets](../api-ref/grpc/DnsZone/updateRecordSets.md) или метода REST API [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md).

   {% endlist %}

   {% endcut %}

## Предзагрузите контент в кеш CDN-серверов {#prefetch-content}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Cloud CDN**.
  1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.ycprojectblue.example`).
  1. Перейдите на вкладку **Контент**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **Предзагрузить контент**.
  1. В поле **Пути к файлам** укажите путь к файлу, хранящемуся в источнике, без доменного имени:

     ```text
     /ycgame-update-v1.1.exe
     ```

  1. Нажмите кнопку **Предзагрузить контент**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Укажите путь к файлу, который нужно предзагрузить:

  ```bash
  yc cdn cache prefetch --resource-id <идентификатор_ресурса> \
    --path /ycgame-update-v1.1.exe
  ```

  Подробнее о команде `yc cdn cache prefetch` смотрите в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/cache/prefetch.md).

- API {#api}

  Используйте вызов gRPC API [CacheService/Prefetch](../../cdn/api-ref/grpc/Cache/prefetch.md) или метод REST API [prefetch](../../cdn/api-ref/Cache/prefetch.md).

{% endlist %}

## Проверьте работу CDN {#check-cdn-working}

1. Дождитесь обновления DNS-записей (на это может потребоваться несколько часов) и предзагрузки файла на CDN-серверы.
1. Скачайте файл по новому URL:

   ```http request
   https://cdn.ycprojectblue.example/ycgame-update-v1.1.exe
   ```

1. Получите логи запросов к бакету с файлами:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
     1. Перейдите в сервис **Object Storage**.
     1. Выберите бакет с логами.
     1. Нажмите на имя объекта, соответствующего времени скачивания файла `ycgame-update-v1.1.exe`.
     1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) →  **Скачать**.

   - AWS CLI {#cli}

     1. Получите список объектов с логами:

        ```bash
        aws --endpoint-url=https://storage.yandexcloud.net \
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
        aws --endpoint-url=https://storage.yandexcloud.net \
          s3 cp s3://<имя_бакета_с_логами>/2021-10-01-13-38-02-E69EAEC1C9083756 \
          2021-10-01-13-38-02-E69EAEC1C9083756
        ```

        Результат:

        ```text
        download: s3://<имя_бакета_с_логами>/2021-10-01-13-38-02-E69EAEC1C9083756 to 2021-10-01-13-38-02-E69EAEC1C9083756
        ```

   - API {#api}

     1. Получите список объектов в бакете с логами с помощью метода API [listObjects](../../storage/s3/api-ref/bucket/listobjects.md).
     1. Найдите в полученном списке объект с логом, сохраненным после скачивания файла `ycgame-update-v1.1.exe`, и скачайте его с помощью метода API [get](../../storage/s3/api-ref/object/get.md).

   {% endlist %}

1. По логам запросов к бакету-источнику убедитесь, что CDN-серверы не скачивали файл из источника после вашего запроса. Подробнее о содержимом логов смотрите в разделе [Формат объекта с логами](../../storage/concepts/server-logs.md#object-format) документации Object Storage.

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу CDN-ресурса и перестать платить за созданные ресурсы:
1. [Отключите](../../cdn/operations/resources/disable-resource.md) созданный ресурс.
1. [Удалите](../../storage/operations/objects/delete.md) объект `ycgame-update-v1.1.exe` из бакета с файлами.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет с файлами.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета с логами.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет с логами.
1. [Удалите](../operations/zone-delete.md) зону DNS, если вы пользовались ей при [настройке DNS](#dns-setup).