---
title: Собственный домен
description: Следуя данной инструкции, вы сможете настроить собственный домен для хостинга.
---

# Собственный домен

Для публикации сайта вы можете использовать собственный домен, например `example.com`.

Чтобы поддержать собственный домен:

1. [Создайте](../buckets/create.md) бакет. Назовите его так же, как домен, например `example.com`.
1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}
1. Создайте на [DNS-сервере](../../../glossary/dns.md#dns-server) публичную [зону DNS](../../../dns/concepts/dns-zone.md) и [ресурсную запись](../../../dns/concepts/resource-record.md), которая связывает ваше доменное имя и бакет.

   {% include [storage-cloud-dns-domains](../../_includes_service/storage-cloud-dns-domains.md) %}

    {% list tabs group=instructions %}

    - {{ dns-full-name }} {#dns}

      {% note warning %}

      Использование сервиса {{ dns-name }} тарифицируется, подробнее см. [{#T}](../../../dns/pricing.md).

      {% endnote %}

      1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, для которого хотите использовать собственный домен.
      1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** и перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
      1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** в блоке **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** нажмите кнопку **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.

          {% note info %}

          В блоке **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** раздела **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** отображаются только те домены, которые были созданы непосредственно в этом интерфейсе. Если запись была создана в сервисе [{{ dns-name }}](../../../dns/quickstart.md), то в этом блоке она отображаться не будет.

          {% endnote %}

      1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}** и выберите доменную зону, которая соответствует имени бакета, например `example.com.`. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Раскройте блок **{{ ui-key.yacloud.dns.label_additional-settings }}**.
      1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни ресурсной записи или выберите из предложенных.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
      
      Чтобы получить доступ к именам из публичной зоны, делегируйте домен. Для этого в личном кабинете вашего доменного регистратора укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

      Делегирование домена и обновление ресурсных записей могут занять некоторое время.

      Вы также можете [создать зону DNS](../../../dns/operations/zone-create-public.md) и [ресурсную запись](../../../dns/operations/resource-record-create) средствами {{ dns-name }}.
      
      {% cut "Пример параметров зоны DNS и ресурсной записи" %}

      Параметры зоны DNS:
      * Зона — `example.com.`.
      * Тип — `публичная`.

      Параметры ресурсной записи:

      | Имя          | Тип   | TTL | Значение                      |
      |--------------|-------|-----|-------------------------------|
      | example.com. | ANAME | 600 | example.com.{{ s3-web-host }} |

      Записи [ANAME](../../../dns/concepts/resource-record.md#aname) позволяют использовать для хостинга домены второго уровня и, в отличие от [CNAME](../../../dns/concepts/resource-record.md#cname), не ограничивают использование других типов записей в одной с ними зоне. 

      {% endcut %}

    - Внешний DNS-сервер {#third-party-dns-server}

      Пример параметров зоны DNS:
      * Зона — `example.com.`.
      * Тип — `публичная`.
      
      Пример ресурсной записи [CNAME](../../../dns/concepts/resource-record.md#cname): 

      ```text
      example.com CNAME example.com.{{ s3-web-host }}
      ```

      Чтобы использовать ресурсную запись CNAME, ваше доменное имя должно быть в домене не ниже третьего уровня — это связано с особенностями обработки CNAME-записей на DNS-хостингах. Подробнее см. п. 2.4 [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

      Обновление ресурсных записей может занять некоторое время.

    {% endlist %}


1. Чтобы сайт был доступен по протоколу HTTPS:

    1. {% include [create-cert.md](../../../_includes/storage/create-cert.md) %}
       
       {% note info %}

       Использование сервиса {{ certificate-manager-name }} не тарифицируется, подробнее см. [{#T}](../../../certificate-manager/pricing.md).
       
       {% endnote %}
       
    1. {% include [add-cert.md](../../../_includes/storage/add-cert.md) %}

    {% include [redirect-https](../../../_includes/storage/redirect-https.md) %}
   

{% include [objects-access.md](../../../_includes/storage/objects-access.md) %}
