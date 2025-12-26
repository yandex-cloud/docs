---
noIndex: true
---

# Миграция CDN-ресурсов и групп источников на {{ cdn-full-name }}

С 22 января 2026 года наш технологический партнер по сервису {{ cdn-name }} — компания EdgeЦентр, перестанет предоставлять технологию CDN на нашей платформе.

Рекомендуем мигрировать ваши CDN-ресурсы из EdgeCDN в {{ yandex-cloud }}. Сделать это можно самостоятельно, или в процессе [частичной автомиграции](#auto), которую мы завершим к 17 января 2026 года.

Чтобы перенести CDN-ресурсы и группы источников от [провайдера](../concepts/providers.md) EdgeCDN к провайдеру {{ cdn-full-name }}:
1. [Перенесите конфигурацию существующего ресурса](#copy-configuration).
1. [Измените CNAME-запись](#cname).
1. [Проверьте работу ресурса](#check).

## Перенесите конфигурацию существующего ресурса {#copy-configuration}

<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplv65sb6shyvchwvqnu?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором размещен CDN-ресурс, относящийся к провайдеру EdgeCDN.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. В поле **{{ ui-key.yacloud.cdn.label_copy-config }}** выберите CDN-ресурс, относящийся к провайдеру EdgeCDN, который вы хотите мигрировать к провайдеру {{ cdn-full-name }}.

      {% note tip %}

      Название провайдера отображается под основным доменным именем ресурса.

      {% endnote %}

  1. Все настройки заполняются автоматически в соответствии с конфигурацией исходного CDN-ресурса. При необходимости откорректируйте параметры.

      {% note info %}

      При миграции от провайдера EdgeCDN к провайдеру {{ cdn-full-name }} вы можете сохранить **{{ ui-key.yacloud.cdn.label_personal-domain }}** ресурса. Имя должно быть уникальным в рамках ресурсов одного провайдера CDN.

      {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  1. При необходимости откорректируйте параметры в разделах **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и **{{ ui-key.yacloud.cdn.label_additional }}** и нажмите **{{ ui-key.yacloud.common.continue }}**.

      Дождитесь появления в списке нового CDN-ресурса с провайдером {{ cdn-full-name }}.

      Помимо нового CDN-ресурса, в процессе будет также создана копия [группы источников](../concepts/origins.md).

  1. Если для исходного CDN-ресурса был загружен TLS-сертификат, выберите новый CDN-ресурс с провайдером {{ cdn-full-name }} и убедитесь что в блоке **{{ ui-key.yacloud.cdn.label_certificate-type }}** указано название вашего сертификата.
      
      {% note warning %}

      Ранее для CDN-ресурсов поддерживался автоматический выпуск TLS-сертификатов на стороне EdgeCDN. В параметрах CDN-ресурса такой тип сертификатов отображается как **{{ ui-key.yacloud.cdn.md_value_certificate-le }}**. 

      Перенести эти сертификаты от провайдера EdgeCDN к провайдеру {{ cdn-full-name }} не получится. Вместо этого [выпустите](../../certificate-manager/operations/managed/cert-create.md) новый сертификат Let's Encrypt^®^ или [загрузите](../../certificate-manager/operations/import/cert-create.md) собственный в сервисе {{ certificate-manager-full-name }} и укажите его при миграции CDN-ресурса.

      {% endnote %}

{% endlist %}

## Измените CNAME-запись {#cname}

1. Узнайте значение для CNAME-записи:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. Выберите созданный CDN-ресурс с провайдером {{ cdn-full-name }}.
      1. В блоке **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** скопируйте значение для CNAME-записи. Пример значения: `{{ cname-example-yc }}`.

    {% endlist %}

1. В настройках вашего DNS-хостинга измените CNAME-запись со значения, указывающего на адрес с доменным именем EdgeCDN, на значение, указывающее на адрес с доменным именем {{ cdn-full-name }}.

    <br>

    > Пример исходной записи для провайдера EdgeCDN:
    > 
    > ```text
    > cdn.example.com. CNAME {{ cname-example-edge }}
    > ```
    > 
    > Пример измененной записи для провайдера {{ cdn-full-name }}:
    > 
    > ```text
    > cdn.example.com. CNAME {{ cname-example-yc }}
    > ```

    {% note tip %}

    Если для DNS-хостинга вы используете {{ dns-full-name }}, см. инструкцию [{#T}](../../dns/operations/resource-record-update.md).

    {% endnote %}

Новый ресурс начнет корректно работать после того, как CNAME-запись, которую вы изменили в своем DNS-хостинге, распространится по серверам DNS. На это может потребоваться несколько часов. См. [раздел о доменных именах для раздачи контента](../../cdn/concepts/resource.md#hostnames).

{% include [note-dns-aname](../../_includes/cdn/note-dns-aname.md) %}

## Проверьте работу ресурса {#check}

После того как CNAME-запись распространится по серверам DNS, клиентские запросы начнут приходить на новый CDN-ресурс.

Чтобы проверить работу ресурса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан CDN-ресурс.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите CDN-ресурс, созданный ранее.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.

{% endlist %}

## Частичная автомиграция {#auto}

К 17 января 2026 года мы самостоятельно перенесем CDN-ресурсы: скопируем их, сохранив настройки, и перенесем в провайдер {{ cdn-full-name }}.

Вам останется только [заменить](#cname) CNAME-запись для домена в настройках вашего DNS-хостинга.

### См. также {#see-also}

* [{#T}](../concepts/providers.md)
* [{#T}](./resources/copy-resource.md)
* [{#T}](./resources/get-stats.md)