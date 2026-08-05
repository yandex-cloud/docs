---
title: FAQ about {{ postbox-full-name }}
description: This page covers questions and answers about {{ postbox-name }}.
---

# General questions about {{ postbox-name }}

#### Is there support for Cyrillic domains? {#cyrillic-domains}

Yes, {{ postbox-name }} supports Cyrillic domains ([IDN](https://{{ lang }}.wikipedia.org/wiki/Internationalized_domain_name)). To use a Cyrillic domain, specify it in [Punycode](../operations/create-address.md) encoding when [creating an address](https://{{ lang }}.wikipedia.org/wiki/Punycode). For example, the domain `пример.рф` will appear as `xn--e1afmkfd.xn--p1ai` in Punycode.

#### Can I use my {{ yandex-360 }} organization's primary domain for {{ postbox-name }} mailings? {#domain-yandex-360-mailing}

Yes, you can specify your {{ yandex-360 }} organization's domain in the address settings and send your emails from it.

#### Are there any {{ yandex-360 }} or {{ postbox-name }} quotas and limits when using a {{ yandex-360 }} domain? {#domain-yandex-360-limits}

{{ postbox-name }} quotas and limits apply when using any domains. For more information, see [{#T}](../concepts/limits.md).

#### Is it required to create an SPF record? {#spf-required}

No, creating an SPF record on your custom domain is not required. Each email sent via {{ postbox-name }} is signed with two DKIM signatures: one from `postbox.yandexcloud.net`, our technical domain (with its SPF record preconfigured), and a second from your custom domain. In most cases, such authentication is sufficient for successful email delivery.

However, if the recipient has strict incoming mail screening policies, you may need to add an SPF record to your custom domain as well. For information about how to do this, see [{#T}](../concepts/dns-records.md#spf).

#### Why is email delivery delayed? {#delivery-delay}

One common cause of delays is [greylisting](https://en.wikipedia.org/wiki/Greylisting_(email)) (`greylisting`) on the recipient's mail server. This is an anti-spam technique where the server temporarily rejects the first email delivery attempt assuming that a legitimate mail server will repeat it later.

{{ postbox-name }} will automatically retry delivery. Usually, after the delay set by the recipient's server, the email will be accepted and delivered.
