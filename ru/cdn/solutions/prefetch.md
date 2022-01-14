# Публикация обновлений для игр с помощью {{ cdn-full-name }}

Сценарий описывает создание и настройку [CDN-ресурса](../concepts/resource.md) {{ cdn-full-name }} для размещения в нем контента, к которому ожидается большое количество запросов в малый промежуток времени, например файлов для обновления игры (патчей, DLC и т. п.). Чтобы в этот промежуток не создавалась высокая нагрузка на источники контента со стороны CDN-серверов, файлы будут однократно [предзагружены](../concepts/caching.md#prefetch) в кеш серверов.

Для примера в сценарии предполагается, что патч состоит из одного файла с именем `ycgame-update-v1.1.exe`. Он будет загружен в бакет {{ objstorage-full-name }}.

{% note info %}

Не рекомендуется предзагружать файлы размером меньше 200 МБ или больше 5 ГБ.

{% endnote %}

Чтобы создать CDN-инфраструктуру:

1. [{#T}](#before-you-begin).
1. [{#T}](#create-buckets).
1. [{#T}](#enable-logging).
1. [{#T}](#upload-object).
1. [{#T}](#create-cdn-resource).
1. [{#T}](#dns-setup).
1. [{#T}](#prefetch-content).
1. [{#T}](#check-cdn-working).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьтесь к работе {#before-you-begin}

Перед тем, как создавать CDN-ресурс:

1. Зарегистрируйтесь в {{ yandex-cloud }} и создайте платежный аккаунт:

   {% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

1. На [странице облака]({{ link-console-cloud }}) выберите каталог, в котором будет работать ваш CDN-ресурс, или [создайте каталог](../../resource-manager/operations/folder/create.md). Все действия сценария нужно выполнять в этом каталоге.

   [Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

1. Убедитесь, что у вас есть доменное имя и доступ к настройкам DNS на сайте компании, которая предоставляет вам услуги DNS-хостинга. Обычно это компания-регистратор вашего домена.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки CDN-инфраструктуры входят:

* плата за исходящий трафик с CDN-серверов (см. [тарифы {{ cdn-name }}](../pricing.md));
* плата за хранение данных в {{ objstorage-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md));
* плата за публичные DNS-запросы и DNS-зоны, если вы используете {{ dns-full-name }} (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).

## Создайте бакеты в {{ objstorage-name }} {#create-buckets}

В сценарии будет создано два бакета: в первом, `ycprojektblue-storage`, будут храниться файлы, а во втором, `ycprojektblue-logs`, — логи запросов к первому.

{% list tabs %}

- Консоль управления
 
  1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ objstorage-name }}**.
  1. Создайте бакет для файлов:
    
     1. Нажмите кнопку **Создать бакет**.
     1. Укажите **Имя** бакета: `ycprojektblue-storage`.
     1. В полях **Доступ на чтение объектов** и **Доступ к списку объектов** выберите **Публичный**.
     1. Нажмите кнопку **Создать бакет**.
     
  1. Создайте бакет для логов:
  
     1. Нажмите кнопку **Создать бакет**.
     1. Укажите **Имя** бакета: `ycprojektblue-logs`.
     1. Нажмите кнопку **Создать бакет**.   
  
- AWS CLI

  1. Создайте бакет для файлов:
  
     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net \
       s3api create-bucket \
       --bucket ycprojektblue-storage \
       --acl public-read
     ```
  
     Результат выполнения команды:
  
     ```json
     {
         "Location": "/ycprojektblue-storage"
     }
     ```
     
  1. Создайте бакет для логов:
  
     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net \
       s3api create-bucket \
       --bucket ycprojektblue-logs
     ```
  
     Результат выполнения команды:
  
     ```json
     {
         "Location": "/ycprojektblue-logs"
     }
     ```
  
- Terraform

  Перед началом работы получите [статические ключи доступа](../../iam/operations/sa/create-access-key.md) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.
  
  1. Опишите в конфигурационном файле параметры бакета:
  
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя создаваемого бакета: `ycprojektblue-storage`.
  
     ```
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "ru-central1-a"
     }
  
     resource "yandex_storage_bucket" "storage" {
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"
       bucket     = "ycprojektblue-storage"
       acl        = "public-read"
     }
     
     resource "yandex_storage_bucket" "logs" {
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"
       bucket     = "ycprojektblue-logs"
     }
     ```
  
  1. Проверьте корректность конфигурационных файлов:
  
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:
        
        ```
        terraform plan
        ```
  
     Если конфигурация описана верно, в терминале отобразятся параметры создаваемого бакета. Если в конфигурации есть ошибки, Terraform на них укажет.
  
  1. Разверните бакет:
  
     1. Если в конфигурации нет ошибок, выполните команду:
     
        ```
        terraform apply
        ```
     
     1. Подтвердите создание бакета.
     
- API

  Используйте метод API [create](../../storage/s3/api-ref/bucket/create.md).
  
{% endlist %}

## Включите логирование бакета с файлами {#enable-logging}

Чтобы в конце сценария проверить, что при пользовательском запросе файл скачивается не напрямую из бакета, а из кеша CDN-сервера, нужно включить логирование бакета.

{% list tabs %}

- API

  Используйте метод API [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md) для бакета `ycprojektblue-storage`. Тело HTTP-запроса:
  
  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
    <LoggingEnabled>
      <TargetBucket>ycprojektblue-logs</TargetBucket>
    </LoggingEnabled>
  </BucketLoggingStatus>
  ```
  
  * `TargetBucket` — имя бакета, в который будут записываться логи: `ycprojektblue-logs`.  
  
{% endlist %}

## Загрузите файл в бакет {#upload-object}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ objstorage-name }}**.
  1. Выберите бакет `ycprojektblue-storage`.
  1. Нажмите кнопку **Загрузить**.
  1. В появившемся окне выберите файл с патчем `ycgame-update-v1.1.exe` и нажмите кнопку **Открыть**.
  1. Нажмите кнопку **Загрузить**.
  
- AWS CLI

  Выполните команду:
  
  ```bash
  aws --endpoint-url=https://storage.yandexcloud.net \
    s3 cp \
    <путь к файлу ycgame-update-v1.1.exe> \ 
    s3://ycprojektblue-storage/ycgame-update-v1.1.exe
  ```
  
  Результат выполнения команды:
  
  ```
  upload: <путь к файлу ycgame-update-v1.1.exe> to s3://ycprojektblue-storage/ycgame-update-v1.1.exe
  ```
  
- Terraform

  1. Добавьте к конфигурационному файлу из [шага с созданием бакетов](#create-buckets) параметры объекта, который необходимо загрузить:
  
     * `bucket` — имя бакета для добавления объекта: `ycprojektblue-storage`.
     * `key` — имя объекта в бакете: `ycgame-update-v1.1.exe`. Обязательный параметр.
     * `source` — относительный или абсолютный путь к файлу, загружаемому как объект.
  
     ```
     ...
  
     resource "yandex_storage_object" "patch-v1-1" {
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"
       bucket = "ycprojektblue-storage"
       key    = "ycgame-update-v1.1.exe"
       source = "<путь к файлу>/ycgame-update-v1.1.exe"
     }
     ```
  
  1. Проверьте корректность конфигурационных файлов.
  
     1. В командной строке перейдите в папку c конфигурационным файлом.
     1. Выполните проверку с помощью команды:
     
        ```
        terraform plan
        ```
  
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 
  
  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:
     
     ```
     terraform apply
     ```
     
     1. Подтвердите создание объекта.
     
- API

  Используйте метод API [upload](../../storage/s3/api-ref/object/upload.md).

{% endlist %}

## Создайте CDN-ресурс и включите кеширование {#create-cdn-resource}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ cdn-name }}**.
  1. Если провайдер CDN еще не активирован, нажмите кнопку **Подключиться к провайдеру**.
  1. Создайте CDN-ресурс:
  
     1. На вкладке **CDN-ресурсы** нажмите кнопку **Создать ресурс**.
     1. Задайте основные параметры CDN-ресурса следующим образом:

        * **Запрос контента** — **Из одного источника**.
        * **Тип источника** — **Бакет**.
        * **Бакет** — `ycprojektblue-storage`.
        * **Доменные имена для раздачи контента** — основное доменное имя, которое вы будете использовать для публикации патчей, например `cdn.ycprojectblue.example`.

          {% note alert %}

          Основное доменное имя для раздачи контента невозможно изменить после создания CDN-ресурса.

          {% endnote %}

        * В блоке **Дополнительно**:

          * В поле **Протокол для источников** выберите **HTTPS**. 
          * В поле **Переадресация клиентов** выберите **С HTTP на HTTPS**.
          * Выберите опцию **Доступ конечных пользователей к контенту**.
          * В поле **Тип сертификата** выберите **Let's Encrypt®**, чтобы автоматически выпустить сертификат для доменного имени `cdn.ycprojektblue.example` после создания CDN-ресурса.
          * В поле **Заголовок Host** выберите **Свое значение**. В поле **Значение заголовка** укажите доменное имя источника, `ycprojektblue-storage.storage.yandexcloud.net`, чтобы бакет-источник корректно отвечал на запросы CDN-серверов.

     1. Нажмите кнопку **Создать**.
     
  1. Включите для ресурса кеширование на CDN-серверах:
  
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.ycprojektblue.example`).
     1. Перейдите на вкладку **Кеширование**.
     1. Нажмите кнопку **Редактировать**.
     1. Включите **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.
  
- API

  Используйте вызов gRPC API [ResourceService/Create](../api-ref/grpc/resource_service.md#Create) или метод REST API [create](../api-ref/Resource/create.md). Чтобы включить кеширование на CDN-серверах, добавьте в тело запроса поле `edge_cache_settings`.
  
{% endlist %}

## Настройте DNS для своего домена {#dns-setup}

1. Получите доменное имя в домене `.gcdn.co`, сгенерированное для созданного CDN-ресурса:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.ycprojektblue.example`).
     1. На вкладке **Обзор** в разделе **Настройки DNS** скопируйте в буфер обмена сгенерированное сервисом имя в домене `.gcdn.co`.
     
   {% endlist %}
   
1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
1. Измените CNAME-запись для `cdn` таким образом, чтобы она указывала на скопированный ранее адрес в домене `.gcdn.co`, например:

   ```http
   cdn CNAME cl-.....6bb.gcdn.co.
   ```
   
   Если вы пользуетесь {{ dns-name }}, настройте запись по следующей инструкции:
      
   {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}
      
   {% list tabs %}
      
   - Консоль управления 
      
     1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ dns-name }}**.
     1. Если у вас нет публичной зоны DNS, создайте ее:
      
        1. Нажмите кнопку **Создать зону**.
        1. Укажите **Имя** зоны: `cdn-dns-a`.
        1. В поле **Зона** укажите ваш домен с точкой в конце: `ycprojektblue.example.`
        1. Выберите **Тип** зоны — **Публичная**.
        1. Нажмите кнопку **Создать**.
         
     1. Создайте запись в зоне:
      
        1. В списке зон нажмите на зону `cdn-dns-a`.
        1. Нажмите кнопку **Создать запись**.
        1. В поле **Имя** укажите `cdn`, чтобы запись соответствовала доменному имени `cdn.ycprojektblue.example`.
        1. Выберите **Тип** записи — **CNAME**.
        1. В поле **Значение** вставьте скопированный адрес в домене `.gcdn.co` с точкой на конце.
        1. Нажмите кнопку **Создать**.
        
   - CLI
     
     1. Если у вас нет публичной зоны DNS, создайте ее:
     
        ```bash
        yc dns zone create --name cdn-dns-a --zone ycprojektblue.example. --public-visibility
        ```
        
        * `--name` — имя зоны.
        * `--zone` — доменная зона — ваш домен с точкой на конце.
        * `--public-visibility` — опция публичной видимости зоны.
        
        Результат выполнения команды:
        
        ```bash
        id: aetuvdw77q61dwbl1z2d
        folder_id: aoewzf73jwdlm1xtp4dd
        created_at: "2021-09-28T10:33:31.917Z"
        name: cdn-zone-a
        zone: ycprojektblue.example.
        public_visibility: {}
        ```
        
     1. Создайте запись в зоне:
     
        ```bash
        yc dns zone add-records --name cdn-dns-a --record "cdn CNAME cl-.....6bb.gcdn.co."
        ```
        
        * `--name` — имя зоны.
        * `--record` — ресурсная запись.
        
     1. Проверьте, что запись создана:
     
        ```bash
        yc dns zone list-records --name cdn-dns-a
        ```
        
        Результат выполнения команды:
                
        ```bash
        +----------------------------+------+-------+--------------------------------+
        |            NAME            | TTL  | TYPE  |              DATA              |
        +----------------------------+------+-------+--------------------------------+
        | ycprojektblue.example.     | 3600 | NS    | ns1.yandexcloud.net.           |
        |                            |      |       | ns2.yandexcloud.net.           |
        | ycprojektblue.example.     | 3600 | SOA   | ns1.yandexcloud.net.           |
        |                            |      |       | mx.cloud.yandex.net. 1 10800   |
        |                            |      |       | 900 604800 86400               |
        | cdn.ycprojektblue.example. |  600 | CNAME | cl-.....6bb.gcdn.co.           |
        +----------------------------+------+-------+--------------------------------+
        ```
        
        В списке должна быть запись с именем `cdn.ycprojektblue.example.`
        
   - API
   
     1. Если у вас нет публичной зоны DNS, создайте ее с помощью вызова gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create) или метода REST API [create](../../dns/api-ref/DnsZone/create.md). Чтобы сделать зону публичной, добавьте в тело запроса поле `public_visibility` (gRPC) или `publicVisibility` (REST).
     1. Создайте в зоне запись `cdn CNAME cl-.....6bb.gcdn.co.` с помощью вызова gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) или метода REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md).
        
   {% endlist %}
      
   {% endcut %}
  
## Предзагрузите контент в кеш CDN-серверов {#prefetch-content}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ cdn-name }}**.
  1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.ycprojektblue.example`).
  1. Перейдите на вкладку **Контент**.
  1. Нажмите кнопку **Предзагрузить контент**.
  1. В поле **Пути к файлам** укажите путь к файлу, хранящемуся в источнике, без доменного имени:

     ```text
     /ycgame-update-v1.1.exe
     ```

  1. Нажмите кнопку **Предзагрузить контент**.
  
- API

  Используйте вызов gRPC API [CacheService/Prefetch](../api-ref/grpc/cache_service.md#Prefetch) или метод REST API [prefetch](../api-ref/Cache/prefetch.md).

{% endlist %}

## Проверьте работу CDN {#check-cdn-working}

1. Дождитесь обновления DNS-записей и предзагрузки файла на CDN-серверы.
1. Скачайте файл по новому URL:

   ```
   https://cdn.ycprojektblue.example/ycgame-update-v1.1.exe
   ```

1. Получите логи запросов к бакету `ycprojektblue-storage`:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ objstorage-name }}**.
     1. Выберите бакет `ycprojektblue-logs`.
     1. Нажмите на имя объекта, соответствующего времени скачивания файла `ycgame-update-v1.1.exe`.
     1. Нажмите кнопку **Скачать**.
     
   - AWS CLI
   
     1. Получите список объектов с логами:
     
        ```bash
        aws --endpoint-url=https://storage.yandexcloud.net \
          s3 ls s3://ycprojektblue-logs
        ```
        
        Результат выполнения операции:
        
        ```
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
          s3 cp s3://ycprojektblue-logs/2021-10-01-13-38-02-E69EAEC1C9083756 \
          2021-10-01-13-38-02-E69EAEC1C9083756
        ```
        
        Результат выполнения команды:
        
        ```
        download: s3://ycprojektblue-logs/2021-10-01-13-38-02-E69EAEC1C9083756 to 2021-10-01-13-38-02-E69EAEC1C9083756 
        ```
        
   - API
   
     1. Получите список объектов с логами в бакете `ycprojektblue-logs` с помощью метода API [listObjects](../../storage/s3/api-ref/bucket/listobjects.md).
     
     1. Найдите в полученном списке объект с логом, сохраненным после скачивания файла `ycgame-update-v1.1.exe`, и скачайте его с помощью метода API [get](../../storage/s3/api-ref/object/get.md).

   {% endlist %}

1. По логам запросов к бакету-источнику убедитесь, что CDN-серверы не скачивали файл из источника после вашего запроса. Подробнее о содержимом логов см. в разделе [{#T}](../../storage/concepts/server-logs.md#object-format) документации {{ objstorage-name }}.

## Удалите созданные ресурсы {#clear-out}

Чтобы остановить работу CDN-ресурса и перестать платить за созданные ресурсы: 

1. [Отключите](../operations/resources/disable-resource.md) созданный ресурс.
1. [Удалите](../../storage/operations/objects/delete.md) объект `ycgame-update-v1.1.exe` из бакета `ycprojektblue-storage`.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет `ycprojektblue-storage`.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета `ycprojektblue-logs`.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет `ycprojektblue-logs`.  
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS, если вы пользовались ей при [настройке DNS](#dns-setup). 