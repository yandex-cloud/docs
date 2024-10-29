---
title: Cookie в {{ yandex-cloud }}
description: Из статьи вы узнаете, какие cookie использует {{ yandex-cloud }}.
---

# Cookie

В веб-интерфейсах {{ yandex-cloud }} для авторизации пользователя используются cookie `yc_session`.

В консоли каждого сервиса (например, [консоль управления]({{ link-console-main }}) или [{{ cloud-center }}]({{ cloud-center-link }})) cookie независимы друг от друга.

Все cookie привязаны к единой логической сессии, которая инициируется сервисом [{{ auth-main-host }}]({{ auth-main-host }}).
