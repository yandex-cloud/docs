---
title: "Cookie в {{ yandex-cloud }}"
description: "Из статьи вы узнаете, какие cookie использует {{ yandex-cloud }}."
---

# Cookie

В веб-интерфейсах {{ yandex-cloud }} для авторизации пользователя используются cookie `yc_session`.

В консоли каждого сервиса (например, [console.yandex.cloud](console.yandex.cloud), [org.yandex.cloud](org.yandex.cloud), [datalens.yandex.cloud](datalens.yandex.cloud)) cookie независимы друг от друга.

Все cookie привязаны к единой логической сессии, которая инициируется сервисом [auth.yandex.cloud](auth.yandex.cloud).
