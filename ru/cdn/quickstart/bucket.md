---
title: Как начать работать с {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете использовать сервис {{ cdn-full-name }}, чтобы создать и настроить CDN-ресурс с бакетом {{ objstorage-full-name }} в качестве источника.
---

# Создание CDN-ресурса с источником-бакетом {{ objstorage-full-name }}

{% include [create-other-resources](../../_includes/cdn/create-other-resources-note.md) %}

Настройте раздачу контента через CDN с [бакетом](../../storage/concepts/bucket.md) {{ objstorage-name }} в качестве источника:

1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Настройте CNAME для вашего домена](#setup-cname).
1. [Проверьте работу CDN](#check-cdn-working).

## Перед началом работы {#before-you-begin}

1. Убедитесь, что у вас есть доменное имя и доступ к настройкам [DNS](../../glossary/dns.md) на сайте компании, которая предоставляет вам услуги DNS-хостинга. Обычно это компания-регистратор вашего домена.
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, [создайте](../../resource-manager/operations/folder/create.md) его.

    {% cut "Подробнее о создании каталога" %}

    {% include [create-folder](../../_includes/create-folder.md) %}

    {% endcut %}

1. Если у вас еще нет бакета {{ objstorage-name }}:

   1. [Создайте бакет](../../storage/operations/buckets/create.md).
   1. [Откройте публичный доступ](../../storage/operations/buckets/bucket-availability.md) к объектам в бакете и их списку.
   1. [Загрузите контент](../../storage/operations/objects/upload.md) в бакет.
      
## Создайте CDN-ресурс {#create-cdn-resource}

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. На вкладке ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
1. В разделе **{{ ui-key.yacloud.cdn.value_stepper-main-settings }}** задайте основные настройки CDN-ресурса:
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
      * В поле **{{ ui-key.yacloud.cdn.label_custom-host-header }}** укажите доменное имя из [URL бакета](../../storage/concepts/bucket.md#bucket-url) в формате `<имя_бакета>.{{ s3-storage-host }}`. Схему (`http` или `https`) указывать не нужно. Например:

         ```
         my-bucket.{{ s3-storage-host }}
         ```

         {% note warning %}

         Если настроен неверный заголовок `Host`, {{ objstorage-name }} будет отвечать на запросы CDN-сервера ошибками.

         {% endnote %}

1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
1. В разделах **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Продолжить**. При необходимости вы сможете настроить эти параметры позднее.

{% include [create-resource-time](../../_includes/cdn/create-resource-time.md) %}

{% include [content-prefetch-quickstart-tip](../../_includes/cdn/content-prefetch-quickstart-tip.md) %}

## Настройте CNAME для вашего домена {#setup-cname}

{% include [quickstart-setup-resource-cname](../../_includes/cdn/quickstart-setup-resource-cname.md) %}

## Проверьте работу CDN {#check-cdn-working}

{% include [quickstart-check-cdn-working](../../_includes/cdn/quickstart-check-cdn-working.md) %}

#### См. также {#see-also}

* [{#T}](./server.md)
* [{#T}](../concepts/index.md)
* [{#T}](../../storage/operations/buckets/create.md)