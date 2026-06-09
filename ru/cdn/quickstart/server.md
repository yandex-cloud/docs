---
title: Как начать работать с {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете использовать сервис {{ cdn-full-name }}, чтобы создать и настроить CDN-ресурс с виртуальной машиной {{ compute-full-name }} или сервером {{ baremetal-full-name }} в качестве источника.
---

# Создание CDN-ресурса с источником-сервером в {{ yandex-cloud }}



{% include [pricing-change-short-warning](../../_includes/cdn/pricing-change-short-warning.md) %}


{% include [create-other-resources](../../_includes/cdn/create-other-resources-note.md) %}

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

    {% include [create-folder](../../_includes/create-folder.md) %}

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
   
{% include [create-resource-time](../../_includes/cdn/create-resource-time.md) %}

{% include [content-prefetch-quickstart-tip](../../_includes/cdn/content-prefetch-quickstart-tip.md) %}

## Настройте CNAME для вашего домена {#setup-cname}

{% include [quickstart-setup-resource-cname](../../_includes/cdn/quickstart-setup-resource-cname.md) %}

## Проверьте работу CDN {#check-cdn-working}

{% include [quickstart-check-cdn-working](../../_includes/cdn/quickstart-check-cdn-working.md) %}

#### См. также {#see-also}

* [{#T}](./bucket.md)
* [{#T}](../concepts/index.md)
* [Создание виртуальной машины из публичного образа Linux](../../compute/operations/vm-create/create-linux-vm.md)
* [Аренда сервера {{ baremetal-name }} в готовой конфигурации](../../baremetal/operations/servers/server-lease.md)
* [Создание сайта на LAMP- или LEMP-стеке](../../tutorials/web/lamp-lemp/index.md)
* [Настройка веб-сервера](../tutorials/protected-access-to-content/console.md#setup-web-server)