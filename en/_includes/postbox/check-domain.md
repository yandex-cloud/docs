{% include [check-domain-intro](../../_includes/postbox/check-domain-intro.md) %}

{% list tabs group=dkim %}

- Simple setup {#easy}

    With the simple setup, {{ postbox-name }} automatically generates DKIM keys. The two CNAME records you need to add to your DNS provider are displayed under **{{ ui-key.yacloud.postbox.section_dkim }}** on the address page.

    {% note info %}

    Both CNAME records are required for automatic DKIM key rotation. You must add them to the DNS provider and cannot delete these records after completing domain ownership verification. Public key TXT records resolve through both CNAME records only during key rotation. At any other time, a valid public key resolves through only one of them. For more information, see [{#T}](../../postbox/concepts/dns-records.md#key-rotation).

    {% endnote %}

    **Example of creating resource records in {{ dns-full-name }}**

    {% include [check-domain-simple](../../_includes/postbox/check-domain-simple.md) %}

- Advanced setup {#advanced}

    With the advanced setup, you need to manually [generate the key](../../postbox/operations/create-address.md) for the DKIM signature. The **{{ ui-key.yacloud.postbox.section_dkim }}** section on the address page displays a single TXT record you need to add to your DNS provider.

    **Example of creating resource records in {{ dns-full-name }}**
    
    1. In the [management console]({{ link-console-main }}), select the folder containing the address and your domain zone.

        If you do not have a [public DNS zone](../../dns/concepts/dns-zone.md#public-zones) yet, [create](../../dns/operations/zone-create-public.md) one:
    1. [Navigate]({{ link-console-main }}/link/dns) to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Select your domain zone.
    1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
    1. In the **{{ ui-key.yacloud.common.name }}** field, specify the name portion generated when creating the address, omitting the domain in `<selector>._domainkey` format, e.g., `postbox._domainkey`.

        {% note info %}

        For other DNS services, you may need to copy the entire record. The final record must look like this: `<selector>._domainkey.<domain>.`, e.g., `postbox._domainkey.example.com.`.

        {% endnote %}

    1. In the **{{ ui-key.yacloud.common.type }}** field, select `TXT`.
    1. Paste the contents of the **{{ ui-key.yacloud.dns.label_records }}** field under **{{ ui-key.yacloud.postbox.label_dns-record-value }}** into the **{{ ui-key.yacloud.postbox.section_dkim }}** field. Note that the record value must be enclosed in quotes, such as follows:

        ```text
        "v=DKIM1;h=sha256;k=rsa;p=M1B...aCA8"
        ```

        {% note info %}

        Other DNS services may have different requirements for resource record formatting. For more information, refer to your DNS provider’s guides.

        {% endnote %}

    1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify the record lifetime.
    1. Click **{{ ui-key.yacloud.common.create }}**.
    1. [Navigate]({{ link-console-main }}/link/postbox) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Select the address you created.
    1. Wait for {{ postbox-name }} to verify the DKIM signature settings. If the record is correct, the verification status on the address page will change to `Success`.

{% endlist %}

DNS server responses are cached, so you may experience delays when updating the resource record. If the verification status does not change within 24 hours, click **{{ ui-key.yacloud.postbox.button_run-verification }}**.
