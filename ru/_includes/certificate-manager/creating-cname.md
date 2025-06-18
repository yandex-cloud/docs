{% list tabs group=instructions %}

- {{ dns-full-name }} {#dns}

  В разделе **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** в блоке с типом записи `CNAME` нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**. В открывшемся окне:

  1. Если в текущем каталоге есть подходящая зона DNS, она будет автоматически подставлена в поле **{{ ui-key.yacloud.dns.label_zone }}**. Если подходящей зоны DNS нет, нажмите **{{ ui-key.yacloud.dns.button_zone-create }}** и задайте ее параметры, чтобы [создать](../../dns/operations/zone-create-public.md) зону.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- Сторонний DNS-провайдер {#third-party-dns-server}

  1. В разделе **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, в блоке с типом записи `CNAME`, в поле **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_value }}** посмотрите значение записи для домена.
  1. Разместите у своего DNS-провайдера или на собственном [DNS-сервере](../../glossary/dns.md#dns-server) `CNAME`-запись для делегирования прав управления на DNS-зону, используемую для проверки:

      ```
      _acme-challenge.example.com CNAME <значение>
      ```
      Строка `<значение>` формируется по шаблону `<идентификатор_сертификата>.cm.yandexcloud.net.`

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}