---
title: Cookie в {{ yandex-cloud }}
description: Из статьи вы узнаете, какие cookie использует {{ yandex-cloud }}.
---

# Cookie

В веб-интерфейсах {{ yandex-cloud }} для аутентификации пользователя используются cookie `yc_session`.

Все cookie привязаны к единой логической [сессии](../../../organization/concepts/sessions.md), которая инициируется сервисом [{{ auth-main-host }}](https://{{ auth-main-host }}).

Cookie создаются независимо для каждого сервиса {{ yandex-cloud }}, работающего на собственном выделенном домене (например, [консоль управления]({{ link-console-main }}), [{{ cloud-center }}]({{ cloud-center-link }}), [{{ datalens-full-name }}]({{ link-datalens-main }}) и др.)

#### См. также {#see-also}

* [{#T}](../../../organization/concepts/sessions.md)