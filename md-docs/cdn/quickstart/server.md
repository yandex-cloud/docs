# Создание CDN-ресурса с источником-сервером в {{ yandex-cloud }}



{% note warning %}

С 1 июля 2026 года изменится модель тарификации {{ cdn-name }}.
Подробнее в разделе [{#T}](../pricing.md).

{% endnote %}


{% note info %}

О создании группы источников и ресурса CDN с другими типами источников читайте в разделах:
  
* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/origin-groups/create-group.md)

{% endnote %}

Настройте раздачу контента через CDN с [виртуальной машиной](../../compute/concepts/vm.md) {{ compute-full-name }} или [сервером](../../baremetal/concepts/servers.md) {{ baremetal-full-name }} в качестве источника:

1. [Создайте веб-сервер](#create-server).
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

## Создайте веб-сервер {#create-server}

Если у вас еще нет веб-сервера:

1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) {{ compute-name }} или [арендуйте сервер](../../baremetal/operations/servers/server-lease.md) {{ baremetal-name }}.
1. На созданный сервер или виртуальную машину установите веб-сервер, например: [Apache](https://httpd.apache.org/) или [nginx](https://nginx.org/).

    При установке веб-сервера на виртуальную машину не забудьте привязать к ней [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую входящий и исходящий сетевой трафик на нужные порты, например: `80`, `443`. Подробнее о создании группы безопасности читайте в разделе [{#T}](../../vpc/operations/security-group-create.md).
1. Загрузите контент на ваш веб-сервер.
1. Убедитесь, что ваш веб-сервер доступен из интернета.

    Чтобы проверить доступность веб-сервера, созданного на виртуальной машине {{ compute-name }} или сервере {{ baremetal-name }}, в адресной строке браузера введите [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ или сервера. Например:

    ```text
    http://198.51.100.27/
    ```

    В результате в окне браузера должна открыться главная страница приложения, развернутого на сервере.

Подробнее о создании сайта на базе виртуальной машины {{ compute-name }} читайте в разделе [{#T}](../../tutorials/web/lamp-lemp/index.md).

## Создайте CDN-ресурс {#create-cdn-resource}

<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplva6365yoayxar6ore?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. На вкладке ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
1. В разделе **{{ ui-key.yacloud.cdn.value_stepper-main-settings }}** задайте основные настройки CDN-ресурса:
    * В блоке **{{ ui-key.yacloud.cdn.label_section-content }}**:
        * Включите **{{ ui-key.yacloud.cdn.label_access }}**.
        * В поле **{{ ui-key.yacloud.cdn.label_content-query-type }}** выберите `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_source-type }}** выберите `{{ ui-key.yacloud.cdn.value_source-type-url }}`.
        * В поле **{{ ui-key.yacloud.cdn.field_origin }}** укажите [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) вашей виртуальной машины или сервера {{ baremetal-name }} с веб-сервером.
        * В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите `{{ ui-key.yacloud.common.label_http }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_personal-domain }}** укажите основное доменное имя, которое будете использовать в ссылках с сайта на контент, размещенный в CDN. Например: `cdn.example.com`.

            {% note alert %}

            Основное доменное имя для раздачи контента невозможно изменить после создания CDN-ресурса.

            {% endnote %}

    * В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_do-not-use }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите `{{ ui-key.yacloud.cdn.value_certificate-no }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите `{{ ui-key.yacloud.cdn.value_host-header-default }}`.

            Значение поля **{{ ui-key.yacloud.cdn.label_host-header }}** должно соответствовать имени виртуального хоста, настроенного на сервере-источнике.

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

* [{#T}](bucket.md)
* [{#T}](../concepts/index.md)
* [Создание виртуальной машины из публичного образа Linux](../../compute/operations/vm-create/create-linux-vm.md)
* [Аренда сервера {{ baremetal-name }} в готовой конфигурации](../../baremetal/operations/servers/server-lease.md)
* [Создание сайта на LAMP- или LEMP-стеке](../../tutorials/web/lamp-lemp/index.md)
* [Настройка веб-сервера](../tutorials/protected-access-to-content/console.md#setup-web-server)