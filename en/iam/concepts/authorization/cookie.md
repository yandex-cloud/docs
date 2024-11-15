---
title: Cookies in {{ yandex-cloud }}
description: In this tutorial, you will learn about the cookies used by {{ yandex-cloud }}.
---

# Cookie

{{ yandex-cloud }} web interfaces use `yc_session` cookies to authenticate a user.

In each service's console, e.g., [management console]({{ link-console-main }}) or [{{ cloud-center }}]({{ cloud-center-link }}), cookies are independent of each other.

All cookies are linked to a single logical session initiated by [{{ auth-main-host }}](https://{{ auth-main-host }}).
