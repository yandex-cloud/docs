---
title: Setting up a DMARC policy
description: Follow this guide to set up a DMARC policy.
---


# Setting up a DMARC policy

To protect your domain from sender email spoofing and increase the security of your email communications, you need to set up a [DMARC policy](https://{{ lang }}.wikipedia.org/wiki/DMARC). Make sure your domain zone settings include the `_dmarc.<domain>.` TXT record. You can add a record with your registrar or in [{{ dns-full-name }}](../../dns/) if you have delegated your domain.

**Example of creating a DMARC record in {{ dns-name }}**

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the address and your domain zone.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Select your domain zone.
    1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
    1. In the **{{ ui-key.yacloud.common.name }}** field, specify `_dmarc`.

        {% note info %}

        For other DNS services, you may need to enter the full record name. The final record should be named `_dmarc.<domain>.`.

        {% endnote %}

    1. In the **{{ ui-key.yacloud.common.type }}** list, select `TXT`.
    1. In the **{{ ui-key.yacloud.dns.label_records }}** field, enter a valid DMARC policy value. Note that the record value must be enclosed in quotes, for example:

        ```text
        "v=DMARC1;p=none"
        ```

        This DMARC record means that if an email fails the DMARC check, the mail service will take no action, such as rejecting the email or classifying it as spam.

    1. Click **{{ ui-key.yacloud.common.create }}**.

    DNS server responses are cached, so delays may occur when updating a resource record.

{% endlist %}
