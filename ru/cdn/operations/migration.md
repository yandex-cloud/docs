---
noIndex: true
---

# Миграция CDN-ресурсов и групп источников на {{ cdn-full-name }}

С 22 января 2026 года наш технологический партнер по сервису {{ cdn-name }} — компания EdgeЦентр ([провайдер](../concepts/providers.md) EdgeCDN), перестанет предоставлять технологию CDN на нашей платформе.

{{ yandex-cloud }} автоматически мигрирует CDN-ресурсы и группы источников от провайдера EdgeCDN к провайдеру {{ cdn-full-name }} до 17 января 2026 года. При переключении [стоимость использования](../pricing.md) сервиса останется прежней.

Чтобы запустить перенесенные CDN-ресурсы и группы источников:
1. [Включите доступ к контенту](#content-access).
1. [Проверьте TLS-сертификат](#tls).
1. [Измените CNAME-запись](#cname).
1. [Проверьте защиту источников от информационных атак](#ddos).
1. [Протестируйте работу ресурса](#check).

## Включите доступ к контенту {#content-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был размещен CDN-ресурс, относящийся к провайдеру EdgeCDN.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. В списке ресурсов найдите перенесенный CDN-ресурс. У него должен быть указан провайдер `{{ cdn-full-name }}`, и должно быть то же самое основное доменное имя, что и в провайдере EdgeCDN. 
  1. Если в столбце **Статус** перенесенного CDN-ресурса указано `Not active`, включите доступ к контенту:
      1. Напротив ресурса нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. В блоке **Контент** включите доступ к контенту и нажмите **Сохранить**.

  {% note info %}

  Чтобы новые настройки применились к CDN-серверам, может потребоваться до 15 минут. 

  {% endnote %}

{% endlist %}

## Проверьте TLS-сертификат {#tls}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Если для исходного CDN-ресурса был загружен TLS-сертификат, в [консоли управления]({{ link-console-main }}) выберите новый CDN-ресурс с провайдером {{ cdn-full-name }} и убедитесь, что в блоке **{{ ui-key.yacloud.cdn.label_certificate-type }}** указано название вашего сертификата.
      
  {% note warning %}

  Ранее для CDN-ресурсов поддерживался автоматический выпуск TLS-сертификатов на стороне EdgeCDN. В параметрах CDN-ресурса такой тип сертификатов отображается как **{{ ui-key.yacloud.cdn.md_value_certificate-le }}**. 

  Перенести эти сертификаты от провайдера EdgeCDN к провайдеру {{ cdn-full-name }} не получится. Вместо этого [выпустите](../../certificate-manager/operations/managed/cert-create.md) новый сертификат Let's Encrypt^®^ или [загрузите](../../certificate-manager/operations/import/cert-create.md) собственный в сервисе {{ certificate-manager-full-name }} и укажите его в настройках перенесенного CDN-ресурса.

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

## Проверьте защиту источников от информационных атак {#ddos}

Если для источника, который вы подключаете к {{ cdn-full-name }}, настроена защита от информационных атак, например файрвол, DDoS Protection и пр., убедитесь, что [адреса {{ cdn-full-name }}](https://tech.cdn.yandex.net/prefixes/yc.json) находятся в списке разрешенных.

## Протестируйте работу ресурса {#check}

После того как CNAME-запись распространится по серверам DNS, клиентские запросы начнут приходить на новый CDN-ресурс.

Чтобы проверить работу ресурса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан CDN-ресурс.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите CDN-ресурс, созданный ранее.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](../concepts/providers.md)
* [{#T}](./resources/copy-resource.md)
* [{#T}](./resources/get-stats.md)