---
title: Как начать работать с {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете создать и настроить CDN-ресурс.
---

# Как начать работать с {{ cdn-full-name }}

Настройте раздачу контента через CDN на примере бакета {{ objstorage-name }}:

1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Загрузите контент в CDN](#upload-content-to-CDN).
1. [Настройте CNAME для своего домена](#setup-cname).
1. [Проверьте работу CDN](#check-cdn-working).

## Перед началом работы {#before-you-begin}

1. Убедитесь, что у вас есть доменное имя и доступ к настройкам [DNS](../glossary/dns.md) на сайте компании, которая предоставляет вам услуги DNS-хостинга. Обычно это компания-регистратор вашего домена.
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Если у вас еще нет бакета {{ objstorage-name }}:

   1. [Создайте бакет](../storage/operations/buckets/create.md).
   1. [Откройте публичный доступ](../storage/operations/buckets/bucket-availability.md) к объектам в бакете и их списку.
   1. [Загрузите контент](../storage/operations/objects/upload.md) в бакет.

## Создайте CDN-ресурс {#create-cdn-resource}

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. На вкладке ![image](../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
1. Задайте основные настройки CDN-ресурса:
   * В блоке **{{ ui-key.yacloud.cdn.label_section-content }}**:
      * Включите **{{ ui-key.yacloud.cdn.label_access }}**.
      * В поле **{{ ui-key.yacloud.cdn.label_content-query-type }}** выберите `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
      * В поле **{{ ui-key.yacloud.cdn.label_source-type }}** выберите `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`.
      * В поле **{{ ui-key.yacloud.cdn.label_bucket }}** выберите бакет, созданный в {{ objstorage-name }}.
      * В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите `{{ ui-key.yacloud.common.label_http }}`.
      * В поле **{{ ui-key.yacloud.cdn.label_personal-domain }}** укажите основное доменное имя, которое будете использовать в ссылках с сайта на контент, размещенный в CDN. Например: `cdn.example.com`.

         {% note alert %}

         Основное доменное имя для раздачи контента невозможно изменить после создания CDN-ресурса.

         {% endnote %}

   * В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:
      * В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_do-not-use }}`.
      * В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите `{{ ui-key.yacloud.cdn.value_certificate-no }}`.
      * В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}`.
      * В поле **{{ ui-key.yacloud.cdn.label_custom-host-header }}** укажите доменное имя из [URL бакета](../storage/concepts/bucket.md#bucket-url) в формате `<имя_бакета>.{{ s3-storage-host }}`. Схему (`http` или `https`) указывать не нужно. Например:

         ```
         my-bucket.{{ s3-storage-host }}
         ```

         {% note warning %}

         Если настроен неверный заголовок `Host`, {{ objstorage-name }} будет отвечать на запросы CDN-сервера ошибками.

         {% endnote %}

1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
1. В разделах **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Продолжить**.

   {% note tip %}

   При необходимости вы сможете настроить эти параметры позднее.

   {% endnote %}

## Загрузите контент в CDN {#upload-content-to-CDN}

{% note tip %}

Рекомендуется предварительно загружать в CDN объемный контент (например, больше 200 МБ). Это опциональный шаг: если не загрузить контент на этом этапе, то он будет загружен в CDN автоматически при первом обращении.

{% endnote %}

Чтобы заранее загрузить контент на серверы CDN:

1. На странице CDN-ресурса перейдите на вкладку ![image](../_assets/console-icons/box.svg) **{{ ui-key.yacloud.cdn.label_resource-content }}**.
1. В правом верхнем углу нажмите ![image](../_assets/console-icons/ellipsis.svg) и выберите ![image](../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.
1. В поле **{{ ui-key.yacloud.cdn.label_resource-content-prefetch-cache-paths }}** укажите имена файлов, хранящихся в бакете, без указания имени бакета, например:

    ```text
    /index.html
    /static/styles.css
    /static/app.js
    ```

1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.


## Настройте CNAME для своего домена {#setup-cname}

1. На странице CDN-ресурса на вкладке ![image](../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** в разделе **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** скопируйте в буфер обмена сгенерированное сервисом доменное имя вида `{{ cname-example-yc }}`.
1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
1. Измените нужную CNAME-запись таким образом, чтобы она указывала на скопированный ранее адрес в домене `.yccdn.cloud.yandex.net`. Например, если при создании CDN-ресурса вы указали доменное имя для раздачи контента `cdn.example.com`, вам нужно создать следующую CNAME-запись или заменить на нее уже существующую запись для `cdn`:

    ```http
    cdn CNAME {{ cname-example-yc }}.
    ```

    {% include [note-dns-aname](../_includes/cdn/note-dns-aname.md) %}

## Проверьте работу CDN {#check-cdn-working}

1. Дождитесь обновления DNS-записей. На это может потребоваться несколько часов.
1. Убедитесь, что CNAME-запись `cdn` в кеше DNS-серверов указывает на сгенерированный сервисом адрес (например, `{{ cname-example-yc }}`).
1. Проверьте работу сайта, открыв в браузере его адрес, например:

    ```http
    http://cdn.example.com/index.html
    ```
