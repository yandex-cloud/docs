---
title: "Подключить профиль безопасности к виртуальному хосту"
description: "Следуя данной инструкции, вы сможете подключить профиль безопасности к виртуальному хосту."
---

# Подключить профиль безопасности к виртуальному хосту

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите подключить [профиль безопасности](../concepts/profiles.md) к [виртуальному хосту](../../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [{{ alb-full-name }}](../../application-load-balancer/).
  1. В списке сервисов выберите **{{ sws-name }}**.
  1. Напротив профиля, который вы хотите подключить к хосту, нажмите ![options](../../_assets/options.svg) и выберите ![pencil](../../_assets/pencil.svg) **Редактировать**.

      {% include [host-connect](../../_includes/smartwebsecurity/host-connect.md) %}

  1. Нажмите кнопку **Сохранить**.

{% endlist %}

{% include [auto-scaling-tip](../../_includes/smartwebsecurity/auto-scaling-tip.md) %}
