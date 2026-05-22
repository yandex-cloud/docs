---
title: Cookies in {{ yandex-cloud }}
description: In this tutorial, you will learn about the cookies used by {{ yandex-cloud }}.
---

# Cookie

{{ yandex-cloud }} web interfaces use `yc_session` cookies for user authentication.

All cookies are linked to a single logical [session](../../../organization/concepts/sessions.md) initiated by [{{ auth-main-host }}](https://{{ auth-main-host }}).

Cookies are created independently for each {{ yandex-cloud }} service operating on its own dedicated domain (e.g., [management console]({{ link-console-main }}), [{{ cloud-center }}]({{ cloud-center-link }}), [{{ datalens-full-name }}]({{ link-datalens-main }}), etc.)

#### See also {#see-also}

* [{#T}](../../../organization/concepts/sessions.md)