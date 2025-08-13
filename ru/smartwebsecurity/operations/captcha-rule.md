---
title: Как настроить правило для {{ captcha-full-name }}
description: Следуя данной инструкции, вы сможете настроить правило для {{ captcha-name }}.
---

# Правило для {{ captcha-full-name }}

Настройте правило, чтобы направлять запросы на проверку в [{{ captcha-name }}](../../smartcaptcha/).

{% include [allow-path-captcha](../../_includes/smartwebsecurity/allow-patch-captcha.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева нажмите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** и выберите нужный профиль.
  1. {% include [allow-captcha](../../_includes/smartwebsecurity/allow-captcha.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](profile-create.md)
* [{#T}](rule-add.md)