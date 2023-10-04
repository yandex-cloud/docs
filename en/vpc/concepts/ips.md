# Public IP address ranges {{ yandex-cloud }}

{% include [public-ip-list](../../_includes/vpc/public-ip-list.md) %}

## IP addresses used by {{ captcha-name }} {#smartcaptcha-ips}

{% include [public-ip-list](../../_includes/smartcaptcha-ips.md) %}

These IP addresses cannot be assigned to user resources. They are only needed for API requests sent to `/validate` to perform properly.

#### See also {#see-also}

* [IP address ranges used by Yandex]({{ link-yandex }}/ips)