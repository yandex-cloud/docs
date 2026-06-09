# Создание CDN-ресурса с источником-бакетом {{ objstorage-full-name }}



{% note warning %}

С 1 июля 2026 года изменится модель тарификации {{ cdn-name }}.
Подробнее в разделе [{#T}](../pricing.md).

{% endnote %}


{% note info %}

О создании группы источников и ресурса CDN с другими типами источников читайте в разделах:
  
* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/origin-groups/create-group.md)

{% endnote %}

Настройте раздачу контента через CDN с [бакетом](../../storage/concepts/bucket.md) {{ objstorage-name }} в качестве источника:

1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Настройте CNAME для вашего домена](#setup-cname).
1. [Проверьте работу CDN](#check-cdn-working).

## Перед началом работы {#before-you-begin}

1. Убедитесь, что у вас есть доменное имя и доступ к настройкам [DNS](../../glossary/dns.md) на сайте компании, которая предоставляет вам услуги DNS-хостинга. Обычно это компания-регистратор вашего домена.
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, [создайте](../../resource-manager/operations/folder/create.md) его.

    {% cut "Подробнее о создании каталога" %}

    1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
    1. Справа от названия облака нажмите ![image](../../_assets/console-icons/ellipsis.svg).
    1. Выберите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
    
       ![create-folder1](../../_assets/resource-manager/create-folder-1.png)
    
    1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
    
        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.
    
    1. (Опционально) Введите описание каталога.
    1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.
    
       ![create-folder2](../../_assets/resource-manager/create-folder-2.png)

    {% endcut %}

1. Если у вас еще нет бакета {{ objstorage-name }}:

   1. [Создайте бакет](../../storage/operations/buckets/create.md).
   1. [Откройте публичный доступ](../../storage/operations/buckets/bucket-availability.md) к объектам в бакете и их списку.
   1. [Загрузите контент](../../storage/operations/objects/upload.md) в бакет.
      
## Создайте CDN-ресурс {#create-cdn-resource}

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
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

Дождитесь создания ресурса. На это может потребоваться до 15 минут.

{% note tip %}

Рекомендуется [принудительно загружать](../operations/resources/prefetch-files.md) в [кеш](../concepts/caching.md) CDN-серверов объемный контент (например, файлы более 200 МБ). Это опциональный шаг: если его не выполнить, то контент будет загружен в кеш [CDN-серверов](../concepts/points-of-presence.md) автоматически при первом обращении к нему конечного пользователя.

{% endnote %}

## Настройте CNAME для вашего домена {#setup-cname}

1. На странице CDN-ресурса на вкладке ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** в разделе **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** скопируйте в буфер обмена сгенерированное сервисом доменное имя вида `{{ cname-example-yc }}`.
1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
1. Измените нужную CNAME-запись таким образом, чтобы она указывала на скопированный ранее адрес в домене `.topology.gslb.yccdn.ru`. Например, если при создании CDN-ресурса вы указали доменное имя для раздачи контента `cdn.example.com`, вам нужно создать следующую CNAME-запись или заменить ею уже существующую запись для `cdn`:

    ```http
    cdn CNAME {{ cname-example-yc }}.
    ```

    {% note info %}
    
    Не используйте ресурсную запись [ANAME](../../dns/concepts/resource-record.md#aname) с доменными именами для раздачи контента, поскольку в таком случае конечный пользователь получит ответ от CDN-сервера, не связанного с геолокацией пользователя. Ответ всегда будет одинаков для всех пользователей.
    
    {% endnote %}

## Проверьте работу CDN {#check-cdn-working}

1. Дождитесь обновления DNS-записей. На это может потребоваться несколько часов.
1. Убедитесь, что CNAME-запись `cdn` в кеше DNS-серверов указывает на сгенерированный сервисом адрес (например, `{{ cname-example-yc }}`).
1. Проверьте работу сайта, открыв в браузере его адрес, например:

    ```http
    http://cdn.example.com/index.html
    ```

#### См. также {#see-also}

* [{#T}](server.md)
* [{#T}](../concepts/index.md)
* [{#T}](../../storage/operations/buckets/create.md)