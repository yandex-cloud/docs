# Настройка хостинга статического сайта в бакете {{ objstorage-full-name }} с доступом через {{ cdn-full-name }}



В этом руководстве вы создадите статический сайт в [бакете](../../storage/concepts/bucket.md) [{{ objstorage-full-name }}](../../storage/) и опубликуете его в качестве источника контента в [{{ cdn-full-name }}](../../cdn/). Соединение между клиентом и CDN-сервером может осуществляться по протоколу TLS версий 1.0 и 1.1, а между CDN-сервером и {{ objstorage-name }} — по протоколу TLS версии 1.2 или выше. Сайт будет доступен по доменному имени, делегированному в [{{ dns-full-name }}](../../dns/), для которого в [{{ certificate-manager-full-name }}](../../certificate-manager/) будет выпущен TLS-сертификат. Доменное имя сайта будет связано с CDN-ресурсом с помощью [CNAME](../../dns/concepts/resource-record.md#cname) записи в [DNS](../../glossary/dns.md).

В качестве примера будет использовано доменное имя `cdn.yandexcloud.example`.

Чтобы настроить хостинг статического сайта в бакете с доступом через CDN:
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

В стоимость поддержки инфраструктуры для сайта в бакете с доступом через CDN входят:
* плата за исходящий трафик с CDN-серверов (см. [тарифы {{ cdn-name }}](../../cdn/pricing.md)).
* плата за хранение данных в {{ objstorage-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* плата за публичные DNS-запросы и [DNS-зоны](../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../dns/) (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


## Добавьте сертификат в {{ certificate-manager-name }} {#add-certificate}

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

Для сертификата Let's Encrypt® пройдите [проверку прав](../../certificate-manager/operations/managed/cert-validate.md) на домен, который указан в сертификате.


## Создайте бакет в {{ objstorage-name }} и загрузите файлы сайта {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
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

  1. На странице созданного ранее бакета нажмите кнопку ![image](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** и выберите файл `index.html`.

{% endlist %}


## Настройте хостинг статического сайта {#hosting}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [hosting-setup-console](../../_includes/storage/hosting-setup-console.md) %}

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
        * В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите `{{ ui-key.yacloud.common.label_http }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_personal-domain }}** укажите `cdn.yandexcloud.example`.

          {% note alert %}

          Доменное имя `cdn.yandexcloud.example` станет основным, и его будет невозможно изменить после создания CDN-ресурса.

          {% endnote %}

      * В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** укажите `{{ ui-key.yacloud.cdn.value_certificate-custom }}` и выберите [сертификат](#add-certificate) для доменного имени `cdn.yandexcloud.example`.
        * В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}` и в **{{ ui-key.yacloud.cdn.label_custom-host-header }}** укажите доменное имя источника в формате: `<имя_бакета_с_файлами>.{{ s3-web-host }}`, чтобы бакет-источник корректно отвечал на запросы CDN-серверов.
  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  1. В разделах **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Продолжить**.

{% endlist %}


## Настройте DNS для CDN-ресурса {#configure-dns}

Доменное имя `cdn.yandexcloud.example` должно быть связано с CDN-ресурсом с помощью записей [DNS](../../glossary/dns.md).

Чтобы настроить DNS:

1. Получите доменное имя провайдера {{ cdn-name }}:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
     1. В списке CDN-ресурсов выберите ресурс с основным доменным именем `cdn.yandexcloud.example`.
     1. Из блока **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** внизу страницы скопируйте доменное имя вида `{{ cname-example-yc }}` или `{{ cname-example-edge }}`в зависимости от используемого [провайдера CDN](../../cdn/concepts/providers.md).

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

Проверьте доступность сайта:
1. Дождитесь обновления DNS-записей (на это может потребоваться несколько часов) и предзагрузки файлов на CDN-серверы.
1. Откройте сайт по новому URL:

   ```http
   https://cdn.example.com
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы создавали зону в {{ dns-name }}, то [удалите](../../dns/operations/zone-delete.md) зону DNS `example-dns-zone`.
1. [Удалите](../../cdn/operations/resources/delete-resource.md) CDN-ресурс с основным доменным именем `cdn.yandexcloud.example`.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.