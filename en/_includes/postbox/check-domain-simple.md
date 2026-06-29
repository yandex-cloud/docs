1. In the [management console]({{ link-console-main }}), select the folder containing the address and your domain zone.

   If you do not have a [public DNS zone](../../dns/concepts/dns-zone.md#public-zones) yet, [create](../../dns/operations/zone-create-public.md) one:
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Select the new address and open the **{{ ui-key.yacloud.postbox.section_dkim }}** section.
1. For each of the two CNAME records, complete the following steps:

    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Select your domain zone.
    1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
    1. In the **{{ ui-key.yacloud.common.type }}** field, select `CNAME`.
    1. Enter the record name from the **{{ ui-key.yacloud.postbox.section_dkim }}** section on the address page into the **{{ ui-key.yacloud.common.name }}** field, omitting the domain.

       {% note info %}

       Other DNS services may require a full record name, including the domain.

       {% endnote %}

    1. In the **{{ ui-key.yacloud.dns.label_records }}** field, paste the record value from the **{{ ui-key.yacloud.postbox.section_dkim }}** section on the address page.
    1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify the record lifetime.
    1. Click **{{ ui-key.yacloud.common.create }}**.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Select the address you created.
1. Wait for {{ postbox-name }} to verify the DKIM signature settings. If the records are correct, the verification status on the address page will change to `Success`.
