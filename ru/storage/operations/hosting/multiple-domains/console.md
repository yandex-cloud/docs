---
title: Как настроить поддержку нескольких доменных имен для сайта с помощью консоли управления, CLI или API
description: Следуя данной инструкции, вы сможете настроить поддержку нескольких доменных имен для сайта с помощью консоли управления {{ yandex-cloud }}, CLI или API.
---

# Поддержка нескольких доменных имен с помощью консоли управления, CLI или API

Чтобы создать инфраструктуру для поддержки [нескольких доменных имен](index.md) сайта с помощью консоли управления {{ yandex-cloud }}, CLI или API:
1. [Создайте бакеты](#buckets).
1. [Настройте статический сайт для основного домена](#common).
1. [Настройте переадресацию для дополнительного домена](#xtra).
1. [Проверьте работу нескольких доменов](#test).


## Создайте бакеты {#buckets}

Создайте бакеты и назовите их в соответствии с доменными именами, например `example.com` и `example2.com`.

1. Создайте бакет для основного доменного имени `example.com`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
      1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. На панели сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. На странице создания бакета:

          1. Введите имя бакета в соответствии с основным доменным именем сайта, например `example.com`.

              {% note info %}

              Имена бакетов должны совпадать с доменными именами. 

              {% endnote %}

          1. Задайте максимальный размер бакета.

          1. Включите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}` — доступ для любых пользователей.

          1. Выберите [класс хранилища](../../../concepts/storage-class.md) по умолчанию — `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`.

          1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [cli-install](../../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

      1. Посмотрите описание команды CLI для создания бакета:

          ```bash
          yc storage bucket create --help
          ```

      1. Создайте бакет в каталоге по умолчанию:

          ```bash
          yc storage bucket create --name <имя_бакета> \
            --public-read \
            --public-list
          ```

          Где 
          * `--name` — имя бакета в соответствии с основным доменным именем сайта, например `example.com`.

              {% note info %}

              Имена бакетов должны совпадать с доменными именами. 

              {% endnote %}

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
          created_at: "2025-08-08T09:12:45.743187Z"
          resource_id: e3etgi7l43gs********
          ```

    - API {#api}

      Чтобы создать бакет, воспользуйтесь методом REST API [create](../../../api-ref/Bucket/create.md) для ресурса [Bucket](../../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../../api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../../s3/api-ref/bucket/create.md).

    {% endlist %}

1. Создайте бакет для дополнительного доменного имени `example2.com`, повторив шаги выше.

## Настройте статический сайт для основного домена {#common}

Настройте статический сайт для бакета и свяжите его с основным доменным именем `example.com`:

1. Настройте бакет `example.com` в качестве хостинга статического сайта.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Выберите бакет, для которого хотите настроить хостинг.
      1. На панели слева выберите ![image](../../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
      1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
          * В поле **{{ ui-key.yacloud.storage.bucket.website.field_index }}** укажите абсолютный путь к файлу в бакете для главной страницы сайта, например `index.html`.
      
            {% include [static-site-index-restriction](../../../../_includes/storage/static-site-index-restriction.md) %}
      
          * (опционально) В поле **{{ ui-key.yacloud.storage.bucket.website.field_error }}** укажите абсолютный путь к файлу в бакете, который будет отображаться при ошибках 4xx, например `pages/error404.html`. По умолчанию {{ objstorage-name }} возвращает собственную страницу.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

      Проверить хостинг можно, перейдя по ссылке в поле **{{ ui-key.yacloud.storage.bucket.website.field_link }}**.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [hosting-setup-cli](../../../../_includes/storage/hosting-setup-cli.md) %}

    - API {#api}

      Чтобы настроить хостинг статического сайта, воспользуйтесь методом REST API [update](../../../api-ref/Bucket/update.md) для ресурса [Bucket](../../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../../api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../../s3/api-ref/hosting/upload.md).

    {% endlist %}

1. Свяжите доменное имя `example.com` и соответствующий бакет.

    1. Создайте на [DNS-сервере](../../../../glossary/dns.md#dns-server) публичную зону DNS и ресурсную запись, которая связывает ваше доменное имя и бакет:

        {% list tabs group=instructions %}

        - {{ dns-full-name }} {#dns}

          {% note warning %}

          Использование сервиса {{ dns-name }} тарифицируется, подробнее см. [{#T}](../../../../dns/pricing.md).

          {% endnote %}

          1. В [консоли управления]({{ link-console-main }}) выберите каталог.
          1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
          1. Выберите бакет, для которого хотите использовать собственный домен.
          1. На панели слева выберите ![image](../../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** и перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
          1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** в блоке **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** нажмите кнопку **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.

              {% note info %}

              В блоке **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** раздела **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** отображаются только те домены, которые были созданы непосредственно в этом интерфейсе. Если запись была создана в сервисе [{{ dns-name }}](../../../../dns/quickstart.md), то в этом блоке она отображаться не будет.

              {% endnote %}

          1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}** и выберите доменную зону, которая соответствует имени бакета, например `example.com`. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
          1. Раскройте блок **{{ ui-key.yacloud.dns.label_additional-settings }}**.
          1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни ресурсной записи или выберите из предложенных.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
          1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
          
          Чтобы получить доступ к именам из публичной зоны, делегируйте домен. Для этого в личном кабинете вашего доменного регистратора укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

          Делегирование домена и обновление ресурсных записей могут занять некоторое время.

          Вы также можете [создать зону DNS](../../../../dns/operations/zone-create-public.md) и [ресурсную запись](../../../../dns/operations/resource-record-create) средствами {{ dns-name }}.
          
          {% cut "Пример параметров зоны DNS и ресурсной записи" %}

          Параметры зоны DNS:
          * Зона — `example.com.`.
          * Тип — `публичная`.

          Параметры ресурсной записи:

          | Имя          | Тип   | TTL | Значение                      |
          |--------------|-------|-----|-------------------------------|
          | example.com. | ANAME | 600 | example.com.{{ s3-web-host }} |

          Записи [ANAME](../../../../dns/concepts/resource-record.md#aname) позволяют использовать для хостинга домены второго уровня и, в отличие от [CNAME](../../../../dns/concepts/resource-record.md#cname), не ограничивают использование других типов записей в одной с ними зоне. 

          {% endcut %}

        - Внешний DNS-сервер {#third-party-dns-server}

          Пример параметров зоны DNS:
          * Зона — `example.com.`.
          * Тип — `публичная`.
          
          Пример ресурсной записи [CNAME](../../../../dns/concepts/resource-record.md#cname): 

          ```text
          example.com CNAME example.com.{{ s3-web-host }}
          ```

          Чтобы использовать ресурсную запись CNAME, ваше доменное имя должно быть в домене не ниже третьего уровня — это связано с особенностями обработки CNAME-записей на DNS-хостингах. Подробнее см. п. 2.4 [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

          Обновление ресурсных записей может занять некоторое время.

        {% endlist %}

        В результате статический сайт будет доступен по адресу `example.com`.

1. {% include [add-cert.md](../../../../_includes/storage/add-cert.md) %}

    {% note info %}

    Вы можете использовать один сертификат для основного и дополнительного домена или несколько сертификатов для каждого домена.

    {% endnote %}

    {% include [redirect-https](../../../../_includes/storage/redirect-https.md) %}

В результате статический сайт будет доступен по адресу `example.com` по протоколу HTTPS.


## Настройте переадресацию для дополнительного домена {#extra}

Для бакета с дополнительным доменным именем `example2.com`:

1. Настройте в бакете `example2.com` переадресацию всех запросов на основной домен `example.com` и **протокол** HTTPS.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Выберите бакет, для которого хотите настроить переадресацию всех запросов.
      1. На панели слева выберите ![image](../../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
      1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_redirect }}** укажите:
          * **{{ ui-key.yacloud.storage.bucket.website.field_hostname }}** — доменное имя, на которое будут переадресованы все запросы, например `example.com`.
          * **{{ ui-key.yacloud.storage.bucket.website.field_protocol }}** — **{{ ui-key.yacloud.common.label_https }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

    - {{ yandex-cloud }} CLI {#cli}

      1. Посмотрите описание команды CLI для настройки переадресации всех запросов:

          ```bash
          yc storage bucket update --help
          ```
     
      1. Создайте файл с настройками переадресации в формате JSON. Например:
     
          ```json
          {
            "redirectAllRequests": {
              "protocol": "PROTOCOL_HTTPS",
              "hostname": "example.com"
            }
          }
          ```

          Где:
          * `protocol` — протокол передачи данных.
          * `hostname` — доменное имя хоста, на который будут перенаправляться все запросы к текущему бакету.

      1. Выполните следующую команду:

          ```bash
          yc storage bucket update --name <имя_бакета> \
            --website-settings-from-file <путь_к_файлу>
          ```

          Где:
          * `--name` — имя бакета.
          * `--website-settings-from-file` — путь к файлу с настройками переадресации.

          Результат:

          ```text
          name: example2.com
          folder_id: b1gjs8dck8bv********
          default_storage_class: STANDARD
          versioning: VERSIONING_SUSPENDED
          max_size: "10737418240"
          acl: {}
          created_at: "2022-12-14T08:42:16.273717Z"
          ```

    - API {#api}

      Чтобы настроить переадресацию всех запросов к бакету, воспользуйтесь методом REST API [update](../../../api-ref/Bucket/update.md) для ресурса [Bucket](../../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../../api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../../s3/api-ref/hosting/upload.md).

    {% endlist %}

1. {% include [add-cert.md](../../../../_includes/storage/add-cert.md) %}

    {% include [redirect-https](../../../../_includes/storage/redirect-https.md) %}

1. [Свяжите](../own-domain.md) доменное имя `example2.com` и соответствующий бакет.


## Проверьте работу нескольких доменов {#test}

{% include [website-multiple-domain-test](../../../../_includes/storage/website-multiple-domain-test.md) %}


#### См. также {#see-also}

* [{#T}](terraform.md)