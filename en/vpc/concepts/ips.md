---
title: "Public IP ranges for {{ yandex-cloud }}"
description: "Resources hosted in {{ yandex-cloud }} networks use two types of public IP addresses: {{ yandex-cloud }} resources IPs and {{ yandex-cloud }} services IPs."
---

# Public IP address ranges for {{ yandex-cloud }}

{% include [public-ip-list](../../_includes/vpc/public-ip-list.md) %}

## IP addresses used by {{ captcha-name }} {#smartcaptcha-ips}

{% include [kz-preview](../../_includes/kz-preview.md) %}

{% include [public-ip-list](../../_includes/smartcaptcha-ips.md) %}

These IP addresses cannot be assigned to user resources. They are only needed for API requests sent to `/validate` to work correctly.

#### See also {#see-also}

* [{#T}](../../smartcaptcha/concepts/ips.md)
* [IP address ranges used by Yandex]({{ link-yandex }}/ips)