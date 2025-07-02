{% list tabs group=instructions %}

- {{ dns-full-name }} {#dns}

  Under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, in the `CNAME` record section, click **{{ ui-key.yacloud.dns.button_record-set-create }}**. In the window that opens:

  1. If the current folder contains an appropriate DNS zone, it will be automatically inserted into the **{{ ui-key.yacloud.dns.label_zone }}** field. If there is no appropriate DNS zone, click **{{ ui-key.yacloud.dns.button_zone-create }}** and set its parameters to [create](../../dns/operations/zone-create-public.md) a new zone.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- Third-party DNS provider {#third-party-dns-server}

  1. Under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, in the `CNAME` record section, check out the record value for the domain in the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_value }}** field.
  1. Add a `CNAME` record to your DNS provider or to your own DNS server to delegate management privileges to the DNS zone used for the check:

      ```
      _acme-challenge.example.com CNAME <value>
      ```
      The `<value>` string is formatted as follows: `<certificate_ID>.cm.yandexcloud.net.`

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}