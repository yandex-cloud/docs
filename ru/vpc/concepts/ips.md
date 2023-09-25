---
title: "Диапазоны публичных IP-адресов {{ yandex-cloud }}"
description: "Для ресурсов в сетях {{ yandex-cloud }} используются два типа публичных IP-адресов: адреса ресурсов {{ yandex-cloud }} и адреса, которые используются {{ yandex-cloud }} для работы сервисов."
---

# Диапазоны публичных IP-адресов {{ yandex-cloud }}

{% include [public-ip-list](../../_includes/vpc/public-ip-list.md) %}

## Адреса, используемые {{ captcha-name }} {#smartcaptcha-ips}

{% include [public-ip-list](../../_includes/smartcaptcha-ips.md) %}

Эти адреса нельзя назначить пользовательским ресурсам. Они нужны только для корректной работы запроса к API, отправленного на `/validate`.

#### См. также {#see-also}

* [{#T}](../../smartcaptcha/concepts/ips.md)
* [Диапазоны IP-адресов, используемых Яндексом]({{ link-yandex }}/ips)