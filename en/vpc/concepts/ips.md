---
title: Public IP address ranges in {{ yandex-cloud }}
description: In this article, you will learn about public IP address ranges in {{ yandex-cloud }} used by services, VMs, databases, and audit logs.
---

# Public IP address ranges in {{ yandex-cloud }}

{% include [public-ip-list](../../_includes/vpc/public-ip-list.md) %}

## IP addresses used by {{ captcha-name }} {#smartcaptcha-ips}

{% include [kz-preview](../../_includes/kz-preview.md) %}

{% include [public-ip-list](../../_includes/smartcaptcha-ips.md) %}

These IP addresses cannot be assigned to user resources. They serve to ensure an API request sent to `/validate` works correctly.

#### See also {#see-also}

* [{#T}](../../smartcaptcha/concepts/ips.md)
* [IP address ranges used by Yandex]({{ link-yandex }}/ips)