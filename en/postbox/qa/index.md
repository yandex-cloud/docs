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
