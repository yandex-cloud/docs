---
title: Диапазоны публичных IP-адресов {{ yandex-cloud }}
description: В этой статье вы узнаете о диапазонах публичных IP-адресов в {{ yandex-cloud }}, которые используются для работы сервисов, виртуальных машин, баз данных и записи аудитных логов.
---

# Диапазоны публичных IP-адресов {{ yandex-cloud }}

{% include [public-ip-list](../../_includes/vpc/public-ip-list.md) %}

## Адреса, используемые {{ captcha-name }} {#smartcaptcha-ips}

{% include [kz-preview](../../_includes/kz-preview.md) %}

{% include [public-ip-list](../../_includes/smartcaptcha-ips.md) %}

Эти адреса нельзя назначить пользовательским ресурсам. Они нужны только для корректной работы запроса к API, отправленного на `/validate`.

#### См. также {#see-also}

* [{#T}](../../smartcaptcha/concepts/ips.md)
* [Диапазоны IP-адресов, используемых Яндексом]({{ link-yandex }}/ips)