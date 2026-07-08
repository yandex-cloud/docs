---
title: DNS records for working with {{ postbox-full-name }}
description: This article describes the required and recommended DNS records for sending emails via {{ postbox-name }}.
---

# DNS records for working with {{ postbox-name }}

To enable {{ postbox-name }} to send emails on behalf of your domain and ensure that recipient mail servers trust these emails, you must configure specific resource records in your domain's DNS zone. Some of them are mandatory for {{ postbox-name }} to operate, while others are recommended to improve delivery rates and protect your domain against spoofing.

You can add the records via your DNS registrar or in [{{ dns-full-name }}](../../dns/) if you have delegated your domain to {{ yandex-cloud }}.

## Mandatory records {#required}

### DKIM {#dkim}

{% include [dkim](../../_includes/postbox/dkim.md) %}

{{ postbox-name }} supports two DKIM configuration methods:

* Simple setup, or Easy DKIM: {{ postbox-name }} automatically generates DKIM keys and manages their rotation. After an [address](glossary.md#adress) is created, the management console will display two CNAME records you need to add to your domain’s DNS zone. These records point to public keys managed by {{ postbox-name }}.

* Advanced setup: You manually generate a pair of 1024-bit or 2048-bit keys, e.g., via OpenSSL, provide the private key to the service, and add a single TXT record containing the public key and chosen selector to the DNZ zone.

You can select the DKIM setup method when [creating an address](../operations/create-address.md). After adding DKIM records, you need to [verify your domain ownership](../operations/check-domain.md).

## Recommended records {#recommended}

While DKIM is sufficient to enable {{ postbox-name }} to sign emails, we recommend setting up SPF and DMARC as well to ensure more reliable email delivery and spoofing protection.

### SPF {#spf}

An [SPF](https://{{ lang }}.wikipedia.org/wiki/Sender_Policy_Framework) (Sender Policy Framework) record is a TXT record published at the domain root, which lists servers authorized to send emails on behalf of that domain. The receiving mail server checks the sending server's IP address against this list. If the IP address is not found, the email may be rejected or flagged as spam.

To authorize email delivery via {{ postbox-name }}, add the `include:spf.postbox.yandexcloud.net` mechanism to the SPF record.

If your domain does not have an SPF record, create a TXT record at the domain root with the `"v=spf1 include:spf.postbox.yandexcloud.net ~all"` value.

If your domain already has an SPF record, e.g., for another mail service, do not create an additional record; instead, add the `include:spf.postbox.yandexcloud.net` mechanism into your current record before the `all` mechanism. For example:

```text
"v=spf1 include:_spf.example.com include:spf.postbox.yandexcloud.net ~all"
```

{% note warning %}

A domain must have exactly one SPF record. If a domain contains multiple TXT records starting with `v=spf1`, SPF validation will fail with the `PermError` error ([RFC 7208, section 4.5](https://datatracker.ietf.org/doc/html/rfc7208#section-4.5)), and all emails from this domain will fail SPF authentication, regardless of the record contents.

{% endnote %}

#### The include mechanism {#include}

During SPF verification, the recipient mail server recursively resolves the `spf.postbox.yandexcloud.net` record and adds the IP addresses to your domain’s authorized sender list. This enables maintaining an up-to-date list of {{ postbox-name }} servers in a centralized manner: if the list is modified, you do not have to update the record in your DNS zone.

#### Validating an SPF record {check-spf}

To make sure your SPF record uses a correct format and your domain has no duplicate records, validate it using an online tool, such as [MxToolbox](https://mxtoolbox.com/SuperTool.aspx?action=spf:). These tools will display the final expanded record, list all its nested `include` mechanisms, and issue warnings if multiple SPF records are detected.

### DMARC {#dmarc}

A [DMARC](https://{{ lang }}.wikipedia.org/wiki/DMARC) (Domain-based Message Authentication, Reporting, and Conformance) record is a TXT record in `_dmarc.<domain>.` format. It instructs recipient mail servers on how to handle emails that fail SPF and DKIM authentication and specifies where to send reports. DMARC enhances SPF and DKIM to protect your domain from sender spoofing.

Here is a minimal DMARC record for monitoring (without rejection of emails):

```text
"v=DMARC1;p=none"
```

For a step-by-step guide on adding a DMARC record, see [{#T}](../operations/setup-dmarc.md).

## Useful links {#see-also}

* [{#T}](../operations/create-address.md)
* [{#T}](../operations/check-domain.md)
* [{#T}](../operations/setup-dmarc.md)
* [{#T}](glossary.md#dkim)
