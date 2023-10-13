---
title: "Подключить профиль безопасности к виртуальному хосту"
description: "Следуя данной инструкции, вы сможете подключить профиль безопасности к виртуальному хосту."
---

# Подключить профиль безопасности к виртуальному хосту

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите подключить [профиль безопасности](../concepts/profiles.md) к [виртуальному хосту](../../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [{{ alb-full-name }}](../../application-load-balancer/).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль, который вы хотите подключить к хосту.
  1. Нажмите кнопку ![plug](../../_assets/smartwebsecurity/plug.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. В открывшемся окне выберите:
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md).
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**. Вы можете подключить профиль безопасности сразу к нескольким хостам.

        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**. Если выбранные хосты уже подключены к другому профилю безопасности, подтвердите подключение.

      На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** появятся подключенные виртуальные хосты.

{% endlist %}

{% include [auto-scaling-tip](../../_includes/smartwebsecurity/auto-scaling-tip.md) %}

### См. также {#see-also}

* [{#T}](host-delete.md)
